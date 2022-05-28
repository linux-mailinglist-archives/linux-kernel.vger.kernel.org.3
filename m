Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59695536A85
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 06:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352907AbiE1EPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 00:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiE1EPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 00:15:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF9E20F60;
        Fri, 27 May 2022 21:15:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x2-20020a17090a1f8200b001e07a64c461so8707249pja.4;
        Fri, 27 May 2022 21:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:cc:content-transfer-encoding;
        bh=BEQCAiVt+b2M1pIa6OqOgGzLof4iO2S8RJBM9DqPBrc=;
        b=JWGAJwEI8Wx8hzY02sOHIXaNW/uLkkoIJdaPKcuaoch5dUXzvR0aMi4fnUu5ivZ35P
         c2pov86fHAlsKnRpVflKEV9wwEBKqbvFonEu6VHXS2cdTEicwgF6J0CaW34KjRFbrOz2
         lRH71neMV5ErVWzYDd8VzthnylDyEj444J3F4H6K3kU02NDMjXfWVqovAN/XwZ1e67jN
         q8RAKwL/THVe7UNJVXwS4H/PelDnLQm2a5QXw8OPGR3F8p0KeS3xRE2CHsEUzd1Z8rGO
         vJP00Oe858qGrFbtQBDLcmgG9NCZsZYffqJuVH7P36TbT3BUbqLJDjiehokqZe+QERWq
         2TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:cc:content-transfer-encoding;
        bh=BEQCAiVt+b2M1pIa6OqOgGzLof4iO2S8RJBM9DqPBrc=;
        b=jMrlFB8kFQ44FD1B4gq/utQiuWnvrG/5gGgIa5nZf3AMCN/lQPwZwnkA+DZBw/xb41
         vy1IqPdHLsvrkx7Tx/FXp4qex/ANnnlCqBqzixKaF+NKMcIcRdedC0eDjtuZViT1WT88
         LrVrGYmXPKNZFayh0JfZ+6S+CUOgYVeRQe/MMtwMlAmlw0UqcF1sRdoA5SUWIhSSknYp
         AL1sijkW+8UUv9As7xPMjw0Ht0iaB4UHrIEyct75ij/M/bCLVBUdkos5lsIlWA4DijHC
         vviegaHYLJJMgkpWDmOdtd8BLUKBRZS5NS7FIh7ct78BC3vCLdFx8KzkqG0XHDxGDC6v
         SX3A==
X-Gm-Message-State: AOAM531iWRTAfs9KVrNCuBBkuy00VJwuQMchl/kptaEw92/y4kTB0i42
        itCcTXUj8fPbsc6oRlQ7Wyw=
X-Google-Smtp-Source: ABdhPJydNMCqC2TVbMJ1ZaqZYNrFy5A0720eM/kHOiBFgmeyATUa8e1Mxtmi6Wt7zT4c2HD2Y3F2XA==
X-Received: by 2002:a17:902:ef47:b0:156:646b:58e7 with SMTP id e7-20020a170902ef4700b00156646b58e7mr45473910plx.57.1653711338374;
        Fri, 27 May 2022 21:15:38 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090a014800b001d92e2e5694sm2442213pje.1.2022.05.27.21.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 21:15:37 -0700 (PDT)
Message-ID: <cc2c7885-ac75-24f3-e18a-e77f97c91b4c@gmail.com>
Date:   Sat, 28 May 2022 13:15:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-GB
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [RFC PATCH -lkmm] docs/memory-barriers: Fix inconsistent name of
 'data dependency barrier'
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The term "data dependency barrier", which has been in
memory-barriers.txt ever since it was first authored by David Howells,
has become confusing due to the fact that in LKMM's explanations.txt
and elsewhere, "data dependency" is used mostly for load-to-store data
dependency.

