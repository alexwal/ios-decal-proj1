//
//  DetailViewController.swift
//  TodoList
//
//  Created by awal on 10/16/16.
//  Copyright © 2016 Alex Walczak. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField? = UITextField()
    @IBOutlet var notesTextView: UITextView? = UITextView()
    var storedToDoData:NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        // we'll use viewDidLoad because once it's possible for it to appear, we won't reload it. It doesn't change, so don't waste resources writing a viewDidAppear func.
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleTextField?.isUserInteractionEnabled = false
        notesTextView?.isUserInteractionEnabled = false
        
        // load the stored to do item
        
        // set the text field once when view loads.
        titleTextField?.text = storedToDoData.object(forKey: "itemTitle") as! String?
        notesTextView?.text = storedToDoData.object(forKey: "itemNote") as! String!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteItem(_ sender: AnyObject) {
        // not mutable -v
        var userDefaults:UserDefaults = UserDefaults.standard
        
        // also not mutable bc the items in the list come from UserDefaults -v (?)
        var itemListArray:NSMutableArray? = userDefaults.object(forKey: "itemList") as? NSMutableArray
        
        // this will be mutable
        var mutableItemList:NSMutableArray = NSMutableArray()
        
        if ((itemListArray) != nil) {
            for dict:Any in itemListArray! {
                mutableItemList.add(dict as! NSDictionary)
                print("hi1")
            }
        }
        mutableItemList.remove(storedToDoData)
        userDefaults.removeObject(forKey: "itemList")
        userDefaults.set(mutableItemList, forKey: "itemList")
        userDefaults.synchronize()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func completeItem(_ sender: AnyObject) {
        var userDefaults:UserDefaults = UserDefaults.standard
        var completedList:NSMutableArray? = userDefaults.object(forKey: "completedList") as? NSMutableArray
        var mutableCompletedList:NSMutableArray = NSMutableArray()
        
        let timestamp:NSDate = NSDate()
        
        print(completedList)
        if ((completedList) != nil) {
            for ts:Any in completedList! {
                mutableCompletedList.add(ts as! NSDate)
            }
        }
        mutableCompletedList.add(timestamp as! NSDate)
        userDefaults.removeObject(forKey: "completedList")
        userDefaults.set(mutableCompletedList, forKey: "completedList")
        userDefaults.synchronize()
        self.deleteItem(self)
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
