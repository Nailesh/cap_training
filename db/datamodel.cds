namespace nailesh.db;
using { mycapapp.commons as spiderman } from './commons';
using { cuid, Country, managed, temporal, Currency } from '@sap/cds/common';

//How to reuse data types like in ABAP data elements and domain
// type Guid: String(32);

context master {

    entity businesspartner {
        key NODE_KEY : spiderman.Guid @(title: '{i18n>XCEL_PARTNER}');
        BP_ROLE: String(2);
        EMAIL_ADDRESS: String(105);
        PHONE_NUMBER: String(32);
        FAX_NUMBER: String(32);
        WEB_ADDRESS: String(44);
        BP_ID: String(32);
        COMPANY_NAME: String(256) @(title: '{i18n>XCEL_COMPANY}');
        //foreign key relation
        ADDRESS_GUID: Association to one address;    
    }

    entity address {
        key NODE_KEY: spiderman.Guid;
        CITY: String(44);
        POSTAL_CODE: String(8);
        STREET: String(44);
        BUILDING: String(128);
        COUNTRY: Country; //@(title: '{i18n>XCEL_COUNTRY}');
        ADDRESS_TYPE: String(44);
        VAL_START_DATE: Date;
        VAL_END_DATE: Date;
        LATITUDE: Decimal;
        LONGITUDE: Decimal;
        //backward relation
        businesspartner: Association to one businesspartner on
            businesspartner.ADDRESS_GUID = $self;
    }

    entity product {
        key NODE_KEY: spiderman.Guid @(title: '{i18n>XCEL_PRODUCT}');
        PRODUCT_ID: String(28);
        TYPE_CODE: String(2);
        CATEGORY: String(32) @(title: '{i18n>XCEL_PROD_CAT}');
        DESCRIPTION: localized String(255) @(title: '{i18n>XCEL_PROD_DESC}');
        SUPPLIER_GUID: Association to master.businesspartner;
        TAX_TARIF_CODE: Integer;
        MEASURE_UNIT: String(2);
        WEIGHT_MEASURE: Decimal(5,2);
        WEIGHT_UNIT: String(2);
        CURRENCY_CODE: String(4);
        PRICE:Decimal(15,2);
        WIDTH:Decimal(5,2);
        DEPTH:Decimal(5,2);
        HEIGHT:Decimal(5,2);
        DIM_UNIT:String(2);
    }

    entity employees: cuid {
        nameFirst: String(40);
        nameMiddle: String(40);
        nameLast: String(40);
        nameInitials: String(40);
        sex: spiderman.Gender;
        language: String(1);
        phoneNumber: spiderman.PhoneNumber;
        email: spiderman.Email;
        loginName: String(12);
        Currency: Currency;
        salaryAmount: spiderman.AmountT;
        accountNumber: String(16);
        bankId: String(8);
        bankName: String(64);
    }

}

context transaction {
    entity purchaseorder: cuid, spiderman.Amount, managed {
        // key NODE_KEY: spiderman.Guid @(title: '{i18n>XCEL_POGUID}');
        PO_ID: String(40) @(title: '{i18n>XCEL_PO_ID}');
        PARTNER_GUID: Association to master.businesspartner @(title: '{i18n>XCEL_PARTNER}');
        LIFECYCLE_STATUS: String(1) @(title: '{i18n>XCEl_LSTATUS}');
        OVERALL_STATUS: String(1) @(title: '{i18n>XCEL_STATUS}');
        // Items: Association to many poitems on Items.PARENT_KEY = $self;
        Items: Composition of many poitems on Items.PARENT_KEY = $self;
    }

    entity poitems: cuid, spiderman.Amount{
        // key NODE_KEY: spiderman.Guid @(title: '{i18n>XCEL_POITEM_KEY}');
        PARENT_KEY: Association to purchaseorder @(title: '{i18n>XCEL_POGUID}');
        PO_ITEM_POS: Integer @(title: '{i18n>XCEL_PO_POS}');
        PRODUCT_GUID: Association to master.product @(title: '{i18n>XCEL_PRODUCT}');
    }
}