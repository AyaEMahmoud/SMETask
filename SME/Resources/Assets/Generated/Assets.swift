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
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let back = ImageAsset(name: "back")
    internal static let baner = ImageAsset(name: "baner")
    internal static let icOnline = ImageAsset(name: "ic-online")
  }
  internal enum Colors {
    internal static let ashGrey = ColorAsset(name: "Ash grey")
    internal static let darkJungleGreen = ColorAsset(name: "Dark jungle green")
    internal static let darkSlateGray = ColorAsset(name: "Dark slate gray")
    internal static let ghostWhite = ColorAsset(name: "Ghost white")
    internal static let languidLavender = ColorAsset(name: "Languid lavender")
    internal static let lavenderGray = ColorAsset(name: "Lavender gray")
    internal static let lightSlateGray = ColorAsset(name: "Light slate gray ")
    internal static let lightTaupe = ColorAsset(name: "Light taupe ")
    internal static let lion = ColorAsset(name: "Lion")
    internal static let manatee = ColorAsset(name: "Manatee")
    internal static let mantis = ColorAsset(name: "Mantis")
    internal static let mikadoYellow = ColorAsset(name: "Mikado yellow")
    internal static let munsell = ColorAsset(name: "Munsell")
    internal static let nonPhotoBlue = ColorAsset(name: "Non-photo blue")
    internal static let onyx = ColorAsset(name: "Onyx")
    internal static let outerSpace = ColorAsset(name: "Outer Space")
    internal static let pacificBlue = ColorAsset(name: "Pacific Blue")
    internal static let paleBrown = ColorAsset(name: "Pale brown ")
    internal static let platinum1 = ColorAsset(name: "Platinum-1")
    internal static let platinum = ColorAsset(name: "Platinum")
    internal static let steelBlue = ColorAsset(name: "Steel blue")
    internal static let timberwolf = ColorAsset(name: "Timberwolf")
  }
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

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
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
