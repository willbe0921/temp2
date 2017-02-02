
drop table pds
cascade constraint;

create table pds(
	seq number(8) primary key,
	id varchar2(50) not null,
	title varchar2(200) not null,
	content varchar2(4000) not null,
	filename varchar2(50) not null,
	readcount number(8) not null,
	downcount number(8) not null,
	regdate date not null
);

create sequence seq_pds
start with 1 increment by 1;

alter table pds
add constraint fk_pds_id foreign key(id)
references member(id);

ALTER TABLE member DROP CONSTRAINT fk_sistpds_id CASCADE;

