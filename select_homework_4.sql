--Количество исполнителей в каждом жанре
select s."name" as "Стиль", count(a.name) as "Количество артистов" from artist a
join artist_style as2 on a.id = as2.artist_id 
join "style" s on as2.style_id = s.id
group by s."name" 

--количество треков, вошедших в альбомы 1999-20 годов;
select count(t.name) as "Количество песен в альбомах 1999-2000 годах" from track t 
join album a on t.album_id = a.id 
where a."year" between 1999 and 2000

--средняя продолжительность треков по каждому альбому;
select a.name, avg(t.duration) from album a 
join track t on a.id = t.album_id
group by a."name" 


--все исполнители, которые не выпустили альбомы в 2020 году;
select a."name"  from artist a 
join artist_album aa on aa.artist_id = a.id 
join album a2 on a2.id = aa.album_id 
where a2.year !=2020


--названия сборников, в которых присутствует конкретный исполнитель (The Prodigy)
select c."name" as "Название сборника" from collection c 
join track_collection tc on tc.collection_id = c.id 
join track t on t.id = tc.track_id 
join album a on a.id = t.album_id 
join artist_album aa on aa.album_id = a.id 
join artist a2 on a2.id = aa.artist_id 
where a2.name like 'The Prodigy'
group by c."name" 


--название альбомов, в которых присутствуют исполнители более 1 жанра;
select a."name", count(distinct as2.style_id)  from album a 
join artist_album aa on a.id = aa.album_id 
join artist a2 on a2.id = aa.artist_id 
join artist_style as2 on aa.artist_id = as2.artist_id 
group by a."name" 
having count(distinct as2.style_id)>1 

--Треки не входящие в сборники
select t.name from track t
left join track_collection tc on t.id = tc.track_id
where tc.collection_id is null

--Исполнитель самого короткой песни
select a.name,t.duration  from artist a 
join artist_album aa on a.id = aa.artist_id 
join album a2 on a2.id = aa.album_id 
join track t on t.album_id = aa.album_id 
where t.duration = (select min(duration) from track)

--названия альбомов с наименьшим количеством треков
select a."name", count(t.id) from album a 
join track t on t.album_id = a.id 
group by a."name" 
having count(t.id) = (select min(count_tracks) 
	from (select count(t2.id) as count_tracks 
		from album a2
		join track t2 on t2.album_id = a2.id
		group by a2.id ) as x)
			



