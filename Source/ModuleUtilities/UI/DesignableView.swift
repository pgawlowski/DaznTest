//
//  DesignableView.swift
//  Dazn
//
//  Created by Piotr Gawlowski on 09/04/2019.
//  Copyright © 2019 Piotr Gawlowski. All rights reserved.
//

import RxSwift
import UIKit

protocol DesignableProtocol {
    var nib: String? { get }
}

@IBDesignable
class DesignableView: UIView, DesignableProtocol {

    @IBOutlet var content: UIView!

    lazy var disposeBag = DisposeBag()

    var nib: String? {
        return nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        content?.prepareForInterfaceBuilder()
    }

    open func setup() {
        xibSetup()
    }

    open func prepareForReuse() {
        disposeBag = DisposeBag()
    }

    internal func xibSetup() {
        guard let nibName = self.nib else { return print("////@IBDesignable nib name not found or empty") }

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }

        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        content = view
    }
}
