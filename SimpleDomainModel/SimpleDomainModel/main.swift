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
  public var amount : Int
  public var currency : String
  
    public func convert(_ to: String) -> Money {
        var retAmount = self.amount
        var retCurrency = self.currency
        if retCurrency == to {
            return Money(amount: retAmount, currency: retCurrency)
        } else if retCurrency != "USD" { //converting all money to USD
            if retCurrency == "GBP" { //pounds
                retAmount = retAmount * 2
                retCurrency = "USD"
            } else if retCurrency == "EUR" { //euro
                retAmount = (retAmount / 3) * 2
                retCurrency = "USD"
            } else { //canadian
                retAmount = (retAmount / 5) * 4
                retCurrency = "USD"
            }
        }
        if to == "USD" {
            return Money(amount: retAmount, currency: retCurrency)
        } else if to == "GBP" {
            retAmount = retAmount / 2
            retCurrency = "GBP"
        } else if to == "EUR" {
            retAmount = (retAmount / 2) * 3
            retCurrency = "EUR"
        } else if to == "CAN"{
            retAmount = (retAmount / 4) * 5
            retCurrency = "CAN"
        } else {
            print("INVALID CURRENCY YOU DUMMY")
        }
        return Money(amount: retAmount, currency: retCurrency)
    }
    
    public func add(_ to: Money) -> Money {
        var ret = Money(amount: self.amount, currency: self.currency)
        ret = ret.convert(to.currency)
        ret.amount = ret.amount + to.amount
        return ret
    }
    
    public func subtract(_ from: Money) -> Money {
        var ret = Money(amount: self.amount, currency: self.currency)
        ret = ret.convert(from.currency)
        ret.amount = ret.amount - from.amount
        return ret
    }
}

////////////////////////////////////
// Job
//
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
           case .Hourly(let rate): return Int(Double(hours) * rate)
           case .Salary(let yearly): return yearly
    }
  }
  
  open func raise(_ amt : Double) {
    switch type {
              case .Hourly(let rate): type = JobType.Hourly(rate + amt)
              case .Salary(let yearly): type = JobType.Salary(yearly + Int(amt))
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
    get { return self._job}
    set(value) {
        if age > 16 {
        self._job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return self._spouse}
    set(value) {
        if age > 18 {
            self._spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(firstName) lastName:\(lastName) " +
            "age:\(age) job:\(job?.title) spouse:\(spouse?.firstName)]"
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    members.append(spouse1)
        members.append(spouse2)
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
  }
  
  open func haveChild(_ child: Person) -> Bool {
    let legal = members.contains { (it) -> Bool in it.age > 21 }
        if legal {
         members.append(child)
        }
    return legal
  }
  
  open func householdIncome() -> Int {
    var total = 0
    for index in 0...(members.count - 1){
        if members[index]._job != nil {
            total += members[index]._job!.calculateIncome(2000)
        }
    }
    return total
  }
}





