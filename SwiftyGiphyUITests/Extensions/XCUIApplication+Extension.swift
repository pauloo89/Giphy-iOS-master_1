import XCTest

extension XCUIApplication {
    
    static var springboard: XCUIApplication {
        return XCUIApplication(bundleIdentifier: "com.apple.springboard")
    }
    
    static var safari: XCUIApplication {
        return XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
    }
    
    static var preferences: XCUIApplication {
        return XCUIApplication(bundleIdentifier: "com.apple.Preferences")
    }
    
}
