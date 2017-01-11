//
//  PlayerDelegateTests.m
//  W1D5
//
//  Created by steve on 2017-01-10.
//  Copyright © 2017 steve. All rights reserved.
//

#import <XCTest/XCTest.h>

// Protocol
@protocol PlayerDelegate <NSObject>
- (NSString*)play;
@end
// Apple Service
@interface AppleMusicService : NSObject<PlayerDelegate>
@end

@implementation AppleMusicService
- (NSString*)play {
  return @"playing apple music playlist";
}
@end

// Spotify Service
@interface SpotifyService : NSObject<PlayerDelegate>
@end

@implementation SpotifyService
- (NSString*)play {
  return @"playing spotify playlist";
}
@end

// Player
@interface Player : NSObject
@property (nonatomic, weak) id<PlayerDelegate>delegate;
- (instancetype)initWithMusicService:(id<PlayerDelegate>)service NS_DESIGNATED_INITIALIZER;
- (NSString *)play;
- (void)changeServiceTo:(id<PlayerDelegate>)service;
@end

@implementation Player

- (instancetype)initWithMusicService:(id<PlayerDelegate>)service  {
  if (self = [super init]) {
    _delegate = service;
  }
  return self;
}

- (instancetype)init {
  return [self initWithMusicService:nil];
}

// player doesn't know how to play
- (NSString *)play {
  return [self.delegate play];
}

- (void)changeServiceTo:(id<PlayerDelegate>)service {
  if ([service isMemberOfClass:[self.delegate class]]) {
    return;
  }
  self.delegate = service;
}

@end

@interface PlayerDelegateTests : XCTestCase

@end

@implementation PlayerDelegateTests

- (void)testPlayer {
  AppleMusicService *appleMusic = [AppleMusicService new];
  SpotifyService *spotify = [SpotifyService new];
  Player *player = [[Player alloc] initWithMusicService:appleMusic];
  NSString *result = [player play];
  XCTAssertEqual(result, @"playing apple music playlist");
  [player changeServiceTo:spotify];
  XCTAssertEqual([player.delegate class], [SpotifyService class]);
  result = [player play];
  XCTAssertEqual(result, @"playing spotify playlist");
}

@end
