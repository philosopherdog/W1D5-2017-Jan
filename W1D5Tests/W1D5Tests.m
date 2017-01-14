//
//  W1D5Tests.m
//  W1D5Tests
//
//  Created by steve on 2017-01-10.
//  Copyright © 2017 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

// Protocol
@protocol MyProtocol <NSObject>
@optional
- (BOOL)someMethod;
@end

// MyObject Class
@interface MyObject : NSObject<MyProtocol>
@end
@implementation MyObject
- (BOOL)someMethod {
  return YES;
}
@end

@interface W1D5Tests : XCTestCase
@property (nonatomic) BOOL wasCalled;
@end

@implementation W1D5Tests

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  [super tearDown];
  self.wasCalled = NO;
}

// Example 1
- (void)fly {}
- (void)nameOfMethod { }

- (void)testTwoWaysToCreateSelector {
  
  //1. compile time
  SEL aSelector1 = @selector(fly);
  
  //2. run time
  NSString *name = @"name";
  NSString *of = @"Of";
  NSString *method = @"Method";
  NSString *stringFromComponents = [NSString stringWithFormat:@"%@%@%@", name, of, method];
  NSString *s = @"nameOfMethod";
  SEL aSelector2 = NSSelectorFromString(s);
  BOOL result1 = [W1D5Tests instancesRespondToSelector:aSelector1];
  BOOL result2 = [W1D5Tests instancesRespondToSelector:aSelector2];
  XCTAssertTrue(result1);
  XCTAssertTrue(result2);
}

// Example 2

- (void)testSelectors {
  // notice the colon
  SEL mySelector = @selector(myMethodWithData:);
  [self performSelectorOnMainThread:mySelector withObject:[NSData new] waitUntilDone:YES];
  XCTAssertTrue(self.wasCalled);
  self.wasCalled = NO;
  [self performSelector:@selector(fullNameWithFirstName:lastName:) withObject:@"Joe" withObject:@"Blow"];
  XCTAssertTrue(self.wasCalled);
}

- (void)myMethodWithData:(NSData *)data {
  self.wasCalled = YES;
}

- (void)fullNameWithFirstName:(NSString *)first lastName:(NSString *)last {
  self.wasCalled = YES;
}


// Example 3

/*
 // definition
 - (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
 */

- (void)testButtonSelectorArgument {
  // adding it to a button
  UIButton *aButton = [[UIButton alloc] initWithFrame:CGRectZero];
  [aButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
  XCTAssertTrue(self.wasCalled);
  
}
// actual method the button calls when tapped
- (void)buttonTapped:(UIButton *)sender {
  self.wasCalled = YES;
}

// Example 4

- (void)testSelector {
  
  MyObject *myObject = [MyObject new];
  
  if ([myObject respondsToSelector:@selector(someMethod)]) {
    
    BOOL result = [myObject performSelector:@selector(someMethod)];
    XCTAssertTrue(result);
    
    // or, since it responds, do this:
    // [myObject someMethod];
  }
}


- (void)testArraySort {
  NSArray *unsorted = @[@"Hello", @"Light", @"House", @"Labs"];
  NSArray *sorted = [unsorted sortedArrayUsingSelector:@selector(compare:)];
  NSArray *expected = @[@"Hello", @"House", @"Labs", @"Light"];
  XCTAssert([sorted isEqualToArray:expected]);
}

@end
