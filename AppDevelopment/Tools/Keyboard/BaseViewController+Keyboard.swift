//
//  BaseViewController+Keyboard.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-12.
//

import UIKit

extension BaseViewController {
    
    // MARK: - Keyboard notifications
    func addKeyboardObserversFor(scrollView: UIScrollView) {
        keyboardWillHideNotification = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                                                              object: nil,
                                                                              queue: .main) {
            [weak self, unowned scrollView] notification in
            self?.onShowKeyboard(notification: notification, scrollView: scrollView)
        }
        
        keyboardWillShowNotification = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                                                              object: nil,
                                                                              queue: .main) {
            [weak self, unowned scrollView] notification in
            self?.onHideKeyboard(notification: notification, scrollView: scrollView)
        }
    }
    
    func onShowKeyboard(notification: Notification, scrollView: UIScrollView) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardViewEndFrame = self.view.convert(keyboardFrame.cgRectValue, from: self.view.window)
        
        UIView.animate(withDuration: duration, animations: {
            scrollView.contentInset =
            UIEdgeInsets(top: 0,
                         left: 0,
                         bottom:
                            keyboardViewEndFrame.height - self.view.safeAreaInsets.bottom,
                         right: 0)
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        })
    }
    
    func onHideKeyboard(notification: Notification, scrollView: UIScrollView) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        UIView.animate(withDuration: duration, animations: {
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        })
    }
}
