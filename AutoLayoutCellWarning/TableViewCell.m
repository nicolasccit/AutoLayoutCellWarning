//
//  TableViewCell.m
//  beam
//
//  Created by Nicolas Meunier on 9/20/13.
//  Copyright (c) 2013 CruiseCritic. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()
@property (nonatomic, strong) UIImageView* imageThumbnail;
@property (nonatomic, strong) UILabel* labelName;
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation TableViewCell

// design spacing constants
static const CGFloat kPadding = 10.0f;
static const CGFloat kThumbnailDimensions = 75.0f;
static const CGFloat kThumbnailPaddingRight = 10.0f;
static const CGFloat kThumbnailBorder = 2.5f;
static const CGFloat kNameFontSize = 16.0f;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageThumbnail = [[UIImageView alloc] init];
        self.imageThumbnail.layer.borderWidth = kThumbnailBorder;
        self.imageThumbnail.layer.borderColor = [[UIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.0f] CGColor];
        [self.imageThumbnail setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.imageThumbnail];
        
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 20.0f)];
        label.backgroundColor = [UIColor clearColor];
        self.labelName = label;
        [self.labelName setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.labelName];
        
        // added this just to prove that the content view is doing the right thing
        self.contentView.backgroundColor = [UIColor greenColor];
        
        [self configureCell];
        [self.contentView addConstraints:[self constraints]];
    }
    return self;
}

- (void)configureCell {
    [self.imageThumbnail setImage:[UIImage imageNamed:@"150x150"]];
    // next line changes the image, to prove that we are resizing to fit the image size
    // comment it out, and run the app again: it still works!
    [self.imageThumbnail setImage:[UIImage imageNamed:@"smileyiPhone"]];
    self.labelName.text = @"HELLO";
}

-(NSArray *)constraints {
    NSMutableArray * constraints = [[NSMutableArray alloc]init];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_labelName, _imageThumbnail);
    
    NSDictionary *metrics = @{@"imageWidth":@(kThumbnailDimensions + 2*kThumbnailBorder),
                              @"imageHeight":@(kThumbnailDimensions + 2*kThumbnailBorder),
                              @"padding":@(kPadding)};
    
    NSString *const kHorizontal = @"H:|-padding-[_imageThumbnail(==imageWidth)]-[_labelName]";
    NSString *const kImageVertical = @"V:|-padding-[_imageThumbnail]-padding-|";
    NSString *const kLabelVertical = @"V:|-padding-[_labelName]";
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kHorizontal options:0 metrics:metrics views:viewsDictionary]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kImageVertical options:0 metrics:metrics views:viewsDictionary]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelVertical options:0 metrics:metrics views:viewsDictionary]];
    return constraints;
}

@end
