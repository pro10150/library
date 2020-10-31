CREATE SCHEMA library;

#DROP SCHEMA library;

USE library;

CREATE TABLE user
	(user_ID numeric(13,0) UNIQUE NOT NULL check(user_ID > 0),
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
	password varchar(20) NOT NULL,
    role varchar(10) NOT NULL check(role IN('member','librarian')),
    PRIMARY KEY (user_ID)
    );

CREATE TABLE fee
	(user_ID numeric(13,0)UNIQUE NOT NULL check(user_ID > 0),
    fee numeric(5,0) NOT NULL check(fee > 0),
    last_update date NOT NULL,
    PRIMARY KEY (user_ID,last_update),
    FOREIGN KEY (user_ID) REFERENCES user(user_ID)
    );
    
CREATE TABLE phone
	(user_ID numeric(13,0) UNIQUE NOT NULL check(user_ID > 0),
    phone numeric(10,0) NOT NULL check(phone > 0),
    PRIMARY KEY(user_ID,phone),
    FOREIGN KEY(user_ID) REFERENCES user(user_ID)
    );

CREATE TABLE book
	(book_ID numeric(10,0) UNIQUE NOT NULL check(book_ID > 0),
    name varchar(20) NOT NULL,
    type varchar(10) NOT NULL,
    description varchar(500),
    published_location varchar(20),
	year numeric(4,0),
    author varchar(20),
    section varchar(2)NOT NULL,
    serial numeric(5) NOT NULL,
    remaining numeric(2) NOT NULL,
    last_update date NOT NULL,
    PRIMARY KEY(book_ID)
    );
    
CREATE TABLE user_pick_book
	(user_ID numeric(13,0) UNIQUE NOT NULL check(user_ID > 0),
    book_ID numeric(10,0) UNIQUE NOT NULL check(book_ID > 0),
    PRIMARY KEY (user_ID,book_ID),
    FOREIGN KEY (user_ID) REFERENCES user(user_ID),
	FOREIGN KEY (book_ID) REFERENCES book(book_ID)
    );
    
CREATE TABLE reserved_book
	(user_ID numeric(13,0) UNIQUE NOT NULL check(user_ID > 0),
	book_ID numeric(10,0) UNIQUE NOT NULL check(book_ID > 0),
    request_date date NOT NULL,
    request_expired_date date NOT NULL,
    PRIMARY KEY (book_ID,user_ID,request_date),
    FOREIGN KEY (book_ID) REFERENCES book(book_ID),
    FOREIGN KEY (user_ID) REFERENCES user(user_ID)
    );
    
CREATE TABLE borrowed_book
	(user_ID numeric(13,0) UNIQUE NOT NULL check(user_ID > 0),
    book_ID numeric(10,0) UNIQUE NOT NULL check(book_ID > 0),
    start_date date NOT NULL,
    due_date date NOT NULL,
    return_date date,
    late_check boolean,
    PRIMARY KEY (user_ID,book_ID,due_date),
    FOREIGN KEY (user_ID) REFERENCES user(user_ID),
    FOREIGN KEY (book_ID) REFERENCES book(book_ID)
    );

CREATE TABLE review
	(user_ID numeric(13,0) UNIQUE NOT NULL  check(user_ID > 0),
    book_ID numeric(10,0) UNIQUE NOT NULL check(book_ID > 0),
    rate numeric(2,0) NOT NULL,
    description varchar(500),
    PRIMARY KEY (user_ID,book_ID),
    FOREIGN KEY (user_ID) REFERENCES user(user_ID),
    FOREIGN KEY (book_ID) REFERENCES book(book_ID)
    );
    
    

    