-- create the database
create database VAG;
use VAG;

-- create the artists table
create table Artists (
    ArtistID int auto_increment primary key,
    Name varchar(255) not null,
    Biography text,
    Nationality varchar(100)
);

-- create the categories table
create table Categories (
    CategoryID int auto_increment primary key,
    Name varchar(100) not null unique
);

-- create the artworks table
create table Artworks (
    ArtworkID int auto_increment primary key,
    Title varchar(255) not null,
    Artistid int,
    Categoryid int,
    Year int,
    Description text,
    Imageurl varchar(255),
    constraint fk_Artist foreign key (ArtistID) references Artists (ArtistID) on delete cascade,
    constraint fk_Category foreign key (CategoryID) references Categories (CategoryID) on delete cascade
);

-- create the exhibitions table
create table Exhibitions (
    Exhibitionid int auto_increment primary key,
    Title varchar(255) not null,
    Startdate date,
    Enddate date,
    Description text
);

-- create a table to associate artworks with exhibitions
create table Exhibitionartworks (
    Exhibitionid int,
    Artworkid int,
    primary key (Exhibitionid, Artworkid),
    constraint fk_Exhibition foreign key (ExhibitionID) references Exhibitions (ExhibitionID) on delete cascade,
    constraint fk_Artwork foreign key (ArtworkID) references Artworks (ArtworkID) on delete cascade
);

-- Insert sample data into the Artists table
INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

-- Insert sample data into the Categories table
INSERT INTO Categories (CategoryID, Name) VALUES
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Photography');

-- Insert sample data into the Artworks table
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso\'s powerful anti-war mural.', 'guernica.jpg');

-- Insert sample data into the Exhibitions table
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

-- Insert artworks into exhibitions
INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2);

select * from ExhibitionArtworks;
-- Q1 
select a.Name, COUNT(ar.ArtworkID) AS Artwork_count
from Artists a
left join Artworks ar ON a.ArtistID = ar.ArtistID
group by a.ArtistID, a.Name
order by Artwork_count desc;

-- Q2
select ar.Title, ar.Year
from Artworks ar
join Artists a on ar.Artistid = a.Artistid
where a.Nationality in ('Spanish', 'Dutch')
order by ar.Year asc;

-- Q3 
select a.Name, count(ar.ArtworkID) as Artwork_Count
from Artists a
join Artworks ar on a.ArtistID = ar.ArtistID
join Categories c on ar.CategoryID = c.CategoryID
where c.Name = 'Painting'
group by a.ArtistID, a.Name
order by Artwork_count desc;

-- Q4 
select ar.Title, a.Name as Artist_Name, c.Name as Category_Name
from Exhibitionartworks ea
join Artworks ar on ea.ArtworkID = ar.ArtworkID
join Artists a on ar.ArtistID = a.ArtistID
join Categories c on ar.Categoryid = c.Categoryid
join Exhibitions e on ea.ExhibitionID = e.ExhibitionID
where e.title = 'Modern Art Masterpieces';

-- Q5
select a.Name, count(ar.ArtworkID) as Artwork_count
from Artists a
join Artworks ar on a.ArtistID = ar.ArtistID
group by a.Artistid, a.Name
having count(ar.ArtworkID) > 2
order by Artwork_Count desc;

-- Q6
select ar.Title
from Artworks ar
join Exhibitionartworks ea on ar.ArtworkID = ea.ArtworkID
join Exhibitions e on ea.exhibitionID = e.exhibitionID
where e.Title in ('Modern Art Masterpieces', 'Renaissance Art')
group by ar.ArtworkID, ar.Title
having count(distinct e.Exhibitionid) = 2;

-- Q7
select c.Name as Category_name, count(ar.ArtworkID) as Artwork_count
from Categories c
left join Artworks ar on c.CategoryID = ar.CategoryID
group by c.CategoryID, c.Name
order by Artwork_count desc;

-- Q8
select a.Name, count(ar.ArtworkID) as Artwork_count
from Artists a
join Artworks ar on a.ArtistID = ar.ArtistID
group by a.ArtistID, a.Name
having Artwork_count > 3
order by Artwork_count desc;

-- Q9
select ar.Title, a.Name as Artist_name, a.Nationality
from Artworks ar
join Artists a on ar.ArtistID = a.ArtistID
where a.Nationality = 'Spanish';

-- Q10
select e.Title
from Exhibitions e
join Exhibitionartworks ea on e.Exhibitionid = ea.Exhibitionid
join Artworks ar on ea.Artworkid = ar.Artworkid
join Artists a on ar.Artistid = a.Artistid
where a.Name in ('Vincent van Gogh', 'Leonardo da Vinci')
group by e.ExhibitionID, e.Title
having count(distinct a.artistid) = 2;

-- Q11
select ar.Title, a.Name as Artist_name
from Artworks ar
join Artists a on ar.Artistid = a.Artistid
left join Exhibitionartworks ea on ar.Artworkid = ea.Artworkid
where ea.Artworkid is null;

-- Q12
select a.Name
from Artists a
join Artworks ar on a.Artistid = ar.Artistid
join Categories c on ar.Categoryid = c.Categoryid
group by a.Artistid, a.Name
having count(distinct ar.Categoryid) = (select count(*) from Categories);

-- Q13
select c.Name as Category_name, count(ar.ArtworkID) as Artwork_count
from Categories c
left join Artworks ar on c.Categoryid = ar.Categoryid
group by c.Categoryid, c.Name
order by Artwork_count desc;

-- Q14
select a.Name, count(ar.ArtworkID) as Artwork_count
from Artists a
join Artworks ar on a.Artistid = ar.Artistid
group by a.Artistid, a.Name
having Artwork_count > 2
order by Artwork_count desc;

-- Q15
select c.Name as Category_name, avg(ar.Year) as Average_year
from Categories c
join Artworks ar on c.Categoryid = ar.Categoryid
group by c.Categoryid, c.Name
having count(ar.Artworkid) > 1
order by Average_year asc;

-- Q16
select ar.Title, a.Name as Artist_name
from Exhibitionartworks ea
join Artworks ar on ea.Artworkid = ar.Artworkid
join Artists a on ar.Artistid = a.Artistid
join Exhibitions e on ea.Exhibitionid = e.Exhibitionid
where e.Title = 'Modern Art Masterpieces';

-- Q17
select c.Name as Category_name, avg(ar.Year) as Category_avg_year
from Categories c
join Artworks ar on c.Categoryid = ar.Categoryid
group by c.Categoryid, c.name
having avg(ar.Year) > (select avg(Year) from artworks)
order by Category_avg_year desc;

-- Q18
select ar.Title, a.name as Artist_name
from Artworks ar
join Artists a on ar.Artistid = a.Artistid
left join Exhibitionartworks ea on ar.Artworkid = ea.Artworkid
where ea.Artworkid is null;

-- Q19
select distinct a.Name
from Artists a
join Artworks ar on a.Artistid = ar.Artistid
where ar.Categoryid = (
    select Categoryid from artworks where title = 'Mona Lisa'
);

-- Q20
select a.Name as Artist_name, count(ar.ArtworkID) as Artwork_count
from Artists a
left join Artworks ar on a.Artistid = ar.Artistid
group by a.Artistid, a.Name
order by Artwork_count desc;