To prevent further confusions, do the following changes:

  - substitute "address-dependency barrier" for "data dependency barrier";
  - add note on the removal of kernel APIs for explicit address-
    dependency barriers in kernel release v5.9;
  - add note on the section title rename;
  - use READ_ONCE_OLD() for READ_ONCE() of pre-4.15 (no address-
    dependency implication) in code snippets;
  - fix number of CPU memory barrier APIs;
  - and a few more context adjustments.

Note: Line break cleanups are deferred to a follow-up patch.

Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
This is a response to Michael's report back in last November [1].

[1]: "data dependency naming inconsistency":
     https://lore.kernel.org/r/20211011064233-mutt-send-email-mst@kernel.org/

In the thread, I suggested removing all the explanations of "data dependency
barriers", which Paul thought was reasonable.

However, such removals would require rewriting the notoriously
hard-to-grasp document, which I'm not quite up to.
I have become more inclined to just substitute "address-dependency
barrier" for "data dependency barrier" considering the fact that
READ_ONCE() has an implicit memory barrier for Alpha.

This RFC patch is the result of such an attempt.

Note: I made a mistake in the thread above. Kernel APIs for explicit data
dependency barriers were removed in v5.9.
I confused the removal with the addition of the barrier to Alpha's
READ_ONCE() in v4.15.

Any feedback is welcome!

        Thanks, Akira
--
 Documentation/memory-barriers.txt | 119 +++++++++++++++++-------------
 1 file changed, 67 insertions(+), 52 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index b12df9137e1c..306afa1f9347 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -52,7 +52,7 @@ CONTENTS
 
      - Varieties of memory barrier.
      - What may not be assumed about memory barriers?
-     - Data dependency barriers (historical).
+     - Address-dependency barriers (historical).
      - Control dependencies.
      - SMP barrier pairing.
      - Examples of memory barrier sequences.
@@ -187,7 +187,7 @@ As a further example, consider this sequence of events:
 	B = 4;		Q = P;
 	P = &B;		D = *Q;
 
-There is an obvious data dependency here, as the value loaded into D depends on
+There is an obvious address dependency here, as the value loaded into D depends on
 the address retrieved from P by CPU 2.  At the end of the sequence, any of the
 following results are possible:
 
@@ -391,49 +391,53 @@ Memory barriers come in four basic varieties:
      memory system as time progresses.  All stores _before_ a write barrier
      will occur _before_ all the stores after the write barrier.
 
-     [!] Note that write barriers should normally be paired with read or data
+     [!] Note that write barriers should normally be paired with read- or address-
      dependency barriers; see the "SMP barrier pairing" subsection.
 
 
- (2) Data dependency barriers.
+ (2) Address-dependency barriers (historical).
 
-     A data dependency barrier is a weaker form of read barrier.  In the case
+     An address-dependency barrier is a weaker form of read barrier.  In the case
      where two loads are performed such that the second depends on the result
      of the first (eg: the first load retrieves the address to which the second
-     load will be directed), a data dependency barrier would be required to
+     load will be directed), an address-dependency barrier would be required to
      make sure that the target of the second load is updated after the address
      obtained by the first load is accessed.
 
-     A data dependency barrier is a partial ordering on interdependent loads
+     An address-dependency barrier is a partial ordering on interdependent loads
      only; it is not required to have any effect on stores, independent loads
      or overlapping loads.
 
      As mentioned in (1), the other CPUs in the system can be viewed as
      committing sequences of stores to the memory system that the CPU being
-     considered can then perceive.  A data dependency barrier issued by the CPU
+     considered can then perceive.  An address-dependency barrier issued by the CPU
      under consideration guarantees that for any load preceding it, if that
      load touches one of a sequence of stores from another CPU, then by the
      time the barrier completes, the effects of all the stores prior to that
-     touched by the load will be perceptible to any loads issued after the data
+     touched by the load will be perceptible to any loads issued after the address-
      dependency barrier.
 
      See the "Examples of memory barrier sequences" subsection for diagrams
      showing the ordering constraints.
 
