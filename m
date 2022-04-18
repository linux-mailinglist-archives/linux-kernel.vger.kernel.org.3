Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496E505FED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiDRWxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiDRWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E451EC40;
        Mon, 18 Apr 2022 15:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B44A61183;
        Mon, 18 Apr 2022 22:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AF8C385A1;
        Mon, 18 Apr 2022 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322235;
        bh=xaOypoIvJjWY7Hi3qb369umxIYGBY5vPPLFOPYp1TjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PU7yxwEoKya9qFyf9QYgyad+UHShOn1wMcpfK7M496yHxyjr4LybMWPrUuUKOG/gE
         zGTJTtsHdlafwKvpHY4NPLKRSG3Dx4acqIp/mq4Hwt4T+HUuFecjh6dqOSUki9knbx
         R5sbLW1zkNrQiCgT2vUQoI1+jR4LFskRGYxsVUYafUFkv6AesK9N7HThNayjROylAl
         IurHCEPtcf10wEbkjynL+0kYPp6GMi+WZWUajLA1aUU9i9r91jdBIulyIFOanN99/z
         bejSrD4vRdRWqcew1qguivaPEgr9Z48rg4qe0KypRPKHRdyLESReslYi5RGWqse+UZ
         lbulICVYwSNRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 897EA5C04C6; Mon, 18 Apr 2022 15:50:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Akira Yokosawa <akiyks@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/2] docs: Update RCU cross-references as suggested in doc-guide
Date:   Mon, 18 Apr 2022 15:50:33 -0700
Message-Id: <20220418225033.3944860-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225004.GA3944767@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akira Yokosawa <akiyks@gmail.com>

The RCU documentation contains old-style cross references which
do not follow the best practices outlined in doc-guide/sphinx.rst.
In addition, some of the cross references use URLs that should be replaced
by pathnames.

Update all of these cross references and adjust the surrounding words.

Summary of changes:

  - out-of-date plaintext file names (*.txt) -> *.rst
  - references by :ref: tags -> path names of *.rst
    * use relative paths to .rst files under the RCU/ subdirectory
    * use abs paths of Documentation/xxx for other .rst files
  - references by URL under https://www.kernel.org/ -> paths of *.rst
  - adjust surrounding words of some of updated references.

Note:
  The automarkup.py script interprets references via "*.txt" as if they
were via "*.rst", so the *.txt -> *.rst changes should be regarded as
cleanups rather than bug fixes.

Cc: rcu@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../Design/Data-Structures/Data-Structures.rst |  2 +-
 .../Expedited-Grace-Periods.rst                |  2 +-
 .../RCU/Design/Requirements/Requirements.rst   |  4 ++--
 Documentation/RCU/arrayRCU.rst                 |  4 ++--
 Documentation/RCU/checklist.rst                |  9 ++++-----
 Documentation/RCU/rcu.rst                      | 13 ++++++-------
 Documentation/RCU/rculist_nulls.rst            |  2 +-
 Documentation/RCU/whatisRCU.rst                | 18 ++++++++----------
 8 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index f4efd6897b09..b34990c7c377 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -973,7 +973,7 @@ The ``->dynticks`` field counts the corresponding CPU's transitions to
 and from either dyntick-idle or user mode, so that this counter has an
 even value when the CPU is in dyntick-idle mode or user mode and an odd
 value otherwise. The transitions to/from user mode need to be counted
-for user mode adaptive-ticks support (see timers/NO_HZ.txt).
+for user mode adaptive-ticks support (see Documentation/timers/no_hz.rst).
 
 The ``->rcu_need_heavy_qs`` field is used to record the fact that the
 RCU core code would really like to see a quiescent state from the
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
index 6f89cf1e567d..c9c957c85bac 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
@@ -406,7 +406,7 @@ In earlier implementations, the task requesting the expedited grace
 period also drove it to completion. This straightforward approach had
 the disadvantage of needing to account for POSIX signals sent to user
 tasks, so more recent implemementations use the Linux kernel's
