using { nailesh.db.master, nailesh.db.transaction } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';

service CatalogService @(path: 'CatalogService') {
    entity EmployeeSet as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity businessPartner as projection on master.businesspartner;
    entity ProductSet as projection on master.product;
    // entity POs as projection on transaction.purchaseorder {
    entity POs @(odata.draft.enabled: true) as projection on transaction.purchaseorder {
        *,
        // PARTNER_GUID.ADDRESS_GUID.COUNTRY.code,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'D' then 'Delivered'
            when 'P' then 'Pending'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
                end as OverallStatus: String(10),
        case OVERALL_STATUS
            when 'N' then 2
            when 'P' then 2
            when 'D' then 3
            when 'A' then 3
            when 'X' then 1
                end as IconColor: Integer
    }
    actions {
        //read call to fetch latest data
        @Common.SideEffects: {
            TargetProperties : [
                'in/GROSS_AMOUNT'
                // 'in/*'   // select whole line data
            ],
        }
        action boost() returns POs;
    };
    entity POItems as projection on transaction.poitems;

    function getLargestOrder() returns POs;
    
    // entity CDSSet as projection on cds.CDSViews.ProductView;
    
}