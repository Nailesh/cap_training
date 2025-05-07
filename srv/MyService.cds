using { nailesh.db.master } from '../db/datamodel';

service MyService @(path: 'MyService') {
    //definition
    function api(name: String) returns String;
    @readonly
    entity EmployeeSrv as projection on master.employees;
}