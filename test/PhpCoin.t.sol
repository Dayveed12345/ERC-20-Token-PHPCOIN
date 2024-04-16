//SPDX-Lincense-Identifier:MIT
pragma solidity 0.8.25;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {PhpCoin} from "../src/PhpCoin.sol";

contract Phptest is Test {
    PhpCoin Obj_phpcoin;

    function setUp() external {
        Obj_phpcoin = new PhpCoin();
    }

    function testNameIsCorrect() public view {
        assertEq(Obj_phpcoin.name(), "PHPCOIN");
    }

    function testSymbolIsCorrect() public view {
        assertEq(Obj_phpcoin.symbol(), "PCN");
    }

    function testDecimalsIsCorrect() public view {
        assertEq(Obj_phpcoin.decimals(), 18);
    }

    function testTotalSupplyIsCorrect() public view {
        assertEq(Obj_phpcoin.totalSupply(), 100 ether);
    }

    function testBalanceOfIsCorrect() public view {
        assertEq(Obj_phpcoin.totalSupply(), Obj_phpcoin.balanceOf());
    }

    function testSenderCanTransfer() public {
        hoax(address(this), 400);
        Obj_phpcoin.transfer(address(1), 300);
        hoax(address(1), 300);
        assertEq(Obj_phpcoin.balanceOf(), 300);
    }

    function testInsufficientBalance() public {
        vm.expectRevert();
        hoax(address(1), 100);
        Obj_phpcoin.transfer(address(2), 2000000000);
    }

    function testUserCanViewAllowance() public {
        hoax(address(1), 20000);

        // Approve address(2) to spend 200 tokens from address(1)'s balance
        Obj_phpcoin.approve(address(2), 200);

        uint256 value = Obj_phpcoin.allowance(address(1), address(2));

        assertEq(value, 200);
    }

    function testSenderCanWithdrawFromTheApprovedUserAccount() public {
        Obj_phpcoin.approve(address(2), 200);

        Obj_phpcoin.allowance(address(this), address(2));

        
        console.log(Obj_phpcoin.transferFrom(address(this), address(2), 200));

       
        vm.prank(address(2));

       
        assertEq(Obj_phpcoin.balanceOf(), 200);

        // Deduct 200 tokens from address(1) (a prank function)
        vm.prank(address(this));

        // Check if the balance of Obj_phpcoin is 1800 tokens
        assertEq(Obj_phpcoin.balanceOf(), 99999999999999999800);
    }
}
