//
//  SnippetController.swift
//  MSJSON
//
//  Created by Alessio Arsuffi on 24/05/2017.
//
//

import Vapor
import HTTP
import MongoProvider
    
final class SnippetController: ResourceRepresentable {
    
    /// When users call 'GET' on '/snippets'
    /// it should return an index of all available snippets
    func index(request: Request) throws -> ResponseRepresentable {
        return try Snippet.all().makeJSON()
    }
    
    /// When consumers call 'POST' on '/snippets' with valid JSON
    /// create and save the snippet
    func create(request: Request) throws -> ResponseRepresentable {
        let snippet = try request.snippet()
        try snippet.save()
        return snippet
    }
    
    /// When the consumer calls 'GET' on a specific resource, ie:
    /// '/snippets/13rd88' we should show that specific snippet
    func show(request: Request, snippet: Snippet) throws -> ResponseRepresentable {
        return snippet
    }
    
    func makeResource() -> Resource<Snippet> {
        return Resource(index: index,
                        store: create,
                        show: show)
    }
}

extension Request {
    /// Create a post from the JSON body
    /// return BadRequest error if invalid
    /// or no JSON
    func snippet() throws -> Snippet {
        guard let json = json else { throw Abort.badRequest }
        return try Snippet(json: json)
    }
}

/// Since PostController doesn't require anything to
/// be initialized we can conform it to EmptyInitializable.
///
/// This will allow it to be passed by type.
extension SnippetController: EmptyInitializable { }
