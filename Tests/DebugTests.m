//
//  DebugTests.m
//  AdvancedCollectionView
//
//  Created by Pierre-Jean Quillere on 19/09/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AAPLDebug.h"

@interface DebugTests : XCTestCase
@end

@implementation DebugTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - String from BOOL

- (void)testStringFromBoolWhenTrue {
    XCTAssertEqualObjects(AAPLStringFromBOOL(YES), @"YES");
}

- (void)testStringFromBoolWhenFalse {
    XCTAssertEqualObjects(AAPLStringFromBOOL(NO), @"NO");
}

#pragma mark - String from NSIndexPath

- (void)testStringFromNSIndexPathForItemInSection {
    XCTAssertEqualObjects(AAPLStringFromNSIndexPath([NSIndexPath indexPathForItem:1 inSection:0]), @"(0, 1)");
}

- (void)testStringFromNSIndexPathForRowInSection {
    XCTAssertEqualObjects(AAPLStringFromNSIndexPath([NSIndexPath indexPathForRow:0 inSection:1]), @"(1, 0)");
}

- (void)testStringFromNSIndexPathWithIndex {
    XCTAssertEqualObjects(AAPLStringFromNSIndexPath([NSIndexPath indexPathWithIndex:42]), @"(42)");
}

- (void)testStringFromNSIndexPathWithIndexes {
    NSUInteger indexes[] = {1, 2, 3};
    XCTAssertEqualObjects(AAPLStringFromNSIndexPath([NSIndexPath indexPathWithIndexes:indexes length:3]), @"(1, 2, 3)");
}

#pragma mark - String from NSIndexSet

- (void)testStringFromNSIndexSetWithoutValues {
    XCTAssertEqualObjects(AAPLStringFromNSIndexSet([NSIndexSet indexSet]), @"()");
}

- (void)testStringFromNSIndexSetWithEmptyRange {
    XCTAssertEqualObjects(AAPLStringFromNSIndexSet([NSIndexSet indexSetWithIndexesInRange:NSMakeRange(42, 0)]), @"()");
}

- (void)testStringFromNSIndexSetWithSingleValue {
    XCTAssertEqualObjects(AAPLStringFromNSIndexSet([NSIndexSet indexSetWithIndex:42]), @"(42)");
}

- (void)testStringFromNSIndexSetWithMultipleValues {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:42];
    [indexSet addIndex:0];
    
    XCTAssertEqualObjects(AAPLStringFromNSIndexSet(indexSet), @"(0, 42)");
}

- (void)testStringFromNSIndexSetWithValuesInSingleRange {
    XCTAssertEqualObjects(AAPLStringFromNSIndexSet([NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]), @"(0..2)");
}

- (void)testStringFromNSIndexSetWithValuesInMultipleRanges {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndexesInRange:NSMakeRange(42, 5)];
    [indexSet addIndexesInRange:NSMakeRange(0, 3)];
    
    XCTAssertEqualObjects(AAPLStringFromNSIndexSet(indexSet), @"(0..2, 42..46)");
}

- (void)testStringFromNSIndexSetWithValuesInRangeAndIndex {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndexesInRange:NSMakeRange(0, 3)];
    [indexSet addIndex:42];
    
    XCTAssertEqualObjects(AAPLStringFromNSIndexSet(indexSet), @"(0..2, 42)");
}

@end
