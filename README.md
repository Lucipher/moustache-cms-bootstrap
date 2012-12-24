<<<<<<< HEAD
# Moustache CMS Bootstrap
=======
[![Build Status](https://secure.travis-ci.org/amkirwan/moustache-cms.png)](http://travis-ci.org/amkirwan/moustache-cms) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/amkirwan/moustache-cms)
>>>>>>> upstream/master

[![Build Status](https://secure.travis-ci.org/n00b2pr0/moustache-cms-bootstrap.png)](http://travis-ci.org/n00b2pr0/moustache-cms-bootstrap)

<<<<<<< HEAD
Moustache CMS Bootstrap is a fork of Amkirwan's [Moustache CMS](https://github.com/amkirwan/moustache-cms).
=======
Moustache CMS is a open source content management system designed for creating great sites and blogs. It features an easy to use interface for putting your site together and managing your content. With the power of [Mustache](https://github.com/defunkt/mustache) for templating Moustache CMS can be easily customized to for your sites needs.
>>>>>>> upstream/master

**In Addition to Moustache by Amkirwan:**

<<<<<<< HEAD
- Twitter Bootstrap Admin UI

## Getting Started Quickly

- A recent version of MongoDB >= 2.0 installed and running. 
- Then clone the repo git clone git://github.com/n00b2pr0/moustache-cms-bootstrap.git
- Run bundle install
- Then run rake db:seed it will create a admin login account for the user account with the login 'admin@moustachecms.org' and the password 'moustache'

Fire up rails and log in

- Start up rails with bin/rails start 
- Go to http://127.0.0.1:3000/admin and login with the email and password listed above

Alternatively you can use [Pow](http://pow.cx/)
=======
- A good looking easy to use UI
- A highly flexible templating system of layouts, snippets, page parts and tagging done with [Mustache](https://github.com/defunkt/mustache).
- Support for Markdown, Textile, and HTML for page part templating. 
- Manage multiple websites in one application instance
- Ability to assign different roles to users
- Built using Ruby on Rails 3.2
- MongoDB for Database 

## Getting Started Quickly

- A recent version of MongoDB >= 2.0 installed and running. On Mac OS X you can use [Homebrew](http://mxcl.github.com/homebrew) to install Mongodb
- Then clone the repo 
```
git clone git://github.com/amkirwan/moustache-cms.git.
```
- Then from the project root run bundler
```
cd moustache-cms
bundle install 
```
- Next setup the default database from the seed file. This will create a default admin login account with the login email of 'admin@moustachecms.org' and the password set to 'moustache'
```
bundle exec rake db:seed
```
- You can access MoustacheCms now in two ways. If you are using [POW](https://github.com/37signals/pow) create an symlink to moustache-cms and then go to 'http://moustache-cms/admin' to login. If you can also start the Rails server and access the cms via the localhost, then go to 'http://127.0.0.1:3000/admin to login.
```
bundle exec rails start
````
- Have fun using MoustacheCms!

Checkout the [wiki](http://github.com/amkirwan/moustache-cms/wiki) for more information and go to the [Demo](https://demo.moustachecms.org/admin) page to see Moustache CMS in action. 
>>>>>>> upstream/master

- Symlink into Pow: `cd ~/.pow` then `ln -s /path/to/moustache-cms-bootstrap moustache`
- Go to http://moustache.dev/admin and login with the email and password listed above

Checkout the Amkirwan's Moustache CMS [wiki](http://github.com/amkirwan/moustache-cms/wiki) for more information and go to the [Demo](https://demo.moustachecms.org/admin) page to see Moustache CMS in action. 

## Contribute

Please do!

I recomend contributing to Amkirwan's [Moustache CMS](https://github.com/amkirwan/moustache-cms), but you are welcome you can submit bugs or pull requests here.

## Support 

Checkout Amkirwan's Moustache CMS [wiki](http://github.com/amkirwan/moustache-cms/wiki).

## License 

Moustache CMS is released under the MIT license, Copyright &copy; 2012

- Code git clone git://github.com/n00b2pr0/moustache-cms-bootstrap.git
- Home http://github.com/n00b2pr0/moustache-cms-bootstrap
- Bugs http://github.com/n00b2pr0/moustache-cms-bootstrap/issues
