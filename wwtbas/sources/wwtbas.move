
module wwtbas::wwtbas{

    use sui::object
    //Game Elements
    //Player
    //ScoreBoard
    //Quiz
    // - Question
    // - Options (right option specified)
    // - Answer
    // Game Features
    // submit
    // start
    // reset
    // next
    // Select Option

    public struct Quiz has key, store{
        id: UID,
    }

    public fun new_quiz(ctx : TxContext):Quiz{
        let quiz : Quiz = Quiz{
            id
        };
        quiz
    }
}


// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


