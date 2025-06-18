
module wwtbas::wwtbas{

    use sui::transfer::public_transfer;
    use sui::test_scenario::sender;
    use std :: {string, debug, string::String};
    
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
        let quiz : Quiz = Quiz{
            id : object::new(ctx),
            questions :vector<String>[],
        };
        debug::print(&quiz);
        transfer::public_transfer(quiz, ctx.sender());
    }

    public fun add_question(quiz: Quiz, question : string::String){
        quiz.questions.push_back(question);
        debug ::print(&quiz.questions);
    }

    public fun get_question(quiz:Quiz): vector<vector<u8>> {
        return quiz.questions;
    }


     #[test]
    fun test_can_add_question() {
        let sender = @0x123;
        let mut scenario = test_scenario::begin(sender);
        let ctx = scenario.ctx();
        let quiz = Quiz{
            id: object::new(ctx),
            questions: vector<vector<u8>>[],
        };
        debug::print(&quiz);
        let question =  string::utf8(b"What is the capital of Nigeria?");
        quiz.add_question(question);
        assert!(quiz.get_questions().length()>0 , 0);
    }






// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

}
