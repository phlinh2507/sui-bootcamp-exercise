// Hoàn thiện đoạn code để có thể publish được
module lesson5::LINCOIN {
    use sui::url::{Self, Url};
    use std::string::{Self,String};
    use sui::object::{Self, ID, UID};
    use sui::event;
    use sui::coin::{Self,CoinMetadata,TreasuryCap,Coin};
    use std::option;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct LINCOIN has drop { }

    fun init(witness: LINCOIN, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"LINCOIN", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx));
    }

    // hoàn thiện function để có thể tạo ra 10_000 token cho mỗi lần mint, và mỗi owner của token mới có quyền mint
    public entry fun mint(_:&CoinMetadata<LINCOIN>,treasury: &mut coin::TreasuryCap<LINCOIN>, amount: u64, recipient: address, ctx: &mut TxContext) {
        coin::mint_and_transfer(treasury, amount, recipient, ctx);
    }

    // Hoàn thiện function sau để user hoặc ai cũng có quyền tự đốt đi số token đang sở hữu
    public entry fun burn_token(_:&CoinMetadata<LINCOIN>,treasury: &mut coin::TreasuryCap<LINCOIN>, coin:Coin<LINCOIN>) {
            coin::burn(treasury, coin);
    }

    // Hoàn thiện function để chuyển token từ người này sang người khác.
    public entry fun transfer_token(coin :CoinMetadata<LINCOIN>, recipient: address) {
            transfer::public_transfer(coin,recipient);
    }

    // Hoàn thiện function để chia Token Object thành một object khác dùng cho việc transfer
    // gợi ý sử dụng coin:: framework
    public entry fun split_token() {

    }

    // Viết thêm function để token có thể update thông tin sau
    public entry fun update_name() {}
    public entry fun update_description() {}
    public entry fun update_symbol() {}
    public entry fun update_icon_url() {}

    // sử dụng struct này để tạo event cho các function update bên trên.
    struct UpdateEvent {
        success: bool,
        data: String
    }

    // Viết các function để get dữ liệu từ token về để hiển thị
    public entry fun get_token_name() {}
    public entry fun get_token_description() {}
    public entry fun get_token_symbol() {}
    public entry fun get_token_icon_url() {}
}
