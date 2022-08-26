import FLOAT from "../FLOAT.cdc"
import NonFungibleToken from "../../core-contracts/NonFungibleToken.cdc"
import MetadataViews from "../../core-contracts/MetadataViews.cdc"
import GrantedAccountAccess from "../../sharedaccount/GrantedAccountAccess.cdc"

transaction{
	prepare(signer: AuthAccount) {
        // SETUP COLLECTION
        let storageFloatCollection = FLOAT.FLOATCollectionStoragePath
        if signer.borrow<&FLOAT.Collection>(from: storageFloatCollection) == nil {
            signer.save(<- FLOAT.createEmptyCollection(), to: storageFloatCollection)
            signer.link<&FLOAT.Collection{NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic, MetadataViews.ResolverCollection, FLOAT.CollectionPublic}>
                    (FLOAT.FLOATCollectionPublicPath, target: storageFloatCollection)
        }

        // SETUP FLOATEVENTS
        let storageFloatEvents = FLOAT.FLOATEventsStoragePath
        if signer.borrow<&FLOAT.FLOATEvents>(from: storageFloatEvents) == nil {
          signer.save(<- FLOAT.createEmptyFLOATEventCollection(), to: storageFloatEvents)
          signer.link<&FLOAT.FLOATEvents{FLOAT.FLOATEventsPublic, MetadataViews.ResolverCollection}>
                    (FLOAT.FLOATEventsPublicPath, target: storageFloatEvents)
        }

        // SETUP SHARED MINTING
        let storageGrantedAccess = GrantedAccountAccess.InfoStoragePath
        if signer.borrow<&GrantedAccountAccess.Info>(from: storageGrantedAccess) == nil {
            signer.save(<- GrantedAccountAccess.createInfo(), to: storageGrantedAccess)
            signer.link<&GrantedAccountAccess.Info{GrantedAccountAccess.InfoPublic}>
                    (GrantedAccountAccess.InfoPublicPath, target: storageGrantedAccess)
        }
    }
}