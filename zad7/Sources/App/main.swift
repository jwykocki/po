import Vapor
import Fluent
import Leaf

var env = try Environment.detect()
let app = Application(env)
defer { app.shutdown() }

try configure(app)
try app.autoMigrate().wait()
try app.run()
