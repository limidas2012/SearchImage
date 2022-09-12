//
//  ImageListViewController.swift
//  SearchImage
//
//  Created by Limi Das on 11/09/22.
//  Copyright © 2022 Limi Das. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {
    
    let viewModel:ImageListViewModel = ImageListViewModel()
    @IBOutlet weak var  tableView: UITableView!
    @IBOutlet weak var  activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.implementViewModel()
        self.viewModel.initiate()
        self.tableView.dataSource = self
        self.tableView.delegate = self
       // self.tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchImageDataFromServer()

    }
    
    func implementViewModel(){
        
        //spinner
        self.viewModel.showSpinner = {shouldShow in
            DispatchQueue.main.async {
                if shouldShow {
                    //show and start spinner
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                }else{
                    //close and hide this spinner
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    
                }
            }
        }
        
        //tablevw
        self.viewModel.showTableView = {shouldShow in
            DispatchQueue.main.async {
                if shouldShow {
                    //show and start tablevw
                    self.tableView.isHidden = false
                    
                }else{
                    //close and hide this tablevw
                     self.tableView.isHidden = true
                }
            }
        }
        
        // reload tablevw
           self.viewModel.reloadTableView = {
               DispatchQueue.main.async {
                self.tableView.reloadData()
               }
           }
    }
    
    
    
}

extension ImageListViewController: UITableViewDataSource, UITableViewDelegate{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("tableview cell count")
//        print(self.viewModel.images.count)
        return self.viewModel.images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
        let model = self.viewModel.images[indexPath.row]
        print(model.name)
        cell.lblName.text = model.name
//        print("tableview cell")
//        print(cell.lblName.text)
        
        return cell
    }
}
