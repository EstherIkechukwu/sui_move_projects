
module wwtbas::wwtbas{

    use sui::transfer::public_transfer;
    use std :: {string, debug, string::String};
    use std :: vector;
    
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

    public struct Quiz has key, store {
        id: UID,
        questions: vector<String>,
    }

    public fun new_quiz(ctx : &mut TxContext){
        let quiz = Quiz{
            id : object::new(ctx),
            questions :vector[],
        };
        debug::print(&quiz);
        transfer::public_transfer(quiz, ctx.sender());
    }

    public fun add_question(quiz: &mut Quiz, question:String){
        let questions = &mut quiz.questions;
        questions.push_back(question);
        debug ::print(questions);
    }

    // public fun get_quiz_size(quiz:Quiz): vector<vector<u8>> {
    //     return quiz.questions.length();
    // }


     #[test]
    fun test_can_add_question() {
        let sender = @0x123;
        let mut scenario = test_scenario::begin(sender);
        let ctx = scenario.ctx();
        let quiz = &mut Quiz{
            id: object::new(ctx),
            questions: vector[],
        };
        debug::print(&quiz);
        let question =  string::utf8(b"What is the capital of Nigeria?");
        quiz.add_question(question);
        assert!(quiz.get_quiz_size = 1, 0);
    }






// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

}
