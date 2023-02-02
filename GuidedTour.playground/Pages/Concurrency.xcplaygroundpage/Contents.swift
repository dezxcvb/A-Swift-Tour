//: ## Concurrency
//:
//: Use `async` to mark a function that runs asynchronously.
//:
func fetchUserID(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    return 501
}

/*
Task {
    await fetchUserID(from: "primary")
}
*/

//: You mark a call to an asynchronous function by writing `await` in front of it.
//:
func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(from: server)
    if userID == 501 {
        return "John Appleseed"
    }
    return "Guest"
}

/*
Task {
    await fetchUsername(from: "primary")
}
*/

//: Use `async let` to call an asynchronous function, letting it run in parallel with other asynchronous code. When you use the value it returns, write `await`.
//:
func connectUser(to/*from*/ server: String) async {
    async let userID = fetchUserID(from: server)
    async let username = fetchUsername(from: server)
    let greeting = await "Hello \(username), user ID \(userID)"
    print(greeting)
}

/*
Task {
    await connectUser(to/*from*/: "primary")
}
*/

//: Use `Task` to call asynchronous functions from synchronous code, without waiting for them to return.
//:
// 2023.02.02
//: [Previous](@previous) | [Next](@next)
