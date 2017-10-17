//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Double
  public var currency : String
    
    public init(amount: Int, currency: String) {
        self.amount = Double(amount)
        self.currency = String(currency)
    }
    
  public func convert(_ to: String) -> Money {
    var currentCurrency = currency
    var currentAmount = amount
    switch (currency, to) {
    case("USD", "GBP"):
        currentAmount *= 0.5
        currentCurrency = "GBP"
    case("USD", "EUR"):
        currentAmount *= 1.5
        currentCurrency = "EUR"
    case("USD", "CAN"):
        currentAmount *= 1.25
        currentCurrency = "CAN"
    case("EUR", "USD"):
        currentAmount *= 1.18
        currentCurrency = "USD"
    case("EUR", "CAN"):
        currentAmount += 1.48
        currentCurrency = "CAN"
    case("EUR", "GBP"):
        currentAmount += 0.89
        currentCurrency = "GBP"
    case("CAN", "USD"):
        currentAmount *= 0.8
        currentCurrency = "CAN"
    case("CAN", "GBP"):
        currentAmount *= 0.6
        currentCurrency = "GBP"
    case("CAN", "EUR"):
        currentAmount *= 0.68
        currentCurrency = "EUR"
    case("GBP", "USD"):
        currentAmount *= 1.33
        currentCurrency = "CAN"
    case("GBP", "CAN"):
        currentAmount *= 1.66
        currentCurrency = "CAN"
    case("GBP", "EUR"):
        currentAmount *= 1.12
        currentCurrency = "EUR"
    default:
        print("Please enter a valid case of either GBP, EUR or CAN")
    }
    return Money(amount: Int(currentAmount), currency: String(currentCurrency))
  }

  public func add(_ to: Money) -> Money {
    let newCurr = self.convert(to.currency)
    let newMoney = newCurr.amount + to.amount
    return Money(amount: Int(newMoney), currency: newCurr.currency)
    }
    
  public func subtract(_ from: Money) -> Money {
    let newCurr = self.convert(from.currency)
    let newMoney = newCurr.amount - from.amount
    return Money(amount: Int(newMoney), currency: newCurr.currency)
  }
    
}

//////////////////////////////////

open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }

  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }

  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
    case .Hourly(let totHours):
        return Int(totHours * Double(hours))
    case .Salary(let totSal):
        return totSal
    }
  }
    
  open func raise(_ amt : Double) {
    switch type {
    case .Salary(let totSal):
        self.type = .Salary(totSal + Int(amt))
    case .Hourly(let totHour):
        self.type = .Hourly(totHour + amt)
    }
}
    
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return _job }
        set(value) {
            if age > 15 {
                _job = value
            }
        }
}

  fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return _spouse}
        set(value) {
            if age > 17 {
                _spouse = value
            }
        }
    }

  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }

  open func toString() -> String {
    let sentence = "Full Name: \(firstName) \(lastName) Age: \(age) Job: \(job) Spouse: \(spouse)"
    return sentence
  }
}

//////////////////////////////////
//Family
//
open class Family {
  fileprivate var members : [Person] = []

  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        members.append(spouse1)
        members.append(spouse2)
    }
  }

  open func haveChild(_ child: Person) -> Bool {
    for person in members {
        if person.age > 20 {
            members.append(child)
            return true
        }
    }
    return false
  }

  open func householdIncome() -> Int {
    var totIncome = 0;
    for person in members {
        if person.job != nil {
            totIncome += person.job!.calculateIncome(52 * 40)
        }
    }
    return totIncome
  }
}






