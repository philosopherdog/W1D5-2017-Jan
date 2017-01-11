//
//  NSNumberTests.m
//  W1D5
//
//  Created by steve on 2017-01-10.
//  Copyright © 2017 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSNumberTests : XCTestCase

@end

@implementation NSNumberTests

// prefer literal instantiation
- (void)test {
  NSNumber *num1 = [[NSNumber alloc] initWithInt:22];
  NSNumber *num2 = [NSNumber numberWithFloat:12.2];
  NSNumber *num3 = @(33);
  NSNumber *num4 = @(YES); // BOOL
  NSNumber *num5 = @('i'); // Char
  NSArray *array = @[num1, num2, num3, num4, num5];
  XCTAssertTrue([array[0] integerValue] == 22);
  XCTAssertTrue([array[1] compare:[NSNumber numberWithFloat:22.2]] == NSOrderedAscending);
  XCTAssertTrue([array[2] isEqual:[NSNumber numberWithInteger:33]]);
  XCTAssertTrue([num4 integerValue] == 1); // BOOLS are 1 or 0 in Objc, but never do this
  XCTAssertTrue([array[4] charValue] == 'i');
  // pro tip
  NSInteger num = 12;
  NSLog(@"for logging out integers wrap them using literal syntax: %@", @(num));
}

- (void)testSomeTricks {
  // using NSNumber's literal syntax as a dictionary key!
  NSDictionary *dict = @{@1:@"One", @2:@"Two", @3:@"Three"};
  
  // looping: dict.allKeys gets an array of keys, but notice it has no definite order
  // dictionaries are unordered
  
  for (NSNumber *key in dict.allKeys) {
    NSLog(@"%@", dict[key]);
  }
  
  NSInteger num5 = 44;
  // logging primitive integer types by wrapping them in an NSNumber literal syntax
  NSLog(@"logging an NSInteger by wrapping it: %@", @(num5));
  
  // this is a quick way to get the string value of an integer type
  NSString *num5ToString = @(num5).stringValue;
  
  // this is the long way of doing the same thing
  num5ToString = [NSString stringWithFormat:@"%d", 44];
}

@end
