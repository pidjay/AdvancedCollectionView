//
//  SectionMetricsTests.m
//  AdvancedCollectionView
//
//  Created by Pierre-Jean Quillere on 01/11/2016.
//  Copyright © 2016 Pierre-Jean Quilleré. All rights reserved.
//

//#import <XCTest/XCTest.h>
@import XCTest;

#import "AAPLLayoutMetrics.h"
#import "AAPLTheme.h"

@interface AAPLTestTheme : AAPLTheme
@end

@implementation AAPLTestTheme
@end

@interface SectionMetricsTests : XCTestCase
@property(nonatomic, strong) AAPLSectionMetrics *sut;
@end

@implementation SectionMetricsTests

- (void)setUp
{
    [super setUp];
    self.sut = [[AAPLSectionMetrics alloc] init];
}

- (void)tearDown
{
    self.sut = nil;
    [super tearDown];
}

- (void)testInitialValues
{
    XCTAssertEqual(self.sut.rowHeight, AAPLCollectionViewAutomaticHeight);
    XCTAssertEqual(self.sut.estimatedRowHeight, 44.0);
    XCTAssertEqual(self.sut.numberOfColumns, 1);
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.sut.padding, UIEdgeInsetsZero));
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.sut.layoutMargins, UIEdgeInsetsZero));
    XCTAssertTrue(self.sut.showsColumnSeparator);
    XCTAssertFalse(self.sut.showsRowSeparator);
    XCTAssertFalse(self.sut.showsSectionSeparator);
    XCTAssertFalse(self.sut.showsSectionSeparatorWhenLastSection);
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.sut.separatorInsets, UIEdgeInsetsZero));
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.sut.sectionSeparatorInsets, UIEdgeInsetsZero));
    XCTAssertEqualObjects(self.sut.backgroundColor, nil);
    XCTAssertEqualObjects(self.sut.selectedBackgroundColor, nil);
    XCTAssertEqualObjects(self.sut.separatorColor, nil);
    XCTAssertEqualObjects(self.sut.sectionSeparatorColor, nil);
    XCTAssertEqual(self.sut.cellLayoutOrder, AAPLCellLayoutOrderLeftToRight);
    XCTAssertEqualObjects(self.sut.theme, [AAPLTheme theme]);
}

- (void)testCopySectionMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.rowHeight = 1.0;
    sectionMetrics.estimatedRowHeight = 1.0;
    sectionMetrics.numberOfColumns = 2;
    sectionMetrics.padding = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
    sectionMetrics.layoutMargins = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
    sectionMetrics.showsColumnSeparator = NO;
    sectionMetrics.showsRowSeparator = YES;
    sectionMetrics.showsSectionSeparator = YES;
    sectionMetrics.showsSectionSeparatorWhenLastSection = YES;
    sectionMetrics.separatorInsets = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
    sectionMetrics.sectionSeparatorInsets = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
    sectionMetrics.backgroundColor = [UIColor redColor];
    sectionMetrics.selectedBackgroundColor = [UIColor blueColor];
    sectionMetrics.separatorColor = [UIColor redColor];
    sectionMetrics.sectionSeparatorColor = [UIColor blueColor];
    sectionMetrics.cellLayoutOrder = AAPLCellLayoutOrderRightToLeft;
    sectionMetrics.theme = [AAPLTheme theme];
    
    // when
    AAPLSectionMetrics *copiedSectionMetrics = [sectionMetrics copy];
    
    // then
    XCTAssertEqual(sectionMetrics.rowHeight, copiedSectionMetrics.rowHeight);
    XCTAssertEqual(sectionMetrics.estimatedRowHeight, copiedSectionMetrics.estimatedRowHeight);
    XCTAssertEqual(sectionMetrics.numberOfColumns, copiedSectionMetrics.numberOfColumns);
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(sectionMetrics.padding, copiedSectionMetrics.padding));
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(sectionMetrics.layoutMargins, copiedSectionMetrics.layoutMargins));
    XCTAssertEqual(sectionMetrics.showsColumnSeparator, copiedSectionMetrics.showsColumnSeparator);
    XCTAssertEqual(sectionMetrics.showsRowSeparator, copiedSectionMetrics.showsRowSeparator);
    XCTAssertEqual(sectionMetrics.showsSectionSeparator, copiedSectionMetrics.showsSectionSeparator);
    XCTAssertEqual(sectionMetrics.showsSectionSeparatorWhenLastSection, copiedSectionMetrics.showsSectionSeparatorWhenLastSection);
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(sectionMetrics.separatorInsets, copiedSectionMetrics.separatorInsets));
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(sectionMetrics.sectionSeparatorInsets, copiedSectionMetrics.sectionSeparatorInsets));
    XCTAssertEqualObjects(sectionMetrics.backgroundColor, copiedSectionMetrics.backgroundColor);
    XCTAssertEqualObjects(sectionMetrics.selectedBackgroundColor, copiedSectionMetrics.selectedBackgroundColor);
    XCTAssertEqualObjects(sectionMetrics.separatorColor, copiedSectionMetrics.separatorColor);
    XCTAssertEqualObjects(sectionMetrics.sectionSeparatorColor, copiedSectionMetrics.sectionSeparatorColor);
    XCTAssertEqual(sectionMetrics.cellLayoutOrder, copiedSectionMetrics.cellLayoutOrder);
    XCTAssertEqualObjects(sectionMetrics.theme, copiedSectionMetrics.theme);
}

