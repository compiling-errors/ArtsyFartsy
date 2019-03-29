https://hackmd.io/B6U3hn3cQC-h_YGBsA_4Hg?both#Wireframes

Group Project - Compiling Errors
===

# Artsy Prompts

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app gives a daily drawing prompt, and allows user artwork to be uploaded, shared, and commented on.

### App Evaluation
[Evaluation of your app across the following attributes]

**Category:**Art / Social Networking

**Mobile:**The primary function of this app is to run on iOS devices. Thus, the artwork images would be best viewed from a mobile device. With postings made in real-time and images uploaded directly from a mobile camera, this interface is specifically formatted for the average mobile user. A separate, optimal interface can be created for computer usage.

**Story:**A new prompt is given daily for the purpose of encouraging the user to create, post, and share personal artwork. The drawing feed allows for messaging between other users. Like many other social media sites, daily updated material and a platform to chat with other users encourages frequent use.

**Market:**This app may interest any casual phone app user, to pass time and interact with other users, or hardcore artists who wish to promote their work.

**Habit:**With a new daily drawing prompt, this app encourages daily access to post, view, and comment on new artwork.

**Scope:**This app will serve as a general platform to encourage sharing and commenting on artwork. This idea is centered around an artwork feed, with the potential to continue adding many optional features. Possible updates could include monetization to allow users to purchase custom artwork or products for sale by the artist. Additional chatting/friends list features can also be added to allow for a more user friendly chat interface. However, these optional features may prove challenging to execute.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* A new account can be created
* Login for account access
* Daily art prompt
* Artwork can be uploaded to the general feed
* Comments can be left on artwork
* Customizable app settings

**Optional Nice-to-have Stories**

* Customizable user profile page
* Friend list
* Chat with other users
* Search for artwork
* Favorite artwork to find it quickly
* Featured artwork page
* Monetization

### 2. Screen Archetypes

* Login Screen: -Log into account
* Register Screen: -Create new account
* Artwork Feed Screen: -Shows currently posted artwork
                    * -Comments can be left on posted artwork
* Daily Prompt Screen: - User can view daily art prompt
* Upload Artwork Screen: -User can upload art work to post it to the artwork feed
* Settings Screen: -Customize app settings:
                    +dark/light theme
                    +notification settings
* Profile Screen: -User can change profile picture

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Artwork feed
* Daily prompt
* Profile account page

Optional:

* Profile
* Featured artwork
* Friend list
* Commission postings feed
* Chat/Friends List

**Flow Navigation** (Screen to Screen)

* Flow Navigation (Screen to Screen)
* Login Screen: -Goes to artwork feed
* Register Screen: -Goes to artwork feed
* Artwork Feed Screen: -View posted artwork from users (Detail Screen)
* Daily Prompt Screen: -View daily art prompt (Detail Screen)
* Upload Artwork Screen: -Goes to artwork feed
* Settings Screen: -View settings page(Detail Screen)
* Profile Screen: -View profile page(Detail Screen)

## Wireframes
<img src="https://github.com/compiling-errors/ArtsyPrompts/blob/master/Wireframe%20for%20group%20project_edited.jpg" width=600>

### Digital Wireframes & Mockups
https://www.figma.com/file/W3SFBGtTPcDWg3Xs7BFgBPKl/ArtsyFartsy?node-id=0%3A1 


### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models

Model: Artwork Post

| Property          | Type               | Description                                     |
|:---               |:---                |:---                                             |
|artworkPostId      |String              |user post’s unique id                            |
|author             |Pointer to User     |Author of post (image/comment)                   |
|artworkImage	      |File	               |User uploaded artwork image                      |
|artworkDescription	|String	             |User written description of personal artwork post|
|numComments	      |Number	             |Any/all comments posted on user’s artwork post   |
|artworkCaption	    |String	             |User written caption for artwork                 |
|profileImage	      |File	               |User uploaded profile image                      |
|artworkFeed	      |Array	             |User uploaded artwork posts                      |
|artworkDate	      |DateTime            |When user has posted/updated an artwork post     |


Model: Account

| Property          | Type               | Description                                     |
|:---               |:---                |:---                                             |
|username           | String             |  User’s username                                |
|password	          |String	             |User’s password                                  |
|email	            |String	             |User’s email address                             |


Model: Daily Prompt Page

|Property	          |Type	               |Description                                      |
|:---               |:---                |:---                                             |
|followedProfile    |Pointer to User	   |A profile/account that a user is following       |                                 
|promptAdjective	  |JSON Object	       |An adjective pulled from a source drawing prompt |                                 
|promptNoun	        |JSON Object	       |A noun pulled from a source for a drawing prompt |                            
|promptVerb	        |JSON Object	       |A verb pulled from a source for a drawing prompt |                                  


Model: Request Post

|Property	          |Type	               |Description                                      |
|:---               |:---                |:---                                             |
|requestPostId	    |String	             |user post’s unique id                            |
|author	            |Pointer to User	   |Author of post (image/comment)                   |
|requestDescription	|String	             |User written description of request post         |                                
|requestNumComments	|Number	             |Any/all comments posted on user’s artwork post   |
|requestCaption	    |String	             |User written caption for request                 |
|profileImage	      |File	               |User uploaded profile image                      |
|requestFeed	      |Array	             |User uploaded request posts                      |

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