-`workqueues <https://www.kernel.org/doc/Documentation/core-api/workqueue.rst>`__.
+workqueues (see Documentation/core-api/workqueue.rst).
 
 The requesting task still does counter snapshotting and funnel-lock
 processing, but the task reaching the top of the funnel lock does a
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index ff2be1ac54c4..04ed8bf27a0e 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -370,8 +370,8 @@ pointer fetched by rcu_dereference() may not be used outside of the
 outermost RCU read-side critical section containing that
 rcu_dereference(), unless protection of the corresponding data
 element has been passed from RCU to some other synchronization
-mechanism, most commonly locking or `reference
-counting <https://www.kernel.org/doc/Documentation/RCU/rcuref.txt>`__.
+mechanism, most commonly locking or reference counting
+(see ../../rcuref.rst).
 
 .. |high-quality implementation of C11 memory_order_consume [PDF]| replace:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
 .. _high-quality implementation of C11 memory_order_consume [PDF]: http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
diff --git a/Documentation/RCU/arrayRCU.rst b/Documentation/RCU/arrayRCU.rst
index 4051ea3871ef..a5f2ff8fc54c 100644
--- a/Documentation/RCU/arrayRCU.rst
+++ b/Documentation/RCU/arrayRCU.rst
@@ -33,8 +33,8 @@ Situation 1: Hash Tables
 
 Hash tables are often implemented as an array, where each array entry
 has a linked-list hash chain.  Each hash chain can be protected by RCU
-as described in the listRCU.txt document.  This approach also applies
-to other array-of-list situations, such as radix trees.
+as described in listRCU.rst.  This approach also applies to other
+array-of-list situations, such as radix trees.
 
 .. _static_arrays:
 
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index f4545b7c9a63..42cc5d891bd2 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -140,8 +140,7 @@ over a rather long period of time, but improvements are always welcome!
 		prevents destructive compiler optimizations.  However,
 		with a bit of devious creativity, it is possible to
 		mishandle the return value from rcu_dereference().
-		Please see rcu_dereference.txt in this directory for
-		more information.
+		Please see rcu_dereference.rst for more information.
 
 		The rcu_dereference() primitive is used by the
 		various "_rcu()" list-traversal primitives, such
@@ -151,7 +150,7 @@ over a rather long period of time, but improvements are always welcome!
 		primitives.  This is particularly useful in code that
 		is common to readers and updaters.  However, lockdep
 		will complain if you access rcu_dereference() outside
-		of an RCU read-side critical section.  See lockdep.txt
+		of an RCU read-side critical section.  See lockdep.rst
 		to learn what to do about this.
 
 		Of course, neither rcu_dereference() nor the "_rcu()"
@@ -323,7 +322,7 @@ over a rather long period of time, but improvements are always welcome!
 	primitives when the update-side lock is held is that doing so
 	can be quite helpful in reducing code bloat when common code is
 	shared between readers and updaters.  Additional primitives
-	are provided for this case, as discussed in lockdep.txt.
+	are provided for this case, as discussed in lockdep.rst.
 
 	One exception to this rule is when data is only ever added to
 	the linked data structure, and is never removed during any
@@ -480,4 +479,4 @@ over a rather long period of time, but improvements are always welcome!
 	both rcu_barrier() and synchronize_rcu(), if necessary, using
 	something like workqueues to to execute them concurrently.
 
-	See rcubarrier.txt for more information.
+	See rcubarrier.rst for more information.
diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 0e03c6ef3147..3cfe01ba9a49 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -10,9 +10,8 @@ A "grace period" must elapse between the two parts, and this grace period
 must be long enough that any readers accessing the item being deleted have
 since dropped their references.  For example, an RCU-protected deletion
 from a linked list would first remove the item from the list, wait for
