

-- CREATING MASTER DATA TEMPLETE USING EXISTING TABLE --
drop table  if exists master_data;
create table master_data
(
date_updated date primary key not null,
load_plan int,
process_resort int,
process_rto int,
process_fm int,
process_misroute int,
semi_large int,
bag_closed int,
brsnr int,
tech_issue int,
damage_miss_issue int,
ib_vehicles int,
short int,
excess int,
ib_resortbags int,
ib_resortshipments int,
ib_crossbags int,
ib_crossshipments int,
ib_rtobags int,
ib_rtoshipments int,
ib_misroutebags int,
ib_misrouteshipments int,
ib_fmbags int,
ib_fmshipments int,
ib_semilarge int,
ob_vehicles int,
ob_bags int,
ob_shipments int,
plan_manpower int,
avail_manpower int,
absent_manpower int
);

truncate table master_data;

-- displaying master_data--

select * from master_data;


-- INSERTION OF DATA FROM TABLE --

insert into master_data
select * from nov2021;


-- STORED PROCEDURE FOR INSERTING DATA--

drop procedure if exists insert_data
create procedure insert_data @table_name nvarchar(255) as
begin
set nocount on;
declare @sql nvarchar(225);
set @sql = ' 
insert into master_data
select * from ' + QUOTENAME(@table_name) + ';'

exec sp_executesql @sql;
end;

-- COMMAND FOR INSERTING DATA --

exec insert_data @table_name = 'nov2022';

drop table  if exists impact_ship_data;
create table impact_ship_data
(
date_updated date primary key not null,
vehi_unload int,
vehi_ontime int,
vehi_early_6 int,
vehi_early_24 int,
vehi_delay_24 int,
vehi_delay_6 int,
vehi_delay_12 int,
impacted_ship int,
cpd int,
special_run int,
cutoff_extend_2 int,
cutoff_extend_1 int
);

-- STORED PROCEDURE FOR INSERTING DATA--

drop procedure if exists insert_data_two
create procedure insert_data_two @table nvarchar(255) as
begin
set nocount on;
declare @sql_two nvarchar(225);
set @sql_two = ' 
insert into impact_ship_data
select * from ' + QUOTENAME(@table) + ';'

exec sp_executesql @sql_two;
end;

-- COMMAND FOR INSERTING DATA --

exec insert_data_two @table = 'impact_data';

select* from impact_ship_data;