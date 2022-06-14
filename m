Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA954AD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbiFNJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242541AbiFNJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:48:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6400240935;
        Tue, 14 Jun 2022 02:48:42 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso8608115pjk.0;
        Tue, 14 Jun 2022 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2Bw7QvWJOVrrnpzbTViSqoysvH5xWHEk1K9ZdFNSZ+c=;
        b=PkDcal2woEekRA/f4UoDU0FLKTNyLd9U2PHcharYmC8WVAg5knVNdeQN5fFOYKEiDK
         Vq5uHgWO4DcWgGkpm6SFXyGHxSQM6mGxZm5kZJ1ecSoBuhN8erjuDSiMjVBfSS6Mnw6R
         gMWSQDEAU0TtrlOfoib51Wr3Fp3fP8MOX6u2JbSFFmvVy78/n7QcfJ1Xr3iJgLiLnK7d
         SjoZf9Y5F5M2ro8bWSo8GC/XiW4v8Q/Qdmwx0hUjk6V1ZiKEHSOSrHxazxbOrcAH7Hq0
         4ExXSRtirS9SpuFEusw24aPYMcBNEEBqqx78HZyzHWGYj2cbLHuJcyLJtp7LDATxsb9v
         aRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2Bw7QvWJOVrrnpzbTViSqoysvH5xWHEk1K9ZdFNSZ+c=;
        b=Ys1ASTFyLVyVXBhZcWh0wLs35VfXYfjWwLti7NrLrc2UayEKSEc41cuecA13vJaFl2
         LFHWyczxCJcFT/oOqUxHl304K4w7dEHyQK+jcwSspo2qu2ruuvUzL1lCjrFy14IDVKav
         qrob3x8fS1sOqZeRn0lJ932CK2/YkdAOv4Mf5LxdP5Xd4j3HaMrN0L9gQ2yVFzQAQ5G6
         pK/a5k+it481ti/fqYFbvJvfU2VeGFzsO/8IkIQDQi2ZBf3kObETP7TzjsqcL/30gjgE
         NHLeduPx/CppRPToPKPDUBniKZv8DeARyU9BdH2NmetskHHNYVCj8w2kau4q6QLqwCuC
         iKqQ==
X-Gm-Message-State: AJIora8mpaCJvao0NloFXS65re86f7HorXhOEd5uS/zxIoTE554QgDon
        0AVbgnitcb+u7XJW/Y717Cg=
X-Google-Smtp-Source: AGRyM1tgdNpDHbwFYonb5O6q6X62CciRPqj4MeEMY4hS3r+a2R32kyHuMEm3nV9tQERECg0mNt8U0w==
X-Received: by 2002:a17:902:930c:b0:167:8960:2c39 with SMTP id bc12-20020a170902930c00b0016789602c39mr3557910plb.33.1655200121632;
        Tue, 14 Jun 2022 02:48:41 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n12-20020a63720c000000b003fbb455040dsm7425088pgc.84.2022.06.14.02.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 02:48:41 -0700 (PDT)
Message-ID: <2299ad7f-4f06-1e81-c8ee-b636bd68dd56@gmail.com>
Date:   Tue, 14 Jun 2022 18:48:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH v1 1/2] docs/memory-barriers.txt: Fix confusing name of 'data
 dependency barrier'
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <2fcb021f-2683-53f3-3088-683276aa580c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <2fcb021f-2683-53f3-3088-683276aa580c@gmail.com>
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

To prevent further confusions, do the changes listed below:

  - substitute "data dependency barrier" with "address-dependency
    barrier";
  - add note on the removal of kernel APIs for explicit address-
    dependency barriers in kernel release v5.9;
  - note that address-dependency barriers are not necessary for
    load-to-store situations;
  - use READ_ONCE_OLD() for pre-4.15 READ_ONCE() (no implicit address-
    dependency barrier);
  - fix count of kernel memory barrier APIs;
  - and a few more context adjustments.

Note: Cleanup of long lines are deferred to a followup patch.

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
 Documentation/memory-barriers.txt | 116 ++++++++++++++++--------------
 1 file changed, 64 insertions(+), 52 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index b12df9137e1c..bdbea3cc66a3 100644
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
-     dependency barriers; see the "SMP barrier pairing" subsection.
+     [!] Note that write barriers should normally be paired with read or
+     address-dependency barriers; see the "SMP barrier pairing" subsection.
 
 
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
@@ -550,17 +554,21 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 	    Documentation/core-api/dma-api.rst
 
 
-DATA DEPENDENCY BARRIERS (HISTORICAL)
--------------------------------------
+ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
+----------------------------------------
 
 As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
 DEC Alpha, which means that about the only people who need to pay attention
 to this section are those working on DEC Alpha architecture-specific code
 and those working on READ_ONCE() itself.  For those who need it, and for
 those who are interested in the history, here is the story of
-data-dependency barriers.
+address-dependency barriers.
+
+[!] While address dependencies are observed in both load-to-load and
+load-to-store relations, address-dependency barriers are not necessary
+for load-to-store situations.
 
-The usage requirements of data dependency barriers are a little subtle, and
+The requirement of address-dependency barriers is a little subtle, and
 it's not always obvious that they're needed.  To illustrate, consider the
 following sequence of events:
 
