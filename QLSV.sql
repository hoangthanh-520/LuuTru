use OnTap
create table Khoa(
	maKhoa varchar(10) primary key ,
	tenKhoa nvarchar(100) not null,
	namThanhLap int not null,
);
create table KhoaHoc(
	maKhoaHoc varchar(10) primary key,
	namBD int not null,
	namKT int 
);


create table ChuongTrinh(
	maCT varchar(10) primary key,
	tenCT nvarchar(100) not null,
);
create table Lop(
	MaLop varchar(10)  primary key,
	maKhoaHoc   varchar(10) not null,
	maKhoa varchar(10)  not null,
	maCT  varchar(10) not null,
	soThuTu   int not null,
	foreign key(maKhoa) references Khoa(maKhoa),
	foreign key(maKhoaHoc) references KhoaHoc(maKhoaHoc),
	foreign key(maCT) references ChuongTrinh(maCT)
);
create table SV(
	MaSV varchar(10) primary key,
	hoten nvarchar(100) not null,
	namSinh int not null,
	dantoc nvarchar(20) not null,
	MaLop varchar(10) not null,
	foreign key (MaLop) references Lop(MaLop)
);
create table MonHoc(
	MaMH varchar(10) primary key,
	tenMH nvarchar(100) not null,
	maKhoa varchar(10) not null,
	foreign key (maKhoa) references Khoa(maKhoa)
);

create table KetQua(
	MaSV varchar(10),
	MaMH varchar(10),
	lanThi int,
	diem float not null
	primary key(MaSV,MaMH,lanThi),
	foreign key (MaSV) references SV(MaSV),
	foreign key (MaMH) references MonHoc(MaMH)

);

create table GiangKhoa(
	maCT varchar(10) not null,
	maKhoa varchar(10) not null,
	maMH varchar(10) not null,
	namHoc int not null,
	hocky int not null,
	soTietLyThuyet int not null,
	soTietThucHanh int not null,
	soTinChi int not null,
	primary key(maCT,maKhoa,maMH,namHoc),
	foreign key (maCT) references ChuongTrinh(maCT),
	foreign key (maKhoa) references Khoa(maKhoa),
	foreign key (maMH) references MonHoc(maMH),

);


drop table KetQua
select *FROM Khoa
--SV
insert into SV(MaSV,hoten,namSinh,dantoc,MaLop)
values(0212001,N'Nguyễn Vĩnh An',1984,N'Kinh','TH2002/01')
insert into SV(MaSV,hoten,namSinh,dantoc,MaLop)
values(0212002,N'Nguyên Thanh Bình',1985,N'Kinh','TH2002/01')
insert into SV(MaSV,hoten,namSinh,dantoc,MaLop)
values(0212003,N'Nguyễn Thanh Cường',1984,N'Kinh','TH2002/02')
insert into SV(MaSV,hoten,namSinh,dantoc,MaLop)
values(0212004,N'Nguyễn Quốc Duy',1983,N'Kinh','TH2002/02')
insert into SV(MaSV,hoten,namSinh,dantoc,MaLop)
values(0311001,N'Phan Tuấn Anh',1985,N'Kinh','VL2003/01')
insert into SV(MaSV,hoten,namSinh,dantoc,MaLop)
values(0311002,N'Huỳnh Thanh Sang',1984,N'Kinh','VL2003/01')
--Lơps
insert into Lop
values('TH2002/01','K2002','CNTT','CQ',1)
insert into Lop
values('TH2002/02','K2002','CNTT','CQ',2)
insert into Lop(MaLop,maKhoaHoc,maKhoa,maCT,soThuTu) 
values('VL2003/01','K2003','VL','CQ',1)
--Chuong Trinh
insert into ChuongTrinh(maCT,tenCT)
values('CQ',N'Chính Qui')
--MH
insert into MonHoc values('THT01',N'Toán Cao cấp A1','CNTT')
insert into MonHoc values('VLT01',N'Toán Cao cấp A1','VL')
insert into MonHoc values('THT02',N'Toán rời rạc','CNTT')
insert into MonHoc values('THCS01',N'Cấu trúc dữ liệu 1','CNTT')
insert into MonHoc values('THCS02',N'Hệ điều hành','CNTT')
--KQ
insert into KetQua values(0212001,'THT01',1,4)
insert into KetQua values(0212001,'THT01',2,7)
insert into KetQua values(0212002,'THT01',1,8)
insert into KetQua values(0212003,'THT01',1,6)
insert into KetQua values(0212004,'THT01',1,9)
insert into KetQua values(0212001,'THT02',1,8)
insert into KetQua values(0212002,'THT02',1,5.5)
insert into KetQua values(0212003,'THT02',1,4)
insert into KetQua values(0212003,'THT02',2,6)
insert into KetQua values(0212001,'THCS01',1,6.5)
insert into KetQua values(0212002,'THCS01',1,4)
insert into KetQua values(0212003,'THCS01',1,7)
--Giang Khoa
insert into GiangKhoa values('CQ','CNTT','THT01',2003,1,60,30,5)
insert into GiangKhoa values('CQ','CNTT','THT02',2003,2,45,30,4)
insert into GiangKhoa values('CQ','CNTT','THCS01',2004,1,45,30,4)



