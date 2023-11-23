// Hoàn thiện đoạn code để có thể publish được
module lesson5::LINCOIN {
    use sui::url::{Self};
    use std::string::{Self,String};
    use std::ascii;
    use sui::event;
    use sui::coin::{Self,CoinMetadata,Coin};
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
    public entry fun mint(_:&CoinMetadata<LINCOIN>,treasury: &mut coin::TreasuryCap<LINCOIN>,recipient: address, ctx: &mut TxContext) {
        let amount = 10_000;
        coin::mint_and_transfer(treasury, amount, recipient, ctx);
        event::emit(UpdateEvent{
             success: true,
             data: string::utf8(b"success")
        })
    }

    // Hoàn thiện function sau để user hoặc ai cũng có quyền tự đốt đi số token đang sở hữu
    public entry fun burn_token(_:&CoinMetadata<LINCOIN>,treasury: &mut coin::TreasuryCap<LINCOIN>, coin:Coin<LINCOIN>) {
            coin::burn(treasury, coin);
             event::emit(UpdateEvent{
             success: true,
             data: string::utf8(b"success")
        })
    }

    // Hoàn thiện function để chuyển token từ người này sang người khác.
    public entry fun transfer_token(coin :CoinMetadata<LINCOIN>, recipient: address) {
            transfer::public_transfer(coin,recipient);
             event::emit(UpdateEvent{
             success: true,
             data: string::utf8(b"success")
        })
    }

    // Hoàn thiện function để chia Token Object thành một object khác dùng cho việc transfer
    // gợi ý sử dụng coin:: framework
    public fun split_token(coin: &mut Coin<LINCOIN>,amount: u64, ctx: &mut TxContext): coin::Coin<LINCOIN>{
             coin::split<LINCOIN>(coin,amount,ctx)
    }

    // Viết thêm function để token có thể update thông tin sau
    public entry fun update_name(coin : &mut CoinMetadata<LINCOIN>,treasury: &mut coin::TreasuryCap<LINCOIN>, new_name: string::String) {
        coin::update_name<LINCOIN>(treasury,coin,new_name);
    }
    public entry fun update_description(coin : &mut CoinMetadata<LINCOIN>,treasury: &mut coin::TreasuryCap<LINCOIN>, new_description: string::String) {
            coin::update_description<LINCOIN>(treasury, coin, new_description);
    }
    public entry fun update_symbol(coin : &mut CoinMetadata<LINCOIN>,treasury: &mut coin::TreasuryCap<LINCOIN>, new_symbol: ascii::String) {
            coin::update_symbol<LINCOIN>(treasury, coin, new_symbol);
    }
    public entry fun update_icon_url(coin : &mut CoinMetadata<LINCOIN>,treasury: &mut coin::TreasuryCap<LINCOIN>, new_url: ascii::String) {
         coin::update_icon_url<LINCOIN>(treasury, coin, new_url);
    }

    // sử dụng struct này để tạo event cho các function update bên trên.
    struct UpdateEvent has copy, drop{
        success: bool,
        data: String
    }

    // Viết các function để get dữ liệu từ token về để hiển thị
    public entry fun get_token_name(coin : &mut CoinMetadata<LINCOIN>):string::String {
            coin::get_name(coin)
    }
    public entry fun get_token_description(coin : &mut CoinMetadata<LINCOIN>):string::String  {
            coin::get_description(coin)
    }
    public entry fun get_token_symbol(coin : &mut CoinMetadata<LINCOIN>): ascii::String{
            coin::get_symbol(coin)
    }
    public entry fun get_token_icon_url(coin : &mut CoinMetadata<LINCOIN>): option::Option<url::Url> {
            coin::get_icon_url(coin)
    }
}
