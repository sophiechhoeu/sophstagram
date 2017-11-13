# Sophstagram

This is my recreation at instagram through Ruby on Rails application. You are able to search by caption of the photo, add new photos, follow other users and comment and like posts. I've named it sophstagram and it is live on heroku you can check out it out here:

* [Sophstagram](https://sophstagram.herokuapp.com/)

Future developments: *(please note that it's currently styled and responsive for 2 media queries)*

- adding mobile responsiveness
- styling for media queries
- including ajax for automatic refresh on the follow/unfollow buttons

## Additional notes:


### System requirements
* Ruby version

  2.4.0

* Rails version

  5.1.4

### Gems Installed

```
gem 'bootstrap', '~> 4.0.0.beta'
#for styling

gem 'jquery-rails'
#for navbar toggle

gem 'acts_as_votable', '~> 0.10.0'
#for likes functionality

gem 'shrine'
#for image uploading

gem 'colorize'
#for font colour change

gem 'devise'
#for user authentication
```

### Configuration

* User flow: when a user signs up they are automatically redirected to create a profile. Once they have a profile they'll see the "edit profile" button next to their profile bio appear. If they click on a profile of another user they'll see the follow button instead.

  ***The only way a user can see anyone's photos, comment or like a photo is if they sign up or login.***

### Database creation

User model was created with

```
gem 'devise'
```
then `bundle install`

Then in terminal run

```
rails g devise:install
```

Where terminal will display a set of prompts you must complete

once that is actioned

in terminal `run`

```
rails g devise MODEL
```
where MODEL will be **User**

then `run`

```
rails db:migrate
```

Rails scaffolding was actioned on the remaining
* photos
* Comments
* Profile

Scaffolding a rails model as below:

```
rails generate model NAME [field[:type]

```

*example rails g model Comments content:text  user:references*

*Note: seperate each pairing of field/type with a space to avoid errors*

* A **User** has many **photos**
* A **User** has many **comments**
* A **User** has one **profile**

##### Joint table (reference users)

* A **User** has and belongs to many **Followers**
* A **User** has and belongs to many **Following**  


* A **Profile** belongs to **User**
* A **Photo** has many **Comments**
* A **Photo** belongs to **User**
* A **Comment** belongs to **User**
* A **Comment** belongs to **Photo**
