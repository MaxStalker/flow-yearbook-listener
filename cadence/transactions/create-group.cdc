import FLOAT, FLOATVerifiers, GrantedAccountAccess from 0x2d4c3caffbeab845
import MetadataViews, NonFungibleToken from 0x1d7e57aa55817448

transaction(groupName: String, image: String, description: String){
    prepare(signer: AuthAccount){
        let events = signer
            .borrow<&FLOAT.FLOATEvents>(from: FLOAT.FLOATEventsStoragePath)
            ?? panic("Could not borrow the FLOATEvents from the signer's account")

        events.createGroup(
            groupName: groupName,
            image: image,
            description: description
        )
    }
}