-     [!] Note that the first load really has to have a _data_ dependency and
+     [!] Note that the first load really has to have an _address_ dependency and
      not a control dependency.  If the address for the second load is dependent
      on the first load, but the dependency is through a conditional rather than
      actually loading the address itself, then it's a _control_ dependency and
      a full read barrier or better is required.  See the "Control dependencies"
      subsection for more information.
 
-     [!] Note that data dependency barriers should normally be paired with
+     [!] Note that address-dependency barriers should normally be paired with
      write barriers; see the "SMP barrier pairing" subsection.
 
+     [!] Kernel release v5.9 removed kernel APIs for explicit address-
+     dependency barriers.  Nowadays, APIs for marking loads from shared
+     variables such as READ_ONCE() and rcu_dereference() provide implicit
+     address-dependency barriers.
 
  (3) Read (or load) memory barriers.
 
-     A read barrier is a data dependency barrier plus a guarantee that all the
+     A read barrier is an address-dependency barrier plus a guarantee that all the
      LOAD operations specified before the barrier will appear to happen before
      all the LOAD operations specified after the barrier with respect to the
      other components of the system.
@@ -441,7 +445,7 @@ Memory barriers come in four basic varieties:
      A read barrier is a partial ordering on loads only; it is not required to
      have any effect on stores.
 
-     Read memory barriers imply data dependency barriers, and so can substitute
+     Read memory barriers imply address-dependency barriers, and so can substitute
      for them.
 
      [!] Note that read barriers should normally be paired with write barriers;
@@ -550,17 +554,24 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	    Documentation/core-api/dma-api.rst
 
 
-DATA DEPENDENCY BARRIERS (HISTORICAL)
--------------------------------------
+ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
+----------------------------------------
 
 As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
 DEC Alpha, which means that about the only people who need to pay attention
 to this section are those working on DEC Alpha architecture-specific code
 and those working on READ_ONCE() itself.  For those who need it, and for
-those who are interested in the history, here is the story of
-data-dependency barriers.
+those who are interested in the history, here is the story of address-
+dependency barriers.
+
+[!] The title of this section was renamed from "DATA DEPENDENCY BARRIERS"
+to prevent developer confusion as "data dependencies" usually refers to
+load-to-store data dependencies.
+While address dependencies are observed in both load-to-load and load-to-
+store relations, address-dependency barriers concern only load-to-load
+situations.
 
-The usage requirements of data dependency barriers are a little subtle, and
+The usage requirements of address-dependency barriers are a little subtle, and
 it's not always obvious that they're needed.  To illustrate, consider the
 following sequence of events:
 
@@ -570,10 +581,13 @@ following sequence of events:
 	B = 4;
 	<write barrier>
 	WRITE_ONCE(P, &B);
-			      Q = READ_ONCE(P);
+			      Q = READ_ONCE_OLD(P);
 			      D = *Q;
 
-There's a clear data dependency here, and it would seem that by the end of the
+[!] READ_ONCE_OLD() corresponds to READ_ONCE() of pre-4.15 kernel, which
+doesn't imply an address-dependency barrier.
+
+There's a clear address dependency here, and it would seem that by the end of the
 sequence, Q must be either &A or &B, and that:
 
 	(Q == &A) implies (D == 1)
@@ -588,8 +602,8 @@ While this may seem like a failure of coherency or causality maintenance, it
 isn't, and this behaviour can be observed on certain real CPUs (such as the DEC
 Alpha).
 
-To deal with this, a data dependency barrier or better must be inserted
-between the address load and the data load:
+To deal with this, an implicit address-dependency barrier of READ_ONCE()
+or better must be inserted between the address load and the data load:
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -598,7 +612,7 @@ between the address load and the data load:
 	<write barrier>
 	WRITE_ONCE(P, &B);
 			      Q = READ_ONCE(P);
-			      <data dependency barrier>
+			      <implicit address-dependency barrier>
 			      D = *Q;
 
 This enforces the occurrence of one of the two implications, and prevents the
@@ -615,7 +629,7 @@ odd-numbered bank is idle, one can see the new value of the pointer P (&B),
 but the old value of the variable B (2).
 
 
