# ResendSwift

A lightweight Swift wrapper for the [Resend](https://resend.com) Email API.

## Features

- Send emails via Resend
- Basic error handling
- Simple integration with Swift applications

## Installation

Use [Swift Package Manager](https://swift.org/package-manager/) to add the dependency:

```swift
.package(url: "https://github.com/Onnwen/resend-swift.git", from: "1.0.0")
```

Then add "ResendSwift" as a dependency for your target.

## Usage

```swift
do {
    let resend = try Resend(apiKey: "your-api-key")
    
    try await resend.sendEmail(
        .init(
            from: "Hello <hello@example.com>",
            to: ["tim@example.com"],
            subject: "Hi Tim",
            html: "<p>Hi Tim!</p>",
            text: "Hi Tim!"
        )
    )
} catch {
    // handle error
}
```
