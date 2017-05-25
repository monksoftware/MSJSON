@_exported import Vapor

extension Droplet {
    public func setup() throws {
        try collection(Routes.self)
        
        get("index") { req in
            return try self.view.make("index")
        }
    }
}
