//
//  ViewController.swift
//  369Game
//
//  Created by 박준우 on 1/8/25.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    let numberPickerView: UIPickerView = UIPickerView()
    
    var maxNumber: Int = 1
    
    var clapCount: Int {
        var count = 0
        // TODO: String의 .count 말고 순회 도는 더 좋은 방법있을까?
        Array(1...maxNumber).forEach { number in
            let _ = String(number).count { num in
                if num == "3" || num == "6" || num == "9" {
                    count += 1
                }
                return true
            }
        }
        return count
    }
    
    var clapArrayString: String {
        var clapArray: [String] = []
        Array(1...maxNumber).forEach { number in
            var clapString: String = ""
            let _ = String(number).count { num in
                if num == "3" || num == "6" || num == "9" {
                    clapString += "👏"
                } else {
                    clapString += "\(num)"
                }
                return true
            }
            clapArray.append(clapString)
        }
        return clapArray.joined(separator: ", ")
    }
    
    var countClapString: String {
        return "숫자 \(maxNumber)까지 총 박수는 \(clapCount)번 입니다."
    }
    
    var numberArray: [Int] {
        return Array(1...100).reversed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberPickerView.delegate = self
        numberPickerView.dataSource = self
        
        setTitleLabel()
        setTextField()
        setTextView()
        setCountLabel()
    }
    
    func setTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.text = "369 게임"
    }
    
    func setTextField() {
        textField.delegate = self
        
        textField.borderStyle = UITextField.BorderStyle.line
        textField.textAlignment = NSTextAlignment.center
        textField.attributedPlaceholder = NSAttributedString(string: "최대 숫자를 입력해주세요", attributes: [.foregroundColor: UIColor.systemGray, .font: UIFont.boldSystemFont(ofSize: 16)])
        textField.font = .boldSystemFont(ofSize: 24)
        textField.text = "\(maxNumber)"
        textField.inputView = numberPickerView
    }
    
    func setCountLabel() {
        countLabel.numberOfLines = 0
        countLabel.textAlignment = .center
        countLabel.font = UIFont.boldSystemFont(ofSize: 32)
        countLabel.text = countClapString
    }
    
    // TODO: verticalAlignment 조절하는 법
    func setTextView() {
        setTextViewText()
        textView.textAlignment = .center
        textView.isSelectable = false
        textView.textColor = .systemGray
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        
    }
    func setTextViewText() {
        textView.text = clapArrayString
        textView.textContainerInset.top = (textView.frame.height / 2) - CGFloat((textView.text.count / 49) * 16)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(numberArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedNumber = numberArray[row]
        maxNumber = selectedNumber
        textField.text = String(selectedNumber)
        countLabel.text = countClapString
        setTextViewText()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

