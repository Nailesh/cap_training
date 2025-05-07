module.exports = cds.service.impl( async function () {
    const { POs, EmployeeSet } = this.entities;

    //generic handler - BEFORE employee data is updated (check - validation)
    this.before(['CREATE', 'UPDATE'], EmployeeSet, (req, res) => {
        console.log("aa gaya " + req.data.salaryAmount);
        if(parseFloat(req.data.salaryAmount) >= 1000000){
            req.error(500, "Salary must be less than 1 mn");
        }
    });

    this.on('boost', async (req, res) => {
        try {
            //since its instance bound, we'll get the key
            const ID = req.params[0];
            console.log(JSON.stringify(ID));

            //start a transaction using cds ql - https://cap.cloud.sap/docs/node.js/cds-tx
            const tx = await cds.tx(req);
            let test = await tx.update(POs).with({
                GROSS_AMOUNT: { '+=' : 20000 }
            }).where(ID);
            let reply = await tx.read(POs).where(ID);
            return reply;

        } catch (error) {

        }
    });

    this.on('getLargestOrder', async (req, res) => {
        try {
            //start a transaction using cds ql - https://cap.cloud.sap/docs/node.js/cds-tx
            const tx = await cds.tx(req);
            let reply = await tx.read(POs).orderBy({"GROSS_AMOUNT": 'desc'}).limit(1);
            return reply;

        } catch (error) {
            return error.toString();
        }
    });

})  