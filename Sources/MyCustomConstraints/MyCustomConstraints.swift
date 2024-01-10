// The Swift Programming Language
// https://docs.swift.org/swift-book
// MARK: - Constraint APIs

import Foundation
import UIKit

extension UIView {
    // MARK: Fill
    @discardableResult
    public func fill(into: UIView) -> UIView {
        return fit(into: into, forceAdd: false, margins: [
            .leading: .init(),
            .trailing: .init(),
            .top: .init(),
            .bottom: .init()
        ], shouldLayOut: true)
    }
    
    @discardableResult
    public func fill(into: UIView, insets: UIEdgeInsets) -> UIView {
        return fit(into: into, forceAdd: false, margins: [
            .leading: .init(constant: insets.left),
            .trailing: .init(constant: insets.right),
            .top: .init(constant: insets.top),
            .bottom: .init(constant: insets.bottom)
        ], shouldLayOut: true)
    }

    @discardableResult
    public func fill(into: UIView, forceAdd: Bool = false) -> UIView {
        return fit(into: into, forceAdd: forceAdd, margins: [
            .leading: .init(),
            .trailing: .init(),
            .top: .init(),
            .bottom: .init()
        ], shouldLayOut: true)
    }

    @discardableResult
    public func fill(into: UIView, shouldLayOut: Bool = false) -> UIView {
        return fit(into: into, forceAdd: false, margins: [
            .leading: .init(),
            .trailing: .init(),
            .top: .init(),
            .bottom: .init()
        ], shouldLayOut: shouldLayOut)
    }
    
    // MARK: Fit
    @discardableResult
    public func fitCenter(into: UIView, forceAdd: Bool = false) -> UIView {
        return fit(into: into, forceAdd: forceAdd, alignments: [
            .centerX: ConstraintAttributeValue(multiplier: 1),
            .centerY: ConstraintAttributeValue(multiplier: 1)
        ])
    }

    @discardableResult
    public func fit(into: UIView, forceAdd: Bool = false, margins: [MarginAttribute: ConstraintAttributeValue], shouldLayOut: Bool = true) -> UIView {
        if into.subviews.contains(self) && forceAdd {
            into.addSubview(self)
        } else if !into.subviews.contains(self) {
            into.addSubview(self)
        }
        guard into.subviews.contains(self) else { return self }
        enableAutoLayoutIfNeeded()
        let constraintList = self.prepareConstraints(into, margins: margins)
        NSLayoutConstraint.activate(constraintList)
        if shouldLayOut {
            layoutIfNeeded()
        }
        return self
    }

    @discardableResult
    public func fit(into: UIView, forceAdd: Bool = false, alignments: [AlignmentAttribute: ConstraintAttributeValue]) -> UIView {
        if into.subviews.contains(self) && forceAdd {
            into.addSubview(self)
        } else if !into.subviews.contains(self) {
            into.addSubview(self)
        }
        guard into.subviews.contains(self) else { return self }
        enableAutoLayoutIfNeeded()
        let constraintList = self.prepareConstraints(into, alignments: alignments)
        NSLayoutConstraint.activate(constraintList)
        layoutIfNeeded()
        return self
    }

