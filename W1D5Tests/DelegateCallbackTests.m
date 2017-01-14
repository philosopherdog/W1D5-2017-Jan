//
//  DelegateCallbackTests.m
//  W1D5
//
//  Created by steve on 2017-01-10.
//  Copyright © 2017 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

// DetailViewController.h
@class DetailViewController;
@protocol DetailDelegate <NSObject>
- (NSString *)detail:(DetailViewController *)detail doStuffWithData:(NSString *)data;
@end

@interface DetailViewController : NSObject
@property (nonatomic, weak) id<DetailDelegate>delegate;
- (NSString *)saveFakeUserInput:(NSString *)input;
@end

// DetailViewController.m
//#import "DetailViewController.h"
@implementation DetailViewController
- (NSString *)saveFakeUserInput:(NSString *)input {
  return [self.delegate detail:self doStuffWithData:input];
}
@end

// MasterViewController.h
@interface MasterViewController : NSObject
- (void)segueToDetailButtonTapped;
@property (nonatomic, strong) DetailViewController *detail;
@end

// MasterViewController.m
//#import "MasterViewController.h"

// class extension, not really used execept for conforming to DetailDelegate
@interface MasterViewController()<DetailDelegate>
@end
@implementation MasterViewController
- (void)segueToDetailButtonTapped {
  self.detail.delegate = self;
  // do segue to Detail
}

// called by detail
- (NSString *)detail:(DetailViewController *)detail doStuffWithData:(NSString *)data {
  return [NSString stringWithFormat:@"data gathered from detail: %@", data];
  // dismiss detail
}

@end

@interface DelegateCallbackTests : XCTestCase

@end

@implementation DelegateCallbackTests

- (void)test {
  MasterViewController *master = [MasterViewController new];
  DetailViewController *detail = [DetailViewController new];
  master.detail = detail;
  [master segueToDetailButtonTapped]; // tap the button
  NSString *result = [detail saveFakeUserInput:@"some user input"]; // save some data on detail
  XCTAssertTrue([result containsString:@"some user input"]);
}

@end
