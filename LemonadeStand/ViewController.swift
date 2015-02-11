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
    var makeLemonadeLabel: UILabel!
    var lemonsInMixLabel: UILabel!
    var iceInMixLabel: UILabel!
    var resultsLabel: UILabel!
    var resultsReturnedLabel: UILabel!
    
    // UIViews
    
    var moneySymbol: UIImageView!
    var lemonSymbol: UIImageView!
    var iceSymbol: UIImageView!
    var weatherSymbol: UIImageView!
    
    // Buttons
    var plusButton: UIButton!
    var minusButton: UIButton!
    var mixLemonadeButton: UIButton!
    
    
    // Misc Constants
    let kMarginForView:CGFloat = 10.0
    let kSixteenth: CGFloat = 1.0 / 16.0
    let kEighth:CGFloat = 1.0 / 8.0
    let kThird:CGFloat = 1.0 / 3.0
    let kHalf: CGFloat = 1.0 / 2.0
    
    // Stats
    var dayCounter = 1
    var moneyAvailable = 10
    var lemonsInInventory = 0
    var lemonsPurchased = 0
    var iceInInventory = 0
    var icePurchased = 0
    var lemonsInMix = 0.0
    var iceInMix = 0.0
    var mixRatio = 0.0
    var customersForDay:[Customers] = []
    var customersWhoPurchasedCount = 0

    override func prefersStatusBarHidden() ->Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpContainerViews()
        setUpFirstContainer(firstContainer)
        setUpSecondContainer(secondContainer)
        setUpThirdContainer(thirdContainer)
        setUpFourthContainer(fourthContainer)
        setUpFifthContainer(fifthContainer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IB Actions
    
    func purchaseAddLemonButtonPressed (button: UIButton) {
        
        if moneyAvailable < 2 {
            showAlertWithText(header: "Not enough money", message: "Try again!")
        }
        else {
            moneyAvailable -= 2
            lemonsInInventory += 1
            lemonsPurchased += 1
            updateMainView()
        }
    }
    
    func purchaseDeductLemonButtonPressed (button: UIButton) {
        if lemonsPurchased < 1 {
            showAlertWithText(header: "No lemons to remove from order", message: "Try again!")
        }
        else if lemonsInInventory == 0 {
            showAlertWithText(header: "Can not remove lemons currently used in mix", message: "Remove lemons from mix first")
        }
        else {
            moneyAvailable += 2
            lemonsInInventory -= 1
            lemonsPurchased -= 1
            updateMainView()
        }
    }
    
    func purchaseAddIceButtonPressed (button: UIButton) {
        if moneyAvailable < 1 {
            showAlertWithText(header: "Not enough money", message: "Try again!")
        }
        else {
            moneyAvailable -= 1
            iceInInventory += 1
            icePurchased += 1
            updateMainView()
            
        }
    }
    
    func purchaseDeductIceButtonPressed (button: UIButton) {
        if icePurchased < 1{
            showAlertWithText(header: "No ice to remove from order", message: "Try again!")
        }
        else if iceInInventory == 0 {
            showAlertWithText(header: "Can not remove ice currently used in mix", message: "Remove ice from mix first")
        }
        else {
            moneyAvailable += 1
            iceInInventory -= 1
            icePurchased -= 1
            updateMainView()
        }
    }
    
    func addLemonsToMixButtonPressed (button: UIButton) {
        if lemonsInInventory < 1 {
            showAlertWithText(header: "No lemons in inventory", message: "Buy more lemons first!")
        }
        else {
            lemonsInInventory -= 1
            lemonsInMix += 1
            updateMainView()
        }
    }
    
    func deductLemonsToMixButtonPressed (button: UIButton) {
        if lemonsInMix < 1 {
            showAlertWithText(header: "No lemons to remove from mix", message: "Try again!")
        }
        else {
            lemonsInInventory += 1
            lemonsInMix -= 1
            updateMainView()
        }
    }
    
    func addIceToMixButtonPressed (button: UIButton) {
        if iceInInventory < 1 {
            showAlertWithText(header: "No ice in inventory", message: "Try again!")
        }
        else {
            iceInInventory -= 1
            iceInMix += 1
            updateMainView()
        }
    }
    
    func deductIceToMixButtonPressed (button: UIButton) {
        if iceInMix < 1 {
            showAlertWithText(header: "No ice to remove from mix", message: "Try again!")
        }
        else {
            iceInInventory += 1
            iceInMix -= 1
            updateMainView()
        }
    }
    
    func mixLemonadeButtonPressed (button: UIButton) {
        customersWhoPurchasedCount = 0
        if lemonsInMix >= 1 && iceInMix >= 1 {
            mixRatio = lemonsInMix / iceInMix
            println("\(mixRatio)")

        customersForDay = Factory.createCustomers()
        for Customers in customersForDay {
            
            if Customers.preference < 0.4 && mixRatio > 1 {
                moneyAvailable += 1
                customersWhoPurchasedCount += 1
                println("Paid")
            }
            
            else if Customers.preference >= 0.4 && Customers.preference <= 0.6 && mixRatio == 1 {
                moneyAvailable += 1
                customersWhoPurchasedCount += 1
                println("Paid")
            }
            
            else if Customers.preference > 0.6 && mixRatio < 1 {
                moneyAvailable += 1
                customersWhoPurchasedCount += 1
                println("Paid")
            }
            
            else {
                println("Not Paid")
            }
            
            println ("\(Customers.preference)")
        }
        
    
        icePurchased = 0
        lemonsPurchased = 0
        lemonsInMix = 0.0
        iceInMix = 0.0
        dayCounter += 1
        var randomWeather = Int(arc4random_uniform(UInt32(3)))
            switch randomWeather {
            case 0:
                self.weatherSymbol.image = UIImage(named: "Cold")
            case 1:
                self.weatherSymbol.image = UIImage(named: "Warm")
            default:
                self.weatherSymbol.image = UIImage(named: "Mild")
                
            }
            
        
            if moneyAvailable == 0 && lemonsInInventory == 0 {
                resetGame()
            }
            
            if moneyAvailable == 0 && iceInInventory == 0 {
                resetGame()
            }
            
            if moneyAvailable == 1 && lemonsInInventory == 0 {
                resetGame()
            }
            if moneyAvailable == 2 && lemonsInInventory == 0 && iceInInventory == 0 {
                resetGame()
            }
            
    
        updateMainView()
        println("\(customersForDay.count)")
            
        }

            
        else {
            showAlertWithText(header: "You must have at least 1 lemon and 1 ice in mix", message: "Try again!")
        }
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
        fourthContainer.backgroundColor = UIColor.purpleColor()
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
        self.dayLabel.text = "Day: \(dayCounter)  "
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
        self.moneyInInventoryLabel.text = "\(moneyAvailable)"
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
        self.weatherSymbol.image = UIImage(named: "Mild")
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
        self.plusButton.addTarget(self, action: "purchaseAddLemonButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
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
        self.minusButton.addTarget(self, action: "purchaseDeductLemonButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(minusButton)
        
        self.plusButton = UIButton()
        self.plusButton.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kHalf, containerView.bounds.origin.y + containerView.frame.height * kEighth * 6, containerView.bounds.width * kSixteenth, containerView.bounds.height * kEighth)
        self.plusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        self.plusButton.setImage(UIImage(named: "Plus"), forState: UIControlState.Normal)
        self.plusButton.addTarget(self, action: "purchaseAddIceButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
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
        self.minusButton.addTarget(self, action: "purchaseDeductIceButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(minusButton)
        
    }
    
    func setUpFourthContainer (containerView:UIView) {
        
        self.makeLemonadeLabel = UILabel()
        self.makeLemonadeLabel.text = "Make Lemonade"
        self.makeLemonadeLabel.textColor = UIColor.greenColor()
        self.makeLemonadeLabel.font = UIFont(name: "Chalkduster", size: 18)
        self.makeLemonadeLabel.sizeToFit()
        self.makeLemonadeLabel.center = CGPointMake(containerView.frame.width * kEighth * 2, containerView.frame.height * kEighth)
        containerView.addSubview(makeLemonadeLabel)
        
        self.mixLemonadeButton = UIButton()
        self.mixLemonadeButton.setTitle("Mix Now!", forState: UIControlState.Normal)
        self.mixLemonadeButton.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        self.mixLemonadeButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 18)
        self.mixLemonadeButton.backgroundColor = UIColor.yellowColor()
        self.mixLemonadeButton.sizeToFit()
        self.mixLemonadeButton.layer.cornerRadius = 0.2 * mixLemonadeButton.bounds.size.width
        self.mixLemonadeButton.center = CGPoint(x: containerView.frame.width * kEighth * 7 - kMarginForView, y: containerView.frame.height * kEighth)
        self.mixLemonadeButton.addTarget(self, action: "mixLemonadeButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(mixLemonadeButton)
        
        self.lemonSymbol = UIImageView ()
        self.lemonSymbol.image = UIImage(named: "Lemon")
        self.lemonSymbol.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 2,
            width: containerView.bounds.width * kEighth,
            height: containerView.bounds.height * kEighth * 2)
        containerView.addSubview(lemonSymbol)
        
        self.iceSymbol = UIImageView ()
        self.iceSymbol.image = UIImage(named: "Ice")
        self.iceSymbol.frame = CGRect(
            x: containerView.bounds.origin.x + kMarginForView,
            y: containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 5,
            width: containerView.bounds.width * kEighth,
            height: containerView.bounds.height * kEighth * 2)
        containerView.addSubview(iceSymbol)
        
        self.plusButton = UIButton()
        self.plusButton.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kHalf, containerView.bounds.origin.y + containerView.frame.height * kEighth * 3, containerView.bounds.width * kSixteenth, containerView.bounds.height * kEighth)
        self.plusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        self.plusButton.setImage(UIImage(named: "Plus"), forState: UIControlState.Normal)
        self.plusButton.addTarget(self, action: "addLemonsToMixButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(plusButton)
        
        self.lemonsInMixLabel = UILabel()
        self.lemonsInMixLabel.text = "0"
        self.lemonsInMixLabel.textColor = UIColor.greenColor()
        self.lemonsInMixLabel.font = UIFont(name: "Chalkduster", size: 20)
        self.lemonsInMixLabel.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kEighth * 6 - kMarginForView * 2, containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 2 + kMarginForView, containerView.bounds.width * kEighth * 2, containerView.bounds.height * kEighth * 2)
        containerView.addSubview(lemonsInMixLabel)
        
        self.minusButton = UIButton()
        self.minusButton.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kEighth * 7, containerView.bounds.origin.y + containerView.frame.height * kEighth * 3, containerView.bounds.width * kSixteenth, containerView.bounds.height * kEighth)
        self.minusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        self.minusButton.setImage(UIImage(named: "Minus"), forState: UIControlState.Normal)
        self.minusButton.addTarget(self, action: "deductLemonsToMixButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(minusButton)
        
        self.plusButton = UIButton()
        self.plusButton.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kHalf, containerView.bounds.origin.y + containerView.frame.height * kEighth * 6, containerView.bounds.width * kSixteenth, containerView.bounds.height * kEighth)
        self.plusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        self.plusButton.setImage(UIImage(named: "Plus"), forState: UIControlState.Normal)
        self.plusButton.addTarget(self, action: "addIceToMixButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(plusButton)
        
        self.iceInMixLabel = UILabel()
        self.iceInMixLabel.text = "0"
        self.iceInMixLabel.textColor = UIColor.greenColor()
        self.iceInMixLabel.font = UIFont(name: "Chalkduster", size: 20)
        self.iceInMixLabel.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kEighth * 6 - kMarginForView * 2, containerView.bounds.origin.y + containerView.bounds.size.height * kEighth * 5 + kMarginForView, containerView.bounds.width * kEighth * 2, containerView.bounds.height * kEighth * 2)
        containerView.addSubview(iceInMixLabel)
        
        self.minusButton = UIButton()
        self.minusButton.frame = CGRectMake(containerView.bounds.origin.x + containerView.frame.width * kEighth * 7, containerView.bounds.origin.y + containerView.frame.height * kEighth * 6, containerView.bounds.width * kSixteenth, containerView.bounds.height * kEighth)
        self.minusButton.layer.cornerRadius = 0.5 * plusButton.bounds.size.width
        self.minusButton.setImage(UIImage(named: "Minus"), forState: UIControlState.Normal)
        self.minusButton.addTarget(self, action: "deductIceToMixButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(minusButton)
    }
    
    func setUpFifthContainer (containerView:UIView) {
        
        self.resultsLabel = UILabel()
        self.resultsLabel.text = "Results!"
        self.resultsLabel.textColor = UIColor.redColor()
        self.resultsLabel.font = UIFont(name: "Chalkduster", size: 18)
        self.resultsLabel.sizeToFit()
        self.resultsLabel.center = CGPointMake(containerView.frame.width * kEighth, containerView.frame.height * kEighth)
        containerView.addSubview(resultsLabel)
        
        self.resultsReturnedLabel = UILabel()
        self.resultsReturnedLabel.text = "You had 0 customers today, 0 bought lemonade!   "
        self.resultsReturnedLabel.textColor = UIColor.redColor()
        self.resultsReturnedLabel.font = UIFont(name: "Chalkduster", size: 11)
        self.resultsReturnedLabel.sizeToFit()
        self.resultsReturnedLabel.center = CGPointMake(containerView.frame.width * kHalf, containerView.frame.height * kEighth * 5)
        containerView.addSubview(resultsReturnedLabel)
        
    }
    
    func showAlertWithText (header : String = "Warning", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateMainView () {
        self.moneyInInventoryLabel.text = "\(moneyAvailable)"
        self.lemonsInInventoryLabel.text = "\(lemonsInInventory)"
        self.dayLabel.text = "Day: \(dayCounter)"
        self.numberOfLemonsPurchasedLabel.text = "\(lemonsPurchased)"
        self.iceInInventoryLabel.text = "\(iceInInventory)"
        self.numberOfIceCubesPurchasedLabel.text = "\(icePurchased)"
        self.lemonsInMixLabel.text = "\(lemonsInMix)"
        self.iceInMixLabel.text = "\(iceInMix)"
        self.resultsReturnedLabel.text = "You had \(customersForDay.count) customers today.  \(customersWhoPurchasedCount) bought lemonade"
    }
    
    func resetGame () {
        showAlertWithText(header: "Game Over", message: "You do not have enough resources to continue")
        moneyAvailable = 10
        lemonsInInventory = 0
        lemonsPurchased = 0
        iceInInventory = 0
        icePurchased = 0
        lemonsInMix = 0.0
        iceInMix = 0.0
        dayCounter = 1
    }


}

