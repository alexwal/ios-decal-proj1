//
//  AddViewController.swift
//  TodoList
//
//  Created by awal on 10/16/16.
//  Copyright © 2016 Alex Walczak. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField! = UITextField()
    @IBOutlet var notesTextView: UITextView! = UITextView()
    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonTapped(_ sender: AnyObject) {
        var userDefaults:UserDefaults = UserDefaults.standard
        var itemList:NSMutableArray? = userDefaults.object(forKey: "itemList") as? NSMutableArray
        
        // adding new item
        var dataSet:NSMutableDictionary = NSMutableDictionary()
        dataSet.setValue(titleTextField.text, forKey: "itemTitle")
        dataSet.setValue(notesTextView.text, forKey: "itemNote")
        
        // putting all todolist items (dicts) into an array (itemList)
        if ((itemList) != nil) {
            // we already have items stored
            
            // userdefaults data not mutable
            var newMutableList:NSMutableArray = NSMutableArray()
            for dict:Any in itemList! {
                newMutableList.add(dict as! NSDictionary)
            }
            userDefaults.removeObject(forKey: "itemList")
            newMutableList.add(dataSet)
            userDefaults.set(newMutableList, forKey: "itemList")
            
        } else {
            // we currently have no items stored
            // userDefaults.removeObject(forKey: "itemList")
            itemList = NSMutableArray()
            itemList!.add(dataSet)
            // Save array in userdefaults
            userDefaults.set(itemList, forKey: "itemList") // ERROR!
        }
        userDefaults.synchronize()
        self.navigationController!.popToRootViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
