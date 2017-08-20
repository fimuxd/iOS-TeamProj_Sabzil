 //
//  RecommendationViewController.swift
//  Plot
//
//  Created by joe on 2017. 8. 1..
//  Copyright © 2017년 joe. All rights reserved.
//

import UIKit
import Firebase

class RecommendationViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, customCellDelegate {
    
    /*******************************************/
    // MARK: -  Outlet & Property              //
    /*******************************************/
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
//    @IBOutlet weak var layoutTAG: FlowLayout!
    @IBOutlet weak var recommendTableView: UITableView!
    
    let localTag:[Genre] = [Genre.Carving,Genre.Craft,Genre.Installation,Genre.Paint,Genre.Photo,Genre.Video,Genre.Etc]
    let genreTag:[District] = [District.Seoul, District.GyeongGi, District.Busan,District.DaeGu, District.DaeJeon, District.GangWon, District.ChungCheong, District.JeJu,District.GwangJu,District.GyeongSang, District.JeonLa, District.Incheon, District.UlSan]
    
    var localtags = [Tag]()
    var genretags = [Tag]()
    
    var sizingCell: TagCustomCell?
    
    
    let exhibitionDatasRef = Database.database().reference().child("ExhibitionData")
    var exhibitionDataCount:Int = 0
    
    /*******************************************/
    // MARK: -  Life Cycle                     //
    /*******************************************/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentLoginVC()
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
        self.tagCollectionView.register(UINib(nibName: "TagCustomCell", bundle: nil), forCellWithReuseIdentifier: "TagCustomCell")
        self.tagCollectionView.register(UINib(nibName: "CollectionViewHeader", bundle: nil), forSupplementaryViewOfKind:  UICollectionElementKindSectionHeader , withReuseIdentifier: "CollectionViewHeader")
        
        let cellNib = UINib(nibName: "TagCustomCell", bundle: nil)
        
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCustomCell?
        //        self.layoutTAG.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        for name in localTag {
            let tag = Tag()
            tag.name = name.rawValue
            self.localtags.append(tag)
        }
        
        for name in genreTag {
            let tag = Tag()
            tag.name = name.rawValue
            self.genretags.append(tag)
        }
        
        
        self.recommendTableView.delegate = self
        self.recommendTableView.dataSource = self
        self.recommendTableView.register(UINib(nibName: "MainCustomCell", bundle: nil), forCellReuseIdentifier: "mainCustomCell")
        
        exhibitionDatasRef.keepSynced(true)
        
        self.exhibitionDatasRef.observeSingleEvent(of: .value, with: { (snapshot) in
            self.exhibitionDataCount = Int(snapshot.childrenCount)
            
            self.recommendTableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        self.exhibitionDatasRef.observe(.childChanged, with: { (snapshot) in
            self.exhibitionDataCount = Int(snapshot.childrenCount)
            self.recommendTableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*******************************************/
    // MARK: -  CustomCell Delegate Method     //
    /*******************************************/
    
    func isStarPointButtonClicked() {
        
    }
    
    func isCommentButtonClicked() {
        
    }
    
    func isLikeButtonClicked() {
        
    }
    
    /*******************************************/
    // MARK: -  Table View                     //
    /*******************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainCustomCell = tableView.dequeueReusableCell(withIdentifier: "mainCustomCell", for: indexPath) as! MainCustomCell
        cell.selectionStyle = .none
        cell.delegate = self
        
        var selectedExhibitionData:ExhibitionData?{
            didSet{
                guard let realExhibitionData = selectedExhibitionData else {
                    print("리얼데이터가 없습니다")
                    return
                }
                
                cell.mainTitleLabel.text = realExhibitionData.title
                cell.localLabel.text = realExhibitionData.district.rawValue
                cell.exhibitionTerm.text = "\(realExhibitionData.periodData[0].startDate)~\(realExhibitionData.periodData[0].endDate)"
                cell.museumName.text = realExhibitionData.placeData[0].address
                
                cell.indexPathRow = indexPath.row
                
                
                
                
                
                guard let url = URL(string: realExhibitionData.imgURL[0].posterURL) else {return}
                
                do{
                    let realData = try Data(contentsOf: url)
                    cell.mainPosterImg.image = UIImage(data: realData)
                }catch{
                    
                }
                
            }
        }
        
        DataCenter.sharedData.requestExhibitionData(id: indexPath.row) { (dic) in
            selectedExhibitionData = dic
        }
        
        /*
         cell.localLabel.text = "서울"
         cell.mainTitleLabel.text = "메인타이틀 텍스트 전시이름이들어갑니다"
         cell.exhibitionTerm.text = "2017. 07. 08~ 2017. 08. 09"
         cell.museumName.text = "디뮤지엄"
         */
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exhibitionDataCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController:DetailViewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    /*******************************************/
    // MARK: -  CollectionView                 //
    /*******************************************/
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return localtags.count
        } else {
            return genretags.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCustomCell", for: indexPath) as! TagCustomCell
        self.configureCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.configureCell(self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if indexPath.section == 0 {
            localtags[indexPath.row].selected = !localtags[indexPath.row].selected
        } else {
            genretags[indexPath.row].selected = !genretags[indexPath.row].selected
        }
        self.tagCollectionView.reloadData()
    }
    
    func configureCell(_ cell: TagCustomCell, forIndexPath indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let tag = localtags[indexPath.row]
            cell.tagName.text = tag.name
            cell.tagName.textColor = tag.selected ? UIColor.white : UIColor(red: 31/255, green: 208/255, blue: 255/255, alpha: 1)
            cell.backgroundColor = tag.selected ? UIColor(red: 31/255, green: 208/255, blue: 255/255, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)

        } else {
            let tag = genretags[indexPath.row]
            cell.tagName.text = tag.name
            cell.tagName.textColor = tag.selected ? UIColor.white : UIColor(red: 31/255, green: 208/255, blue: 255/255, alpha: 1)
            cell.backgroundColor = tag.selected ? UIColor(red: 31/255, green: 208/255, blue: 255/255, alpha: 1) : UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header:CollectionViewHeader = tagCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeader", for: indexPath) as! CollectionViewHeader
        
        if indexPath.section == 0 {
            header.headerName.text! = "장르"
        }else {
            header.headerName.text! = "지역"
    
        }
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: tagCollectionView.frame.size.width, height: 30)
    }

    func presentLoginVC(){
        if Auth.auth().currentUser == nil {
            let loginVC:LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            present(loginVC, animated: true, completion: nil)
        }else{
            print(Auth.auth().currentUser?.email)
        }
    }
    
}
