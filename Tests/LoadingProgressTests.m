//
//  LoadingProgressTests.m
//  AdvancedCollectionView
//
//  Created by Pierre-Jean Quillere on 21/09/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AAPLContentLoading.h"

@interface AAPLLoadingProgress()
@property (nonatomic, readwrite, getter = isCancelled) BOOL cancelled;
@end

@interface LoadingProgressTests : XCTestCase
@end

@implementation LoadingProgressTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testInitialState {
    AAPLLoadingProgress *sut = [AAPLLoadingProgress loadingProgressWithCompletionHandler:^(NSString * _Nullable state, NSError * _Nullable error, AAPLLoadingUpdateBlock  _Nullable update) {
        
    }];
    
    XCTAssertFalse(sut.cancelled);
}

- (void)testIgnore {
    XCTestExpectation *expectation = [self expectationWithDescription:@"IGNORE loading progress"];
    
    AAPLLoadingProgress *sut = [AAPLLoadingProgress loadingProgressWithCompletionHandler:^(NSString * _Nullable state, NSError * _Nullable error, AAPLLoadingUpdateBlock  _Nullable update) {
        XCTAssertNil(state);
        XCTAssertNil(error);
        XCTAssertNil(update);
        
        [expectation fulfill];
        
    }];
    
    [sut ignore];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)testCancel {
    XCTestExpectation *expectation = [self expectationWithDescription:@"CANCEL loading progress"];
    
    AAPLLoadingProgress *sut = [AAPLLoadingProgress loadingProgressWithCompletionHandler:^(NSString * _Nullable state, NSError * _Nullable error, AAPLLoadingUpdateBlock  _Nullable update) {
        XCTAssertNil(state);
        XCTAssertNil(error);
        XCTAssertNil(update);
        
        [expectation fulfill];
        
    }];
    
    sut.cancelled = YES;
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)testDone {
    XCTestExpectation *expectation = [self expectationWithDescription:@"DONE loading progress"];
    
    AAPLLoadingProgress *sut = [AAPLLoadingProgress loadingProgressWithCompletionHandler:^(NSString * _Nullable state, NSError * _Nullable error, AAPLLoadingUpdateBlock  _Nullable update) {
        XCTAssertEqualObjects(state, AAPLLoadStateContentLoaded);
        XCTAssertNil(error);
        XCTAssertNil(update);
        
        [expectation fulfill];
        
    }];
    
    [sut done];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)testDoneWithError {
    XCTestExpectation *expectation = [self expectationWithDescription:@"DONE loading progress with error"];
    NSError *error = [NSError errorWithDomain:@"domain" code:42 userInfo:nil];
    
    AAPLLoadingProgress *sut = [AAPLLoadingProgress loadingProgressWithCompletionHandler:^(NSString * _Nullable state, NSError * _Nullable error, AAPLLoadingUpdateBlock  _Nullable update) {
        XCTAssertEqualObjects(state, AAPLLoadStateError);
        XCTAssertNotNil(error);
        XCTAssertEqualObjects(error.domain, @"domain");
        XCTAssertEqual(error.code, 42);
        XCTAssertNil(update);
        
        [expectation fulfill];
        
    }];
    
    [sut doneWithError:error];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)testDoneWithNilError {
    XCTestExpectation *expectation = [self expectationWithDescription:@"DONE loading progress without error"];
    NSError *error = nil;
    
    AAPLLoadingProgress *sut = [AAPLLoadingProgress loadingProgressWithCompletionHandler:^(NSString * _Nullable state, NSError * _Nullable error, AAPLLoadingUpdateBlock  _Nullable update) {
        XCTAssertEqualObjects(state, AAPLLoadStateContentLoaded);
        XCTAssertNil(error);
        XCTAssertNil(update);
        
        [expectation fulfill];
        
    }];
    
    [sut doneWithError:error];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)testUpdateWithContent {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UPDATE loading progress with content"];
    AAPLLoadingUpdateBlock block = ^(id  _Nonnull object) {
        
    };
    
    AAPLLoadingProgress *sut = [AAPLLoadingProgress loadingProgressWithCompletionHandler:^(NSString * _Nullable state, NSError * _Nullable error, AAPLLoadingUpdateBlock  _Nullable update) {
        XCTAssertEqualObjects(state, AAPLLoadStateContentLoaded);
        XCTAssertNil(error);
        XCTAssertEqualObjects(update, block);
        
        [expectation fulfill];
        
    }];
    
    [sut updateWithContent:block];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)testUpdateWithNoContent {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UPDATE loading progress with NO content"];
    AAPLLoadingUpdateBlock block = ^(id  _Nonnull object) {
        
    };
    
    AAPLLoadingProgress *sut = [AAPLLoadingProgress loadingProgressWithCompletionHandler:^(NSString * _Nullable state, NSError * _Nullable error, AAPLLoadingUpdateBlock  _Nullable update) {
        XCTAssertEqualObjects(state, AAPLLoadStateNoContent);
        XCTAssertNil(error);
        XCTAssertEqualObjects(update, block);
        
        [expectation fulfill];
        
    }];
    
    [sut updateWithNoContent:block];
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)testThrowsOnSecondCall {
    AAPLLoadingProgress *sut = [AAPLLoadingProgress loadingProgressWithCompletionHandler:^(NSString * _Nullable state, NSError * _Nullable error, AAPLLoadingUpdateBlock  _Nullable update) {}];
    [sut done];
    
    XCTAssertThrows([sut done]);
}

@end
