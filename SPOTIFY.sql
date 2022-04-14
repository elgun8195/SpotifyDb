CREATE DATABASE Spotify
USE Spotify

CREATE TABLE Musics(
Id int primary key identity,
[Name] nvarchar(100),
Duration int,
ListenerCount decimal(18,2)
)

CREATE TABLE Artists(
Id int primary key identity,
Fullname nvarchar(100),
)


CREATE TABLE Albums(
Id int primary key identity,
[Name] nvarchar(100),
TotalSongs int,
TotalDuration int,
ArtisId INT CONSTRAINT FK_AlbumArtisId FOREIGN KEY REFERENCES Artists(Id)
)

CREATE TABLE MusicArtists(
Id int primary key identity,
MusicId INT CONSTRAINT FK_MMusicId FOREIGN KEY REFERENCES Musics(Id),
ArtistId INT CONSTRAINT FK_MusicArtisId FOREIGN KEY REFERENCES Artists(Id)
)


CREATE TABLE MusicAlbums(
Id int primary key identity,
MusicId INT CONSTRAINT FK_AlMusicId FOREIGN KEY REFERENCES Musics(Id),
AlbumsId INT CONSTRAINT FK_MusicAlbumId FOREIGN KEY REFERENCES Albums(Id)
)

CREATE VIEW V_VIEW_1
AS
SELECT m.Name 'Music Name',M.Duration 'TotalSecond',ats.Fullname 'ArtistName',al.Name 'AlbumName' FROM Musics	AS M
JOIN MusicArtists AS ms
ON M.Id=ms.MusicId
JOIN Artists AS ats
ON ms.ArtistId=ats.Id
JOIN MusicAlbums AS mas
ON M.Id=mas.MusicId
JOIN Albums AS al
ON mas.AlbumsId=al.Id

SELECT*FROM V_VIEW_1

CREATE VIEW V_VIEW_2
AS
SELECT Albums.Name,Albums.TotalSongs FROM Albums

SELECT*FROM V_VIEW_2


CREATE PROCEDURE Musicsss @Countt int AND @Name varchar(100)
AS
SELECT Musics.Name,Musics.ListenerCount,Albums.Name FROM Musics
WHERE ListenerCount > @Countt , Albums.Name=@Name
JOIN MusicAlbums AS mas
ON Musics.Id=mas.MusicId
JOIN Albums 
ON mas.AlbumsId=Albums.Id
