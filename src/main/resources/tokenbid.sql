create table if not exists users(
	user_id serial primary key,
	username varchar(50) not null unique,
	password varchar(100) not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(100) not null unique,
	tokens int default 0 check(tokens >= 0),
	email_verified boolean default false
);

create table if not exists items(
	item_id serial primary key,
	user_id int not null,
	category varchar(50) not null,
	title varchar(100) not null,
	description text not null,
	image_url text default 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
	foreign key (user_id) references users(user_id)
);

create table if not exists auctions(
	auction_id serial primary key,
	item_id int not null,
	starting_bid int not null check(starting_bid >= 0),
	status varchar(50) default 'In Progress',
	start_time timestamp,
	end_time timestamp,
	foreign key (item_id) references items(item_id)
);

create table if not exists bids(
	bid_id serial primary key, 
	auction_id int not null,
	user_id int not null,
	bid int not null check(bid >= 0),
	is_outbid boolean default false,
	foreign key (auction_id) references auctions(auction_id),
	foreign key (user_id) references users(user_id)
);