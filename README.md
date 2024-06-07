# Gumroad Clone

A clone of Gumroad.com with basic features.

## Features

- Products
  - Users can purchase products and see them in their library.
    - One caveat is that users must sign up to purchase a product (to simplify this version of Gumroad).
  - Users can browse the product marketplace by category.
- Reviews
  - Users can leave reviews for their purchased products.
- Emails
  - Users can send emails to their followers.
- Followers
  - Users purchasing a product become a follower of the user who owns the purchased product.
- User
  - Public profile page displays products, posts and a way to subscribe as a follower.
- Tips
  - Any user can give a one time tip to a creator.
- Wishlist items
  - Users can add products as wishlist items, and browse their wishlist on the library page wishlist tab.

## Teck Stack

* Rails
* PostgreSQL
* Tailwind CSS
* StimulusJS

## Setup

1. Clone the repo
2. Install Ruby `3.3.0`  and Rails `7.1.3.3`
2. Instal dependencies `bundle install` && `yarn install`
3. Run migrations `rails db:create && rails db:schema:load`
4. Run the server `bin/dev` and visit `http://localhost:3000`