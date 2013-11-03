#import "DKAAppDelegate.h"
#import <FactualSDK/FactualQuery.h>
#import <FactualSDK/FactualAPI.h>

#define DKALocationUpdated @"LocationUpdated"
#define DKALocationMuchUpdated @"LocationMuchUpdated"
#define LOCATIONLISTFONTSIZE 18

typedef void (^DKAFactualHelperCompletionBlock)  (FactualQueryResult *data, NSError *error);

#define helper ((DKAHelper *)[DKAHelper sharedInstance])
#define appDelegate ((DKAAppDelegate *)[[UIApplication sharedApplication] delegate])

