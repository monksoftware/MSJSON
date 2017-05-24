//
//  Snippet.swift
//  MSJSON
//
//  Created by Alessio Arsuffi on 24/05/2017.
//
//

import Vapor
import FluentProvider
import HTTP

final class Snippet: Model {
    let storage = Storage()
    
    /// The content of the snippet
    var content: String
    
    /// Creates a new Snippet
    init(content: String) {
        self.content = content
    }
    
    /// Initializes the Post from the
    /// database row
    init(row: Row) throws {
        content = try row.get("content")
    }
    
    // Serializes the Post to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("content", content)
        return row
    }
}

// MARK: Fluent Preparation

extension Snippet: Preparation {
    /// Prepares a table/collection in the database
    /// for storing Posts
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string("content")
        }
    }
    
    /// Undoes what was done in `prepare`
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

// MARK: JSON

// How the model converts from / to JSON.
// For example when:
//     - Creating a new snippet (POST /snippets)
//     - Fetching a snippet (GET /snippets, GET /snippets/:id)
//
extension Snippet: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(
            content: json.get("content")
        )
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set("id", id)
        try json.set("content", content)
        return json
    }
}

// MARK: HTTP

// This allows Post models to be returned
// directly in route closures
extension Snippet: ResponseRepresentable {}

extension Snippet: NodeInitializable, NodeRepresentable {
    
}
