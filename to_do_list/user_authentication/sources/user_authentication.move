
/// Module: user_authentication
module user_authentication::user_authentication;

use sui::object::UID;
use sui::tx_context::{TxContext};
use std::u8;



public struct User_profile has key, store {
    id: UID,
    name: vector<u8>,
    age: u8,
}



// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


