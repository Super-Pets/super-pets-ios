import UIKit

final class RegisterTextFieldComponent: UIView, ViewConfiguration {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Strings.Color.white)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var inputText: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = UIColor(named: Strings.Color.darkGray)
        textView.backgroundColor = UIColor(named: Strings.Color.white)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.text = placeholderText
        label.textColor = UIColor(named: Strings.Color.lightGray)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private var backgroundViewHeightConstraint: NSLayoutConstraint?
    private let minimumHeight: CGFloat = 66
    private var placeholderText: String
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
        super.init(frame: .zero)
        inputText.delegate = self
        buildLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    func getCurrentText() -> String {
        return inputText.text
    }
    
    private func adjustTextViewHeight() {
        let newSize = inputText.sizeThatFits(CGSize(width: inputText.frame.width, height: .infinity))
        let newHeight = max(newSize.height, 66)
        backgroundViewHeightConstraint?.constant = newHeight
    }
    
    func setFirstResponder(isFirstResponder: Bool) {
        if isFirstResponder {
            inputText.becomeFirstResponder()
        } else {
            inputText.resignFirstResponder()
        }
    }
    
    func configureViews() {
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        backgroundView.isUserInteractionEnabled = true
        inputText.becomeFirstResponder()
        inputText.layoutIfNeeded()
    }
    
    func buildViewHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(inputText)
        inputText.addSubview(placeholderLabel)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backgroundView.heightAnchor.constraint(greaterThanOrEqualToConstant: minimumHeight),
            
            inputText.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            inputText.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 24),
            inputText.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -16),
            inputText.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -24),
            
            placeholderLabel.topAnchor.constraint(equalTo: inputText.topAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: inputText.leadingAnchor)
        ])
        
        adjustTextViewHeight()
    }
}


extension RegisterTextFieldComponent: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: frame.width, height: .infinity)
        var estimatedSize = inputText.sizeThatFits(size)
        
        if textView.text.last == "\n" {
            estimatedSize.height += textView.font?.lineHeight ?? 0
        }
        
        let newHeight = max(estimatedSize.height, 66)
        backgroundViewHeightConstraint?.constant = newHeight
        
        if textView.text.isEmpty && textView.isFirstResponder {
            placeholderLabel.isHidden = false
        } else {
            placeholderLabel.isHidden = !textView.text.isEmpty
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholderLabel.isHidden = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !inputText.text.isEmpty
    }
}
