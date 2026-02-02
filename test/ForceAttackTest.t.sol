// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {ForceAttack, ForceScript} from "script/ForceAttack.s.sol";
import {Force} from "src/Force.sol";

contract ForceTest is Test {
    ForceScript script;
    Force force;

    function setUp() external {
        script = new ForceScript();
        force = script.run();
    }

    function test_contractBalance() external view {
        assert(address(force).balance >= 0);
    }
}
