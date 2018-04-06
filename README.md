# Computer Science Mentoring Program

The Computer Science faculty at the Citadel has found that retaining freshman students in the major can be challenging. There are far more freshman Computer Science students than the small faculty can meet with on a regular basis. Such lack of regular communication can lead to freshman becoming disenchanted with the Computer Science program before the faculty has the chance to intervene.
 
To mitigate this issue, the faculty enlists the aid of upperclass students to mentor freshman, notifying faculty when mentees are struggling to stay in the program.This has proven to reduce the likelihood that freshman will leave the major for the wrong reasons. However, it is important for faculty to keep track of interactions between mentors and mentees. Previous attempts at mentoring experienced limited success due to communication breakdowns between mentors, mentees, and faculty.

### Guru4u - *Mentoring Made Easy*

Guru4u is a web application aimed at helping the Computer Science faculty improve the retention of freshman by mitigating communication issues. It accomplishes this by enabling Computer Science faculty to maintain a mapping of upperclass mentors to freshmen mentees. Mentors use Guru4u to record a brief report of an interaction with their mentees and automatically alert faculty about mentees that need follow-up. Faculty can subsequently review reports of interactions and identify mentees who have not been met with recently or are in need of immediate attention.

Guru4u is the brainchild of Dr. Michael Verdicchio (AKA, "Dr. V".) You can contact him at his Citadel Computer Science Department [home page](http://www.citadel.edu/root/mathcs-directory/58-academics/schools/ssm/mathematics-and-computer-science/23884-michael-verdicchio).

### Build Procedure

To run the project on Clould 9 after creating a new "blank" workspace, and assuming you have access to the CitadelCS/guru4u git repository, execute the following steps in your workspace terminal:

```
sudo apt-get update 
sudo apt-get install qt5-default libqt5webkit5-dev qtdeclarative5-dev g++   
sudo apt-get install xvfb
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
sudo usermod -a -G rvm <username>
source /etc/profile.d/rvm.sh
#logout and log back in
rvm install ruby-2.3.5
git clone https://github.com/CitadelCS/guru4u
<enter your git credentials>
cd guru4u
gem regenerate_binstubs
gem install bundler
bundle install
bundle update
rails db:purge db:migrate db:seed
RAILS_ENV=test rails db:purge db:migrate db:seed
rails s -p $PORT -b $IP
```

Then click: "Share" (in the upper right hand corner of the C9 menu bar), the "Application:" link, and "Open" from the popup.

To run the cucumber and rspec tests, create a new c9 terminal and type:

```
cucumber
rspec
```

### Heroku and Pivotal Tracker links

Heroku: https://guru4u.herokuapp.com/. You can log into an Advisor account with guru4u602@gmail.com/foobar and into a Mentor account with jsmith@gmail.com/password.
Pivotal Tracker: https://www.pivotaltracker.com/n/projects/2120069

### Developer notes

All Guru4u tables were created by using the following gem: https://github.com/bogdan/datagrid.  Detailed programming instructions are provided in the repository README.

To deploy to Heroku, you must:

1. Edit config/environments/production.rb to add:
 
 ```
config.action_mailer.default_url_options = { :host => ENV['MAILER_URL'] }
config.action_mailer.delivery_method = :smtp
  
config.action_mailer.smtp_settings = {
     :address => "smtp.gmail.com",
     :port => 587,
     :user_name => ENV['MAILER_ACCOUNT'],
     :password =>  ENV['MAILER_PASSWORD'],
     :authentication => :plain,
     :enable_starttls_auto => true
```

2. Configure the gmail account that will be used for smtp properly:

```
Settings->Forwarding and POP/IMAP->Enable IMAP
https://myaccount.google.com/lesssecureapps-> Allow less secure apps: ON
```

3. Make sure the Heroku toolbelt is installed:

```
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
```

4. Log into the Heroku account where your APPNAME.herokuapp.com exits:

```
heroku login
```

5. Tell Heroku the value of the mailer ENV parameters:

```
heroku config:set MAILER_ACCOUNT=<gmail account>
heroku config:set MAILER_PASSWORD=<gmail password>
heroku config:set MAILER_URL=<APPNAME.herokuapp.com>
```

6. Push the master branch to Heroku

```
git push heroku
```

7. Reset the Heroku database:

```
heroku pg:reset DATABASE
heroku run rails db:migrate
heroku run rails db:seed
heroku restart
```

### Current Status

Guru4u was created as part of a Team project in Agile development fostered by Dr. V's Fall 2017 CSCI 602 class, *Foundations of Software Engineering*. The initial team was comprised of Hassam Solano-Morel, Sarah Deris, Andres Valencia, Anuja Gargate, and Mike Dalpee. 
The team current has completed Iteration 4.  This release provides the core functionality request.  Additional features for future iterations can be found in the project's previously identified Pivotal Tracker account.

