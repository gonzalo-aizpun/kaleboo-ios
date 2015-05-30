//
//  KBItemDetailView.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/30/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBItemDetailView.h"

@implementation KBItemDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)homeTapped:(id)sender {
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)contactActionTapped:(id)sender {
}

- (IBAction)openGalleryTapped:(id)sender {
    [self.delegate openGallery];
}

@end
