/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Tests for the basic data source.
 */


@import UIKit;
@import XCTest;

#import "AAPLBasicDataSource.h"
#import "AAPLDataSource_Private.h"
#import "AAPLCollectionViewLayout_Private.h"
#import "AAPLCollectionViewLayout_Internal.h"

@interface BasicDataSourceTests : XCTestCase
@end

@implementation BasicDataSourceTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testNumberOfHeadersInEmptyDataSource
{
    AAPLBasicDataSource *dataSource = [AAPLBasicDataSource new];

    XCTAssertEqual(0, [dataSource numberOfHeadersInSectionAtIndex:0 includeChildDataSouces:YES]);
}

- (void)testNumberOfHeadersInDataSourceWithGlobalHeaders
{
    AAPLBasicDataSource *dataSource = [AAPLBasicDataSource new];

    AAPLSupplementaryItem *firstHeader = [dataSource newHeaderForKey:@"FOO"];
    firstHeader.estimatedHeight = 100;

    XCTAssertEqual(1, [dataSource numberOfHeadersInSectionAtIndex:AAPLGlobalSectionIndex includeChildDataSouces:YES]);

    AAPLSupplementaryItem *secondHeader = [dataSource newHeaderForKey:@"Bar"];
    secondHeader.estimatedHeight = 100;
    XCTAssertEqual(2, [dataSource numberOfHeadersInSectionAtIndex:AAPLGlobalSectionIndex includeChildDataSouces:YES]);
}

- (void)testNumberOfHeadersInDefaultMetrics
{
    AAPLBasicDataSource *dataSource = [AAPLBasicDataSource new];

    AAPLSupplementaryItem *defaultHeader = [dataSource newSectionHeader];
    defaultHeader.estimatedHeight = 100;

    XCTAssertEqual(1, [dataSource numberOfHeadersInSectionAtIndex:0 includeChildDataSouces:YES]);
}

- (void)testNumberOfHeadersInSection
{
    AAPLBasicDataSource *dataSource = [AAPLBasicDataSource new];

    AAPLSupplementaryItem *sectionHeader = [dataSource newHeaderForSectionAtIndex:0];
    sectionHeader.estimatedHeight = 100;

    XCTAssertEqual(1, [dataSource numberOfHeadersInSectionAtIndex:0 includeChildDataSouces:YES]);
}

- (void)testNumberOfHeadersInSectionWithDefaultHeaders
{
    AAPLBasicDataSource *dataSource = [AAPLBasicDataSource new];

    AAPLSupplementaryItem *defaultHeader = [dataSource newSectionHeader];
    defaultHeader.estimatedHeight = 100;

    AAPLSupplementaryItem *sectionHeader = [dataSource newHeaderForSectionAtIndex:0];
    sectionHeader.estimatedHeight = 100;

    XCTAssertEqual(2, [dataSource numberOfHeadersInSectionAtIndex:0 includeChildDataSouces:YES]);
}

- (void)testStickyHeaderInDataSourceWithGlobalHeader
{
    AAPLBasicDataSource *dataSource = [AAPLBasicDataSource new];
    
    AAPLSupplementaryItem *stickyHeader = [dataSource newHeaderForKey:@"FOO"];
    stickyHeader.height = 100;
    stickyHeader.shouldStick = YES;
    stickyHeader.visibleWhileShowingPlaceholder = YES;
    
    AAPLCollectionViewLayout *layout = [[AAPLCollectionViewLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 320.0) collectionViewLayout:layout];
    collectionView.dataSource = dataSource;
    collectionView.contentOffset = CGPointMake(0.0, -60.0); // pulling the collection view down
    
    [layout prepareLayout];
    
    AAPLLayoutSection *section = [layout sectionInfoForSectionAtIndex:AAPLGlobalSectionIndex];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(1, section.headers.count);
    XCTAssertEqual(1, section.stickyHeaders.count);
    XCTAssertEqual(0, section.pinnableHeaders.count);
    
    AAPLLayoutSupplementaryItem *header = section.stickyHeaders.firstObject;
    
    XCTAssertNotNil(header);
    XCTAssertTrue(header.layoutAttributes.stickedHeader, @"Sticky header should stick in a section.");
    XCTAssertEqual(collectionView.contentOffset.y, header.layoutAttributes.frame.origin.y);
}

