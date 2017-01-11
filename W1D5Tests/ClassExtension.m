//
//  ClassExtension.m
//  W1D5
//
//  Created by steve on 2017-01-10.
//  Copyright © 2017 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

// Simple example of class extension

// Person.h
@import Foundation; // Notice the modern importation syntax

@interface Person: NSObject
// Notice age is readonly
@property (nonatomic, readonly) NSInteger age;
- (instancetype)initWithName:(NSString *)name age:(NSInteger)age;
@end

// Person.m
// #import "Person.h"

// class extension. notice it's another interface on .m
@interface Person()
// privately it's readwrite but publicly it's readonly
@property (nonatomic, readwrite) NSInteger age; // optional way of doing this, because you can write to age using _age privately
@property (nonatomic) NSString *name;
@end

@implementation Person

// this is called the designated initializer
- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
  if (self = [super init]) {
    _name = name;
    _age = age;
  }
  return self;
}

// overriding the default init and calling the designated initializer and passes in defaults
- (instancetype)init {
  return [self initWithName:nil age:0];
}
@end

#pragma mark - Tests

@interface ClassExtension : XCTestCase

@end

@implementation ClassExtension
- (void)test {
  Person *person1 = [[Person alloc] init];
  XCTAssert(person1.name == nil);
  XCTAssert(person1.age == 0);
  Person *person2 = [[Person alloc] initWithName:@"JJ" age:10];
  XCTAssert(person2.name = @"JJ");
  XCTAssert(person2.age == 10);
}


@end
