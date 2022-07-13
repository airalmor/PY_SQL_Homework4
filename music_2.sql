create table style (
id SERIAL PRIMARY key,
name varchar(60)
);

create table artist (
id SERIAL PRIMARY key,
name varchar(60)
);

create table album (
id SERIAL PRIMARY key,
name varchar(60),
year integer not null
);

create table track (
id SERIAL PRIMARY key,
name varchar(60),
duration integer not null,
album_id integer references album(id)
);

create table collection (
id SERIAL PRIMARY key,
year integer not null,
name varchar(60)
);

create table artist_style (
artist_id integer references artist(id),
style_id integer references style(id)
);

create table artist_album (
artist_id integer references artist(id),
album_id integer references album(id)
);


create table track_collection (
track_id integer references track(id),
collection_id integer references collection(id)
);