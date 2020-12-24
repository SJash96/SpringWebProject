# SpringWebProject

A simple Java project using the Spring Maven MVC to develop a web application which interacts with the local database(MySQL).
Application is a clone of Redit, you can create accounts, manage your postings, reply and view others postings and much more.

## Folder Contents

src folder contains all packages for the web project.
- **Bean** package contains all of the Pojo classes used to instantiate and create users, posts, replies etc.
- **Dao** package is the data access object classes used to interact with MySQL using hibernate.
- **Controller** package contains the HomeController class that is the heart of implementation and connects JSP pages with Java code. All different site accesses come from here
