# Twitter

### Starter project
The starter project can be found in the `starter-project` tag. Download and run `pod install`.

# Project 4 - *Twitter Mock App*

**Twitter Mock App** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **22** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User sees app icon in home screen and styled launch screen
- [X] User can sign in using OAuth login flow
- [X] User can Logout
- [X] User can view last 20 tweets from their home timeline
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [X] User can pull to refresh.
- [X] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [X] User can compose a new tweet by tapping on a compose button.
- [X] Using AutoLayout, the Tweet cell should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation.
- [X] The current signed in user will be persisted across restarts

The following **optional** features are implemented:

- [X] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [X] User can view their profile in a *profile tab*
- Contains the user header view: picture and tagline
- Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] Profile view should include that user's timeline
- [X] User should display the relative timestamp for each tweet "8m", "7h"
- [X] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [ ] Links in tweets are clickable.
- [ ] User can tap the profile image in any tweet to see another user's profile
- Contains the user header view: picture and tagline
- Contains a section with the users basic stats: # tweets, # following, # followers
- [X] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 140) (**1 point**)
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available 
- [ ] User can switch between timeline, mentions, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I think doing the character countdown optional feature will really give the app more functionality.
2. I want to discuss how the APIManager really works in conjunction to all the files in the workspace.

## Video Walkthrough

Here's a walkthrough of implemented user stories:
- this is showing the app icon
<img src='https://i.imgur.com/YL3M4zn.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
 -launch screen, log in and log out 
<img src='https://i.imgur.com/7nAbN9G.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
- composing tweets and liking and retweeting, refreshing
<img src='https://i.imgur.com/YL3M4zn.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
- showing detailed view and profile view (will fix the retweet and favorite button to unselect)
<img src='https://i.imgur.com/CeIckbE.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
- showing auto layout do its magic
<img src='https://i.imgur.com/y3wUgfb.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I had trouble with code logic and how blocks work in Objective C. I always had to ask about segues and what to pass to each view controller. However, the more I did it, the more I got more fluent with the segue syntax. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

Copyright [2018] [Roesha Nigos]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
### Notes
https://paper.dropbox.com/doc/Twitter--ADuVCVvwop_njSNAbUU96Q2VAQ-g255BPX3K4X7G0reYOWCI
