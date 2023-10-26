// hoàn thiện code để module có thể publish được
module lesson6::hero_game {
    // Điền thêm các ability phù hợp cho các object
    struct Hero {
        id: UID,
        name: String,
        hp: u64,
        experience: u64,
    }

    // Điền thêm các ability phù hợp cho các object
    struct Sword {
        id: UID,
        attack: u64,
        strenght: u64,
    }

    // Điền thêm các ability phù hợp cho các object
    struct Armor {
        id: UID,
        defense: u64,
    }

    // Điền thêm các ability phù hợp cho các object
    struct Monter {
        id: UID,
        hp: u64,
        strenght: u64,
    }

    struct GameInfo {
        id: UID,
        admin: address
    }

    // hoàn thiện function để khởi tạo 1 game mới
    fun init(ctx: &mut TxContext) {

    }

    // function để create các vật phẩm, nhân vật trong game.
    fun create_hero() {}
    fun create_sword() {}
    fun create_armor() {}

    // function để create quái vật, chiến đấu với hero, chỉ admin mới có quyền sử dụng function này
    // Gợi ý: khởi tạo thêm 1 object admin.
    fun create_monter() {}

    // func để tăng điểm kinh nghiệm cho hero sau khi giết được quái vật
    fun level_up_hero() {}
    fun level_up_sword() {}
    fun level_up_armor() {}

    // Tấn công, hoàn thiện function để hero và monter đánh nhau
    // gợi ý: kiểm tra số điểm hp và strength của hero và monter, lấy hp trừ đi số sức mạnh mỗi lần tấn công. HP của ai về 0 trước người đó thua
    public entry fun attack_monter() {}
}
