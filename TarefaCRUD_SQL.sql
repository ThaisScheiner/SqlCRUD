Create Database Livraria

Go

use Livraria

Create table Livro
(
	Codigo_Livro int	not null,
	Nome		 varchar(100),
	Lingua		 varchar(50),
	Ano			 int
	primary key (Codigo_Livro)
)
go

create table Autor
(
	Codigo_Autor	int		not null,
	Nome			varchar(100),
	Nascimento		date,
	Pais			varchar(50),
	Biografia		varchar(255)
	primary key (Codigo_Autor)
)
go

create table Livro_Autor
(
	LivroCodigo_Livro int not null,
	AutorCodigo_Autor int not null
	primary key (LivroCodigo_Livro, AutorCodigo_Autor),
	foreign key (LivroCodigo_Livro) references Livro(Codigo_Livro),
	foreign key (AutorCodigo_Autor) references Autor(Codigo_Autor)
)
go

create table Editora
(
	Codigo_Editora		int		not null,
	Nome				varchar(50),
	Logradouro			varchar(255),
	Numero				int,
	CEP					char(8),
	telefone			char(11)
	primary key (Codigo_Editora) 
)
go

create table Edicoes
(
	ISBN		int		not null,
	Preco		decimal(7,2),
	Ano			int,
	Num_Paginas int,
	Qtd_Estoque int
	primary key (ISBN)
)
go

create table Livro_Edicoes_Editora
(
	EdicoesISBN			    int		not null,
	EditoraCodigo_Editora	int		not null,
	LivroCodigo_Livro		int		not null
	primary key(EdicoesISBN, EditoraCodigo_Editora, LivroCodigo_Livro),
	foreign key(EdicoesISBN) references Edicoes(ISBN),
	foreign key(EditoraCodigo_Editora) references Editora(Codigo_Editora),
	foreign key(LivroCodigo_Livro) references Livro(Codigo_Livro)
)

--Modificar o nome da coluna ano da tabela edicoes, para AnoEdicao
exec sp_rename 'dbo.Edicoes.Ano', 'AnoEdicao', 'Column'

--Modificar o tamanho do varchar do Nome da editora de 50 para 30
alter table Editora
alter column Nome varchar(30)

--Modificar o tipo da coluna ano da tabela autor para int

alter table Autor
drop column Nascimento 

alter table Autor
add Nascimento int

--inserindo dados tabela Livro
insert into Livro (Codigo_Livro, Nome, Lingua, Ano)
values (10001, 'CCNA 4.1', 'PT-BR', 2015)

insert into Livro (Codigo_Livro, Nome, Lingua, Ano)
values (10002, 'HTML 5', 'PT-BR', 2017)

insert into Livro (Codigo_Livro, Nome, Lingua, Ano)
values (10003, 'Redes de Computadores', 'EN', 2010)

insert into Livro (Codigo_Livro, Nome, Lingua, Ano)
values (10004, 'Android em Ação', 'PT-BR', 2018)

--inserindo dados da tabela Autor
insert into Autor (Codigo_Autor, Nome, Pais, Biografia, Nascimento)
values (10001, 'Inácio da Silva', 'Brasil', 'Programador WEB desde 1995', 1975)

insert into Autor (Codigo_Autor, Nome, Pais, Biografia, Nascimento)
values (10002, 'Andrew Tannenbaum', 'EUA', 'Chefe do Departamento de Sistemas de Computação da Universidade de Vrij', 1944)

insert into Autor (Codigo_Autor, Nome, Pais, Biografia, Nascimento)
values (10003, 'Luis Rocha', 'Brasil', 'Programador Mobile desde 2000', 1967)

insert into Autor (Codigo_Autor, Nome, Pais, Biografia, Nascimento)
values (10004, 'David Halliday', 'EUA', 'Físico PH.D desde 1941', 1916)

--inserindo dados da tabela Livro_Autor
insert into Livro_Autor (LivroCodigo_Livro, AutorCodigo_Autor)
values (1001, 10001)

insert into Livro_Autor (LivroCodigo_Livro, AutorCodigo_Autor)
values (1002, 10003)

insert into Livro_Autor (LivroCodigo_Livro, AutorCodigo_Autor)
values (1003, 10002)

insert into Livro_Autor (LivroCodigo_Livro, AutorCodigo_Autor)
values (1004, 10003)

--inserindo dados da tabela Edicoes
insert into Edicoes (ISBN, Preco, AnoEdicao, Num_Paginas, Qtd_Estoque)
values (0130661023, 189.99, 2018, 653, 10)

--Alterando campo biografia 
update Autor
set Biografia = 'Chefe do Departamento de Sistemas de Computação da Universidade de Vrije'
where Codigo_Autor = 10002

--- A livraria vendeu 2 unidades do livro 0130661023, atualizar
update Edicoes
set Qtd_Estoque = 8
where ISBN = 130661023

--Por não ter mais livros do David Halliday, apagar o autor.
delete Autor
where Codigo_Autor = 10004

