using {
    cuid,
    managed
} from '@sap/cds/common';


context md {

    entity BusinessPartners : cuid, managed {
        name           : String;
        email          : String;
        phone          : String;
        sapPartnerId   : String;
        address        : {
            street     : String;
            city       : String;
            state      : String;
            postalCode : String;
            country    : String;
        };
        OutputTypes    : Composition of many OutputTypes
                             on OutputTypes.BusinessPartner = $self;
    }

    @assert.unique : {OutputTypes : [
        BusinessPartner,
        OutputChannel
    ]}
    entity OutputTypes : cuid, managed {
        BusinessPartner : Association to BusinessPartners;
        @mandatory
        OutputChannel   : Association to one OutputChannels;
    }

    entity MessageTypes {
        key ID   : String(2);
            name : String(30);
    }

    entity OutputChannels {
        key ID   : String(2);
            name : String(50);
    }
}
