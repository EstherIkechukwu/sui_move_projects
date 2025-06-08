module shared::Game{

    public struct Game has key {
        id: UID,
        board: vector<u8>,
        turn: u8,
        x: address,
        o: address,
    }

    public fun new(x: address, o: address, ctx: &mut TxContext) {
        transfer::share_object(Game {
            id: object::new(ctx),
            board: vector[MARK__, MARK__, MARK__, MARK__, MARK__, MARK__, MARK__, MARK__, MARK__],
            turn: 0,
            x,
            o,
        });
    }

   public fun place_mark(game: &mut Game, row: u8, col: u8, ctx: &mut TxContext) {
        assert!(game.ended() == TROPHY_NONE, EAlreadyFinished);
        assert!(row < 3 && col < 3, EInvalidLocation);

        let (me, them, sentinel) = game.next_player();
        assert!(me == ctx.sender(), EWrongPlayer);

        if (game[row, col] != MARK__) {
            abort EAlreadyFilled
        };

        *(&mut game[row, col]) = sentinel;
        game.turn = game.turn + 1;

        let end = game.ended();
        if (end == TROPHY_WIN) {
            transfer::transfer(game.mint_trophy(end, them, ctx), me);
        } else if (end == TROPHY_DRAW) {
            transfer::transfer(game.mint_trophy(end, them, ctx), me);
            transfer::transfer(game.mint_trophy(end, me, ctx), them);
        } else if (end != TROPHY_NONE) {
            abort EInvalidEndState
        }
    }
    


}

