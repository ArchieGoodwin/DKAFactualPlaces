//
//  DKAFactualHelper.m
//  LookAround.iOS7
//
//  Created by Nero Wolfe on 17/10/13.
//  Copyright (c) 2013 Sergey Dikarev. All rights reserved.
//

#import "DKAFactualHelper.h"
#import "DKAHelper.h"
#import <FactualSDK/FactualAPI.h>
#import <FactualSDK/FactualQuery.h>
#import "Defines.h"

@implementation DKAFactualHelper
{
    FactualQuery* queryObject;
    DKAFactualHelperCompletionBlock completionBlock;
}


-(id)initWithPreferences:(NSMutableDictionary *)preferences
{
    
    if (self = [super init]) {
        prefs = preferences;
        
        queryResult = nil;
        
        queryObject = [FactualQuery query];
        
        queryObject.limit = 50;
		return self;
	}
	return self;
    

}


-(void)doQueryWithSearchTermAndLocation:(NSString *)searchTerm location:(CLLocation *)location completeBlock:(DKAFactualHelperCompletionBlock) completeBlock
{
    
    completionBlock = completeBlock;
    //Location enabled!!!
    if (location) {

        // set geo filter
       

        [queryObject setGeoFilter:location.coordinate radiusInMeters:[((NSNumber*)[prefs valueForKey:PREFS_RADIUS]) doubleValue]];
        
        
    }
    else {
        // sort by relevance if full text available ...
        if (searchTerm != nil && searchTerm.length != 0) {
            FactualSortCriteria* primarySort = [[FactualSortCriteria alloc] initWithFieldName:@"$relevance" sortOrder:FactualSortOrder_Ascending];
            // set the sort criteria
            [queryObject setPrimarySortCriteria:primarySort];
        }
    }
    
    // full text term
    if (searchTerm != nil && searchTerm.length != 0) {
        [queryObject addFullTextQueryTerms:searchTerm, nil];
    }
    
    // check if locality filter is on ...
    if ([[prefs valueForKey:PREFS_LOCALITY_FILTER_ENABLED] boolValue]) {
        // see if locality value is present
        NSString* localityFilterText = [prefs valueForKey:PREFS_LOCALITY_FILTER_TEXT];
        if (localityFilterText.length != 0) {
            [queryObject addRowFilter:[FactualRowFilter fieldName: [prefs valueForKey:PREFS_LOCALITY_FILTER_TYPE] equalTo:localityFilterText]];
        }
    }
    
    // check if category filter is on ...
    if ([[prefs valueForKey:PREFS_CATEGORY_FILTER_ENABLED] boolValue]) {
        // see if locality value is present
        NSString* categoryName = [prefs valueForKey:PREFS_CATEGORY_FILTER_TYPE];
        if (categoryName.length != 0) {
            [queryObject addRowFilter:[FactualRowFilter fieldName:@"category" beginsWith:categoryName]];
        }
    }
    
    FactualAPI *api = [[FactualAPI alloc] initWithAPIKey:@"G1onplQoOqNrWt8lH4osdfZWwHXFdFLW9zy9vs9u" secret:@"4ZFCD4TaSlyjHBzOu2xl7E88lU3oiQfaVxFRCOYU"];
    _activeRequest = [api queryTable:@"places" optionalQueryParams:queryObject withDelegate:self];
}

#pragma mark -
#pragma mark FactualAPIDelegate methods

- (void)requestDidReceiveInitialResponse:(FactualAPIRequest *)request {
    if (request == _activeRequest) {
        NSLog(@"Recvd Response...");
    }
    
}

- (void)requestDidReceiveData:(FactualAPIRequest *)request {
    if (request == _activeRequest) {
        NSLog(@"Recvd Data...");

    }
}


-(void) requestComplete:(FactualAPIRequest *)request failedWithError:(NSError *)error {
    if (_activeRequest == request) {
        _activeRequest = nil;
        
        
        NSLog(@"Active request failed with Error:%@", [error localizedDescription]);
        
        if(completionBlock)
        {
            completionBlock(nil, error);
        }
    }
}


-(void) requestComplete:(FactualAPIRequest *)request receivedQueryResult:(FactualQueryResult *)queryResultObj {
    if (_activeRequest == request) {
        NSLog(@"Active request Completed with row count:%ld TableId:%@ RequestTableId:%@", (long)queryResultObj.rows.count, queryResult.tableId,request.tableId);

        queryResult = queryResultObj;
        _activeRequest = nil;
        
    
        if(completionBlock)
        {
            completionBlock(queryResult, nil);
        }

    }
}

@end
