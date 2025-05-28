import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf

public func configure(_ app: Application) throws {
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    app.migrations.add(CreateProduct())

        app.views.use(.leaf)
        print("Views directory: \(app.directory.viewsDirectory)")

    try routes(app)
}