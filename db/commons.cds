namespace mycapapp.commons;
using { Currency } from '@sap/cds/common';

type Gender : String(1) enum{
    male = 'M';
    female = 'F';
    undisclosed = 'U';
};

//How to reuse data types like in ABAP data elements and domain
type Guid: String(32);

type AmountT: Decimal(10, 2) @(
    Semantics.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit: 'CURRENCY_CODE'
);


//combination of fields - aspect
aspect Amount {
    CURRENCY: Currency; //@(title : '{i18n>XCEL_CURR}');
    GROSS_AMOUNT: AmountT @(title : '{i18n>XCEL_GROSS}');
    NET_AMOUNT: AmountT @(title : '{i18n>XCEL_NET}');
    TAX_AMOUNT: AmountT @(title : '{i18n>XCEL_TAX}');
}

type PhoneNumber: String(30)@assert.format : '^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';
type Email: String(255);  //@assert.format : '/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/';