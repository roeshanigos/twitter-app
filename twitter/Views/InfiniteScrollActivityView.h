//
//  InfiniteScrollActivityView.h
//  twitter
//
//  Created by Roesha Nigos on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfiniteScrollActivityView : UIView
@property (class, nonatomic, readonly) CGFloat defaultHeight;
- (void)startAnimating;
- (void)stopAnimating;

@end
