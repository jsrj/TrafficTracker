import App

/// We have isolated all of our App's logic into
/// the App module because it makes our app
/// more testable.
///
/// In general, the executable portion of our App
/// shouldn't include much more code than is presented
/// here.
///
/// We simply initialize our Droplet, optionally
/// passing in values if necessary
/// Then, we pass it to our App's setup function
/// this should setup all the routes and special
/// features of our app
///
/// .run() runs the Droplet's commands,
/// if no command is given, it will default to "serve"
let config = try Config()
try config.setup()

let drop = try Droplet(config)
try drop.setup()

//drop.get("/") { request in
//    return ">Hello Swift"
//}

//drop.get("get-test/:app-code/:key") { request in
//    // app-code will be a randomly generated number that users will be assigned when registering.
//    // key will be a generated hash for that user's particular app
//
//    // To return a response as a JSON object
//    let dict: [String : String] = [
//        "app-code": request.parameters["app-code"]!.string!,
//        "key":      request.parameters["key"]!.string!
//    ]
//    return try dict.makeResponse()
//}
//
drop.get("strong/:name") { request in
    let name:String = request.parameters["name"] == nil ? "noname" : request.parameters["name"]!.string!
    return try drop.view.make("strong.leaf", ["name" : name])
}

try drop.run()
