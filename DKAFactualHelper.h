//
//  DKAFactualHelper.h
//  LookAround.iOS7
//
//  Created by Nero Wolfe on 17/10/13.
//  Copyright (c) 2013 Sergey Dikarev. All rights reserved.
//

#import <FactualSDK/FactualAPI.h>
#import <FactualSDK/FactualQuery.h>
#import "Defines.h"
#import <Foundation/Foundation.h>

@interface DKAFactualHelper : NSObject <FactualAPIDelegate>
{
    
    FactualAPIRequest* _activeRequest;
    NSMutableDictionary* prefs;
    FactualQueryResult* queryResult;
}

-(id)initWithPreferences:(NSMutableDictionary *)preferences;
-(void)doQueryWithSearchTermAndLocation:(NSString *)searchTerm location:(CLLocation *)location completeBlock:(DKAFactualHelperCompletionBlock) completeBlock;
@end
