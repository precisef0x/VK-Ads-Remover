%group vkapp	//Group for VK App 2.2
%hook NewsFeedModel

-(id)renderFeedItem:(id)item sources:(id)sources context:(id)context
{
	int isAds = [[item objectForKey:@"type"] isEqualToString:@"ads"];
	id r;
	if(!isAds) r = %orig;
	else r = nil;
	return r;
}

%end
%end


%group vkhdapp	//Group for VK HD v2.0 for iPad
%hook VKNewsfeedNews

-(id)parseItems:(id)items asClass:(Class)aClass
{
	NSMutableArray* newItems = [items mutableCopy];
	NSMutableArray *discardedItems = [NSMutableArray array];
	for(id item in items)
	{
		int isAds = [[item objectForKey:@"type"] isEqualToString:@"ads"];
		if(isAds)
		{
			[discardedItems addObject:item];
		}
	}
	[newItems removeObjectsInArray:discardedItems];
	id r = %orig(newItems, aClass);	//Execute the original method with new parameters
	return r;
}

%end
%end


%ctor	//Will be executed right after the lib is loaded
{
	NSLog(@"Thanks for using Vk Ads Remover!");
	NSString *prodName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];	//Check the application BundleID
	if([prodName isEqualToString:@"com.vk.vkclient"]) %init(vkapp);	//If VK App 2.2 then activate appropriate group
	else %init(vkhdapp);	//Else activate iPad group
}
