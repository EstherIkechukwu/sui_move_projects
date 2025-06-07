
module tic_tac_toe::tic_tac_toe{

    public struct Game has key, store {
        id: UID,
        board: vector<u8>,
        turn: u8,
        x: address,
        o: address,
        admin: vector<u8>,
    }

    public fun new_game(x: address, o: address, admin: vector<u8>, ctx: &mut TxContext): Game {{
        let game = Game {
            id: object::new(ctx),
            board: vector[MARK__, MARK__, MARK__, MARK__, MARK__, MARK__, MARK__, MARK__, MARK__],
            turn: 0,
            x,
            o,
            admin,
        }

        let turn = TurnCap {
            id: object::new(ctx),
            game: object::id(&game),
        }

        transfer::transfer(turn, x);
        game
    }


    public struct Mark has key, store{
        id: UID,
        player: address,
        row: u8,
        col: u8,
    }
}