@@ -570,10 +578,13 @@ following sequence of events:
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
@@ -588,8 +599,8 @@ While this may seem like a failure of coherency or causality maintenance, it
 isn't, and this behaviour can be observed on certain real CPUs (such as the DEC
 Alpha).
 
-To deal with this, a data dependency barrier or better must be inserted
-between the address load and the data load:
+To deal with this, READ_ONCE() provides an implicit address-dependency
+barrier since kernel release v4.15:
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -598,7 +609,7 @@ between the address load and the data load:
 	<write barrier>
 	WRITE_ONCE(P, &B);
 			      Q = READ_ONCE(P);
-			      <data dependency barrier>
+			      <implicit address-dependency barrier>
 			      D = *Q;
 
 This enforces the occurrence of one of the two implications, and prevents the
@@ -615,7 +626,7 @@ odd-numbered bank is idle, one can see the new value of the pointer P (&B),
 but the old value of the variable B (2).
 
 
-A data-dependency barrier is not required to order dependent writes
+An address-dependency barrier is not required to order dependent writes
 because the CPUs that the Linux kernel supports don't do writes
 until they are certain (1) that the write will actually happen, (2)
 of the location of the write, and (3) of the value to be written.
@@ -629,12 +640,12 @@ break dependencies in a great many highly creative ways.
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
 
@@ -645,12 +656,12 @@ can be used to record rare error conditions and the like, and the CPUs'
 naturally occurring ordering prevents such records from being lost.
 
 
-Note well that the ordering provided by a data dependency is local to
+Note well that the ordering provided by an address dependency is local to
 the CPU containing it.  See the section on "Multicopy atomicity" for
 more information.
 
 
-The data dependency barrier is very important to the RCU system,
+The address-dependency barrier is very important to the RCU system,
 for example.  See rcu_assign_pointer() and rcu_dereference() in
 include/linux/rcupdate.h.  This permits the current target of an RCU'd
 pointer to be replaced with a new modified target, without the replacement
@@ -667,16 +678,17 @@ not understand them.  The purpose of this section is to help you prevent
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
@@ -927,9 +939,9 @@ General barriers pair with each other, though they also pair with most
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
 
@@ -948,7 +960,7 @@ Or:
 	a = 1;
 	<write barrier>
 	WRITE_ONCE(b, &a);    x = READ_ONCE(b);
-			      <data dependency barrier>
+			      <implicit address-dependency barrier>
 			      y = *x;
 
 Or even:
@@ -968,7 +980,7 @@ Basically, the read barrier always has to be there, even though it can be of
 the "weaker" type.
 
 [!] Note that the stores before the write barrier would normally be expected to
-match the loads after the read barrier or the data dependency barrier, and vice
+match the loads after the read barrier or the address-dependency barrier, and vice
 versa:
 
 	CPU 1                               CPU 2
@@ -1021,7 +1033,7 @@ STORE B, STORE C } all occurring before the unordered set of { STORE D, STORE E
 	                   V
 
 
-Secondly, data dependency barriers act as partial orderings on data-dependent
+Secondly, address-dependency barriers act as partial orderings on address-dependent
 loads.  Consider the following sequence of events:
 
 	CPU 1			CPU 2
@@ -1067,7 +1079,7 @@ effectively random order, despite the write barrier issued by CPU 1:
 In the above example, CPU 2 perceives that B is 7, despite the load of *C
 (which would be B) coming after the LOAD of C.
 
-If, however, a data dependency barrier were to be placed between the load of C
+If, however, an address-dependency barrier were to be placed between the load of C
 and the load of *C (ie: B) on CPU 2:
 
 	CPU 1			CPU 2
@@ -1078,7 +1090,7 @@ and the load of *C (ie: B) on CPU 2:
 	<write barrier>
 	STORE C = &B		LOAD X
 	STORE D = 4		LOAD C (gets &B)
-				<data dependency barrier>
+				<address-dependency barrier>
 				LOAD *C (reads B)
 
 then the following will occur:
@@ -1101,7 +1113,7 @@ then the following will occur:
 	                               |        +-------+       |       |
 	                               |        | X->9  |------>|       |
 	                               |        +-------+       |       |
-	  Makes sure all effects --->   \   ddddddddddddddddd   |       |
+	  Makes sure all effects --->   \   aaaaaaaaaaaaaaaaa   |       |
 	  prior to the store of C        \      +-------+       |       |
 	  are perceptible to              ----->| B->2  |------>|       |
 	  subsequent loads                      +-------+       |       |
@@ -1292,7 +1304,7 @@ Which might appear as this:
 	LOAD with immediate effect              :       :       +-------+
 
 
-Placing a read barrier or a data dependency barrier just before the second
+Placing a read barrier or an address-dependency barrier just before the second
 load:
 
 	CPU 1			CPU 2
@@ -1816,20 +1828,20 @@ which may then reorder things however it wishes.
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
@@ -2888,7 +2900,7 @@ AND THEN THERE'S THE ALPHA
 The DEC Alpha CPU is one of the most relaxed CPUs there is.  Not only that,
 some versions of the Alpha CPU have a split data cache, permitting them to have
 two semantically-related cache lines updated at separate times.  This is where
-the data dependency barrier really becomes necessary as this synchronises both
+the address-dependency barrier really becomes necessary as this synchronises both
 caches with the memory coherence system, thus making it seem like pointer
 changes vs new data occur in the right order.
 
-- 
2.25.1


