using {md} from './schema';


context view {
    entity BusinessPartnerOutputs as
        select from md.BusinessPartners {
            *,
            OutputTypes.MessageType.ID                  as messageTypeId,
            OutputTypes.OutputChannels.OutputChannel.ID as outputChannelId
        }
        where
            OutputTypes.OutputChannels.ID is not null
}
