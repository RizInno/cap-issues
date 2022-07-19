using {CommunicationNexus} from './CommunicationNexus';

annotate CommunicationNexus.BusinessPartners with @(
    Capabilities : {DeleteRestrictions : {Deletable : false

    }},
    Common       : {Label : '{i18n>businessPartners}'},
    UI           : {
        LineItem            : [
            {Value : name},
            {Value : email},
            {Value : sapPartnerId},
            {Value : address_street},
            {Value : address_city},
            {Value : address_state},
            {Value : address_postalCode},
            {Value : address_country}
        ],

        /**
         * Object Page
         */

        HeaderInfo          : {
            TypeName       : '{i18n>businessPartner}',
            TypeNamePlural : '{i18n>businessPartners}',
            Title          : {Value : name},
            Description    : {Value : sapPartnerId}
        },
        Facets              : [
            {
                $Type  : 'UI.CollectionFacet',
                ID     : 'Details',
                Label  : '{i18n>details}',
                Facets : [
                    {
                        $Type  : 'UI.ReferenceFacet',
                        ID     : 'Contact',
                        Label  : '{i18n>contact}',
                        Target : '@UI.FieldGroup#Contact'
                    },
                    {
                        $Type  : 'UI.ReferenceFacet',
                        ID     : 'Address',
                        Label  : '{i18n>address}',
                        Target : '@UI.FieldGroup#Address'
                    }
                ]
            },
            {
                $Type  : 'UI.ReferenceFacet',
                ID     : 'MessageTypes',
                Label  : '{i18n>messageTypes}',
                Target : 'OutputTypes/@UI.LineItem'
            }
        ],
        FieldGroup #Contact : {Data : [
            {Value : email},
            {Value : phone}
        ]},
        FieldGroup #Address : {Data : [
            {Value : address_street},
            {Value : address_city},
            {Value : address_state},
            {Value : address_postalCode},
            {Value : address_country}
        ]}
    }
) {
    ID             @(UI : {Hidden});
    name           @(title : '{i18n>name}');
    email          @(title : '{i18n>email}');
    phone          @(title : '{i18n>phone}');
    sapPartnerId   @(title : '{i18n>sapPartnerId}');
    address {
        street     @(title : '{i18n>street}');
        city       @(title : '{i18n>city}');
        state      @(title : '{i18n>state}');
        postalCode @(title : '{i18n>postalCode}');
        country    @(title : '{i18n>country}');
    }
};

annotate CommunicationNexus.OutputTypes with @(UI : {

    LineItem   : [
        {Value : MessageType_ID},
        {Value : createdBy},
        {Value : createdAt}
    ],

    /**
     * Object Page
     */

    HeaderInfo : {
        $Type          : 'UI.HeaderInfoType',
        TypeName       : '{i18n>messageType}',
        TypeNamePlural : '{i18n>messageTypes}',
        Title          : {Value : MessageType.name}
    },
    Facets     : [{
        $Type  : 'UI.ReferenceFacet',
        ID     : 'OutputChannels',
        Label  : '{i18n>outputChannels}',
        Target : 'OutputChannels/@UI.LineItem'
    }]
}) {
    ID              @(UI : {Hidden});
    BusinessPartner @(UI : {Hidden});
    MessageType
                    @(
        title  : '{i18n>messageType}',
        Common : {
            Text      : {
                $value                 : MessageType.name,
                ![@UI.TextArrangement] : #TextOnly
            },
            ValueList : {
                $Type          : 'Common.ValueListType',
                CollectionPath : 'VH_MessageTypes',
                Label          : '{i18n>messageTypes}',
                Parameters     : [{
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : MessageType_ID,
                    ValueListProperty : 'ID'
                }]
            }
        }
    );
};

annotate CommunicationNexus.MessageOutputChannels with @(UI : {LineItem : [
    {Value : OutputChannel_ID},
    {Value : createdBy},
    {Value : createdAt}
]}) {
    ID            @(UI : {Hidden});
    OutputType    @(UI : {Hidden});
    OutputChannel @(
        title  : '{i18n>outputChannel}',
        Common : {
            Text      : {
                $value                 : OutputChannel.name,
                ![@UI.TextArrangement] : #TextOnly
            },
            ValueList : {
                $Type          : 'Common.ValueListType',
                CollectionPath : 'VH_OutputChannels',
                Label          : '{i18n>outputChannels}',
                Parameters     : [{
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : OutputChannel_ID,
                    ValueListProperty : 'ID'
                }]
            }
        }
    );
};


annotate CommunicationNexus.VH_MessageTypes with {
    ID @(
        title  : '{i18n>name}',
        Common : {Text : {
            $value                 : name,
            ![@UI.TextArrangement] : #TextOnly
        }}
    )
};

annotate CommunicationNexus.VH_OutputChannels with {
    ID @(
        title  : '{i18n>name}',
        Common : {Text : {
            $value                 : name,
            ![@UI.TextArrangement] : #TextOnly
        }}
    )
};
