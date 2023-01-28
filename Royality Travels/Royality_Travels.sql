--create dateabase and table
create database Royality_Travels

create table [Admins] (
	adminID int not null primary key,
	[name] varchar(50) not null, 
	phoneNum char(11)not null, 
	country varchar(50), 
	[password] [varchar](50) not null )

create table [Users] (
	userID int not null primary key,
	[name] varchar(50) not null, 
	phoneNum char(11) not null, 
	country varchar(50) , 
	[password] [varchar](50) not null,
	email varchar(50) not null)

	
create table [Trips] (
	tripID int not null primary key,
	location_name varchar(50) not null,
	totalSeats int default 10,
	seatsAvailable int default 0,
	[start_date] date not null,
	end_date date not null)

create table [Hotels] (
	hotelID int not null primary key,
	hotel_name varchar(50) not null,
	location_name varchar(50) not null,
	hotel_category varchar(50) )

create table [Package] (
	packageID int not null primary key,
	package_name varchar(50) not null)

create table [Bookings] (
	userID int not null,
	tripID int not null,
	hotelID int not null foreign key references [Hotels](hotelID),
	seats int not null,
	booking_date date not null,
	packageID int not null foreign key references [Package](packageID),
	primary key (userID, tripID) )

create table [HotelBookings] (
	hotelID int not null foreign key references [Hotels](hotelID),
	tripID int not null foreign key references [Trips](tripID),
	primary key (hotelID, tripID) )

create table [History] (
	userID int not null foreign key references [Users](userID),
	tripID int not null foreign key references [Trips](tripID),
	rating int default null check(rating >= 0 and rating <= 5),
	primary key (userID, tripID) )


create table [Wishlist] (
	userID int not null foreign key references [Users](userID),
	tripID int not null foreign key references [Trips](tripID),
	primary key (userID, tripID) )

select* from[Users]


--insert data in table 
insert into Admins values 
	(1, 'Hammad', 03000000000, 'Pakistan', 'hammad123'), 
	(2, 'Abdullah', 03000000001, 'Pakistan', 'abdullah123'),
	(3, 'Arslan', 0300000002, 'Pakistan', 'arslan123');

insert into Users values 
	(1, 'Hassan' , 03123456789, 'Pakistan', 'user1', 'hassan1@gmai.com'),
	(2, 'John', 03123456788, 'USA', 'user2', 'john11@gmail.com'),
	(3, 'Zain', 03123456777, 'Pakistan', 'user3', 'zain2@gmail.com')

insert into Trips values
	(1, 'Sawat', 20, 0, '2020-01-12', '2020-01-15'), 
	(2, 'Murree', 10, 0, '2020-03-18', '2020-03-20'), 
	(3, 'Deosai', 15, 0, '2021-01-05', '2021-01-08'), 
	(4, 'Malam Jabbah', 20, 15, '2021-04-08', '2021-04-30'), 
	(5, 'Sawat', 15, 12, '2021-05-01', '2021-05-04');

insert into Hotels values
	(1, 'Sawat Heights', 'Sawat' , '5 Start'), 
	(2, 'Mountain Views', 'Sawat' , '5 Start'), 
	(3, 'Lala Hotel', 'Murree' , '5 Start'), 
	(4, 'Hotel Paradise', 'Murree' , '5 Start'), 
	(5, 'Bonfire Nights', 'Hunza' , '5 Start'), 
	(6, 'Hotel Plains', 'Skardu' , '5 Start'), 
	(7, 'Resort Special', 'Deosai' , '5 Start'), 
	(8, 'PC Hotel', 'Malam Jabbah' , '5 Start');

insert into Package values
	(1, 'Standard'), 
	(2, 'Gold'),
	(3, 'Premium');

insert into Bookings values
	(5, 1, 2, 15, '2020-01-04', 2),
	(1, 1, 1, 5, '2020-01-02', 1),
	(10, 2, 4, 4, '2020-03-12', 3),
	(7, 2, 4, 3, '2020-03-10', 2),
	(1, 2, 3, 3, '2020-03-11', 3),
	(2, 3, 7, 8, '2020-01-02', 1),
	(5, 3, 7, 7, '2020-01-03', 3),
	(3, 5, 1, 5, '2021-04-16', 1),
	(1, 5, 1, 3, '2021-04-15', 1);

insert into HotelBookings values
	(2, 1),
	(1, 1),
	(4, 2),
	(3, 2),
	(7, 3),
	(1, 5);

insert into History values
	(5, 1, 4),
	(1, 1, 3),
	(10, 2, 3),
	(7, 2, 5),
	(1, 2, null),
	(2, 3, 3),
	(5, 3, 5);

insert into Wishlist values
	(1, 1),
	(1, 3),
	(5, 2),
	(3, 5),
	(5, 5);


ALTER TABLE Users
ADD Email varchar(255);

select *from Admins 
select * from Users
select *from Trips
select *from Hotels
select *from Bookings
select *from HotelBookings
select *from History
select *from Wishlist


create Procedure UserLogIn 
@userID int , @password [varchar](50) 
As
Begin
	select* 
	from[Users] 
	where [Users].userID=@userID AND [Users].password=@password
end
select* from Users
select* from admins

create procedure UpdateUser
@userID int, @oldPass [varchar](50), @newPass [varchar](50), @newName [varchar](50), @newEmail [varchar](50), @newCountry [varchar](50),  @newPhone char(11)

as 
begin 
	update Users
	set [userID]=@userID, [name]=@newName, [phoneNum]=@newPhone, [country]=@newCountry, [password]=@newPass, [email]=@newEmail
	where [userID]=@userID
end

create procedure ResetPassword
@userID int, @emailID varchar(50), @newpassword varchar(50)
as 
begin 
	update Users
	set password=@newpassword
	where userID=@userID and email=@emailID
end


