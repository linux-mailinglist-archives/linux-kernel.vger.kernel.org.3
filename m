Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D02A55126E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiFTITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbiFTITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:19:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC0311A1F;
        Mon, 20 Jun 2022 01:19:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso9584724pja.2;
        Mon, 20 Jun 2022 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lKgZl00LO3baResYPqzv+xZm7bUivTP8lpX1YIhZHWw=;
        b=j+mKt1qVOYyAqIRSbQ9SR6NkWPs9yBthLkg9kgzMM8w7TvKFNQruPa4yXPCEHJchZI
         pM65nbAuwofx7GeLD5Z1Rlfsu4QmpZLCHeFaB2TTsNdDu+K//TRgOy9RCHI9FfapoZEd
         puAfHF7ng8TL9rjx4vShBNr16fj5WhmlqmA0SaUxgPcmH2XN92XlsVhacUEEkrDOMu0O
         nOvDGHRZdBEE1qXymy+snethinLNQc0+Ho77d9jmnvZv51XK99T57hx7qyYKWCInPUon
         qfw+ZnxMM84p6XzsQ6Qz9MJ4t6VsWwxjcxSh/weU4iCMj44aozts/rH4UUFOpRcWsT81
         5V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lKgZl00LO3baResYPqzv+xZm7bUivTP8lpX1YIhZHWw=;
        b=R97TTKbT1eya2sTS6WeLRJZu53i0+Y5mEbyLh1dsk+SH3Mzg0mvsOCr7XgSn/aEs0j
         UZUQ7K/63yfv/v/tOBp2wBORPVvlDH/C+1XjhIRp+HSi7RI3sDajKckaxc7DUL0KN3EN
         SvhKP7UC8R5BPoyleUzhWAQJK50szKHGfExLlwaS88OmgIHbXbqT40oloqiB4h27ujth
         nnX65qPJ/VGLyQ8dT+SGf3WF0N9TxwACJGfuHS7iqHPHXTXCT9drkvXBP44UtIWKKSlO
         YmkTCjxxO4rANrseF7naXQFfRTMH69Y48NI0CwpeiaVrgc/RXM1NCGXeMWvm70sIVmhC
         YoJw==
X-Gm-Message-State: AJIora/MxyzL6Xq58EnJqNq+M6LQtr4mtq5dIyiJZ8HIploNHgqywb3u
        dkJk5lOcUPkT0eKVhoCWI3U=
X-Google-Smtp-Source: AGRyM1v6e1QM4oxNinBtl59HpPjXfnZGXIWqFNmqvt9DTdT9EuUSaC14YLUANweLshlVLzqscv0hXQ==
X-Received: by 2002:a17:90a:7803:b0:1ec:747c:5d1 with SMTP id w3-20020a17090a780300b001ec747c05d1mr18798726pjk.213.1655713180372;
        Mon, 20 Jun 2022 01:19:40 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id nr6-20020a17090b240600b001df82551cf2sm7640086pjb.44.2022.06.20.01.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:19:39 -0700 (PDT)
Message-ID: <2b105cd9-a86a-a6af-4c92-cc1bf0a02706@gmail.com>
Date:   Mon, 20 Jun 2022 17:19:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: [PATCH RESEND v1 2/2] docs/memory-barriers.txt: Fixup long lines
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <a84435e4-5342-f886-4388-e4c5909298a7@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <a84435e4-5342-f886-4388-e4c5909298a7@gmail.com>
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

Substitution of "data dependency barrier" with "address-dependency
barrier" left quite a lot of lines exceeding 80 columns.

Reflow those lines as well as a few short ones not related to
the substitution.

No changes in documentation text.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/memory-barriers.txt | 93 ++++++++++++++++---------------
 1 file changed, 47 insertions(+), 46 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index bdbea3cc66a3..334b37689127 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -187,9 +187,9 @@ As a further example, consider this sequence of events:
 	B = 4;		Q = P;
 	P = &B;		D = *Q;
 