-A data-dependency barrier is not required to order dependent writes
+An address-dependency barrier is not required to order dependent writes
 because the CPUs that the Linux kernel supports don't do writes
 until they are certain (1) that the write will actually happen, (2)
 of the location of the write, and (3) of the value to be written.
@@ -629,12 +643,12 @@ break dependencies in a great many highly creative ways.
 	B = 4;
 	<write barrier>
 	WRITE_ONCE(P, &B);
-			      Q = READ_ONCE(P);
+			      Q = READ_ONCE_OLD(P);
 			      WRITE_ONCE(*Q, 5);
 
-Therefore, no data-dependency barrier is required to order the read into
+Therefore, no address-dependency barrier is required to order the read into
 Q with the store into *Q.  In other words, this outcome is prohibited,
-even without a data-dependency barrier:
+even without an implicit address-dependency barrier of modern READ_ONCE():
 
 	(Q == &B) && (B == 4)
 
@@ -645,12 +659,12 @@ can be used to record rare error conditions and the like, and the CPUs'
 naturally occurring ordering prevents such records from being lost.
 
 
-Note well that the ordering provided by a data dependency is local to
+Note well that the ordering provided by an address or a data dependency is local to
 the CPU containing it.  See the section on "Multicopy atomicity" for
 more information.
 
 
-The data dependency barrier is very important to the RCU system,
+The address-dependency barrier is very important to the RCU system,
 for example.  See rcu_assign_pointer() and rcu_dereference() in
 include/linux/rcupdate.h.  This permits the current target of an RCU'd
 pointer to be replaced with a new modified target, without the replacement
@@ -667,16 +681,17 @@ not understand them.  The purpose of this section is to help you prevent
 the compiler's ignorance from breaking your code.
 
 A load-load control dependency requires a full read memory barrier, not
-simply a data dependency barrier to make it work correctly.  Consider the
+simply an (implicit) address-dependency barrier to make it work correctly.  Consider the
 following bit of code:
 
 	q = READ_ONCE(a);
+	<implicit address-dependency barrier>
 	if (q) {
-		<data dependency barrier>  /* BUG: No data dependency!!! */
+		/* BUG: No address dependency!!! */
 		p = READ_ONCE(b);
 	}
 
-This will not have the desired effect because there is no actual data
+This will not have the desired effect because there is no actual address
 dependency, but rather a control dependency that the CPU may short-circuit
 by attempting to predict the outcome in advance, so that other CPUs see
 the load from b as having happened before the load from a.  In such a
@@ -927,9 +942,9 @@ General barriers pair with each other, though they also pair with most
 other types of barriers, albeit without multicopy atomicity.  An acquire
 barrier pairs with a release barrier, but both may also pair with other
 barriers, including of course general barriers.  A write barrier pairs
-with a data dependency barrier, a control dependency, an acquire barrier,
+with an address-dependency barrier, a control dependency, an acquire barrier,
 a release barrier, a read barrier, or a general barrier.  Similarly a
-read barrier, control dependency, or a data dependency barrier pairs
+read barrier, control dependency, or an address-dependency barrier pairs
 with a write barrier, an acquire barrier, a release barrier, or a
 general barrier:
 
@@ -948,7 +963,7 @@ Or:
 	a = 1;
 	<write barrier>
 	WRITE_ONCE(b, &a);    x = READ_ONCE(b);
-			      <data dependency barrier>
+			      <implicit address-dependency barrier>
 			      y = *x;
 
 Or even:
@@ -968,7 +983,7 @@ Basically, the read barrier always has to be there, even though it can be of
 the "weaker" type.
 
 [!] Note that the stores before the write barrier would normally be expected to
-match the loads after the read barrier or the data dependency barrier, and vice
+match the loads after the read barrier or the address-dependency barrier, and vice
 versa:
 
 	CPU 1                               CPU 2
