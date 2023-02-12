//
//  BaseViewController.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import UIKit
import NVActivityIndicatorView
import Toast_Swift
import RxSwift
import RxCocoa
import SkeletonView

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    var disposeBag = DisposeBag()
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40.0, height: 40.0))

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupIndicatorView()
        hideKeyboardWhenTappedAround()
        
        // Enable swipe gesture back
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .light {
                if #available(iOS 13.0, *) {
                    return .darkContent
                } else {
                    return .default
                }
            } else {
                return .lightContent
            }
        } else {
            return .default
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.type = .circleStrokeSpin
        activityIndicatorView.color = Colors.AppBaseDarkBlueColor.color()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
        
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func keyboardHeight() -> Observable<CGFloat> {
        return Observable
            .from([
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
                    .map { notification -> CGFloat in
                        (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                    },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { _ -> CGFloat in
                        0
                    }
                ])
            .merge()
    }
    
    func bindErrorStateInViewModel(_ viewModel: BaseViewModel) {
        bindErrorStateToast(viewModel)
        viewModel.errorModelObservable
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] errorModel in
                self.showError(errorModel)
            }).disposed(by: disposeBag)
    }
    
    func bindErrorStateToast(_ viewModel: BaseViewModel) {
        viewModel.errorModelObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] errorModel in
                guard let errorModel = errorModel else { return }
                self?.showToastError(errorModel)
            }).disposed(by: disposeBag)
    }
    
    func showToastMessage(_ message: String, isAppWindow: Bool = false) {
        var style = ToastStyle()
        style.backgroundColor = UIColor(red: 255.0 / 255.0, green: 229.0 / 255.0, blue: 232.0 / 255.0, alpha: 1)
        style.messageColor = UIColor(red: 54.0 / 255.0, green: 64.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        style.cornerRadius = 4
        style.messageFont = Fonts.Regular.font(12)
        style.messageAlignment = .center
        let toastView = createDefaultToastView(message: message, title: nil, image: nil, style: style)
        let point = CGPoint(x: view.bounds.size.width / 2.0, y: ( UIScreen.main.bounds.size.height - (toastView.frame.size.height / 2.0)) - 100)
        view.showToast(toastView, duration: 5.0, point: point, completion: nil)
    }
    
    func showToastWithMessage(message: String, type: ToastType, duration: TimeInterval = 5) {
        UIApplication.shared.keyWindow?.makeTokoDefaultToast(message, type: type, duration: duration)
    }
    
    func showToast(message: String, isShowInAppWindow: Bool = false, backgroundColor: UIColor? = nil, textColor: UIColor? = nil) {
        var style = ToastStyle()
        
        if let textColor = textColor {
            style.messageColor = textColor
        }
                
        if let backgroundColor = backgroundColor {
            style.backgroundColor = backgroundColor
        }
        
        style.messageFont = Fonts.Regular.font(12)
        style.messageAlignment = .center
        style.cornerRadius = 8
        
        var appView: UIView?
        
        if isShowInAppWindow {
           appView = UIApplication.shared.keyWindow
        } else {
            appView = view
        }
        
        let toastView = createDefaultToastView(message: message, title: nil, image: nil, style: style)
        let point = CGPoint(x: view.bounds.size.width / 2.0, y: (UIScreen.main.bounds.size.height - (toastView.frame.size.height / 2.0)) - 100)
        appView?.showToast(toastView, duration: 2.0, point: point, completion: nil)
        
        // toggle "tap to dismiss" functionality
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.isQueueEnabled = true
    }
    
    // TODO: create better default view for generics toast
    func createDefaultToastView(message: String?, title: String?, image: UIImage?, style: ToastStyle) -> UIView {
        var messageLabel: UILabel?
        var titleLabel: UILabel?
        var imageView: UIImageView?
        
        let wrapperView = UIView()
        wrapperView.backgroundColor = style.backgroundColor
        wrapperView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin]
        wrapperView.layer.cornerRadius = style.cornerRadius
        wrapperView.layer.borderWidth = 1
        wrapperView.layer.borderColor = UIColor(red: 217.0 / 255.0, green: 0 / 255.0, blue: 27.0 / 255.0, alpha: 1).withAlphaComponent(0.5).cgColor
        
        if style.displayShadow {
            wrapperView.layer.shadowColor = UIColor.black.cgColor
            wrapperView.layer.shadowOpacity = style.shadowOpacity
            wrapperView.layer.shadowRadius = style.shadowRadius
            wrapperView.layer.shadowOffset = style.shadowOffset
        }
        
        if let image = image {
            imageView = UIImageView(image: image)
            imageView?.contentMode = .scaleAspectFit
            imageView?.frame = CGRect(x: style.horizontalPadding, y: style.verticalPadding, width: style.imageSize.width, height: style.imageSize.height)
        }
        
        var imageRect = CGRect.zero
        
        if let imageView = imageView {
            imageRect.origin.x = style.horizontalPadding
            imageRect.origin.y = style.verticalPadding
            imageRect.size.width = imageView.bounds.size.width
            imageRect.size.height = imageView.bounds.size.height
        }

        if let title = title {
            titleLabel = UILabel()
            titleLabel?.numberOfLines = style.titleNumberOfLines
            titleLabel?.font = style.titleFont
            titleLabel?.textAlignment = style.titleAlignment
            titleLabel?.lineBreakMode = .byTruncatingTail
            titleLabel?.textColor = style.titleColor
            titleLabel?.backgroundColor = UIColor.clear
            titleLabel?.text = title;
            
            let maxTitleSize = CGSize(width: (self.view.bounds.size.width * style.maxWidthPercentage) - imageRect.size.width,
                                      height: self.view.bounds.size.height * style.maxHeightPercentage)
            let titleSize = titleLabel?.sizeThatFits(maxTitleSize)
            if let titleSize = titleSize {
                titleLabel?.frame = CGRect(x: 0.0, y: 0.0, width: titleSize.width, height: titleSize.height)
            }
        }
        
        if let message = message {
            messageLabel = UILabel()
            messageLabel?.text = message
            messageLabel?.numberOfLines = style.messageNumberOfLines
            messageLabel?.font = style.messageFont
            messageLabel?.textAlignment = style.messageAlignment
            messageLabel?.lineBreakMode = .byTruncatingTail;
            messageLabel?.textColor = style.messageColor
            messageLabel?.backgroundColor = UIColor.clear
            
            let maxMessageSize = CGSize(width: (self.view.bounds.size.width * style.maxWidthPercentage) - imageRect.size.width,
                                        height: self.view.bounds.size.height * style.maxHeightPercentage)
            let messageSize = messageLabel?.sizeThatFits(maxMessageSize)
            if let messageSize = messageSize {
                let actualWidth = UIScreen.main.bounds.width - 64
                //min(messageSize.width, maxMessageSize.width)
                let actualHeight = min(messageSize.height, maxMessageSize.height)
                messageLabel?.frame = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
            }
        }
  
        var titleRect = CGRect.zero
        
        if let titleLabel = titleLabel {
            titleRect.origin.x = imageRect.origin.x + imageRect.size.width + style.horizontalPadding
            titleRect.origin.y = style.verticalPadding
            titleRect.size.width = titleLabel.bounds.size.width
            titleRect.size.height = titleLabel.bounds.size.height
        }
        
        var messageRect = CGRect.zero
        
        if let messageLabel = messageLabel {
            messageRect.origin.x = imageRect.origin.x + imageRect.size.width + style.horizontalPadding
            messageRect.origin.y = titleRect.origin.y + titleRect.size.height + style.verticalPadding
            messageRect.size.width = messageLabel.bounds.size.width
            messageRect.size.height = messageLabel.bounds.size.height
        }
        
        let longerWidth = max(titleRect.size.width, messageRect.size.width)
        //let longerX = max(titleRect.origin.x, messageRect.origin.x)
        let wrapperWidth = UIScreen.main.bounds.width - 32
        //max((imageRect.size.width + (style.horizontalPadding * 2.0)), (longerX + longerWidth + style.horizontalPadding))
        let wrapperHeight = max((messageRect.origin.y + messageRect.size.height + style.verticalPadding), (imageRect.size.height + (style.verticalPadding * 2.0)))
        
        wrapperView.frame = CGRect(x: 0.0, y: 0.0, width: wrapperWidth, height: wrapperHeight)
        
        if let titleLabel = titleLabel {
            titleRect.size.width = longerWidth
            titleLabel.frame = titleRect
            wrapperView.addSubview(titleLabel)
        }
        
        if let messageLabel = messageLabel {
            messageRect.size.width = longerWidth
            messageLabel.frame = messageRect
            wrapperView.addSubview(messageLabel)
        }
        
        if let imageView = imageView {
            wrapperView.addSubview(imageView)
        }
        
        return wrapperView
    }

    func showError(_ errorModel: ResponseErrorModel?) {
        if let validErrorModel = errorModel {
            if let statusCode = validErrorModel.status, statusCode.intValue == NSURLErrorNotConnectedToInternet { //Show login for Unauthorized access
                self.showToastMessage("Internet connection not available.")
            } else {
                if let validUnauthorisedCode = validErrorModel.status, validUnauthorisedCode == 401 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        if let validTokenExpireMessage = validErrorModel.detail {
                            self.showToastMessage(validTokenExpireMessage, isAppWindow: true)
                        }
                    })
                }
            }
        }
    }
    
    func showToastError(_ errorModel: ResponseErrorModel) {
        if errorModel.status?.intValue == NSURLErrorNotConnectedToInternet {
            let description = "Internet connection not available"
            showToastMessage(description)
        } else {
            guard let descriptionMessage = errorModel.detail else { return }
            showToast(message: descriptionMessage, isShowInAppWindow: true, backgroundColor: UIColor(red: 255.0 / 255.0, green: 229.0 / 255.0, blue: 232.0 / 255.0, alpha: 1), textColor: UIColor(red: 54.0 / 255.0, green: 64.0 / 255.0, blue: 79.0 / 255.0, alpha: 1))
        }
    }

    func showAlertWithTitleAndMessage(title: String? = "Alert", message: String, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler))
            self.present(alert, animated: true, completion: {
            })
        }
    }

}
