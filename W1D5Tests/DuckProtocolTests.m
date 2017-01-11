//
//  ProtocolTests.m
//  W1D5
//
//  Created by steve on 2017-01-10.
//  Copyright © 2017 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

// Flyable.h
@protocol Flyable <NSObject>
- (NSString *)fly;
@end

// Duck.h
//#import "Flyable.h"
@interface Duck : NSObject<Flyable>
@end

// Duck.m
//#import "Duck.h"
@implementation Duck
- (NSString *)fly {
  return @"flyin high!";
}
@end

// RubberDuck.h
//#import "Flyable.h"
@interface RubberDuck : NSObject<Flyable>
@end

// RebberDuck.m
//#import "RubberDuck.h"
@implementation RubberDuck
- (NSString *)fly {
  return @"can't fly worth beans";
}
@end

@interface DuckProtocolTests : XCTestCase

@end

@implementation DuckProtocolTests

- (NSString *)executeFlyableObject:(id<Flyable>)aFlyable {
  return [aFlyable fly];
}

- (void)testDucks {
  id<Flyable>duck = [Duck new];
  id<Flyable>rubber = [RubberDuck new];
  NSArray *flyableArray = @[duck, rubber];
  // loop through
  for (id<Flyable>item in flyableArray) {
    __unused NSString *result = [item fly];
  }
  NSString *result1 = [self executeFlyableObject:rubber]; // ==> can't fly worth beans
  XCTAssert([result1 isEqualToString:@"can't fly worth beans"]);
  NSString *result2 = [self executeFlyableObject:duck]; // ==> flyin high!
  XCTAssert([result2 isEqualToString:@"flyin high!"]);
}

@end
