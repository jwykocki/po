import Vapor
import Leaf

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")
        products.get(use: index)
        products.get("create", use: create)
        products.post(use: store)
        products.get(":id", use: show)
        products.get(":id", "edit", use: edit)
        products.post(":id", use: update)
        products.post(":id", "delete", use: delete)
    }

    func index(req: Request) async throws -> View {
        let products = try await Product.query(on: req.db).all()
        return try await req.view.render("products/index", ["products": products])
    }

    func create(req: Request) async throws -> View {
        return try await req.view.render("products/create")
    }

    func store(req: Request) async throws -> Response {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)
        return req.redirect(to: "/products")
    }

    func show(req: Request) async throws -> View {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("products/show", ["product": product])
    }

    func edit(req: Request) async throws -> View {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return try await req.view.render("products/edit", ["product": product])
    }

    func update(req: Request) async throws -> Response {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        let updatedProduct = try req.content.decode(Product.self)
        product.name = updatedProduct.name
        product.description = updatedProduct.description
        product.price = updatedProduct.price
        product.quantity = updatedProduct.quantity
        try await product.save(on: req.db)
        return req.redirect(to: "/products")
    }

    func delete(req: Request) async throws -> Response {
        guard let product = try await Product.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await product.delete(on: req.db)
        return req.redirect(to: "/products")
    }
}