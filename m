Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30E50B53C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446634AbiDVKii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446676AbiDVKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0163ED9A;
        Fri, 22 Apr 2022 03:34:57 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:34:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLGpxpkidQo8fGok8y8h0fEebSqhN3diHXW7D1YeyUw=;
        b=E+B8JHYkglzrSyHNsbgoZJYYsrm/W7vyAsQQW5u/jJfHAlcum/veZtCi6b8kyxn3Ij0U6O
        spUGj+9EkjeDA1sC7Eee+hBJZzPVbHN/TdpLSF4DWvP6SGnN1VlmHHcJtSCKluisBARxc6
        YdBHyt142MiMoIvcEAIrW23pvkNjJR1uQqpbbn70j4OxKWljBkTQG4bybFDqCTsq99lA0R
        G3MGa2Ch/eGTowD4/H6Pp5atubietyjL1fkKM2aB34c3S9xzcvfbf5eJ4ZsekGo7fCrk4p
        7ZLPYHPXmHdn/ZZUXC2PbmBA4yJI3LnHM0Adf5YC/i9zUFSNUw882r4tGEJMnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLGpxpkidQo8fGok8y8h0fEebSqhN3diHXW7D1YeyUw=;
        b=M7hbh7LJEboW0NYaKOh2c62XAI9IJhJzEOoba1MCZZxwFanGV3pRJnr5FhK7jzPVk7mYhD
        eMgDsFVW0A0qHKAg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Update documentation
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b6a84d301d9f73ec6725752654097f4e31fa1b69.1650300597.git.jpoimboe@redhat.com>
References: <b6a84d301d9f73ec6725752654097f4e31fa1b69.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062369543.4207.4187792544269995350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a8e35fece49b16b20de000aab687ca075e4463af
Gitweb:        https://git.kernel.org/tip/a8e35fece49b16b20de000aab687ca075e4463af
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:44 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:05 +02:00

objtool: Update documentation

