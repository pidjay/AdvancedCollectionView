//
//  LoadableContentStateMachineTests.m
//  AdvancedCollectionView
//
//  Created by Pierre-Jean Quillere on 20/09/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AAPLContentLoading.h"

@interface LoadableContentStateMachineTests : XCTestCase
@property(nonatomic, strong) AAPLLoadableContentStateMachine *sut;
@end

@implementation LoadableContentStateMachineTests

- (void)setUp {
    [super setUp];
    self.sut = [[AAPLLoadableContentStateMachine alloc] init];
}

- (void)tearDown {
    self.sut = nil;
    [super tearDown];
}

- (void)testStateMachineInitialState {
    XCTAssertEqualObjects(self.sut.currentState, AAPLLoadStateInitial);
}

- (void)testStateMachineValidTransitionsFromInitialState {
    NSSet<NSString *> *validTransitions = [NSSet setWithArray:@[AAPLLoadStateLoadingContent]];
    XCTAssertEqualObjects([NSSet setWithArray:self.sut.validTransitions[AAPLLoadStateInitial]], validTransitions);
}

- (void)testStateMachineValidTransitionsFromLoadingContentState {
    NSSet<NSString *> *validTransitions = [NSSet setWithArray:@[AAPLLoadStateContentLoaded, AAPLLoadStateNoContent, AAPLLoadStateError]];
    XCTAssertEqualObjects([NSSet setWithArray:self.sut.validTransitions[AAPLLoadStateLoadingContent]], validTransitions);
}

- (void)testStateMachineValidTransitionsFromRefreshingContentState {
    NSSet<NSString *> *validTransitions = [NSSet setWithArray:@[AAPLLoadStateContentLoaded, AAPLLoadStateNoContent, AAPLLoadStateError]];
    XCTAssertEqualObjects([NSSet setWithArray:self.sut.validTransitions[AAPLLoadStateRefreshingContent]], validTransitions);
}

- (void)testStateMachineValidTransitionsFromContentLoadedState {
    NSSet<NSString *> *validTransitions = [NSSet setWithArray:@[AAPLLoadStateRefreshingContent, AAPLLoadStateNoContent, AAPLLoadStateError]];
    XCTAssertEqualObjects([NSSet setWithArray:self.sut.validTransitions[AAPLLoadStateContentLoaded]], validTransitions);
}

- (void)testStateMachineValidTransitionsFromNoContentState {
    NSSet<NSString *> *validTransitions = [NSSet setWithArray:@[AAPLLoadStateRefreshingContent, AAPLLoadStateContentLoaded, AAPLLoadStateError]];
    XCTAssertEqualObjects([NSSet setWithArray:self.sut.validTransitions[AAPLLoadStateNoContent]], validTransitions);
}

- (void)testStateMachineValidTransitionsFromErrorState {
    NSSet<NSString *> *validTransitions = [NSSet setWithArray:@[AAPLLoadStateLoadingContent, AAPLLoadStateRefreshingContent, AAPLLoadStateNoContent, AAPLLoadStateContentLoaded]];
    XCTAssertEqualObjects([NSSet setWithArray:self.sut.validTransitions[AAPLLoadStateError]], validTransitions);
}

@end