select* from GiangKhoa 
--1.Danh sách các sinh viên khoa “Công nghệ Thông tin” khoá 2002-2006
select sv.* from Khoa k,KhoaHoc kh, SV sv, Lop L, ChuongTrinh ct
where k.maKhoa = 'CNTT' 
and	sv.MaLop = l.MaLop
and kh.namBD = '2002'
and kh.namKT = '2006'
and l.maKhoa = k.maKhoa
and l.maKhoaHoc = kh.maKhoaHoc
and l.maCT = ct.maCT
--cau 2Cho biết các thông tin (MSSV, họ tên ,năm sinh) của các sinh viên học sớm hơn tuổi quy định (theo tuổi quy định thi sinh viên đủ 18 tuổi khi bắt đầu khóa học)
select sv.MaSV,sv.hoten,sv.namSinh from SV sv,KhoaHoc kh,Lop l
where sv.MaLop = l.MaLop
and kh.maKhoaHoc = l.maKhoaHoc
and kh.namBD - sv.namSinh <18
--cau 3Cho biết sinh viên khoa CNTT, khoá 2002-2006 chưa học môn cấu trúc dữ liệu 1

select sv.* from SV sv, KhoaHoc kh, Lop l
where sv.MaLop = l.MaLop
and kh.namBD = '2002'
and kh.namKT = '2006'
and l.maKhoaHoc = kh.maKhoaHoc
and l.maKhoa = 'CNTT'
and sv.MaSV not in(
	select kq.MaSV from KetQua kq, MonHoc mh
	where mh.tenMH = N'Cấu trúc dữ liệu 1'
	and mh.MaMH = kq.MaMH
)

--cau 4 Cho biết sinh viên thi không đậu (Diem <5) môn cấu trúc dữ liệu 1 nhưng chưa thi lại. 
select *from SV sv, MonHoc mh, KetQua kq
where sv.MaSV = kq.MaSV
and mh.MaMH = kq.MaMH
and mh.tenMH = N'Cấu trúc dữ liệu 1'
and kq.diem <5
and kq.lanThi=1
and sv.MaSV not in(
	select kq2.MaSV from KetQua kq2
	where mh.MaMH = kq.MaMH
	and kq2.lanThi >1
)
--cau 5 Với mỗi lớp thuộc khoa CNTT, cho biết mã lớp, mã khóa học, tên chương trình và số sinh viên thuộc lớp đó 
select l.MaLop,l.maKhoaHoc, ct.tenCT,COUNT(sv.MaLop) as So_luong_SV from SV sv, Lop l,ChuongTrinh ct,Khoa k
where l.maKhoa = 'CNTT'
and l.maKhoa = k.maKhoa
and l.maCT = ct.maCT
and sv.MaLop = l.MaLop
group by l.MaLop,l.maKhoaHoc,ct.tenCT

--cau 6 Cho biết điểm trung bình của sinh viên có mã số 0212003 (điểm trung bình chỉ tính trên lần thi sau cùng của sinh viên) 
select AVG(kq1.diem) from KetQua kq1
where kq1.MaSV ='212003'
and kq1.lanThi=(
	select MAX(kq2.lanThi)
	from KetQua kq2
	where kq2.MaSV = kq1.MaSV
	and kq2.MaMH = kq1.MaMH

)
