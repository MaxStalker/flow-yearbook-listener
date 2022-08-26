import FLOAT, FLOATVerifiers, GrantedAccountAccess from 0x2d4c3caffbeab845
import MetadataViews, NonFungibleToken from 0x1d7e57aa55817448

transaction(name: String, description: String, image: String, url: String){
    prepare(signer: AuthAccount){
        // We can skip borrow check, cause that would be covered by separate tx
        let events = signer
            .borrow<&FLOAT.FloatEvents>(from: FLOAT.FLOATEventsStoragePath)
            ?? panic("Could not borrow the FLOATEvents from the signer")

        events.createEvent(
            claimable: false,
            description: description,
            image: image,
            name: name,
            transferrable: false,
            url: url,
            verifiers: [],
            {}, // extrad metadata can be added here {String: AnyStruct}
            initialGroups:[]
        )
    }
}