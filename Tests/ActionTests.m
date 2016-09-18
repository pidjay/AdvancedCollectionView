//
//  ActionTests.m
//  AdvancedCollectionView
//
//  Created by Pierre-Jean Quilleré on 9/18/16.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AAPLAction.h"

@interface ActionTests : XCTestCase
@end

@implementation ActionTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testActionInitialization {
    AAPLAction *sut = [AAPLAction actionWithTitle:@"title" selector:@selector(actionMethod)];
    
    XCTAssertFalse(sut.isDestructive);
    XCTAssertEqual(sut.title, @"title");
    XCTAssertEqual(sut.selector, @selector(actionMethod));
}

- (void)testDestructiveActionInitialization {
    AAPLAction *sut = [AAPLAction destructiveActionWithTitle:@"destructive title" selector:@selector(destructiveActionMethod)];
    
    XCTAssertTrue(sut.isDestructive);
    XCTAssertEqual(sut.title, @"destructive title");
    XCTAssertEqual(sut.selector, @selector(destructiveActionMethod));
}

- (void)actionMethod {
    
}

- (void)destructiveActionMethod {
    
}

@end
