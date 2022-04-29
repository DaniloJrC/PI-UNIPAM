// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let backgroundColor = ColorAsset(name: "backgroundColor")
  internal static let barButtonColor = ColorAsset(name: "barButtonColor")
  internal static let circleStrokeColor = ColorAsset(name: "circleStrokeColor")
  internal static let popupBackgroundColor = ColorAsset(name: "popupBackgroundColor")
  internal static let popupShadowColor = ColorAsset(name: "popupShadowColor")
  internal static let blue = ColorAsset(name: "blue")
  internal static let gray = ColorAsset(name: "gray")
  internal static let green = ColorAsset(name: "green")
  internal static let red = ColorAsset(name: "red")
  internal static let darkEightHundred = ColorAsset(name: "dark_eight_hundred")
  internal static let darkFiveHundred = ColorAsset(name: "dark_five_hundred")
  internal static let darkFourHundred = ColorAsset(name: "dark_four_hundred")
  internal static let darkNineHundred = ColorAsset(name: "dark_nine_hundred")
  internal static let darkOneHundred = ColorAsset(name: "dark_one_hundred")
  internal static let darkSevenHundred = ColorAsset(name: "dark_seven_hundred")
  internal static let darkSixHundred = ColorAsset(name: "dark_six_hundred")
  internal static let darkThreeHundred = ColorAsset(name: "dark_three_hundred")
  internal static let darkTwoHundred = ColorAsset(name: "dark_two_hundred")
  internal static let bottomShadowColor = ColorAsset(name: "bottom_shadow_color")
  internal static let topShadowColor = ColorAsset(name: "top_shadow_color")
  internal static let facebook = ColorAsset(name: "facebook")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
