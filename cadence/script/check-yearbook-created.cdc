import YearbookMinter from 0x63ffd70144f80d07

pub fun main(userAddress: Address):Bool{
    // checks if we have a yearbook resource in our account
    let yearbookExists = getAccount(userAddress)
        .getCapability(YearbookMinter.publicPath)
        .check<&YearbookMinter.Yearbook>()

    return yearbookExists
}