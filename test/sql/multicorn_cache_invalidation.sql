CREATE EXTENSION multicorn;
CREATE server multicorn_srv foreign data wrapper multicorn options (
    wrapper 'multicorn.testfdw.TestForeignDataWrapper'
);
CREATE user mapping for postgres server multicorn_srv options (usermapping 'test');

CREATE foreign table testmulticorn (
    test1 character varying,
    test2 character varying
) server multicorn_srv options (
    option1 'option1'
);

-- Test "normal" usage
select * from testmulticorn;

ALTER foreign table testmulticorn drop column test1;

select * from testmulticorn;

ALTER foreign table testmulticorn add column test1 varchar;

select * from testmulticorn;

ALTER foreign table testmulticorn add column test3 varchar;

select * from testmulticorn;

ALTER foreign table testmulticorn options (SET option1 'option1_update');

select * from testmulticorn;

ALTER foreign table testmulticorn options (ADD option2 'option2');

select * from testmulticorn;

ALTER foreign table testmulticorn options (DROP option2);

select * from testmulticorn;

-- Test dropping column when returning sequences (issue #15)
ALTER foreign table testmulticorn options (ADD test_type 'sequence');

select * from testmulticorn;

ALTER foreign table testmulticorn drop test3;

select * from testmulticorn;

DROP extension multicorn cascade;
