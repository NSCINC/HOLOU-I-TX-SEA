import Vapor

public func routes(_ app: Application) throws {
    // Registra o ChatController
    let chatController = ChatController()
    try app.register(collection: chatController)
}
