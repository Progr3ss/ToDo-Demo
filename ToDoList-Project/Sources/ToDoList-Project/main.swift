import Kitura
import HeliumLogger
import LoggerAPI

let controller = TodoController()
let router =  Router()
router.get("/hello") { (request, response, next) in
    
    response.send("hello everyone")
    next()
}
Log.logger = HeliumLogger()


Kitura.addHTTPServer(onPort: 8080, with: router)
Kitura.run()

