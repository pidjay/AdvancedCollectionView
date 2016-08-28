/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 A pinnable header subclass of UICollectionReusableView.
 */

#import "AAPLPinnableHeaderView.h"
#import "AAPLCollectionViewLayout_Private.h"
#import "AAPLHairlineView.h"
#import "AAPLTheme.h"

@interface AAPLPinnableHeaderView ()
@property (nonatomic, getter = isPinned, readwrite) BOOL pinned;
@property (nonatomic, getter = isSticked, readwrite) BOOL sticked;
@property (nonatomic, strong) AAPLHairlineView *borderView;
/// This is a non-active property for background color, because the background property actually IS the current background color
@property (nonatomic, strong) UIColor *normalBackgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *oldBackgroundColor;
/// The current background color based on the state of the header/footer.
@property (nonatomic, strong, readonly) UIColor *currentBackgroundColor;
@property (nonatomic) BOOL simulatesSelection;
@end

@implementation AAPLPinnableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
        return nil;

    self.backgroundColor = [UIColor whiteColor];

    _borderView = [[AAPLHairlineView alloc] initWithFrame:CGRectZero];
    _borderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_borderView];

    NSMutableArray *constraints = [NSMutableArray array];
    NSDictionary *views = NSDictionaryOfVariableBindings(_borderView);

    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_borderView]|" options:0 metrics:nil views:views]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:_borderView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];

    [self addConstraints:constraints];

    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.layoutMargins = self.defaultLayoutMargins;
    _pinned = NO;
    _sticked = NO;
    _pinnedBackgroundColor = nil;
    _stickedBackgroundColor = nil;
}

- (void)setTheme:(AAPLTheme *)theme
{
    if (_theme == theme)
        return;
    _theme = theme;
    _separatorColor = theme.separatorColor;
    _pinnedSeparatorColor = theme.separatorColor;
}

- (UIEdgeInsets)defaultLayoutMargins
{
    return UIEdgeInsetsMake(8, 15, 8, 15);
}

- (void)layoutMarginsDidChange
{
    [super layoutMarginsDidChange];
    [self setNeedsUpdateConstraints];
}

- (void)setShowsSeparator:(BOOL)showsSeparator
{
    _showsSeparator = showsSeparator;
    _borderView.hidden = !showsSeparator;
}

- (void)setSeparatorColor:(UIColor *)separatorColor
{
    _separatorColor = separatorColor;
    if (self.pinned)
        _borderView.backgroundColor = separatorColor;
}

- (void)setPinnedSeparatorColor:(UIColor *)pinnedSeparatorColor
{
    _pinnedSeparatorColor = pinnedSeparatorColor;
    if (self.pinned)
        _borderView.backgroundColor = pinnedSeparatorColor;
}

- (UIColor *)currentBackgroundColor
{
    if (self.highlighted)
        return self.selectedBackgroundColor;
    if (self.pinned)
        return self.pinnedBackgroundColor;
    if (self.sticked) {
        return self.stickedBackgroundColor;
    }
    return self.normalBackgroundColor;
}

- (void)updateBackgroundAndSeparatorColorsAnimated:(BOOL)animated
{
    CGFloat duration = (animated ? 0.25 : 0);
    
    [UIView animateWithDuration:duration animations:^{
        if (self.pinned) {
            self.backgroundColor = self.pinnedBackgroundColor;
            self.borderView.backgroundColor = self.pinnedSeparatorColor;
        }
        else if (self.sticked) {
            self.backgroundColor = self.stickedBackgroundColor;
        }
        else {
            self.backgroundColor = self.normalBackgroundColor;
            self.borderView.backgroundColor = self.separatorColor;
        }
        
        UIColor *borderColor = _pinned ? self.pinnedSeparatorColor : self.separatorColor;
        self.borderView.backgroundColor = borderColor;
    }];
}

- (void)applyLayoutAttributes:(AAPLCollectionViewLayoutAttributes *)layoutAttributes
{
    if (![layoutAttributes isKindOfClass:[AAPLCollectionViewLayoutAttributes class]])
        return;

    self.hidden = layoutAttributes.hidden;
    self.userInteractionEnabled = !layoutAttributes.editing;
    self.theme = layoutAttributes.theme;

    if (UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.layoutMargins, UIEdgeInsetsZero))
        self.layoutMargins = self.defaultLayoutMargins;
    else
        self.layoutMargins = layoutAttributes.layoutMargins;

    self.separatorColor = layoutAttributes.separatorColor;
    self.pinnedSeparatorColor = layoutAttributes.pinnedSeparatorColor;
    self.showsSeparator = layoutAttributes.showsSeparator;
    self.normalBackgroundColor = layoutAttributes.backgroundColor;
    self.selectedBackgroundColor = layoutAttributes.selectedBackgroundColor;
    self.pinnedBackgroundColor = layoutAttributes.pinnedBackgroundColor;
    self.stickedBackgroundColor = layoutAttributes.stickedBackgroundColor;

    self.simulatesSelection = layoutAttributes.simulatesSelection;
    
    // Animate the color changes if the pinned or sticked flags changed
    BOOL animated = (_pinned != layoutAttributes.pinnedHeader || _sticked != layoutAttributes.stickedHeader);
    
    self.pinned = layoutAttributes.pinnedHeader;
    self.sticked = layoutAttributes.stickedHeader;
    
    [self updateBackgroundAndSeparatorColorsAnimated:animated];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (_highlighted == highlighted)
        return;

    _highlighted = highlighted;
    if (!self.simulatesSelection)
        return;

    if (highlighted) {
        self.oldBackgroundColor = self.backgroundColor;
        self.backgroundColor = self.selectedBackgroundColor;
    }
    else
        self.backgroundColor = self.oldBackgroundColor;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    if (![layoutAttributes isKindOfClass:[AAPLCollectionViewLayoutAttributes class]])
        return layoutAttributes;

    AAPLCollectionViewLayoutAttributes *attributes = (AAPLCollectionViewLayoutAttributes *)layoutAttributes;
    if (!attributes.shouldCalculateFittingSize)
        return layoutAttributes;

    [self layoutSubviews];
    CGRect frame = attributes.frame;

    CGSize fittingSize = CGSizeMake(frame.size.width, UILayoutFittingCompressedSize.height);
    frame.size = [self systemLayoutSizeFittingSize:fittingSize withHorizontalFittingPriority:UILayoutPriorityDefaultHigh verticalFittingPriority:UILayoutPriorityFittingSizeLevel];

    AAPLCollectionViewLayoutAttributes *newAttributes = [attributes copy];
    newAttributes.frame = frame;
    return newAttributes;
}

@end
