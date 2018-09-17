//
//  MainVC.swift
//  binarycounter
//
//  Created by Ashwin Chalaka on 9/17/18.
//  Copyright © 2018 Ashwin Chalaka. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    // Whenever we add or subtract we have to update the total in the View Controller...
    // For that we need a delegate to let the view controller know when the total display should be added or subtracted from
    var delegate: CustomCellDelegate?
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        delegate?.updateTotal(Int(cellLabel.text!)!)
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        delegate?.updateTotal(Int(cellLabel.text!)! * -1)
    }
}

protocol CustomCellDelegate: class {
    func updateTotal(_ num: Int)
}

class MainVC: UIViewController {

    let numOfSecs = 1
    let numOfRows = 16
    
    var currentTotal = 0
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        totalLabel.text = "Total: \(currentTotal)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numOfSecs
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellID", for: indexPath) as! CustomCell
        cell.delegate = self
        cell.cellLabel.text = "\(pow(10, indexPath.row))"
        return cell
    }
}

extension MainVC: CustomCellDelegate {
    func updateTotal(_ num: Int) {
        currentTotal += num
        totalLabel.text = "Total: \(currentTotal)"
    }
}
