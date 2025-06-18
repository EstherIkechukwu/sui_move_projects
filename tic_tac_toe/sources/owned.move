
module tic_tac_toe::tic_tac_toe{

    use sui::transfer::transfer;
    use sui::object::id;

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
}

    public struct Mark has key, store{
        id: UID,
        player: address,
        row: u8,
        col: u8,
    }

    public fun send_mark(cap: TurnCap, row: u8, col: u8, ctx: &mut TxContext) {
        assert!(row <3 && col < 3, ElnvalidLocation);

        let TurnCap { id, game } = cap;
        id.delete();

        let mark = Mark {
            id: object::new(ctx),
            player: ctx.sender(),
            row,
            col,
        };

        event::emit(MarkSent { game, mark: object::id(&mark) });
        transfer::transfer(mark, game.to_address());

    }

    public fun place_mark(game: &mut Game, mark: Receiving<Mark>, ctx: &mut TxContext) {
    assert!(game.ended() == TROPHY_NONE, EAlreadyFinished);

    let Mark { id, row, col, player } = transfer::receive(&mut game.id, mark);
    id.delete();

    let (me, them, sentinel) = game.next_player();
    assert!(me == player, EWrongPlayer);

    if (game[row, col] == MARK__) {
        *(&mut game[row, col]) = sentinel;
        game.turn = game.turn + 1;
    };

    let end = game.ended();
    if (end == TROPHY_WIN) {
        transfer::transfer(game.mint_trophy(end, them, ctx), me);
        event::emit(GameEnd { game: object::id(game) });
    } else if (end == TROPHY_DRAW) {
        transfer::transfer(game.mint_trophy(end, them, ctx), me);
        transfer::transfer(game.mint_trophy(end, me, ctx), them);
        event::emit(GameEnd { game: object::id(game) });
    } else if (end == TROPHY_NONE) {
        let cap = TurnCap { id: object::new(ctx), game: object::id(game) };
        let (to, _, _) = game.next_player();
        transfer::transfer(cap, to);
    } else {
        abort EInvalidEndState
    }
    }
}

    





