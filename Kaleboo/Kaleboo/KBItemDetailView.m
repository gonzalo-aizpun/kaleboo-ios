//
//  KBItemDetailView.m
//  Kaleboo
//
//  Created by OLX - Andres Ciaño on 5/30/15.
//  Copyright (c) 2015 Kaleboo. All rights reserved.
//

#import "KBItemDetailView.h"

#import <MessageUI/MessageUI.h>

@interface KBItemDetailView () <MFMailComposeViewControllerDelegate>

@property (nonatomic) MFMailComposeViewController * mailComposer;

@end

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

- (IBAction)openGalleryTapped:(id)sender {
    [self.delegate openGallery];
}

- (IBAction)contactActionTapped:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        self.mailComposer = [[MFMailComposeViewController alloc] init];
        self.mailComposer.mailComposeDelegate = self;
        
        [self.mailComposer setSubject:@"Contacto desde OLX"];
        [self.mailComposer setMessageBody:@"Hola, me interesa tu propiedad!" isHTML:NO];
        [self.mailComposer setToRecipients:@[[self.delegate getPublisherEmail]]];
        
        if (self.mailComposer) {
            [self.delegate presentViewController:self.mailComposer animated:YES completion:nil];
        }
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error {
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

@end
