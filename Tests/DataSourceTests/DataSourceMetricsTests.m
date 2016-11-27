//
//  DataSourceMetricsTests.m
//  AdvancedCollectionView
//
//  Created by Pierre-Jean Quillere on 27/11/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "AAPLDataSourceMetrics.h"

@interface DataSourceMetricsTests : XCTestCase
@property(nonatomic, strong) AAPLDataSourceSectionMetrics *sut;
@end

@implementation DataSourceMetricsTests

- (void)setUp {
    [super setUp];
    
    self.sut = [[AAPLDataSourceSectionMetrics alloc] init];
}

- (void)tearDown {
    self.sut = nil;
    
    [super tearDown];
}

- (void)testNewHeaderElementKind
{
    // given
    AAPLSupplementaryItem *header = [self.sut newHeader];
    
    // then
    XCTAssertEqualObjects(header.elementKind, UICollectionElementKindSectionHeader);
}

- (void)testNewFooterElementKind
{
    // given
    AAPLSupplementaryItem *footer = [self.sut newFooter];
    
    // then
    XCTAssertEqualObjects(footer.elementKind, UICollectionElementKindSectionFooter);
}

@end
