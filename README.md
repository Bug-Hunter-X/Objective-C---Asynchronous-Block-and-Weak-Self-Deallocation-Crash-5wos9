# Objective-C Asynchronous Block and Weak Self Deallocation Crash

This repository demonstrates a common Objective-C bug related to memory management within asynchronous blocks.  The issue occurs when `self` is deallocated before a block completes, leaving a weak reference to `self` (`weakSelf`) as `nil`.  Attempting to use this `nil` reference to modify properties results in a crash.  The solution showcases proper handling to avoid this problem.

## Bug Description
The bug arises from improper handling of `self` within a `dispatch_async` block.  A `__weak` reference is used to prevent retain cycles, but if the view controller or object owning the block deallocates before the block executes, accessing `self` or `weakSelf` leads to a crash. 

## Solution
The solution demonstrates several approaches, including checking for `nil` before accessing `weakSelf` and using a stronger reference to ensure the object persists until the block completes.