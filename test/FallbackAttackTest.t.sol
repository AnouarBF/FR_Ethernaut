// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Attack} from "script/FallbackAttack.s.sol";
import {Fallback} from "src/fallback.sol";

contract TestingAttack is Test {

    Attack fallbackAttack;
    Fallback target;
    // address attacker = vm.envAddress("ATTACKER");
    address attacker = address(uint160(vm.envUint("ATTACKER")));

    function setUp() external {
        fallbackAttack = new Attack();
        target = fallbackAttack.run();
    }

    function test_correctOwner() external view {
        assert(target.owner() == attacker);
    }

    function test_noBalance() external view {
        assert(address(target).balance == 0); 
    }
}