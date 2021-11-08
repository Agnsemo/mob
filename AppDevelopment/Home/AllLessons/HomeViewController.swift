//
//  HomeViewController.swift
//  AppDevelopment
//
//  Created by Agne  on 2021-10-13.
//

import UIKit

class HomeViewController: UIViewController, UISearchResultsUpdating {
   
    @IBOutlet var tableView: UITableView!
    
    var searchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()
    
    var dataModel: HomeDataModel!
    
    override func viewWillAppear(_ animated: Bool) {
        dataModel.updateLessons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataModel = HomeDataModel(onUpdate: {
            self.tableView.reloadData()
        })
        
        dataModel.updateLessons()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellNib(withType: HomeTableViewCell.self)
        
        setupSearchController(with: "Search")
        setupRefreshControl(tintColor: .gray)
        setupSorting()
        GetLecturesOperation().getLectures()
        
        title = "All lectures"
    }
    
    // MARK: - Navigation
    func showEditView(lesson: Lesson) {
        let viewController = EditLessonsViewController(lecturesID: lesson.id, date: lesson.date, lectureName: lesson.name, studentsGroup: lesson.group, place: lesson.place)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showRegisterView(lesson: Lesson) {
        let viewController = RegisterToLessonsViewController(lesson: lesson)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - override BaseViewController
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            print("Warning, there is no search text")
            return
        }
        dataModel.filterLessons(by: searchText)
    }
    
    // MARK: - SearchController
    func setupSearchController(with placeholder: String) {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = placeholder
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .never
        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        definesPresentationContext = true
    }
    
    // MARK: - UIRefreshControl
    func setupRefreshControl(tintColor: UIColor = .clear) {
        configureRefreshControl(tintColor: tintColor, onStart: {
            #selector(updateDataModel)
        })
    }

    private func configureRefreshControl(tintColor: UIColor = .clear, onStart: () -> Selector) {
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = tintColor
        refreshControl.addTarget(self, action: onStart(), for: .valueChanged)
    }

    @objc func updateDataModel() {
        dataModel.updateLessons()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Sorting
    private func setupSorting() {
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(title: "SORT", style: .plain, target: self, action: #selector(showActionSheetForSorting))
    }
    
    @objc func showActionSheetForSorting() {
        let actionSheet = UIAlertController(title: "Sort by:", message: "", preferredStyle: .actionSheet)
        if UserTypeManager.shared.isUserStudent() {
            for sortType in LessonSortType.userList {
                actionSheet.addAction(UIAlertAction(title: sortType.actionTitle, style: .default, handler: { [weak self] _ in
                    self?.dataModel.sortLessons(by: sortType)
                }))
            }
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(actionSheet, animated: true, completion: nil)
            
        } else {
            for sortType in LessonSortType.allCases {
                actionSheet.addAction(UIAlertAction(title: sortType.actionTitle, style: .default, handler: { [weak self] _ in
                    self?.dataModel.sortLessons(by: sortType)
                }))
            }
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
}
