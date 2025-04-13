# 🔥 SwiftyNetwoking
 generic based approach doing api request in swift

A lightweight and developer-friendly Swift networking library that handles the boilerplate so you don’t have to. Built-in:

- ✅ **Curl logging** for debugging
- 🍪 **Cookie support**
- 🎯 **Custom headers** (applied globally)
- ⚡️ **Simple async/await interface**
- 💡 **Clean, reusable API calls**

---

## 🚀 Getting Started

## Usage

### 1. Initialize the Shared Instance or however you prefer
```swift
let apiService = APIService.shared 
```

### 2. Set Headers or Authentication
```swift
apiService.setBearerToken("your_token")
apiService.setSessionId("session_123")
```

### 3. Execute a Request
```swift
let result: APIResult<LoginResponse, APIClientError> = await apiService.execute(LoginPostApi())

switch result {
case .success(let user):
    print("User: \(user)")
case .failure(let error):
    print("Error: \(error)")
}
```

### 4. Cookie Management
If the server returns a `Set-Cookie` header, `APIService` extracts and persists it for future requests automatically.

## APIRequestable Example

```swift
struct LoginPostApi: APIRequestable {
    var path: String { "/login" }
    var method: HTTPMethod { .post }
    var headers: [String: String]? { ["Accept": "application/json"] }
    var body: Data? {
        try? JSONEncoder().encode(LoginRequest(email: "test@test.com", password: "password"))
    }
}
```

## APIResult Enum
```swift
public enum APIResult<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}
```

## Debugging

In `DEBUG` mode:
- All requests are logged as cURL strings.
- You can stub any request using `.shouldStubResponse = true` and provide `stubbedResponseData`.

## Structure

- `APIService`: Main service that handles request execution
- `APIRequestable`: Protocol to define endpoints
- `APIResult`: Enum for success/failure handling
- `APIClientError`: Enum for standardized error types
- `URLSessionProxy`: Proxy for request logging (debug only)

## Secure Storage

Cookies are securely saved to Keychain via `StorageManager` and used in subsequent requests.

---

For contributions or issues, feel free to open a pull request or report a bug.

