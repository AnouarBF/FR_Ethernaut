// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Telephone} from "src/Telephone.sol";
import {TelephoneAttack} from "script/TelephoneAttack.s.sol";

contract TelephoneAttackTest is Test {
    Telephone target;
    address localAttacker = makeAddr("attacker");
    // AttackContract attack;
    TelephoneAttack telephoneAttack;

    function setUp() external {
        telephoneAttack = new TelephoneAttack();
        target = telephoneAttack.run();
        console.log(address(target));
        console.log(target.owner());
    }

    function test_correctTelephoneOwner() external view {
        assert(target.owner() == localAttacker);
    }
}