- (void)testStickyHeaderInDataSourceWithSectionHeader
{
    AAPLBasicDataSource *dataSource = [AAPLBasicDataSource new];
    
    AAPLSupplementaryItem *stickyHeader = [dataSource newSectionHeader];
    stickyHeader.height = 100;
    stickyHeader.shouldStick = YES;
    stickyHeader.visibleWhileShowingPlaceholder = YES;
    
    AAPLCollectionViewLayout *layout = [[AAPLCollectionViewLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 320.0) collectionViewLayout:layout];
    collectionView.dataSource = dataSource;
    collectionView.contentOffset = CGPointMake(0.0, -60.0); // pulling the collection view down
    
    [layout prepareLayout];
    
    AAPLLayoutSection *section = [layout sectionInfoForSectionAtIndex:0];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(1, section.headers.count);
    XCTAssertEqual(0, section.stickyHeaders.count);
    XCTAssertEqual(0, section.pinnableHeaders.count);
    
    AAPLLayoutSupplementaryItem *header = section.headers.firstObject;
    
    XCTAssertNotNil(header);
    XCTAssertFalse(header.layoutAttributes.stickedHeader, @"Sticky header should not stick in a section.");
    XCTAssertEqual(header.layoutAttributes.frame.origin.y, 0);
}

- (void)testStretchableHeaderInDataSourceWithGlobalHeader
{
    AAPLBasicDataSource *dataSource = [AAPLBasicDataSource new];
    
    AAPLSupplementaryItem *stretchableHeader = [dataSource newHeaderForKey:@"FOO"];
    stretchableHeader.height = 100;
    stretchableHeader.shouldStretch = YES;
    stretchableHeader.visibleWhileShowingPlaceholder = YES;
    
    AAPLCollectionViewLayout *layout = [[AAPLCollectionViewLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 320.0) collectionViewLayout:layout];
    collectionView.dataSource = dataSource;
    collectionView.contentOffset = CGPointMake(0.0, -60.0); // pulling the collection view down
    
    [layout prepareLayout];
    
    AAPLLayoutSection *section = [layout sectionInfoForSectionAtIndex:AAPLGlobalSectionIndex];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(1, section.headers.count);
    XCTAssertEqual(1, section.stickyHeaders.count);
    XCTAssertEqual(0, section.pinnableHeaders.count);
    
    AAPLLayoutSupplementaryItem *header = section.stickyHeaders.firstObject;
    
    XCTAssertNotNil(header);
    XCTAssertTrue(header.layoutAttributes.stickedHeader, @"Sticky header should stick in a section.");
    XCTAssertEqual(collectionView.contentOffset.y, header.layoutAttributes.frame.origin.y);
    XCTAssertTrue(header.layoutAttributes.stretchedHeader, @"Stretchable header should stretch in a section.");
    XCTAssertEqual(-collectionView.contentOffset.y + 100, header.layoutAttributes.frame.size.height);
}

- (void)testStretchableHeaderInDataSourceWithSectionHeader
{
    AAPLBasicDataSource *dataSource = [AAPLBasicDataSource new];
    
    AAPLSupplementaryItem *stretchableHeader = [dataSource newSectionHeader];
    stretchableHeader.height = 100;
    stretchableHeader.shouldStretch = YES;
    stretchableHeader.visibleWhileShowingPlaceholder = YES;
    
    AAPLCollectionViewLayout *layout = [[AAPLCollectionViewLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 320.0) collectionViewLayout:layout];
    collectionView.dataSource = dataSource;
    collectionView.contentOffset = CGPointMake(0.0, -60.0); // pulling the collection view down
    
    [layout prepareLayout];
    
    AAPLLayoutSection *section = [layout sectionInfoForSectionAtIndex:0];
    
    XCTAssertNotNil(section);
    XCTAssertEqual(1, section.headers.count);
    XCTAssertEqual(0, section.stickyHeaders.count);
    XCTAssertEqual(0, section.pinnableHeaders.count);
    
    AAPLLayoutSupplementaryItem *header = section.headers.firstObject;
    
    XCTAssertNotNil(header);
    XCTAssertFalse(header.layoutAttributes.stickedHeader, @"Sticky header should not stick in a section.");
    XCTAssertEqual(header.layoutAttributes.frame.origin.y, 0);
    XCTAssertFalse(header.layoutAttributes.stretchedHeader, @"Stretchable header should not stretch in a section.");
    XCTAssertEqual(header.layoutAttributes.frame.size.height, 100);
}

@end
