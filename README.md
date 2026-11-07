# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

Notes:

Backend for a shared note taking and organizing system.

1.  Do as an API backend with access to anyone that has the access to the hosted API
2.  There will be one table called notes with the following fields.
    a. title - string
    b. category - string
    c. author - string
    d. description - string
    e. note - string/text
3.  APIs
    a. create
    b. get_note
    c. get_all
    d. update
    e. delete 
    f. search
4.  Read, update and delete can be accessed by title/name
    a. /get_note/:id
    b. /get_note_by_author?author=fred
    c. /get_note_by_category?category=sales
    d. /search?search_str=xxxxx
    e. /get_all
    f. /update/:id
    g. /delete/:id
5.  It is better to get or update an individual record by id which would be passed in by the UI for the item selcted. 
6.  Return status for my api
    a. {"status":"success", "message":"id: #{id}, successfully delete"}
    b. {"status":"error", "message": "Id: #{id}, was not successfully deleted"}
    c. {"status":"success", json}
