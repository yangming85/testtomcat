-- autogenerated: do not edit this file

create table batch_job_instance  (
	job_instance_id bigint  not null primary key ,  
	version bigint ,  
	job_name varchar(100) not null, 
	job_key varchar(32) not null,
	constraint job_inst_un unique (job_name, job_key)
) engine=innodb;

create table batch_job_execution  (
	job_execution_id bigint  not null primary key ,
	version bigint  ,  
	job_instance_id bigint not null,
	create_time datetime not null,
	start_time datetime default null , 
	end_time datetime default null ,
	status varchar(10) ,
	exit_code varchar(100) ,
	exit_message varchar(2500) ,
	last_updated datetime,
	constraint job_inst_exec_fk foreign key (job_instance_id)
	references batch_job_instance(job_instance_id)
) engine=innodb;
	
create table batch_job_params  (
	job_instance_id bigint not null ,
	type_cd varchar(6) not null ,
	key_name varchar(100) not null , 
	string_val varchar(250) , 
	date_val datetime default null ,
	long_val bigint ,
	double_val double precision ,
	constraint job_inst_params_fk foreign key (job_instance_id)
	references batch_job_instance(job_instance_id)
) engine=innodb;
	
create table batch_step_execution  (
	step_execution_id bigint  not null primary key ,
	version bigint not null,  
	step_name varchar(100) not null,
	job_execution_id bigint not null,
	start_time datetime not null , 
	end_time datetime default null ,  
	status varchar(10) ,
	commit_count bigint , 
	read_count bigint ,
	filter_count bigint ,
	write_count bigint ,
	read_skip_count bigint ,
	write_skip_count bigint ,
	process_skip_count bigint ,
	rollback_count bigint , 
	exit_code varchar(100) ,
	exit_message varchar(2500) ,
	last_updated datetime,
	constraint job_exec_step_fk foreign key (job_execution_id)
	references batch_job_execution(job_execution_id)
) engine=innodb;

create table batch_step_execution_context  (
	step_execution_id bigint not null primary key,
	short_context varchar(2500) not null,
	serialized_context text , 
	constraint step_exec_ctx_fk foreign key (step_execution_id)
	references batch_step_execution(step_execution_id)
) engine=innodb;

create table batch_job_execution_context  (
	job_execution_id bigint not null primary key,
	short_context varchar(2500) not null,
	serialized_context text , 
	constraint job_exec_ctx_fk foreign key (job_execution_id)
	references batch_job_execution(job_execution_id)
) engine=innodb;

create table batch_step_execution_seq (id bigint not null) engine=myisam;
insert into batch_step_execution_seq values(0);
create table batch_job_execution_seq (id bigint not null) engine=myisam;
insert into batch_job_execution_seq values(0);
create table batch_job_seq (id bigint not null) engine=myisam;
insert into batch_job_seq values(0);
