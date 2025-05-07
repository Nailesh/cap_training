module.exports = function(srv) {
    //implementation
    srv.on('api', (req, res) => {
        return 'Hello Amigo, your name is ' + req.data.name;
    });


    //Replace the implementation using generic handler
    const { employees } = cds.entities('nailesh.db.master');

    srv.on('READ', 'EmployeeSrv', async (req, res)=>{


        //Get data from DB and loop and process, return
        let tx = await cds.tx(req);
       
        // let allRecords = await tx.from(employees).limit(5);
        let allRecords = await tx.run(SELECT.from(employees).limit(5));


        // for (let i = 0; i < allRecords.length; i++) {
        //     const element = allRecords[i];
        //     element.salaryAmount = element.salaryAmount * 0.88
        //     newData.push(element)
        // }
       
        const updatedRecords = allRecords.map(record => ({
            ...record, //return other fields also
            salaryAmount: record.salaryAmount * 0.88 // 12% reduction
        }));


        return updatedRecords;


        //Exmaple 1: hardcoded response
        // return {
        //     "ID": "zkas",
        //     "nameFirst": "Messi"
        // }
    });


}