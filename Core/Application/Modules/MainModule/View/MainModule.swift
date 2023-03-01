//
//  ViewController.swift
//  MusicApp
//
//  Created by G G on 05.12.2022.
//

import UIKit
import SnapKit

class MainModule: UIViewController {
    var movieData = [[MovieDataModel]]()
    var presenter: MainPresenterProtocol!
    var router: RouterProtocol!
    
    let mainFeedTable: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseId)
        table.allowsSelection = false
        table.backgroundColor = .none
        return table
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = #colorLiteral(red: 0.1626832485, green: 0.197935462, blue: 0.2544843853, alpha: 1)
        navigationController?.isNavigationBarHidden = true
        self.mainFeedTableSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension MainModule: MainModuleProtocol {
    func success(movieData: [MovieDataModel]) {
        self.movieData.append(movieData)
        self.mainFeedTable.reloadData()
    }
        
    func failure() {
        
    }
}

extension MainModule: UITableViewDelegate, UITableViewDataSource {
    
    func mainFeedTableSetup() {
        view.addSubview(mainFeedTable)
        mainFeedTable.dataSource = self
        mainFeedTable.delegate   = self
        
        mainFeedTable.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(26)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Resources.MainFeedTable.numberOfRowsInSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Resources.MainFeedTable.numberOfSections
    }
    
    //MARK: Configure collection's data and size
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseId, for: indexPath) as! MainTableViewCell
        if movieData.count == 4 {
            switch indexPath.section {
            case Resources.Collections.BigCellConfig.section:
                cell.configureCollection(cellHeight: Resources.Collections.BigCellConfig.cellHeight,
                                                        cellWidth:  Resources.Collections.BigCellConfig.cellWidth,
                                                        fontSize: Resources.Collections.BigCellConfig.fontSize,
                                                        section: indexPath.section,
                                                        router: router,
                                                        moviesData: movieData[indexPath.section] )
                
            default:
                cell.configureCollection(cellHeight: Resources.Collections.DefaultCellConfig.cellHeight,
                                                        cellWidth:  Resources.Collections.DefaultCellConfig.cellWidth,
                                                        fontSize: Resources.Collections.DefaultCellConfig.fontSize,
                                                        section: indexPath.section,
                                                        router: router,
                                                        moviesData: movieData[indexPath.section] )
            }
        }
        
        return cell
    }
    
    //MARK: Set Tables Row's height
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var offsetBetweenSections: CGFloat
        switch indexPath.section {
        case
            Resources.Collections.BigCellConfig.section:
            offsetBetweenSections =
            Resources.Collections.BigCellConfig.cellHeight +
            Resources.Collections.offsetBetweenSections
        default:
            offsetBetweenSections =
            Resources.Collections.DefaultCellConfig.cellHeight +
            Resources.Collections.offsetBetweenSections
        }
        return offsetBetweenSections
    }
    
    //MARK: Set header text
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.headerName.text = Resources.Collections.headers[section]
        return headerView
    }
    
}

//MARK: header for the MainFeedTableView

class HeaderView: UIView {

    let headerName: UILabel = {
        let name            = UILabel()
        name.tintColor      = .black
        name.numberOfLines  = 1
        name.textAlignment  = .left
        name.font           = .robotoRegular(size: 22)
        name.textColor      = .white
        return name
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor     = UIColor.clear
        setupHeaderName()
    }

    func setupHeaderName() {
        addSubview(headerName)
        headerName.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.bottom.equalToSuperview().inset(28)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