@@ -1021,7 +1036,7 @@ STORE B, STORE C } all occurring before the unordered set of { STORE D, STORE E
 	                   V
 
 
-Secondly, data dependency barriers act as partial orderings on data-dependent
+Secondly, address-dependency barriers act as partial orderings on address-dependent
 loads.  Consider the following sequence of events:
 
 	CPU 1			CPU 2
@@ -1067,7 +1082,7 @@ effectively random order, despite the write barrier issued by CPU 1:
 In the above example, CPU 2 perceives that B is 7, despite the load of *C
 (which would be B) coming after the LOAD of C.
 
-If, however, a data dependency barrier were to be placed between the load of C
+If, however, an address-dependency barrier were to be placed between the load of C
 and the load of *C (ie: B) on CPU 2:
 
 	CPU 1			CPU 2
@@ -1078,7 +1093,7 @@ and the load of *C (ie: B) on CPU 2:
 	<write barrier>
 	STORE C = &B		LOAD X
 	STORE D = 4		LOAD C (gets &B)
-				<data dependency barrier>
+				<address-dependency barrier>
 				LOAD *C (reads B)
 
 then the following will occur:
@@ -1101,7 +1116,7 @@ then the following will occur:
 	                               |        +-------+       |       |
 	                               |        | X->9  |------>|       |
 	                               |        +-------+       |       |
-	  Makes sure all effects --->   \   ddddddddddddddddd   |       |
+	  Makes sure all effects --->   \   aaaaaaaaaaaaaaaaa   |       |
 	  prior to the store of C        \      +-------+       |       |
 	  are perceptible to              ----->| B->2  |------>|       |
 	  subsequent loads                      +-------+       |       |
@@ -1292,7 +1307,7 @@ Which might appear as this:
 	LOAD with immediate effect              :       :       +-------+
 
 
-Placing a read barrier or a data dependency barrier just before the second
+Placing a read barrier or an address-dependency barrier just before the second
 load:
 
 	CPU 1			CPU 2
@@ -1816,20 +1831,20 @@ which may then reorder things however it wishes.
 CPU MEMORY BARRIERS
 -------------------
 
-The Linux kernel has eight basic CPU memory barriers:
+The Linux kernel has seven basic CPU memory barriers:
 
-	TYPE		MANDATORY		SMP CONDITIONAL
-	===============	=======================	===========================
-	GENERAL		mb()			smp_mb()
-	WRITE		wmb()			smp_wmb()
-	READ		rmb()			smp_rmb()
-	DATA DEPENDENCY				READ_ONCE()
+	TYPE			MANDATORY	SMP CONDITIONAL
+	=======================	===============	===============
+	GENERAL			mb()		smp_mb()
+	WRITE			wmb()		smp_wmb()
+	READ			rmb()		smp_rmb()
+	ADDRESS DEPENDENCY			READ_ONCE()
 
 
-All memory barriers except the data dependency barriers imply a compiler
-barrier.  Data dependencies do not impose any additional compiler ordering.
+All memory barriers except the address-dependency barriers imply a compiler
+barrier.  Address dependencies do not impose any additional compiler ordering.
 
-Aside: In the case of data dependencies, the compiler would be expected
+Aside: In the case of address dependencies, the compiler would be expected
 to issue the loads in the correct order (eg. `a[b]` would have to load
 the value of b before loading a[b]), however there is no guarantee in
 the C specification that the compiler may not speculate the value of b
@@ -2888,7 +2903,7 @@ AND THEN THERE'S THE ALPHA
 The DEC Alpha CPU is one of the most relaxed CPUs there is.  Not only that,
 some versions of the Alpha CPU have a split data cache, permitting them to have
 two semantically-related cache lines updated at separate times.  This is where
-the data dependency barrier really becomes necessary as this synchronises both
+the address-dependency barrier really becomes necessary as this synchronises both
 caches with the memory coherence system, thus making it seem like pointer
 changes vs new data occur in the right order.
 

base-commit: 29fe03d9190c37a93b96078e34ddd95344ef8b0f
-- 
2.25.1

