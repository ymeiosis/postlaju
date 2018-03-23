//
//  IdeaDetailViewController.swift
//  postlaju
//
//  Created by Ying Mei Lum on 21/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit

class IdeaDetailViewController: UIViewController {
    var selectedIdea : Idea = Idea()
    let myPickerData = [String](arrayLiteral: "Incomplete", "Unstarted", "In Progress", "Complete")

//    @IBAction func backBtn(_ sender: Any) {
//    backIdeaVC()
//    }
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var detailtitle: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var status: UITextField!
    @IBAction func location(_ sender: Any) {
    }
    @IBOutlet weak var detaildescription: UITextView!
    @IBOutlet weak var detaillikes: UILabel!
    
    @IBOutlet weak var detaildislikes: UILabel!
    
    @IBOutlet weak var detailcomments: UILabel! {
        didSet {
            detailcomments.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(commentLabelTapped))
            detailcomments.addGestureRecognizer(tap)
        }
    }
    
    @objc func commentLabelTapped() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController else {return}
        vc.selectedIdea = selectedIdea
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func saveBtn(_ sender: Any) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
        let thePicker = UIPickerView()
        status.inputView = thePicker
        thePicker.delegate = self
        self.navigationController?.isNavigationBarHidden = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDetails() {
        detailtitle.text = selectedIdea.caption
        detaildescription.text = selectedIdea.description
        date.text = String(selectedIdea.date)
//        status.text = selectedIdea.status
        detaillikes.text = String(describing: selectedIdea.likes)
        detaildislikes.text = String(describing: selectedIdea.dislikes)
    }
//    func backIdeaVC() {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        
//        guard let navVc = storyboard.instantiateViewController(withIdentifier: "IdeaListViewController") as? UIViewController else {return}
//        
//        self.present(navVc, animated: true, completion: nil)
//    }
//    
}

func saveDetails() {

}

extension IdeaDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        status.text = myPickerData[row]
    }

    
}
