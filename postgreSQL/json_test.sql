select '{"result": "success", "data":1 }'::json;

create table t5(
	response json
);

insert into t5 values('{"result": "success", "data":1 }');
insert into t5 values('{"result": "success", "data":2 }');

