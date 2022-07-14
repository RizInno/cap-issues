using {md} from './schema';


context view {
    entity BusinessPartnerOutputs as
        select from md.BusinessPartners {
            *,
            OutputTypes.OutputChannel.ID as outputChannelId
        }
}
