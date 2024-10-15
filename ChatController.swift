import Vapor

final class ChatController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        // Defina a rota para o endpoint de chat
        routes.post("ask", use: ask)
    }

    // Função para lidar com requisições POST
    func ask(req: Request) throws -> EventLoopFuture<Response> {
        // Extraia a mensagem do corpo da requisição
        let message = try req.content.decode(ChatMessage.self)

        // Aqui você pode processar a mensagem recebida e gerar uma resposta
        let responseMessage = "Você disse: \(message.message)"

        // Crie a resposta JSON
        let response = ChatResponse(response: responseMessage)

        // Retorne a resposta
        return req.eventLoop.future(response)
    }
}

// Estruturas para decodificação/encodificação JSON
struct ChatMessage: Content {
    let message: String
}

struct ChatResponse: Content {
    let response: String
}
