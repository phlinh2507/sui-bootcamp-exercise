module lesson5::FT_TOKEN {
    use std::option;
    use std::string::{Self, String};
    use sui::url;
    use sui::coin::{Self, CoinMetadata, TreasuryCap, Coin};
    use sui::tx_context::{Self,TxContext};
    use sui::transfer;
    use sui::event;

    struct FT_TOKEN has drop { }

    fun init(witness: FT_TOKEN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<FT_TOKEN>(
            witness,
            2,
            b"EAMON$",
            b"EAMON$",
            b"Token for lesson 04",
            option::some(url::new_unsafe_from_bytes(b"http://facebook.com/eamondang")),
            ctx
        );
        transfer::public_transfer(metadata, tx_context::sender(ctx));
        transfer::public_share_object(treasury_cap);
    }

    public entry fun mint(_: &CoinMetadata<FT_TOKEN>, treasury_cap: &mut TreasuryCap<FT_TOKEN>, amount: u64, recipient: address, ctx: &mut TxContext) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }

    public entry fun burn_token(treasury_cap: &mut TreasuryCap<FT_TOKEN>, coin: Coin<FT_TOKEN>) {
        coin::burn(treasury_cap, coin);
    }

    struct TransferToken has drop,copy {
        success: bool,
        recipient: address,
    }

    public entry fun transfer_token(coin: &mut Coin<FT_TOKEN>, amount: u64, recipient: address, ctx: &mut TxContext) {
        let object_split = split_token(coin, amount, ctx);
        transfer::public_transfer(object_split, recipient)
    }

    public fun split_token(token: &mut Coin<FT_TOKEN>, split_amount: u64, ctx: &mut TxContext): Coin<FT_TOKEN> {
        // -> Coin<T>
        coin::split(token, split_amount, ctx)
    }

    public entry fun update_name() {}
    public entry fun update_description() {}
    public entry fun update_symbol() {}
    public entry fun update_icon_url() {}

    struct UpdateEvent {
        success: bool,
        data: String
    }

    public entry fun get_token_name() {}
    public entry fun get_token_description() {}
    public entry fun get_token_symbol() {}
    public entry fun get_token_icon_url() {}
}