-There is an obvious address dependency here, as the value loaded into D depends on
-the address retrieved from P by CPU 2.  At the end of the sequence, any of the
-following results are possible:
+There is an obvious address dependency here, as the value loaded into D depends
+on the address retrieved from P by CPU 2.  At the end of the sequence, any of
+the following results are possible:
 
 	(Q == &A) and (D == 1)
 	(Q == &B) and (D == 2)
@@ -397,25 +397,25 @@ Memory barriers come in four basic varieties:
 
  (2) Address-dependency barriers (historical).
 
-     An address-dependency barrier is a weaker form of read barrier.  In the case
-     where two loads are performed such that the second depends on the result
-     of the first (eg: the first load retrieves the address to which the second
-     load will be directed), an address-dependency barrier would be required to
-     make sure that the target of the second load is updated after the address
-     obtained by the first load is accessed.
+     An address-dependency barrier is a weaker form of read barrier.  In the
+     case where two loads are performed such that the second depends on the
+     result of the first (eg: the first load retrieves the address to which
+     the second load will be directed), an address-dependency barrier would
+     be required to make sure that the target of the second load is updated
+     after the address obtained by the first load is accessed.
 
-     An address-dependency barrier is a partial ordering on interdependent loads
-     only; it is not required to have any effect on stores, independent loads
-     or overlapping loads.
+     An address-dependency barrier is a partial ordering on interdependent
+     loads only; it is not required to have any effect on stores, independent
+     loads or overlapping loads.
 
      As mentioned in (1), the other CPUs in the system can be viewed as
      committing sequences of stores to the memory system that the CPU being
-     considered can then perceive.  An address-dependency barrier issued by the CPU
-     under consideration guarantees that for any load preceding it, if that
-     load touches one of a sequence of stores from another CPU, then by the
-     time the barrier completes, the effects of all the stores prior to that
-     touched by the load will be perceptible to any loads issued after the address-
-     dependency barrier.
+     considered can then perceive.  An address-dependency barrier issued by
+     the CPU under consideration guarantees that for any load preceding it,
+     if that load touches one of a sequence of stores from another CPU, then
+     by the time the barrier completes, the effects of all the stores prior to
+     that touched by the load will be perceptible to any loads issued after
+     the address-dependency barrier.
 
      See the "Examples of memory barrier sequences" subsection for diagrams
      showing the ordering constraints.
@@ -437,16 +437,16 @@ Memory barriers come in four basic varieties:
 
  (3) Read (or load) memory barriers.
 
-     A read barrier is an address-dependency barrier plus a guarantee that all the
-     LOAD operations specified before the barrier will appear to happen before
-     all the LOAD operations specified after the barrier with respect to the
-     other components of the system.
+     A read barrier is an address-dependency barrier plus a guarantee that all
+     the LOAD operations specified before the barrier will appear to happen
+     before all the LOAD operations specified after the barrier with respect to
+     the other components of the system.
 
      A read barrier is a partial ordering on loads only; it is not required to
      have any effect on stores.
 
-     Read memory barriers imply address-dependency barriers, and so can substitute
-     for them.
+     Read memory barriers imply address-dependency barriers, and so can
+     substitute for them.
 
      [!] Note that read barriers should normally be paired with write barriers;
      see the "SMP barrier pairing" subsection.
@@ -584,8 +584,8 @@ following sequence of events:
 [!] READ_ONCE_OLD() corresponds to READ_ONCE() of pre-4.15 kernel, which
 doesn't imply an address-dependency barrier.
 
-There's a clear address dependency here, and it would seem that by the end of the
-sequence, Q must be either &A or &B, and that:
+There's a clear address dependency here, and it would seem that by the end of
+the sequence, Q must be either &A or &B, and that:
 
 	(Q == &A) implies (D == 1)
 	(Q == &B) implies (D == 4)
@@ -599,8 +599,8 @@ While this may seem like a failure of coherency or causality maintenance, it
 isn't, and this behaviour can be observed on certain real CPUs (such as the DEC
 Alpha).
 
-To deal with this, READ_ONCE() provides an implicit address-dependency
-barrier since kernel release v4.15:
+To deal with this, READ_ONCE() provides an implicit address-dependency barrier
+since kernel release v4.15:
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -627,12 +627,12 @@ but the old value of the variable B (2).
 
 
 An address-dependency barrier is not required to order dependent writes
