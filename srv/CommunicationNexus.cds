using {md} from '../db/schema';

service CommunicationNexus {

    @odata.draft.enabled
    entity BusinessPartners  as projection on md.BusinessPartners;

    entity OutputTypes       as projection on md.OutputTypes;

    @readonly
    entity VH_OutputChannels as projection on md.OutputChannels;

    type Recipients : String(50);

    type Input : {
        message          : String;
        @mandatory
        recipients       : many {
            ID           : UUID;
            email        : String;
            street       : String;
            postalCode   : String;
            sapPartnerId : String;
        }
    };

    type Report : {
        channel             : String;
        callbackData        : String;
        bulkId              : String;
        price               : {
            pricePerMessage : Decimal;
            currency        : String;
        };
        status              : {
            id              : Integer;
            groupId         : Integer;
            groupName       : String;
            name            : String;
            description     : String;
        };
        error               : {
            id              : Integer;
            name            : String;
            description     : String;
            groupId         : Integer;
            groupName       : String;
            permanent       : Boolean;
        };
        messageId           : String;
        messageCount        : Integer;
        ![from]             : String;
        to                  : String;
        // Whatsapp sends date format that's not received well by OData V4 - DateTimeOffSet type
        // i.e. "Deserialization Error: Invalid value 2019-04-09T16:01:56.494-0300 (JavaScript string)
        // for property \"doneAt\". A string value in the format YYYY-MM-DDThh:mm:ss.sTZD must be
        // specified as value for type Edm.DateTimeOffset."
        doneAt              : String;
        sentAt              : String;
        seenAt              : String;
        deletedAt           : String;
    }

    action Send(data : Input);
    action SendReport(results : many Report);
}