- (void)testApplyRowHeightFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.rowHeight = 1.0;
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertEqual(self.sut.rowHeight, 1.0);
}

- (void)testApplyEstimatedRowHeightFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.estimatedRowHeight = 1.0;
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertEqual(self.sut.estimatedRowHeight, 1.0);
}

- (void)testApplyNumberOfColumnsFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.numberOfColumns = 2;
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertEqual(self.sut.numberOfColumns, 2);
}

- (void)testApplyPaddingFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.padding = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.sut.padding, UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)));
}

- (void)testApplyLayoutMarginsFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.layoutMargins = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.sut.layoutMargins, UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)));
}

- (void)testApplyShowsColumnSeparatorFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.showsColumnSeparator = NO;
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertFalse(self.sut.showsColumnSeparator);
}

- (void)testApplyShowsRowSeparatorFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.showsRowSeparator = YES;
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertTrue(self.sut.showsRowSeparator);
}

- (void)testApplyShowsSectionSeparatorFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.showsSectionSeparator = YES;
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertTrue(self.sut.showsSectionSeparator);
}

- (void)testApplyShowsSectionSeparatorWhenLastSectionFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.showsSectionSeparatorWhenLastSection = YES;
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertTrue(self.sut.showsSectionSeparatorWhenLastSection);
}

- (void)testApplySeparatorInsetsFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.separatorInsets = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.sut.separatorInsets, UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)));
}

- (void)testApplySectionSeparatorInsetsFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.sectionSeparatorInsets = UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0);
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.sut.sectionSeparatorInsets, UIEdgeInsetsMake(1.0, 1.0, 1.0, 1.0)));
}

- (void)testApplyBackgroundColorFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.backgroundColor = [UIColor redColor];
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertEqualObjects(self.sut.backgroundColor, [UIColor redColor]);
}

- (void)testApplySelectedBackgroundColorFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.selectedBackgroundColor = [UIColor blueColor];
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertEqualObjects(self.sut.selectedBackgroundColor, [UIColor blueColor]);
}

- (void)testApplySeparatorColorFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.separatorColor = [UIColor redColor];
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertEqualObjects(self.sut.separatorColor, [UIColor redColor]);
}

- (void)testApplySectionSeparatorColorFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.sectionSeparatorColor = [UIColor blueColor];
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertEqualObjects(self.sut.sectionSeparatorColor, [UIColor blueColor]);
}

- (void)testApplyCellLayoutOrderFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.cellLayoutOrder = AAPLCellLayoutOrderRightToLeft;
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertEqual(self.sut.cellLayoutOrder, AAPLCellLayoutOrderRightToLeft);
}

- (void)testApplyThemeFromMetrics
{
    // given
    AAPLSectionMetrics *sectionMetrics = [[AAPLSectionMetrics alloc] init];
    sectionMetrics.theme = [AAPLTheme theme];
    
    // when
    [self.sut applyValuesFromMetrics:sectionMetrics];
    
    // then
    XCTAssertEqualObjects(self.sut.theme, [AAPLTheme theme]);
}

@end