-because the CPUs that the Linux kernel supports don't do writes
-until they are certain (1) that the write will actually happen, (2)
-of the location of the write, and (3) of the value to be written.
+because the CPUs that the Linux kernel supports don't do writes until they
+are certain (1) that the write will actually happen, (2) of the location of
+the write, and (3) of the value to be written.
 But please carefully read the "CONTROL DEPENDENCIES" section and the
-Documentation/RCU/rcu_dereference.rst file:  The compiler can and does
-break dependencies in a great many highly creative ways.
+Documentation/RCU/rcu_dereference.rst file:  The compiler can and does break
+dependencies in a great many highly creative ways.
 
 	CPU 1		      CPU 2
 	===============	      ===============
@@ -678,8 +678,8 @@ not understand them.  The purpose of this section is to help you prevent
 the compiler's ignorance from breaking your code.
 
 A load-load control dependency requires a full read memory barrier, not
-simply an (implicit) address-dependency barrier to make it work correctly.  Consider the
-following bit of code:
+simply an (implicit) address-dependency barrier to make it work correctly.
+Consider the following bit of code:
 
 	q = READ_ONCE(a);
 	<implicit address-dependency barrier>
@@ -691,8 +691,8 @@ following bit of code:
 This will not have the desired effect because there is no actual address
 dependency, but rather a control dependency that the CPU may short-circuit
 by attempting to predict the outcome in advance, so that other CPUs see
-the load from b as having happened before the load from a.  In such a
-case what's actually required is:
+the load from b as having happened before the load from a.  In such a case
+what's actually required is:
 
 	q = READ_ONCE(a);
 	if (q) {
@@ -980,8 +980,8 @@ Basically, the read barrier always has to be there, even though it can be of
 the "weaker" type.
 
 [!] Note that the stores before the write barrier would normally be expected to
-match the loads after the read barrier or the address-dependency barrier, and vice
-versa:
+match the loads after the read barrier or the address-dependency barrier, and
+vice versa:
 
 	CPU 1                               CPU 2
 	===================                 ===================
@@ -1033,8 +1033,8 @@ STORE B, STORE C } all occurring before the unordered set of { STORE D, STORE E
 	                   V
 
 
-Secondly, address-dependency barriers act as partial orderings on address-dependent
-loads.  Consider the following sequence of events:
+Secondly, address-dependency barriers act as partial orderings on address-
+dependent loads.  Consider the following sequence of events:
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -1079,8 +1079,8 @@ effectively random order, despite the write barrier issued by CPU 1:
 In the above example, CPU 2 perceives that B is 7, despite the load of *C
 (which would be B) coming after the LOAD of C.
 
-If, however, an address-dependency barrier were to be placed between the load of C
-and the load of *C (ie: B) on CPU 2:
+If, however, an address-dependency barrier were to be placed between the load
+of C and the load of *C (ie: B) on CPU 2:
 
 	CPU 1			CPU 2
 	=======================	=======================
@@ -2760,7 +2760,8 @@ is discarded from the CPU's cache and reloaded.  To deal with this, the
 appropriate part of the kernel must invalidate the overlapping bits of the
 cache on each CPU.
 
-See Documentation/core-api/cachetlb.rst for more information on cache management.
+See Documentation/core-api/cachetlb.rst for more information on cache
+management.
 
 
 CACHE COHERENCY VS MMIO
@@ -2900,8 +2901,8 @@ AND THEN THERE'S THE ALPHA
 The DEC Alpha CPU is one of the most relaxed CPUs there is.  Not only that,
 some versions of the Alpha CPU have a split data cache, permitting them to have
 two semantically-related cache lines updated at separate times.  This is where
-the address-dependency barrier really becomes necessary as this synchronises both
-caches with the memory coherence system, thus making it seem like pointer
+the address-dependency barrier really becomes necessary as this synchronises
+both caches with the memory coherence system, thus making it seem like pointer
 changes vs new data occur in the right order.
 
 The Alpha defines the Linux kernel's memory model, although as of v4.15
-- 
2.25.1


