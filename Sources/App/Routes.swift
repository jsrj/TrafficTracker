import Vapor
import JSON

// Non-default function to simplify the process of converting
// a Swift Dictionary to the StructuredData expected by JSONRepresentable
func JSONBuilder(dictionaryRef: [String:Any]) -> JSON {
    var jsonOut = JSON()
    for kvPair in dictionaryRef {
        do {
            try jsonOut.set(kvPair.key, kvPair.value)
        }
        catch {
            print("An error occured when attempting to add \(kvPair.key) : \(kvPair.value) to JSON.")
        }
    }
    return jsonOut
}

final class Routes: RouteCollection {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }

    func build(_ builder: RouteBuilder) throws {
        // VIEW-BACKED GET REQUESTS
            /// GET /
            builder.get("/") { req in
                return try self.view.make("welcome")
            }
        
            /// GET /test
            builder.get("test") { req in
                return "Test Works"
            }
        
        // NON-VIEW GET REQUESTS
            /// GET /json
            builder.get("json/:code/:key") { req in
                
                let dummyJson: [String:Any] = [
                    "code": req.parameters["code"]!.string!,
                    "key":  req.parameters["key"]!.string!,
                    "array": [
                        "one thing",
                        "two thing",
                        "red thing",
                        "blue thing"
                    ]
                ]
                return JSONBuilder(dictionaryRef: dummyJson)
            }

        // response to requests to /info domain
        // with a description of the request
//        builder.get("info") { req in
//            return req.description
//        }

    }
}
