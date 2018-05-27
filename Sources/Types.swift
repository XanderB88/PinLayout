//  Copyright (c) 2018 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation


/*
 UIView's anchors point
 ======================

 topLeft      topCenter       topRight
 o-------------o--------------o
 |                            |
 |                            |
 |                            |
 |                            |
 |                            |
 |           center           |
 centerLeft o             o              o centerRight
 |                            |
 |                            |
 |                            |
 |                            |
 |                            |
 |                            |
 o-------------o--------------o
 bottomLeft    bottomCenter     bottomLeft

 */

/// UIViews's anchor definition
@objc public protocol Anchor {
}

/// UIViews's list of anchors.
@objc public protocol AnchorList {
    var topLeft: Anchor { get }
    var topCenter: Anchor { get }
    var topRight: Anchor { get }
    var centerLeft: Anchor { get }
    var center: Anchor { get }
    var centerRight: Anchor { get }
    var bottomLeft: Anchor { get }
    var bottomCenter: Anchor { get }
    var bottomRight: Anchor { get }

    // RTL support
    var topStart: Anchor { get }
    var topEnd: Anchor { get }
    var centerStart: Anchor { get }
    var centerEnd: Anchor { get }
    var bottomStart: Anchor { get }
    var bottomEnd: Anchor { get }
}

/*
 UIView's Edges
 ======================
 top
 +-----------------+
 |                 |
 |                 |
 |     hCenter     |
 left |        +        | right
 |     vCenter     |
 |                 |
 |                 |
 +-----------------+
 bottom
 */

/// UIViews's list of edges
@objc public protocol EdgeList {
    var top: VerticalEdge { get }
    var vCenter: VerticalEdge { get }
    var bottom: VerticalEdge { get }
    var left: HorizontalEdge { get }
    var hCenter: HorizontalEdge { get }
    var right: HorizontalEdge { get }

    // RTL support
    var start: HorizontalEdge { get }
    var end: HorizontalEdge { get }
}

/// Horizontal alignment used with relative positionning methods: above(of relativeView:, aligned:), below(of relativeView:, aligned:)
///
/// - left: left aligned
/// - center: center aligned
/// - right: right aligned
@objc public enum HorizontalAlign: Int {
    case left
    case center
    case right

    // RTL support
    case start
    case end
}

/// Vertical alignment used with relative positionning methods: left(of relativeView:, aligned:), right(of relativeView:, aligned:)
///
/// - top: top aligned
/// - center: center aligned
/// - bottom: bottom aligned
@objc public enum VerticalAlign: Int {
    case top
    case center
    case bottom
}

/// UIView's horizontal edges (left/right) definition
@objc public protocol HorizontalEdge {
}

/// UIView's vertical edges (top/bottom) definition
@objc public protocol VerticalEdge {
}

public enum FitType {
    /**
     **Adjust the view's height** based on the reference width.
     * If properties related to the width have been pinned (e.g: width, left & right, margins),
     the **reference width will be determined by these properties**, else the **current view's width**
     will be used.
     * The resulting width will always **match the reference width**.
     */
    case width
    /**
     **Adjust the view's width** based on the reference height.
     * If properties related to the height have been pinned (e.g: height, top & bottom, margins),
     the reference height will be determined by these properties, else the **current view's height**
     will be used.
     * The resulting height will always **match the reference height*.
     */
    case height

    /**
     Similar to `.width`, except that PinLayout won't constrain the resulting width to
     match the reference width. The resulting width may be smaller of bigger depending on the view's
     sizeThatFits(..) method result. For example a single line UILabel may returns a smaller width if its
     string is smaller than the reference width.
     */
    case widthFlexible
    /**
     Similar to `.height`, except that PinLayout won't constrain the resulting height to
     match the reference height. The resulting height may be smaller of bigger depending on the view's
     sizeThatFits(..) method result.
     */
    case heightFlexible
}

public enum WrapType {
    /**
     */
    case all
    /**
     */
    case width
    /**
     */
    case height
}

public struct PPadding {
    let top: CGFloat
    let left: CGFloat
    let bottom: CGFloat
    let right: CGFloat

    static var zero: PPadding {
        return PPadding(0)
    }

    init(_ all: CGFloat) {
        top = all
        left = all
        bottom = all
        right = all
    }

    init(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }

    init(h: CGFloat, v: CGFloat) {
        top = v
        left = h
        bottom = v
        right = h
    }
}

@objc public enum LayoutDirection: Int {
    case auto
    case ltr
    case rtl
}

/// Control how PinLayout will calls `UIView.safeAreaInsetsDidChange` when the `UIView.pin.safeArea` change.
/// This support is usefull only on iOS 8/9/10. On iOS 11 `UIView.safeAreaInsetsDidChange` is supported
/// natively so this settings have no impact.
@objc public enum PinSafeAreaInsetsDidChangeMode: Int {
    /// PinLayout won't call `UIView.safeAreaInsetsDidChange` on iOS 8/9/10.
    case disable
    /// PinLayout will call `UIView.safeAreaInsetsDidChange` only if the UIView implement the PinSafeAreaInsetsUpdate protocol.
    case optIn
    /// PinLayout will automatically calls `UIView.safeAreaInsetsDidChange` if the view has implemented this method.
    case always
}
