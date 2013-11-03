DKAFactualPlaces
================

get Factual places around location with Factual helper block edition


Gets a list of places around user location. Uses UICollectionView with iOS7 like spring effect for collection view items. Factual helper uses block interface to get places

      DKAFactualHelper *fHelper = [[DKAFactualHelper alloc] initWithPreferences:_searchPrefs];
      [fHelper doQueryWithSearchTermAndLocation:nil location:location completeBlock:^(FactualQueryResult *data, NSError *error) {
        NSLog(@"Factual data received");
        if(!error)
        {
            if(completion)
            {
                completion(data, nil);
            }
        }
        else
        {
            if(completion)
            {
                completion(nil, error);
            }
        }
      }];
