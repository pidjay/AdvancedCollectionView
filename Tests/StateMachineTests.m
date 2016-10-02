//
//  StateMachineTests.m
//  AdvancedCollectionView
//
//  Created by Pierre-Jean Quillere on 25/09/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AAPLStateMachine.h"

@interface StateMachineTests : XCTestCase <AAPLStateMachineDelegate>
@property(nonatomic, strong) AAPLStateMachine *sut;
@end

@implementation StateMachineTests
{
    NSInteger _stateWillChangeCount;
    NSInteger _stateDidChangeCount;
    
    BOOL _shouldEnterInitialState;
    BOOL _shouldEnterValidState;
    
    BOOL _didEnterInitialState;
    BOOL _didExitInitialState;
    BOOL _didEnterValidState;
    BOOL _didChangeFromNilToInitialState;
    BOOL _didChangeFromInitialStateToValidState;
}

- (void)setUp {
    [super setUp];
    
    self.sut = [[AAPLStateMachine alloc] init];
    self.sut.delegate = self;
    
    _stateDidChangeCount = 0;
    _stateWillChangeCount = 0;
    
    _shouldEnterInitialState = NO;
    _shouldEnterValidState = NO;
    
    _didEnterInitialState = NO;
    _didExitInitialState = NO;
    _didEnterValidState = NO;
    _didChangeFromNilToInitialState = NO;
    _didChangeFromInitialStateToValidState = NO;
}

- (void)tearDown {
    self.sut = nil;
    [super tearDown];
}

- (void)testInitialState {
    XCTAssertEqualObjects(self.sut.validTransitions, @{});
    XCTAssertNil(self.sut.currentState);
    
    XCTAssertFalse(_shouldEnterInitialState);
    XCTAssertFalse(_shouldEnterValidState);
    XCTAssertFalse(_didEnterInitialState);
    XCTAssertFalse(_didExitInitialState);
    XCTAssertFalse(_didEnterValidState);
    XCTAssertFalse(_didChangeFromNilToInitialState);
    XCTAssertFalse(_didChangeFromInitialStateToValidState);
}

- (void)testValidInitialState {
    self.sut.validTransitions = @{
                                  @"InitialState": @[@"ValidState"]
                                  };
    
    XCTAssertNoThrow(self.sut.currentState = @"InitialState");
    XCTAssertEqual(_stateWillChangeCount, 1);
    XCTAssertEqual(_stateDidChangeCount, 1);
    
    XCTAssertTrue(_shouldEnterInitialState);
    XCTAssertFalse(_shouldEnterValidState);
    XCTAssertTrue(_didEnterInitialState);
    XCTAssertFalse(_didExitInitialState);
    XCTAssertFalse(_didEnterValidState);
    XCTAssertTrue(_didChangeFromNilToInitialState);
    XCTAssertFalse(_didChangeFromInitialStateToValidState);
}

- (void)testInvalidInitialState {
    self.sut.validTransitions = @{
                                  @"InitialState": @[@"ValidState"]
                                  };
    
    XCTAssertThrows(self.sut.currentState = @"InvalidInitialState");
    XCTAssertEqual(_stateWillChangeCount, 0);
    XCTAssertEqual(_stateDidChangeCount, 0);
    
    XCTAssertFalse(_shouldEnterInitialState);
    XCTAssertFalse(_shouldEnterValidState);
    XCTAssertFalse(_didEnterInitialState);
    XCTAssertFalse(_didExitInitialState);
    XCTAssertFalse(_didEnterValidState);
    XCTAssertFalse(_didChangeFromNilToInitialState);
    XCTAssertFalse(_didChangeFromInitialStateToValidState);
}