    // MARK: Sizing
    /// Set static width to view
    /// - Note: UITemporaryLayoutWidth is added when layoutIfNeeded is called before layoutSubviews
    @discardableResult
    public func setWidth(_ widthConstant: CGFloat, shouldLayout: Bool = false) -> UIView {
        enableAutoLayoutIfNeeded()
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: widthConstant)
        ])
        if shouldLayout {
            layoutIfNeeded()
        }
        return self
    }

    /// Set static height to view
    /// - Note: UITemporaryLayoutHeight is added when layoutIfNeeded is called before layoutSubviews
    @discardableResult
    public func setHeight(_ heightConstant: CGFloat, shouldLayout: Bool = false) -> UIView {
        enableAutoLayoutIfNeeded()
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: heightConstant)
        ])
        if shouldLayout {
            layoutIfNeeded()
        }
        return self
    }

    @discardableResult
    public func setAspect(attribute: AspectRatioAttribute, _ value: ConstraintAttributeValue) -> UIView {
        enableAutoLayoutIfNeeded()
        let constraintList = self.prepareConstraints(self, attribute: attribute, value: value)
        NSLayoutConstraint.activate(constraintList)
        layoutIfNeeded()
        return self
    }

    // MARK: Segment
    @discardableResult
    public func leading(to: UIView, _ value: ConstraintAttributeValue? = nil, shouldLayOut: Bool = true) -> UIView {
        enableAutoLayoutIfNeeded()
        let valueModel = value ?? .init()
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: to, attribute: .leading, multiplier: valueModel.multiplier, constant: valueModel.constant)
        NSLayoutConstraint.activate([constraint])
        if shouldLayOut {
            layoutIfNeeded()
        }
        return self
    }

    @discardableResult
    public func trailing(to: UIView, _ value: ConstraintAttributeValue? = nil, shouldLayOut: Bool = true) -> UIView {
        enableAutoLayoutIfNeeded()
        let valueModel = value ?? .init()
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: to, attribute: .trailing, multiplier: valueModel.multiplier, constant: valueModel.constant)
        NSLayoutConstraint.activate([constraint])
        if shouldLayOut {
            layoutIfNeeded()
        }
        return self
    }

    @discardableResult
    public func top(to: UIView, _ value: ConstraintAttributeValue? = nil, shouldLayOut: Bool = true) -> UIView {
        enableAutoLayoutIfNeeded()
        let valueModel = value ?? .init()
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: to, attribute: .top, multiplier: valueModel.multiplier, constant: valueModel.constant)
        NSLayoutConstraint.activate([constraint])
        if shouldLayOut {
            layoutIfNeeded()
        }
        return self
    }

    @discardableResult
    public func bottom(to: UIView, _ value: ConstraintAttributeValue? = nil, shouldLayOut: Bool = true) -> UIView {
        enableAutoLayoutIfNeeded()
        let valueModel = value ?? .init()
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: to, attribute: .bottom, multiplier: valueModel.multiplier, constant: valueModel.constant)
        NSLayoutConstraint.activate([constraint])
        if shouldLayOut {
            layoutIfNeeded()
        }
        return self
    }
    
    @discardableResult
    public func centerX(to: UIView, _ value: CGFloat = 0) -> UIView {
        enableAutoLayoutIfNeeded()
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: to, attribute: .centerX, multiplier: 1.0, constant: value)
        NSLayoutConstraint.activate([constraint])
        layoutIfNeeded()
        return self
    }
    
    @discardableResult
    public func centerY(to: UIView, _ value: CGFloat = 0) -> UIView {
        enableAutoLayoutIfNeeded()
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: to, attribute: .centerY, multiplier: 1.0, constant: value)
        NSLayoutConstraint.activate([constraint])
        layoutIfNeeded()
        return self
    }

    @discardableResult
    public func proportion(_ to: UIView, attribute: ProportionAttribute, value: ConstraintAttributeValue) -> UIView {
        enableAutoLayoutIfNeeded()
        var constraintList: [NSLayoutConstraint] = .init()
        if attribute == .width {
            constraintList.append(.init(item: self, attribute: .width, relatedBy: .equal, toItem: to, attribute: .width, multiplier: value.multiplier, constant: value.constant))
        } else if attribute == .height {
            constraintList.append(.init(item: self, attribute: .height, relatedBy: .equal, toItem: to, attribute: .height, multiplier: value.multiplier, constant: value.constant))
        }
        NSLayoutConstraint.activate(constraintList)
        layoutIfNeeded()
        return self
    }

    @discardableResult
    public func chain(_ selfAttribute: MarginAttribute, to: UIView, targetAttribute: MarginAttribute, value: ConstraintAttributeValue, shouldLayOut: Bool = true) -> UIView {
        enableAutoLayoutIfNeeded()
        let chainConstraint = NSLayoutConstraint(
            item: self,
            attribute: selfAttribute.toNSLayoutAttribute,
            relatedBy: .equal,
            toItem: to,
            attribute: targetAttribute.toNSLayoutAttribute,
            multiplier: value.multiplier, constant: value.constant
        )
        NSLayoutConstraint.activate([chainConstraint])
        if shouldLayOut {
            layoutIfNeeded()
        }
        return self
    }
}