-a grace period to elapse, then free the element.  See the
-:ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` for more information on
-using RCU with linked lists.
+a grace period to elapse, then free the element.  See listRCU.rst for more
+information on using RCU with linked lists.
 
 Frequently Asked Questions
 --------------------------
@@ -50,7 +49,7 @@ Frequently Asked Questions
 - If I am running on a uniprocessor kernel, which can only do one
   thing at a time, why should I wait for a grace period?
 
-  See :ref:`Documentation/RCU/UP.rst <up_doc>` for more information.
+  See UP.rst for more information.
 
 - How can I see where RCU is currently used in the Linux kernel?
 
@@ -64,13 +63,13 @@ Frequently Asked Questions
 
 - What guidelines should I follow when writing code that uses RCU?
 
-  See the checklist.txt file in this directory.
+  See checklist.rst.
 
 - Why the name "RCU"?
 
   "RCU" stands for "read-copy update".
-  :ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` has more information on where
-  this name came from, search for "read-copy update" to find it.
+  listRCU.rst has more information on where this name came from, search
+  for "read-copy update" to find it.
 
 - I hear that RCU is patented?  What is with that?
 
diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index a9fc774bc400..ca4692775ad4 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -8,7 +8,7 @@ This section describes how to use hlist_nulls to
 protect read-mostly linked lists and
 objects using SLAB_TYPESAFE_BY_RCU allocations.
 
-Please read the basics in Documentation/RCU/listRCU.rst
+Please read the basics in listRCU.rst.
 
 Using 'nulls'
 =============
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index c34d2212eaca..77ea260efd12 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -224,7 +224,7 @@ synchronize_rcu()
 	be delayed.  This property results in system resilience in face
 	of denial-of-service attacks.  Code using call_rcu() should limit
 	update rate in order to gain this same sort of resilience.  See
-	checklist.txt for some approaches to limiting the update rate.
+	checklist.rst for some approaches to limiting the update rate.
 
 rcu_assign_pointer()
 ^^^^^^^^^^^^^^^^^^^^
@@ -318,7 +318,7 @@ rcu_dereference()
 	must prohibit.	The rcu_dereference_protected() variant takes
 	a lockdep expression to indicate which locks must be acquired
 	by the caller. If the indicated protection is not provided,
-	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
+	a lockdep splat is emitted.  See Design/Requirements/Requirements.rst
 	and the API's code comments for more details and example usage.
 
 .. 	[2] If the list_for_each_entry_rcu() instance might be used by
@@ -399,8 +399,7 @@ for specialized uses, but are relatively uncommon.
 
 This section shows a simple use of the core RCU API to protect a
 global pointer to a dynamically allocated structure.  More-typical
-uses of RCU may be found in :ref:`listRCU.rst <list_rcu_doc>`,
-:ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst <NMI_rcu_doc>`.
+uses of RCU may be found in listRCU.rst, arrayRCU.rst, and NMI-RCU.rst.
 ::
 
 	struct foo {
@@ -482,10 +481,9 @@ So, to sum up:
 	RCU read-side critical sections that might be referencing that
 	data item.
 
-See checklist.txt for additional rules to follow when using RCU.
-And again, more-typical uses of RCU may be found in :ref:`listRCU.rst
-<list_rcu_doc>`, :ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst
-<NMI_rcu_doc>`.
+See checklist.rst for additional rules to follow when using RCU.
+And again, more-typical uses of RCU may be found in listRCU.rst,
+arrayRCU.rst, and NMI-RCU.rst.
 
 .. _4_whatisRCU:
 
@@ -579,7 +577,7 @@ to avoid having to write your own callback::
 
 	kfree_rcu(old_fp, rcu);
 
-Again, see checklist.txt for additional rules governing the use of RCU.
+Again, see checklist.rst for additional rules governing the use of RCU.
 
 .. _5_whatisRCU:
 
@@ -663,7 +661,7 @@ been able to write-acquire the lock otherwise.  The smp_mb__after_spinlock()
 promotes synchronize_rcu() to a full memory barrier in compliance with
 the "Memory-Barrier Guarantees" listed in:
 
-	Documentation/RCU/Design/Requirements/Requirements.rst
+	Design/Requirements/Requirements.rst
 
 It is possible to nest rcu_read_lock(), since reader-writer locks may
 be recursively acquired.  Note also that rcu_read_lock() is immune
-- 
2.31.1.189.g2e36527f23