- (void)testValidStateTransition {
    self.sut.validTransitions = @{
                                  @"InitialState": @[@"ValidState"]
                                  };
    self.sut.currentState = @"InitialState";
    
    XCTAssertTrue(_shouldEnterInitialState);
    XCTAssertFalse(_shouldEnterValidState);
    XCTAssertTrue(_didEnterInitialState);
    XCTAssertFalse(_didExitInitialState);
    XCTAssertFalse(_didEnterValidState);
    XCTAssertTrue(_didChangeFromNilToInitialState);
    XCTAssertFalse(_didChangeFromInitialStateToValidState);
    
    // Reset flags after the initial state was set
    _shouldEnterInitialState = NO;
    _didEnterInitialState = NO;
    _didChangeFromNilToInitialState = NO;
    
    XCTAssertTrue([self.sut applyState:@"ValidState"]);
    XCTAssertEqual(_stateWillChangeCount, 2);
    XCTAssertEqual(_stateDidChangeCount, 2);
    
    XCTAssertFalse(_shouldEnterInitialState);
    XCTAssertTrue(_shouldEnterValidState);
    XCTAssertFalse(_didEnterInitialState);
    XCTAssertTrue(_didExitInitialState);
    XCTAssertTrue(_didEnterValidState);
    XCTAssertFalse(_didChangeFromNilToInitialState);
    XCTAssertTrue(_didChangeFromInitialStateToValidState);
}

- (void)testInvalidStateTransition {
    self.sut.validTransitions = @{
                                  @"InitialState": @[@"ValidState"],
                                  @"ValidState": @[@"InvalidState"]
                                  };
    self.sut.currentState = @"InitialState";
    
    XCTAssertThrows([self.sut applyState:@"InvalidState"]);
}

- (void)testTransitionToNilState {
    self.sut.validTransitions = @{
                                  @"InitialState": @[@"ValidState"],
                                  @"ValidState": @[@"InvalidState"]
                                  };
    self.sut.currentState = @"InitialState";
    
    XCTAssertThrows(self.sut.currentState = nil);
}

- (void)testSingleValidTransition {
    self.sut.validTransitions = @{
                                  @"InitialState": @"ValidState",
                                  @"ValidState": @"InvalidState"
                                  };
    self.sut.currentState = @"InitialState";
    
    XCTAssertTrue([self.sut applyState:@"ValidState"]);
    XCTAssertEqualObjects(self.sut.currentState, @"ValidState");
}

- (void)testTransitionToSameState {
    self.sut.validTransitions = @{
                                  @"InitialState": @"ValidState"
                                  };
    self.sut.currentState = @"InitialState";
    
    XCTAssertTrue(_shouldEnterInitialState);
    XCTAssertFalse(_shouldEnterValidState);
    XCTAssertTrue(_didEnterInitialState);
    XCTAssertFalse(_didExitInitialState);
    XCTAssertFalse(_didEnterValidState);
    XCTAssertTrue(_didChangeFromNilToInitialState);
    XCTAssertFalse(_didChangeFromInitialStateToValidState);
    
    // Reset flags after the initial state was set
    _shouldEnterInitialState = NO;
    _didEnterInitialState = NO;
    _didChangeFromNilToInitialState = NO;
    
    XCTAssertFalse([self.sut applyState:@"InitialState"]);
    
    // Transitioning to the same state should be silent
    XCTAssertFalse(_shouldEnterInitialState);
    XCTAssertFalse(_shouldEnterValidState);
    XCTAssertFalse(_didEnterInitialState);
    XCTAssertFalse(_didExitInitialState);
    XCTAssertFalse(_didEnterValidState);
    XCTAssertFalse(_didChangeFromNilToInitialState);
    XCTAssertFalse(_didChangeFromInitialStateToValidState);
}

#pragma mark - AAPLStateMachineDelegate

- (void)stateWillChange {
    _stateWillChangeCount++;
}

- (void)stateDidChange {
    _stateDidChangeCount++;
}

- (BOOL)shouldEnterInitialState {
    _shouldEnterInitialState = YES;
    return YES;
}

- (BOOL)shouldEnterValidState {
    _shouldEnterValidState = YES;
    return YES;
}

- (void)didEnterInitialState {
    _didEnterInitialState = YES;
}

- (void)didExitInitialState {
    _didExitInitialState = YES;
}

- (void)didEnterValidState {
    _didEnterValidState = YES;
}

- (void)stateDidChangeFromNilToInitialState {
    _didChangeFromNilToInitialState = YES;
}

- (void)stateDidChangeFromInitialStateToValidState {
    _didChangeFromInitialStateToValidState = YES;
}

@end
