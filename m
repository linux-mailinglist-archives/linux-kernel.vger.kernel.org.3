Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7584ECC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350238AbiC3SmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiC3SmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:42:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1076B2DAB1;
        Wed, 30 Mar 2022 11:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84A87B81D51;
        Wed, 30 Mar 2022 18:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45369C340EC;
        Wed, 30 Mar 2022 18:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648665483;
        bh=AHTTgpHE9fw4K0wOKg8Bck1kQmWsSsi/ndtLHELnkFU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lvWagMA2cHDK4vucBJIu6tXnStfxTg8lIPNLO6FY+dVYO8agRYPck4VrBNWyzqIv6
         6G4Ln1eFF62WRTEzTRsHNoDUPv5RQxHXBLVMX0KhhDjX+wrFS6+8dilsNJKyn6HULL
         WgwA78Zmdec0VX/DXycn8UmpQ953zIBGHsq01wNnc7llaHXMecOZRakgNjdzwttu/E
         234IFEYAXmg2FVs8eDaXwMqsgEODs0GZJBRCdcECtBKztqLuwRZjaSFIycaFvYyOgj
         CNLQsRFMSf8ElU6WT1QkCdp2kDgccYRp5p0UiPAwmLsvNtFHmN+GhG0XqD6MIm75lX
         bbpTOx7GB/8jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D449E5C1289; Wed, 30 Mar 2022 11:38:02 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:38:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu] rcu: docs: Update cross-references as suggested in
 doc-guide
Message-ID: <20220330183802.GJ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <22710880-6bf8-261e-d3bc-ad9baaf50f53@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22710880-6bf8-261e-d3bc-ad9baaf50f53@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:41:00PM +0900, Akira Yokosawa wrote:
> There are cross references which are sub-optimal with regard
> to the practices mentioned in doc-guide/sphinx.rst.
> 
> There are also a couple of references to RCU documentation via URL.
> They can be expressed by file paths.
> 
> Update them and adjust surrounding words.
> 
> Summary of changes:
> 
>   - out-of-date plaintext file names (*.txt) -> *.rst
>   - references by :ref: tags -> path names of *.rst
>     * use relative paths to .rst files under the RCU/ subdirectory
>     * use abs paths of Documentation/xxx for other .rst files
>   - references by URL under https://www.kernel.org/ -> paths of *.rst
>   - adjust surrounding words of some of updated references.
> 
> Note:
>   The automarkup.py script interprets references via "*.txt" as if they
> were via "*.rst", so the hyperlinks in the resulting HTML pages works
> without this change.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: rcu@vger.kernel.org
> Cc: linux-doc@vger.kernel.org

Nice!  I have queued these for testing and review, thank you!

(As usual, I could not resist a bit of wordsmithing, so please check
to see if I messed something up.)

							Thanx, Paul

------------------------------------------------------------------------

commit 66150a50090d7bd97d572bc40fd676ab9c1a0d35
Author: Akira Yokosawa <akiyks@gmail.com>
Date:   Wed Mar 30 23:41:00 2022 +0900

    docs: Update RCU cross-references as suggested in doc-guide
    
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
