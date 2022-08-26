import FLOAT, GrantedAccountAccess from 0x2d4c3caffbeab845
import MetadataViews, NonFungibleToken from 0x1d7e57aa55817448

transaction(host:Address, eventId: UInt64, recipientAddress: Address){
    prepare(signer: AuthAccount){
        // Get reference to FLOAT Events on signer account
        let events = signer
            .borrow<&FLOAT.FLOATEvents>(from: FLOAT.FLOATEventsStoragePath)
            ?? panic("Could not borrow reference to FLOATEvents on signer's account")

		// Get reference to a specific FLOAT Event
		let event = events
		    .borrowEventRef(eventId: eventId)
		    ?? panic("The event with specified eventId doesn't exist")

        let recipient = getAccount(recipientAddress)
            .getCapability(FLOAT.FLOATCollectionPublicPath)
            .borrow<&FLOAT.Collection{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not get reference to public FLOAT Collection recipient's account")

        // Mint FLOAT and transfer it to recipient
        event.mint(recipient: recipient)
    }
}