//
//  InfiniteScrollActivityView.h
//  instagram
//
//  Created by Emily Schussheim on 7/10/18.
//  Copyright © 2018 Emily Schussheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfiniteScrollActivityView : UIView

@property (class, nonatomic, readonly) CGFloat defaultHeight;

- (void)startAnimating;
- (void)stopAnimating;

@end
