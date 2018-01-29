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
  
    public mutating func convert(_ to: String) -> Money {
        var ret = Money(amount: amount, currency: currency)
        if currency == to {
            return ret
        } else if currency != "USD"{ //converting all money to USD
            
            if to == "GBP" { //pounds
                ret.amount = ret.amount * 2
            } else if currency == "EUR" { //euro
                ret.amount = (ret.amount * 3) / 2
            } else { //canadian
                ret.amount = (ret.amount * 5) / 4
            }
        }
        if to == "USD" {
            return Money(amount: amount, currency: currency)
        } else if to == "GBP" {
            ret.amount = ret.amount * 2
        } else if to == "EUR" {
            ret.amount = (ret.amount / 2) * 3
        } else if to == "CAN"{
            ret.amount = (ret.amount / 4) * 5
        } else {
            print("INVALID CURRENCY YOU DUMMY")
        }
        return ret
    }
    
    public mutating func add(_ to: Money) -> Money {
        var ret = Money(amount: self.amount, currency: currency)
        ret.convert(to.currency)
        ret.amount = ret.amount + to.amount
        ret.convert(self.currency)
        return ret
    }
    
    public func subtract(_ from: Money) -> Money {
        var ret = Money(amount: self.amount, currency: currency)
        ret.convert(from.currency)
        ret.amount = ret.amount - from.amount
        ret.convert(self.currency)
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
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
  }
  
  open func raise(_ amt : Double) {
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
    get { }
    set(value) {
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { }
    set(value) {
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
  }
  
  open func haveChild(_ child: Person) -> Bool {
  }
  
  open func householdIncome() -> Int {
  }
}





