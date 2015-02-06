//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Charles Eison on 2/5/15.
//  Copyright (c) 2015 Charles Eison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Views
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    var fifthContainer: UIView!
    
    // UILabels
    
    var titleLabel: UILabel!
    var dayLabel: UILabel!
    var inventoryLabel: UILabel!
    var moneyInInventoryLabel: UILabel!
    var lemonsInInventoryLabel: UILabel!
    var iceInInventoryLabel: UILabel!
    var todaysWeatherLabel: UILabel!
    var purchaseSuppliesLabel: UILabel!
    var costPerLemonLabel: UILabel!
    var costPerIceCubeLabel: UILabel!
    var numberOfLemonsPurchasedLabel: UILabel!
    var numberOfIceCubesPurchasedLabel: UILabel!
    
    // UIViews
    
    var moneySymbol: UIImageView!
    var lemonSymbol: UIImageView!
    var iceSymbol: UIImageView!
    var weatherSymbol: UIImageView!
    
    // Buttons
    var plusButton: UIButton!
    var minusButton: UIButton!
    
    
    // Misc Constants
    let kMarginForView:CGFloat = 10.0
    let kSixteenth: CGFloat = 1.0 / 16.0
    let kEighth:CGFloat = 1.0 / 8.0
    let kThird:CGFloat = 1.0 / 3.0
    let kHalf: CGFloat = 1.0 / 2.0
    
    // Misc Variables
    var dayCounter = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpContainerViews()
        setUpFirstContainer(firstContainer)
        setUpSecondContainer(secondContainer)
        setUpThirdContainer(thirdContainer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUpContainerViews () {
        firstContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height * kEighth))
        firstContainer.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(firstContainer)
        
        secondContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.firstContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * 2 * kEighth))
        secondContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(secondContainer)
        
        thirdContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.firstContainer.frame.height + self.secondContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * 2 * kEighth))
        thirdContainer.backgroundColor = UIColor.blueColor()
        self.view.addSubview(thirdContainer)
        
        fourthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.firstContainer.frame.height + self.secondContainer.frame.height + self.thirdContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kEighth * 2))
        fourthContainer.backgroundColor = UIColor.greenColor()
        self.view.addSubview(fourthContainer)
        
        fifthContainer = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.firstContainer.frame.height + self.secondContainer.frame.height + self.thirdContainer.frame.height + self.fourthContainer.frame.height, width: self.view.bounds.width, height: self.view.bounds.height * kEighth))
        fifthContainer.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(fifthContainer)
        
    }
    
    func setUpFirstContainer (containerView:UIView) {
        self.titleLabel = UILabel()
        self.titleLabel.text = "Lemonade Stand"
        self.titleLabel.textColor = UIColor.redColor()
        self.titleLabel.font = UIFont(name: "Chalkduster", size: 23)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = CGPointMake(containerView.frame.width / 3, containerView.frame.height / 2)
        containerView.addSubview(titleLabel)
        
        self.dayLabel = UILabel()
        self.dayLabel.text = "Day: \(dayCounter)"
        self.dayLabel.textColor = UIColor.redColor()
        self.dayLabel.font = UIFont(name: "Chalkduster", size: 23)
        self.dayLabel.sizeToFit()
        self.dayLabel.center = CGPointMake(containerView.frame.width * 4 / 5, containerView.frame.height / 2)
        containerView.addSubview(dayLabel)
        
    }
    
    func setUpSecondContainer (containerView:UIView) {
        
        self.inventoryLabel = UILabel()
        self.inventoryLabel.text = "Inventory"
        self.inventoryLabel.textColor = UIColor.greenColor()
        self.inventoryLabel.font = UIFont(name: "Chalkduster", size: 18)
        self.inventoryLabel.sizeToFit()
        self.inventoryLabel.center = CGPointMake(containerView.frame.width * kEighth + kMarginForView, containerView.frame.height * kEighth)
        containerView.addSubview(inventoryLabel)
        
        self.moneySymbol = UIImageView ()
        self.moneySymbol.image = UIImage(named: "DollarSign")
        self.moneySymbol.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 2,
            width: containerView.bounds.width * kEighth,
            height: containerView.bounds.height * kEighth * 2)
        containerView.addSubview(moneySymbol)
        
        self.moneyInInventoryLabel = UILabel()
        self.moneyInInventoryLabel.text = "10"
        self.moneyInInventoryLabel.textColor = UIColor.greenColor()
        self.moneyInInventoryLabel.font = UIFont(name: "Chalkduster", size: 18)
        self.moneyInInventoryLabel.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView * 2 + containerView.frame.size.width * kEighth,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 2,
            width: containerView.bounds.width * kEighth * 2 - kMarginForView,
            height: containerView.bounds.height * kThird)
        containerView.addSubview(moneyInInventoryLabel)
        
        self.lemonSymbol = UIImageView ()
        self.lemonSymbol.image = UIImage(named: "Lemon")
        self.lemonSymbol.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 5,
            width: containerView.bounds.width * kEighth,
            height: containerView.bounds.height * kEighth * 2)
        containerView.addSubview(lemonSymbol)
        
        self.lemonsInInventoryLabel = UILabel()
        self.lemonsInInventoryLabel.text = "0"
        self.lemonsInInventoryLabel.textColor = UIColor.greenColor()
        self.lemonsInInventoryLabel.font = UIFont(name: "Chalkduster", size: 18)
        self.lemonsInInventoryLabel.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView * 2 + containerView.frame.size.width * kEighth,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 5,
            width: containerView.bounds.width * kEighth * 2 - kMarginForView,
            height: containerView.bounds.height * kThird)
        containerView.addSubview(lemonsInInventoryLabel)
        
        self.todaysWeatherLabel = UILabel()
        self.todaysWeatherLabel.text = "Today's Weather:"
        self.todaysWeatherLabel.textColor = UIColor.greenColor()
        self.todaysWeatherLabel.font = UIFont(name: "Chalkduster", size: 14)
        self.todaysWeatherLabel.frame = CGRect(
            x: containerView.bounds.origin.x + containerView.bounds.size.width * kHalf - kMarginForView,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth,
            width: containerView.bounds.width * kEighth * 3,
            height: containerView.bounds.size.height * kThird)
        
        containerView.addSubview(todaysWeatherLabel)
        
        self.weatherSymbol = UIImageView ()
        self.weatherSymbol.image = UIImage(named: "Cold")
        self.weatherSymbol.frame = CGRect(
            x: containerView.bounds.origin.x + containerView.bounds.size.width * kEighth * 7 - kMarginForView,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth,
            width: containerView.bounds.width * kEighth,
            height: containerView.bounds.height * kThird)
        containerView.addSubview(weatherSymbol)
        
        self.iceSymbol = UIImageView()
        self.iceSymbol.image = UIImage(named: "Ice")
        self.iceSymbol.frame = CGRect(
            x: containerView.bounds.origin.x + containerView.bounds.size.width * kHalf,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 5,
            width: containerView.bounds.width * kEighth,
            height: containerView.bounds.height * kEighth * 2)
        containerView.addSubview(iceSymbol)
        
        self.iceInInventoryLabel = UILabel()
        self.iceInInventoryLabel.text = "0"
        self.iceInInventoryLabel.textColor = UIColor.greenColor()
        self.iceInInventoryLabel.font = UIFont(name: "Chalkduster", size: 18)
        self.iceInInventoryLabel.frame = CGRect(
            x: containerView.bounds.origin.x + containerView.bounds.width * kEighth * 6 - kMarginForView,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 5,
            width: containerView.bounds.width * kEighth * 2 - kMarginForView,
            height: containerView.bounds.height * kThird)
        containerView.addSubview(iceInInventoryLabel)
        
    }
    
    func setUpThirdContainer (containerView:UIView) {
        
        self.purchaseSuppliesLabel = UILabel()
        self.purchaseSuppliesLabel.text = "Purchase Supplies"
        self.purchaseSuppliesLabel.textColor = UIColor.greenColor()
        self.purchaseSuppliesLabel.font = UIFont(name: "Chalkduster", size: 18)
        self.purchaseSuppliesLabel.sizeToFit()
        self.purchaseSuppliesLabel.center = CGPointMake(containerView.frame.width * kEighth * 2, containerView.frame.height * kEighth)
        containerView.addSubview(purchaseSuppliesLabel)
        
        self.lemonSymbol = UIImageView ()
        self.lemonSymbol.image = UIImage(named: "Lemon")
        self.lemonSymbol.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 2,
            width: containerView.bounds.width * kEighth,
            height: containerView.bounds.height * kEighth * 2)
        containerView.addSubview(lemonSymbol)
        
        self.costPerLemonLabel = UILabel()
        self.costPerLemonLabel.text = "$2"
        self.costPerLemonLabel.textColor = UIColor.greenColor()
        self.costPerLemonLabel.font = UIFont(name: "Chalkduster", size: 18)
        self.costPerLemonLabel.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView * 2 + containerView.frame.size.width * kEighth,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 2,
            width: containerView.bounds.width * kEighth * 2 - kMarginForView,
            height: containerView.bounds.height * kThird)
        containerView.addSubview(costPerLemonLabel)
        
        self.iceSymbol = UIImageView ()
        self.iceSymbol.image = UIImage(named: "Ice")
        self.iceSymbol.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 5,
            width: containerView.bounds.width * kEighth,
            height: containerView.bounds.height * kEighth * 2)
        containerView.addSubview(iceSymbol)
        
        self.costPerIceCubeLabel = UILabel()
        self.costPerIceCubeLabel.text = "$1"
        self.costPerIceCubeLabel.textColor = UIColor.greenColor()
        self.costPerIceCubeLabel.font = UIFont(name: "Chalkduster", size: 18)
        self.costPerIceCubeLabel.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView * 2 + containerView.frame.size.width * kEighth,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 5,
            width: containerView.bounds.width * kEighth * 2 - kMarginForView,
            height: containerView.bounds.height * kThird)
        containerView.addSubview(costPerIceCubeLabel)
        
        self.plusButton = UIButton()
        self.plusButton.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kHalf, containerView.bounds.origin.y + containerView.frame.height * kEighth * 3, containerView.bounds.width * kSixteenth, containerView.bounds.height * kEighth)
        self.plusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        self.plusButton.setImage(UIImage(named: "Plus"), forState: UIControlState.Normal)
        containerView.addSubview(plusButton)
        
        self.numberOfLemonsPurchasedLabel = UILabel()
        self.numberOfLemonsPurchasedLabel.text = "0"
        self.numberOfLemonsPurchasedLabel.textColor = UIColor.greenColor()
        self.numberOfLemonsPurchasedLabel.font = UIFont(name: "Chalkduster", size: 20)
        self.numberOfLemonsPurchasedLabel.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kEighth * 6 - kMarginForView * 2, containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 2 + kMarginForView, containerView.bounds.width * kEighth * 2, containerView.bounds.height * kEighth * 2)
        containerView.addSubview(numberOfLemonsPurchasedLabel)
        
        self.minusButton = UIButton()
        self.minusButton.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kEighth * 7, containerView.bounds.origin.y + containerView.frame.height * kEighth * 3, containerView.bounds.width * kSixteenth, containerView.bounds.height * kEighth)
        self.minusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        self.minusButton.setImage(UIImage(named: "Minus"), forState: UIControlState.Normal)
        containerView.addSubview(minusButton)
        
        self.plusButton = UIButton()
        self.plusButton.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kHalf, containerView.bounds.origin.y + containerView.frame.height * kEighth * 6, containerView.bounds.width * kSixteenth, containerView.bounds.height * kEighth)
        self.plusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        self.plusButton.setImage(UIImage(named: "Plus"), forState: UIControlState.Normal)
        containerView.addSubview(plusButton)
        
        self.numberOfIceCubesPurchasedLabel = UILabel()
        self.numberOfIceCubesPurchasedLabel.text = "0"
        self.numberOfIceCubesPurchasedLabel.textColor = UIColor.greenColor()
        self.numberOfIceCubesPurchasedLabel.font = UIFont(name: "Chalkduster", size: 20)
        self.numberOfIceCubesPurchasedLabel.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kEighth * 6 - kMarginForView * 2, containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 5 + kMarginForView, containerView.bounds.width * kEighth * 2, containerView.bounds.height * kEighth * 2)
        containerView.addSubview(numberOfIceCubesPurchasedLabel)
        
        self.minusButton = UIButton()
        self.minusButton.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kEighth * 7, containerView.bounds.origin.y + containerView.frame.height * kEighth * 6, containerView.bounds.width * kSixteenth, containerView.bounds.height * kEighth)
        self.minusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        self.minusButton.setImage(UIImage(named: "Minus"), forState: UIControlState.Normal)
        containerView.addSubview(minusButton)
        
    }
    
    func setUpFourthContainer (containerView:UIView) {
        
        
        
    }
    


}

