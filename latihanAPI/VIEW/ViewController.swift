//
//  ViewController.swift
//  latihanAPI
//
//  Created by Phincon on 14/03/23.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel : CommentViewModel?
    private var modelListComment : [Comment]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let apiServiceComment = APIServiceComment(url: "google.com")
        registerTableView()
//        self.viewModel = CommentViewModel(urlString: "https://jsonplaceholder.typicode.com/comments")
        self.viewModel = CommentViewModel(urlString: "https://jsonplaceholder.typicode.com/comments", apiService: ApiService())
        self.viewModel?.bindCommentData = {commentListModel in
            if let commentListModel = commentListModel {
                self.modelListComment = commentListModel
                self.tableView.backgroundColor = .blue
            } else {
                self.tableView.backgroundColor = .red
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func registerTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: CommentTableViewCell.identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.modelListComment?.count ?? 2
        print(count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else {
            return UITableViewCell()
        }
        
        cell.postIdLabel.text = "\(String(describing: self.modelListComment?[indexPath.row].postId ?? 0))"
        cell.idLabel.text = "\(String(describing: self.modelListComment?[indexPath.row].id ?? 0))"
        cell.nameLabel.text = self.modelListComment?[indexPath.row].name
        cell.emailLabel.text = self.modelListComment?[indexPath.row].email
        cell.bodyLabel.text = self.modelListComment?[indexPath.row].body
        return cell
    }

}