// MARK: - Helpers
extension UIView {
    private func prepareConstraints(_ into: UIView, margins: [MarginAttribute: ConstraintAttributeValue]) -> [NSLayoutConstraint] {
        var constraintList = [NSLayoutConstraint]()
        if let leading = margins[.leading] {
            constraintList.append(.init(item: self, attribute: .leading, relatedBy: .equal, toItem: into, attribute: .leading, multiplier: leading.multiplier, constant: leading.constant))
        }
        if let trailing = margins[.trailing] {
            constraintList.append(.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: into, attribute: .trailing, multiplier: trailing.multiplier, constant: trailing.constant))
        }
        if let top = margins[.top] {
            constraintList.append(.init(item: self, attribute: .top, relatedBy: .equal, toItem: into, attribute: .top, multiplier: top.multiplier, constant: top.constant))
        }
        if let bottom = margins[.bottom] {
            constraintList.append(.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: into, attribute: .bottom, multiplier: bottom.multiplier, constant: bottom.constant))
        }
        return constraintList
    }

    private func prepareConstraints(_ into: UIView, alignments: [AlignmentAttribute: ConstraintAttributeValue]) -> [NSLayoutConstraint] {
        var constraintList = [NSLayoutConstraint]()
        if let centerXValue = alignments[.centerX] {
            constraintList.append(.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: into, attribute: .centerX, multiplier: centerXValue.multiplier, constant: centerXValue.constant))
        }
        if let centerYValue = alignments[.centerY] {
            constraintList.append(.init(item: self, attribute: .centerY, relatedBy: .equal, toItem: into, attribute: .centerY, multiplier: centerYValue.multiplier, constant: centerYValue.constant))
        }
        return constraintList
    }

    private func prepareConstraints(_ onto: UIView, attribute: AspectRatioAttribute, value: ConstraintAttributeValue) -> [NSLayoutConstraint] {
        var constraintList = [NSLayoutConstraint]()
        if attribute == .widthToHeight {
            constraintList.append(.init(item: onto, attribute: .width, relatedBy: .equal, toItem: onto, attribute: .height, multiplier: value.multiplier, constant: value.constant))
        } else if attribute == .heightToWidth {
            constraintList.append(.init(item: onto, attribute: .height, relatedBy: .equal, toItem: onto, attribute: .width, multiplier: value.multiplier, constant: value.constant))
        }
        return constraintList
    }

    private func enableAutoLayoutIfNeeded() {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

public enum MarginAttribute: Hashable {
    case top
    case bottom
    case leading
    case trailing

    public var toNSLayoutAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

public enum AlignmentAttribute: Hashable {
    case centerX
    case centerY
}

public enum MarginPreserveAttribute: Hashable {
    case topPreserve
    case bottomPreserve
    case leadingPreserve
    case trailingPreserve
}

public enum AlignmentPreserveAttribute: Hashable {
    case centerXPreserve
    case centerYPreserve
}

public enum AspectRatioAttribute: Hashable {
    case widthToHeight
    case heightToWidth
}

public enum ProportionAttribute: Hashable {
    case width
    case height
}

public struct ConstraintAttributeValue {
    var constant: CGFloat
    var multiplier: CGFloat

    public init() {
        self.constant = 0
        self.multiplier = 1
    }

    public init(constant: CGFloat) {
        self.constant = constant
        self.multiplier = 1
    }

    public init(multiplier: CGFloat) {
        self.constant = 0
        self.multiplier = multiplier
    }

    public init(constant: CGFloat, multiplier: CGFloat) {
        self.constant = constant
        self.multiplier = multiplier
    }
}
