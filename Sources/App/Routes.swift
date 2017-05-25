import Vapor

final class Routes: RouteCollection {
    func build(_ builder: RouteBuilder) throws {
        try builder.resource("snippets", SnippetController.self)
    }
}

/// Since Routes doesn't depend on anything
/// to be initialized, we can conform it to EmptyInitializable
///
/// This will allow it to be passed by type.
extension Routes: EmptyInitializable { }