The objtool documentation is very stack validation centric.  Broaden the
documentation and describe all the features objtool supports.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/b6a84d301d9f73ec6725752654097f4e31fa1b69.1650300597.git.jpoimboe@redhat.com
---
 tools/objtool/Documentation/objtool.txt          | 442 ++++++++++++++-
 tools/objtool/Documentation/stack-validation.txt | 360 +-----------
 2 files changed, 442 insertions(+), 360 deletions(-)
 create mode 100644 tools/objtool/Documentation/objtool.txt
 delete mode 100644 tools/objtool/Documentation/stack-validation.txt

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
new file mode 100644
index 0000000..8a67190
--- /dev/null
+++ b/tools/objtool/Documentation/objtool.txt
@@ -0,0 +1,442 @@
+Objtool
+=======
+
+The kernel CONFIG_OBJTOOL option enables a host tool named 'objtool'
+which runs at compile time.  It can do various validations and
+transformations on .o files.
+
+Objtool has become an integral part of the x86-64 kernel toolchain.  The
+kernel depends on it for a variety of security and performance features
+(and other types of features as well).
+
+
+Features
+--------
+
+Objtool has the following features:
+
+- Stack unwinding metadata validation -- useful for helping to ensure
+  stack traces are reliable for live patching
+
+- ORC unwinder metadata generation -- a faster and more precise
+  alternative to frame pointer based unwinding
+
+- Retpoline validation -- ensures that all indirect calls go through
+  retpoline thunks, for Spectre v2 mitigations
+
+- Retpoline call site annotation -- annotates all retpoline thunk call
+  sites, enabling the kernel to patch them inline, to prevent "thunk
+  funneling" for both security and performance reasons
+
+- Non-instrumentation validation -- validates non-instrumentable
+  ("noinstr") code rules, preventing instrumentation in low-level C
+  entry code
+
+- Static call annotation -- annotates static call sites, enabling the
+  kernel to implement inline static calls, a faster alternative to some
+  indirect branches
+
+- Uaccess validation -- validates uaccess rules for a proper
+  implementation of Supervisor Mode Access Protection (SMAP)
+
+- Straight Line Speculation validation -- validates certain SLS
+  mitigations
+
+- Indirect Branch Tracking validation -- validates Intel CET IBT rules
+  to ensure that all functions referenced by function pointers have
+  corresponding ENDBR instructions
+
+- Indirect Branch Tracking annotation -- annotates unused ENDBR
+  instruction sites, enabling the kernel to "seal" them (replace them
+  with NOPs) to further harden IBT
+
+- Function entry annotation -- annotates function entries, enabling
+  kernel function tracing
+
+- Other toolchain hacks which will go unmentioned at this time...
+
+Each feature can be enabled individually or in combination using the
+objtool cmdline.
+
+
+Objects
+-------
+
+Typically, objtool runs on every translation unit (TU, aka ".o file") in
+the kernel.  If a TU is part of a kernel module, the '--module' option
+is added.
+
+However:
+
+- If noinstr validation is enabled, it also runs on vmlinux.o, with all
+  options removed and '--noinstr' added.
+
+- If IBT or LTO is enabled, it doesn't run on TUs at all.  Instead it
+  runs on vmlinux.o and linked modules, with all options.
+
+In summary:
+
+  A) Legacy mode:
+             TU: objtool [--module] <options>
+        vmlinux: N/A
+         module: N/A
+
+  B) CONFIG_NOINSTR_VALIDATION=y && !(CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y):
+             TU: objtool [--module] <options>	// no --noinstr
+        vmlinux: objtool --noinstr		// other options removed
+         module: N/A
+
+  C) CONFIG_X86_KERNEL_IBT=y || CONFIG_LTO=y:
+             TU: N/A
+        vmlinux: objtool --noinstr <options>
+         module: objtool --module --noinstr <options>
+
+
+Stack validation
+----------------
+
+Objtool's stack validation feature analyzes every .o file and ensures
+the validity of its stack metadata.  It enforces a set of rules on asm
+code and C inline assembly code so that stack traces can be reliable.
+
+For each function, it recursively follows all possible code paths and
+validates the correct frame pointer state at each instruction.
+
+It also follows code paths involving special sections, like
+.altinstructions, __jump_table, and __ex_table, which can add
+alternative execution paths to a given instruction (or set of
+instructions).  Similarly, it knows how to follow switch statements, for
+which gcc sometimes uses jump tables.
+
+Here are some of the benefits of validating stack metadata:
+
+a) More reliable stack traces for frame pointer enabled kernels
+
+   Frame pointers are used for debugging purposes.  They allow runtime
+   code and debug tools to be able to walk the stack to determine the
+   chain of function call sites that led to the currently executing
+   code.
+
+   For some architectures, frame pointers are enabled by
+   CONFIG_FRAME_POINTER.  For some other architectures they may be
+   required by the ABI (sometimes referred to as "backchain pointers").
+
+   For C code, gcc automatically generates instructions for setting up
+   frame pointers when the -fno-omit-frame-pointer option is used.
+
+   But for asm code, the frame setup instructions have to be written by
+   hand, which most people don't do.  So the end result is that
+   CONFIG_FRAME_POINTER is honored for C code but not for most asm code.
+
+   For stack traces based on frame pointers to be reliable, all
+   functions which call other functions must first create a stack frame
+   and update the frame pointer.  If a first function doesn't properly
+   create a stack frame before calling a second function, the *caller*
+   of the first function will be skipped on the stack trace.
+
+   For example, consider the following example backtrace with frame
+   pointers enabled:
+
+     [<ffffffff81812584>] dump_stack+0x4b/0x63
+     [<ffffffff812d6dc2>] cmdline_proc_show+0x12/0x30
+     [<ffffffff8127f568>] seq_read+0x108/0x3e0
+     [<ffffffff812cce62>] proc_reg_read+0x42/0x70
+     [<ffffffff81256197>] __vfs_read+0x37/0x100
+     [<ffffffff81256b16>] vfs_read+0x86/0x130
+     [<ffffffff81257898>] SyS_read+0x58/0xd0
+     [<ffffffff8181c1f2>] entry_SYSCALL_64_fastpath+0x12/0x76
+
+   It correctly shows that the caller of cmdline_proc_show() is
+   seq_read().
+
+   If we remove the frame pointer logic from cmdline_proc_show() by
+   replacing the frame pointer related instructions with nops, here's
+   what it looks like instead:
+
+     [<ffffffff81812584>] dump_stack+0x4b/0x63
+     [<ffffffff812d6dc2>] cmdline_proc_show+0x12/0x30
+     [<ffffffff812cce62>] proc_reg_read+0x42/0x70
+     [<ffffffff81256197>] __vfs_read+0x37/0x100
+     [<ffffffff81256b16>] vfs_read+0x86/0x130
+     [<ffffffff81257898>] SyS_read+0x58/0xd0
+     [<ffffffff8181c1f2>] entry_SYSCALL_64_fastpath+0x12/0x76
+
+   Notice that cmdline_proc_show()'s caller, seq_read(), has been
+   skipped.  Instead the stack trace seems to show that
+   cmdline_proc_show() was called by proc_reg_read().
+
+   The benefit of objtool here is that because it ensures that *all*
+   functions honor CONFIG_FRAME_POINTER, no functions will ever[*] be
+   skipped on a stack trace.
+
+   [*] unless an interrupt or exception has occurred at the very
+       beginning of a function before the stack frame has been created,
+       or at the very end of the function after the stack frame has been
+       destroyed.  This is an inherent limitation of frame pointers.
+
+b) ORC (Oops Rewind Capability) unwind table generation
+
+   An alternative to frame pointers and DWARF, ORC unwind data can be
+   used to walk the stack.  Unlike frame pointers, ORC data is out of
+   band.  So it doesn't affect runtime performance and it can be
+   reliable even when interrupts or exceptions are involved.
+
+   For more details, see Documentation/x86/orc-unwinder.rst.
+
+c) Higher live patching compatibility rate
+
+   Livepatch has an optional "consistency model", which is needed for
+   more complex patches.  In order for the consistency model to work,
+   stack traces need to be reliable (or an unreliable condition needs to
+   be detectable).  Objtool makes that possible.
+
+   For more details, see the livepatch documentation in the Linux kernel
+   source tree at Documentation/livepatch/livepatch.rst.
+
+To achieve the validation, objtool enforces the following rules:
+
+1. Each callable function must be annotated as such with the ELF
+   function type.  In asm code, this is typically done using the
+   ENTRY/ENDPROC macros.  If objtool finds a return instruction
+   outside of a function, it flags an error since that usually indicates
+   callable code which should be annotated accordingly.
+
+   This rule is needed so that objtool can properly identify each
+   callable function in order to analyze its stack metadata.
+
+2. Conversely, each section of code which is *not* callable should *not*
+   be annotated as an ELF function.  The ENDPROC macro shouldn't be used
+   in this case.
+
+   This rule is needed so that objtool can ignore non-callable code.
+   Such code doesn't have to follow any of the other rules.
+
+3. Each callable function which calls another function must have the
+   correct frame pointer logic, if required by CONFIG_FRAME_POINTER or
+   the architecture's back chain rules.  This can by done in asm code
+   with the FRAME_BEGIN/FRAME_END macros.
+
+   This rule ensures that frame pointer based stack traces will work as
+   designed.  If function A doesn't create a stack frame before calling
+   function B, the _caller_ of function A will be skipped on the stack
+   trace.
+
+4. Dynamic jumps and jumps to undefined symbols are only allowed if:
+
+   a) the jump is part of a switch statement; or
+
+   b) the jump matches sibling call semantics and the frame pointer has
+      the same value it had on function entry.
+
+   This rule is needed so that objtool can reliably analyze all of a
+   function's code paths.  If a function jumps to code in another file,
+   and it's not a sibling call, objtool has no way to follow the jump
+   because it only analyzes a single file at a time.
+
+5. A callable function may not execute kernel entry/exit instructions.
+   The only code which needs such instructions is kernel entry code,
+   which shouldn't be be in callable functions anyway.
+
+   This rule is just a sanity check to ensure that callable functions
+   return normally.
+
+
+Objtool warnings
+----------------
+
+For asm files, if you're getting an error which doesn't make sense,
+first make sure that the affected code follows the above rules.
+
+For C files, the common culprits are inline asm statements and calls to
+"noreturn" functions.  See below for more details.
+
+Another possible cause for errors in C code is if the Makefile removes
+-fno-omit-frame-pointer or adds -fomit-frame-pointer to the gcc options.
+
+Here are some examples of common warnings reported by objtool, what
+they mean, and suggestions for how to fix them.  When in doubt, ping
+the objtool maintainers.
+
+
+1. file.o: warning: objtool: func()+0x128: call without frame pointer save/setup
+
+   The func() function made a function call without first saving and/or
+   updating the frame pointer, and CONFIG_FRAME_POINTER is enabled.
+
+   If the error is for an asm file, and func() is indeed a callable
+   function, add proper frame pointer logic using the FRAME_BEGIN and
+   FRAME_END macros.  Otherwise, if it's not a callable function, remove
+   its ELF function annotation by changing ENDPROC to END, and instead
+   use the manual unwind hint macros in asm/unwind_hints.h.
+
+   If it's a GCC-compiled .c file, the error may be because the function
+   uses an inline asm() statement which has a "call" instruction.  An
+   asm() statement with a call instruction must declare the use of the
+   stack pointer in its output operand.  On x86_64, this means adding
+   the ASM_CALL_CONSTRAINT as an output constraint:
+
+     asm volatile("call func" : ASM_CALL_CONSTRAINT);
+
+   Otherwise the stack frame may not get created before the call.
+
+
+2. file.o: warning: objtool: .text+0x53: unreachable instruction
+
+   Objtool couldn't find a code path to reach the instruction.
+
+   If the error is for an asm file, and the instruction is inside (or
+   reachable from) a callable function, the function should be annotated
+   with the ENTRY/ENDPROC macros (ENDPROC is the important one).
+   Otherwise, the code should probably be annotated with the unwind hint
+   macros in asm/unwind_hints.h so objtool and the unwinder can know the
+   stack state associated with the code.
+
+   If you're 100% sure the code won't affect stack traces, or if you're
+   a just a bad person, you can tell objtool to ignore it.  See the
+   "Adding exceptions" section below.
+
+   If it's not actually in a callable function (e.g. kernel entry code),
+   change ENDPROC to END.
+
+
+4. file.o: warning: objtool: func(): can't find starting instruction
+   or
+   file.o: warning: objtool: func()+0x11dd: can't decode instruction
+
+   Does the file have data in a text section?  If so, that can confuse
+   objtool's instruction decoder.  Move the data to a more appropriate
+   section like .data or .rodata.
+
+
+5. file.o: warning: objtool: func()+0x6: unsupported instruction in callable function
+
+   This is a kernel entry/exit instruction like sysenter or iret.  Such
+   instructions aren't allowed in a callable function, and are most
+   likely part of the kernel entry code.  They should usually not have
+   the callable function annotation (ENDPROC) and should always be
+   annotated with the unwind hint macros in asm/unwind_hints.h.
+
+
+6. file.o: warning: objtool: func()+0x26: sibling call from callable instruction with modified stack frame
+
+   This is a dynamic jump or a jump to an undefined symbol.  Objtool
+   assumed it's a sibling call and detected that the frame pointer
+   wasn't first restored to its original state.
+
+   If it's not really a sibling call, you may need to move the
+   destination code to the local file.
+
+   If the instruction is not actually in a callable function (e.g.
+   kernel entry code), change ENDPROC to END and annotate manually with
+   the unwind hint macros in asm/unwind_hints.h.
+
+
+7. file: warning: objtool: func()+0x5c: stack state mismatch
+
+   The instruction's frame pointer state is inconsistent, depending on
+   which execution path was taken to reach the instruction.
+
+   Make sure that, when CONFIG_FRAME_POINTER is enabled, the function
+   pushes and sets up the frame pointer (for x86_64, this means rbp) at
+   the beginning of the function and pops it at the end of the function.
+   Also make sure that no other code in the function touches the frame
+   pointer.
+
+   Another possibility is that the code has some asm or inline asm which
+   does some unusual things to the stack or the frame pointer.  In such
+   cases it's probably appropriate to use the unwind hint macros in
+   asm/unwind_hints.h.
+
+
+8. file.o: warning: objtool: funcA() falls through to next function funcB()
+
+   This means that funcA() doesn't end with a return instruction or an
+   unconditional jump, and that objtool has determined that the function
+   can fall through into the next function.  There could be different
+   reasons for this:
+
+   1) funcA()'s last instruction is a call to a "noreturn" function like
+      panic().  In this case the noreturn function needs to be added to
+      objtool's hard-coded global_noreturns array.  Feel free to bug the
+      objtool maintainer, or you can submit a patch.
+
+   2) funcA() uses the unreachable() annotation in a section of code
+      that is actually reachable.
+
+   3) If funcA() calls an inline function, the object code for funcA()
+      might be corrupt due to a gcc bug.  For more details, see:
+      https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
+
+9. file.o: warning: objtool: funcA() call to funcB() with UACCESS enabled
+
+   This means that an unexpected call to a non-whitelisted function exists
+   outside of arch-specific guards.
+   X86: SMAP (stac/clac): __uaccess_begin()/__uaccess_end()
+   ARM: PAN: uaccess_enable()/uaccess_disable()
+
+   These functions should be called to denote a minimal critical section around
+   access to __user variables. See also: https://lwn.net/Articles/517475/
+
+   The intention of the warning is to prevent calls to funcB() from eventually
+   calling schedule(), potentially leaking the AC flags state, and not
+   restoring them correctly.
+
+   It also helps verify that there are no unexpected calls to funcB() which may
+   access user space pages with protections against doing so disabled.
+
+   To fix, either:
+   1) remove explicit calls to funcB() from funcA().
+   2) add the correct guards before and after calls to low level functions like
+      __get_user_size()/__put_user_size().
+   3) add funcB to uaccess_safe_builtin whitelist in tools/objtool/check.c, if
+      funcB obviously does not call schedule(), and is marked notrace (since
+      function tracing inserts additional calls, which is not obvious from the
+      sources).
+
+10. file.o: warning: func()+0x5c: stack layout conflict in alternatives
+
+    This means that in the use of the alternative() or ALTERNATIVE()
+    macro, the code paths have conflicting modifications to the stack.
+    The problem is that there is only one ORC unwind table, which means
+    that the ORC unwind entries must be consistent for all possible
+    instruction boundaries regardless of which code has been patched.
+    This limitation can be overcome by massaging the alternatives with
+    NOPs to shift the stack changes around so they no longer conflict.
+
+11. file.o: warning: unannotated intra-function call
+
+   This warning means that a direct call is done to a destination which
+   is not at the beginning of a function. If this is a legit call, you
+   can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
+   directive right before the call.
+
+
+If the error doesn't seem to make sense, it could be a bug in objtool.
+Feel free to ask the objtool maintainer for help.
+
+
+Adding exceptions
+-----------------
+
+If you _really_ need objtool to ignore something, and are 100% sure
+that it won't affect kernel stack traces, you can tell objtool to
+ignore it:
+
+- To skip validation of a function, use the STACK_FRAME_NON_STANDARD
+  macro.
+
+- To skip validation of a file, add
+
+    OBJECT_FILES_NON_STANDARD_filename.o := y
+
+  to the Makefile.
+
+- To skip validation of a directory, add
+
+    OBJECT_FILES_NON_STANDARD := y
+
+  to the Makefile.
+
+NOTE: OBJECT_FILES_NON_STANDARD doesn't work for link time validation of
+vmlinux.o or a linked module.  So it should only be used for files which
+aren't linked into vmlinux or a module.
diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
deleted file mode 100644
index 30f38fd..0000000
--- a/tools/objtool/Documentation/stack-validation.txt
+++ /dev/null
@@ -1,360 +0,0 @@
-Compile-time stack metadata validation
-======================================
-
-
-Overview
---------
-
-The kernel CONFIG_STACK_VALIDATION option enables a host tool named
-objtool which runs at compile time.  It has a "check" subcommand which
-analyzes every .o file and ensures the validity of its stack metadata.
-It enforces a set of rules on asm code and C inline assembly code so
-that stack traces can be reliable.
-
-For each function, it recursively follows all possible code paths and
-validates the correct frame pointer state at each instruction.
-
-It also follows code paths involving special sections, like
-.altinstructions, __jump_table, and __ex_table, which can add
-alternative execution paths to a given instruction (or set of
-instructions).  Similarly, it knows how to follow switch statements, for
-which gcc sometimes uses jump tables.
-
-(Objtool also has an 'orc generate' subcommand which generates debuginfo
-for the ORC unwinder.  See Documentation/x86/orc-unwinder.rst in the
-kernel tree for more details.)
-
-
-Why do we need stack metadata validation?
------------------------------------------
-
-Here are some of the benefits of validating stack metadata:
-
-a) More reliable stack traces for frame pointer enabled kernels
-
-   Frame pointers are used for debugging purposes.  They allow runtime
-   code and debug tools to be able to walk the stack to determine the
-   chain of function call sites that led to the currently executing
-   code.
-
-   For some architectures, frame pointers are enabled by
-   CONFIG_FRAME_POINTER.  For some other architectures they may be
-   required by the ABI (sometimes referred to as "backchain pointers").
-
-   For C code, gcc automatically generates instructions for setting up
-   frame pointers when the -fno-omit-frame-pointer option is used.
-
-   But for asm code, the frame setup instructions have to be written by
-   hand, which most people don't do.  So the end result is that
-   CONFIG_FRAME_POINTER is honored for C code but not for most asm code.
-
-   For stack traces based on frame pointers to be reliable, all
-   functions which call other functions must first create a stack frame
-   and update the frame pointer.  If a first function doesn't properly
-   create a stack frame before calling a second function, the *caller*
-   of the first function will be skipped on the stack trace.
-
-   For example, consider the following example backtrace with frame
-   pointers enabled:
-
-     [<ffffffff81812584>] dump_stack+0x4b/0x63
-     [<ffffffff812d6dc2>] cmdline_proc_show+0x12/0x30
-     [<ffffffff8127f568>] seq_read+0x108/0x3e0
-     [<ffffffff812cce62>] proc_reg_read+0x42/0x70
-     [<ffffffff81256197>] __vfs_read+0x37/0x100
-     [<ffffffff81256b16>] vfs_read+0x86/0x130
-     [<ffffffff81257898>] SyS_read+0x58/0xd0
-     [<ffffffff8181c1f2>] entry_SYSCALL_64_fastpath+0x12/0x76
-
-   It correctly shows that the caller of cmdline_proc_show() is
-   seq_read().
-
-   If we remove the frame pointer logic from cmdline_proc_show() by
-   replacing the frame pointer related instructions with nops, here's
-   what it looks like instead:
-
-     [<ffffffff81812584>] dump_stack+0x4b/0x63
-     [<ffffffff812d6dc2>] cmdline_proc_show+0x12/0x30
-     [<ffffffff812cce62>] proc_reg_read+0x42/0x70
-     [<ffffffff81256197>] __vfs_read+0x37/0x100
-     [<ffffffff81256b16>] vfs_read+0x86/0x130
-     [<ffffffff81257898>] SyS_read+0x58/0xd0
-     [<ffffffff8181c1f2>] entry_SYSCALL_64_fastpath+0x12/0x76
-
-   Notice that cmdline_proc_show()'s caller, seq_read(), has been
-   skipped.  Instead the stack trace seems to show that
-   cmdline_proc_show() was called by proc_reg_read().
-
-   The benefit of objtool here is that because it ensures that *all*
-   functions honor CONFIG_FRAME_POINTER, no functions will ever[*] be
-   skipped on a stack trace.
-
-   [*] unless an interrupt or exception has occurred at the very
-       beginning of a function before the stack frame has been created,
-       or at the very end of the function after the stack frame has been
-       destroyed.  This is an inherent limitation of frame pointers.
-
-b) ORC (Oops Rewind Capability) unwind table generation
-
-   An alternative to frame pointers and DWARF, ORC unwind data can be
-   used to walk the stack.  Unlike frame pointers, ORC data is out of
-   band.  So it doesn't affect runtime performance and it can be
-   reliable even when interrupts or exceptions are involved.
-
-   For more details, see Documentation/x86/orc-unwinder.rst.
-
-c) Higher live patching compatibility rate
-
-   Livepatch has an optional "consistency model", which is needed for
-   more complex patches.  In order for the consistency model to work,
-   stack traces need to be reliable (or an unreliable condition needs to
-   be detectable).  Objtool makes that possible.
-
-   For more details, see the livepatch documentation in the Linux kernel
-   source tree at Documentation/livepatch/livepatch.rst.
-
-Rules
------
-
-To achieve the validation, objtool enforces the following rules:
-
-1. Each callable function must be annotated as such with the ELF
-   function type.  In asm code, this is typically done using the
-   ENTRY/ENDPROC macros.  If objtool finds a return instruction
-   outside of a function, it flags an error since that usually indicates
-   callable code which should be annotated accordingly.
-
-   This rule is needed so that objtool can properly identify each
-   callable function in order to analyze its stack metadata.
-
-2. Conversely, each section of code which is *not* callable should *not*
-   be annotated as an ELF function.  The ENDPROC macro shouldn't be used
-   in this case.
-
-   This rule is needed so that objtool can ignore non-callable code.
-   Such code doesn't have to follow any of the other rules.
-
-3. Each callable function which calls another function must have the
-   correct frame pointer logic, if required by CONFIG_FRAME_POINTER or
-   the architecture's back chain rules.  This can by done in asm code
-   with the FRAME_BEGIN/FRAME_END macros.
-
-   This rule ensures that frame pointer based stack traces will work as
-   designed.  If function A doesn't create a stack frame before calling
-   function B, the _caller_ of function A will be skipped on the stack
-   trace.
-
-4. Dynamic jumps and jumps to undefined symbols are only allowed if:
-
-   a) the jump is part of a switch statement; or
-
-   b) the jump matches sibling call semantics and the frame pointer has
-      the same value it had on function entry.
-
-   This rule is needed so that objtool can reliably analyze all of a
-   function's code paths.  If a function jumps to code in another file,
-   and it's not a sibling call, objtool has no way to follow the jump
-   because it only analyzes a single file at a time.
-
-5. A callable function may not execute kernel entry/exit instructions.
-   The only code which needs such instructions is kernel entry code,
-   which shouldn't be be in callable functions anyway.
-
-   This rule is just a sanity check to ensure that callable functions
-   return normally.
-
-
-Objtool warnings
-----------------
-
-For asm files, if you're getting an error which doesn't make sense,
-first make sure that the affected code follows the above rules.
-
-For C files, the common culprits are inline asm statements and calls to
-"noreturn" functions.  See below for more details.
-
-Another possible cause for errors in C code is if the Makefile removes
--fno-omit-frame-pointer or adds -fomit-frame-pointer to the gcc options.
-
-Here are some examples of common warnings reported by objtool, what
-they mean, and suggestions for how to fix them.
-
-
-1. file.o: warning: objtool: func()+0x128: call without frame pointer save/setup
-
-   The func() function made a function call without first saving and/or
-   updating the frame pointer, and CONFIG_FRAME_POINTER is enabled.
-
-   If the error is for an asm file, and func() is indeed a callable
-   function, add proper frame pointer logic using the FRAME_BEGIN and
-   FRAME_END macros.  Otherwise, if it's not a callable function, remove
-   its ELF function annotation by changing ENDPROC to END, and instead
-   use the manual unwind hint macros in asm/unwind_hints.h.
-
-   If it's a GCC-compiled .c file, the error may be because the function
-   uses an inline asm() statement which has a "call" instruction.  An
-   asm() statement with a call instruction must declare the use of the
-   stack pointer in its output operand.  On x86_64, this means adding
-   the ASM_CALL_CONSTRAINT as an output constraint:
-
-     asm volatile("call func" : ASM_CALL_CONSTRAINT);
-
-   Otherwise the stack frame may not get created before the call.
-
-
-2. file.o: warning: objtool: .text+0x53: unreachable instruction
-
-   Objtool couldn't find a code path to reach the instruction.
-
-   If the error is for an asm file, and the instruction is inside (or
-   reachable from) a callable function, the function should be annotated
-   with the ENTRY/ENDPROC macros (ENDPROC is the important one).
-   Otherwise, the code should probably be annotated with the unwind hint
-   macros in asm/unwind_hints.h so objtool and the unwinder can know the
-   stack state associated with the code.
-
-   If you're 100% sure the code won't affect stack traces, or if you're
-   a just a bad person, you can tell objtool to ignore it.  See the
-   "Adding exceptions" section below.
-
-   If it's not actually in a callable function (e.g. kernel entry code),
-   change ENDPROC to END.
-
-
-4. file.o: warning: objtool: func(): can't find starting instruction
-   or
-   file.o: warning: objtool: func()+0x11dd: can't decode instruction
-
-   Does the file have data in a text section?  If so, that can confuse
-   objtool's instruction decoder.  Move the data to a more appropriate
-   section like .data or .rodata.
-
-
-5. file.o: warning: objtool: func()+0x6: unsupported instruction in callable function
-
-   This is a kernel entry/exit instruction like sysenter or iret.  Such
-   instructions aren't allowed in a callable function, and are most
-   likely part of the kernel entry code.  They should usually not have
-   the callable function annotation (ENDPROC) and should always be
-   annotated with the unwind hint macros in asm/unwind_hints.h.
-
-
-6. file.o: warning: objtool: func()+0x26: sibling call from callable instruction with modified stack frame
-
-   This is a dynamic jump or a jump to an undefined symbol.  Objtool
-   assumed it's a sibling call and detected that the frame pointer
-   wasn't first restored to its original state.
-
-   If it's not really a sibling call, you may need to move the
-   destination code to the local file.
-
-   If the instruction is not actually in a callable function (e.g.
-   kernel entry code), change ENDPROC to END and annotate manually with
-   the unwind hint macros in asm/unwind_hints.h.
-
-
-7. file: warning: objtool: func()+0x5c: stack state mismatch
-
-   The instruction's frame pointer state is inconsistent, depending on
-   which execution path was taken to reach the instruction.
-
-   Make sure that, when CONFIG_FRAME_POINTER is enabled, the function
-   pushes and sets up the frame pointer (for x86_64, this means rbp) at
-   the beginning of the function and pops it at the end of the function.
-   Also make sure that no other code in the function touches the frame
-   pointer.
-
-   Another possibility is that the code has some asm or inline asm which
-   does some unusual things to the stack or the frame pointer.  In such
-   cases it's probably appropriate to use the unwind hint macros in
-   asm/unwind_hints.h.
-
-
-8. file.o: warning: objtool: funcA() falls through to next function funcB()
-
-   This means that funcA() doesn't end with a return instruction or an
-   unconditional jump, and that objtool has determined that the function
-   can fall through into the next function.  There could be different
-   reasons for this:
-
-   1) funcA()'s last instruction is a call to a "noreturn" function like
-      panic().  In this case the noreturn function needs to be added to
-      objtool's hard-coded global_noreturns array.  Feel free to bug the
-      objtool maintainer, or you can submit a patch.
-
-   2) funcA() uses the unreachable() annotation in a section of code
-      that is actually reachable.
-
-   3) If funcA() calls an inline function, the object code for funcA()
-      might be corrupt due to a gcc bug.  For more details, see:
-      https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
-
-9. file.o: warning: objtool: funcA() call to funcB() with UACCESS enabled
-
-   This means that an unexpected call to a non-whitelisted function exists
-   outside of arch-specific guards.
-   X86: SMAP (stac/clac): __uaccess_begin()/__uaccess_end()
-   ARM: PAN: uaccess_enable()/uaccess_disable()
-
-   These functions should be called to denote a minimal critical section around
-   access to __user variables. See also: https://lwn.net/Articles/517475/
-
-   The intention of the warning is to prevent calls to funcB() from eventually
-   calling schedule(), potentially leaking the AC flags state, and not
-   restoring them correctly.
-
-   It also helps verify that there are no unexpected calls to funcB() which may
-   access user space pages with protections against doing so disabled.
-
-   To fix, either:
-   1) remove explicit calls to funcB() from funcA().
-   2) add the correct guards before and after calls to low level functions like
-      __get_user_size()/__put_user_size().
-   3) add funcB to uaccess_safe_builtin whitelist in tools/objtool/check.c, if
-      funcB obviously does not call schedule(), and is marked notrace (since
-      function tracing inserts additional calls, which is not obvious from the
-      sources).
-
-10. file.o: warning: func()+0x5c: stack layout conflict in alternatives
-
-    This means that in the use of the alternative() or ALTERNATIVE()
-    macro, the code paths have conflicting modifications to the stack.
-    The problem is that there is only one ORC unwind table, which means
-    that the ORC unwind entries must be consistent for all possible
-    instruction boundaries regardless of which code has been patched.
-    This limitation can be overcome by massaging the alternatives with
-    NOPs to shift the stack changes around so they no longer conflict.
-
-11. file.o: warning: unannotated intra-function call
-
-   This warning means that a direct call is done to a destination which
-   is not at the beginning of a function. If this is a legit call, you
-   can remove this warning by putting the ANNOTATE_INTRA_FUNCTION_CALL
-   directive right before the call.
-
-
-If the error doesn't seem to make sense, it could be a bug in objtool.
-Feel free to ask the objtool maintainer for help.
-
-
-Adding exceptions
------------------
-
-If you _really_ need objtool to ignore something, and are 100% sure
-that it won't affect kernel stack traces, you can tell objtool to
-ignore it:
-
-- To skip validation of a function, use the STACK_FRAME_NON_STANDARD
-  macro.
-
-- To skip validation of a file, add
-
-    OBJECT_FILES_NON_STANDARD_filename.o := y
-
-  to the Makefile.
-
-- To skip validation of a directory, add
-
-    OBJECT_FILES_NON_STANDARD := y
-
-  to the Makefile.
