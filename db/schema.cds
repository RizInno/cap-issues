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
        MessageType
    ]}
    entity OutputTypes : cuid, managed {
        BusinessPartner : Association to BusinessPartners;
        @mandatory
        MessageType     : Association to one MessageTypes;
        OutputChannels  : Composition of many MessageOutputChannels
                              on OutputChannels.OutputType = $self;
    }

    @assert.unique : {OutputChannels : [
        OutputType,
        OutputChannel
    ]}
    entity MessageOutputChannels : cuid, managed {
        OutputType    : Association to one OutputTypes;
        @mandatory
        OutputChannel : Association to one OutputChannels;
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
