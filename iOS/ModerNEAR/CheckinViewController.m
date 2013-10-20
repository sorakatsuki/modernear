//
//  CheckinViewController.m
//  Foursquare2-iOS
//
//  Created by Constantine Fry on 1/21/13.
//
//

#import "CheckinViewController.h"
#import "Foursquare2.h"
#import "FSVenue.h"

@interface CheckinViewController ()

@property (weak, nonatomic) IBOutlet UILabel *venueName;
@property (weak, nonatomic) IBOutlet UIButton *uploadPhotButton;
@property (strong, nonatomic) NSString *checkin;

- (IBAction)checkin:(id)sender;
@end

@implementation CheckinViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Checkin";
    self.venueName.text = self.venue.name;
}

- (void)viewDidUnload {
    [self setVenueName:nil];
    [super viewDidUnload];
}

- (IBAction)checkin:(id)sender {
    [Foursquare2  createCheckinAtVenue:self.venue.venueId
                                 venue:nil
                                 shout:@"Testing"
                             broadcast:broadcastPublic
                              latitude:nil
                             longitude:nil
                            accuracyLL:nil
                              altitude:nil
                           accuracyAlt:nil
                              callback:^(BOOL success, id result){
                                  if (success) {
                                      self.checkin = [result valueForKeyPath:@"response.checkin.id"];
                                      [self showAlertViewWithTitle:@"Checkin Successfull"];
                                      self.uploadPhotButton.enabled = YES;
                                  }
                              }];
}

- (IBAction)addPhoto:(id)sender {
    [Foursquare2 addPhoto:[UIImage imageNamed:@"testimage@2x.png"]
                toCheckin:self.checkin
                 callback:^(BOOL success, id result) {
                     if (success) {
                         [self showAlertViewWithTitle:@"Photo was added"];
                     }
                }];
}

- (void)showAlertViewWithTitle:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
