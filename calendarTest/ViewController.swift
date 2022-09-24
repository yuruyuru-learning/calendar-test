//
//  ViewController.swift
//  calendarTest
//
//  Created by クワシマ・ユウキ on 2022/09/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let margin: CGFloat = 5
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        (cell.contentView.viewWithTag(1) as! UILabel).text = String(getDayCalendar(year: 2022, month: 9)[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getDayCalendar(year: 2022, month: 9).count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 7  //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}

func getDayCalendar(year: Int, month: Int) -> [Int] {
    func zellerCongruence(year: Int, month: Int, day: Int) -> Int {
        var processedMonth = month
        if month == 1 || month == 2 {
            processedMonth += 12
        }
        let a = year/4
        let b = year/100
        let c = year/400
        let d = (13 * processedMonth + 8)/5
        return (year + a - b + c + d + day) % 7
    }
    func isLeapYear(year: Int) -> Bool {
        return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
    }
    func getDaysInMonth(year: Int, month: Int) -> Int {
        switch month {
        case 1:
            return 31
        case 2:
            if isLeapYear(year: year) {
                return 29
            } else {
                return 28
            }
        case 3:
            return 31
        case 4:
            return 30
        case 5:
            return 31
        case 6:
            return 30
        case 7:
            return 31
        case 8:
            return 31
        case 9:
            return 30
        case 10:
            return 31
        case 11:
            return 30
        case 12:
            return 31
        default:
            return 0
        }
    }
    let weekdayInt = zellerCongruence(year: year, month: month, day: 1)
    var calendarArray: [Int] = []
    for _ in 0..<weekdayInt {
        calendarArray.append(0)
    }
    let daysInMonth = getDaysInMonth(year: year, month: month)
    for i in 1...daysInMonth {
        calendarArray.append(i)
    }
    var remainder = 7 - (calendarArray.count % 7)
    if remainder == 7 {
        remainder = 0
    }
    for _ in 0..<remainder {
        calendarArray.append(0)
    }
    return calendarArray
}

