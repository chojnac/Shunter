# Shunter

[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg?maxAge=2592000)](https://github.com/chojnac/Shunter/blob/master/LICENSE)

_Shunter_ is a small framework enabling [feature flags](https://en.wikipedia.org/wiki/Feature_toggle) in your project. 

## Motivation

A feature flag is a very simple but yet powerful concept. It enables developers to merge code earlier, demonstrate "unfinished" features or ships alternative code paths. Also with companion remote server - it gives a way to disable "problematic" new feature in the production builds. 

All this helps to increase the speed of development and validating new ideas.

The goal of this library is to provide a very simple solution to quickly plugin feature flags in your project. 

## Features
* Simple and small 
* Define features default state (on/off)
* UI for overriding settings in the development/test environment.

## Requirements
* iOS 11.0+ / macOS 10.12+
* Xcode 10.2+
* Swift 5+

## Installation

### CocoaPods

Add the pod to your Podfile:

```
pod 'Shunter'
```

And then run: 

```
pod install
```

After installing the cocoapod into your project import library with
```swift
import Shuter
```

## Usage 

A feature is a type containing an identifier and a comment. 

The best way to group all features in one place is to create static properties in an extension on the `Feature` type. For example:

```swift
import Shunter

extension Feature {
    public static let feature01Feature = Feature("ios_feature01", comment: "Example feature #01")
    public static let feature02Feature = Feature("ios_feature02", comment: "Example feature #02")
}
```

The recommended place to initialize the `FeatureManager` for the iOS application is the `AppDelegate`. 
The example below shows the manager set up with disabled `shake` action for the `Release` build. 

```swift
#if DEBUG
let showOverrideScreenOnShake = true
#else
let showOverrideScreenOnShake = false
#endif
FeatureManager.setup(
    configuration: .defaultConfiguration(showOverrideScreenOnShake: showOverrideScreenOnShake),
    features: [
        .feature01Feature: false,
        .feature02Feature: true
    ])
```

The example of how to check feature status in your code:

```swift
if FeatureManager.shared.isEnabled(.feature02Feature) {
    // enable your feature 
} else {
    // the feature is disabled
}

```

or shorter version:

```swift
if FeatureManager.shared[.feature02Feature] {
// enable your feature 
} else {
// the feature is disabled
}

```

You will find more code examples in the Demo application. 

## Author

**[Wojciech Chojnacki](https://github.com/chojnac)**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
