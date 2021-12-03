Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761C4466E87
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349776AbhLCAkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:22 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48305 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349738AbhLCAkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:16 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 429075C00CB;
        Thu,  2 Dec 2021 19:36:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 Dec 2021 19:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=96x1pqO6fnniP
        ioI2LtuW2i2E57PHbaeOqcbOR3fj9I=; b=lJrJ8EbuQCp0uOAIDImG6rZsraCUT
        fHStydgzq0GwWEmQlDir1WzZ6Tz9bF0lS7e1ITsIIxHHIzWFxezP6OKCj+fVuzd7
        eL0ErNVsX2mjr3GARTdk9QJZVUZa0W/fehAQWEHwXm6XebCs5F2cYgzLJF2+O+I8
        s8jzp8FOZUJMn3zFiSbNiNeun3EmvBWqDGHmE1wWS8TMXy6oicQr9lARcDofdbSZ
        2m040eK9kQhIi0xjDbttKbbs9AFntgIII2EDSrgrMR7z1WjYgsZaVZILoKGFHZJ8
        Aule5cw6ktPXwXhkIFw94XuwbxsJ/RkEhT0Wt/zm61Jo9ZLoYs+rALD5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=96x1pqO6fnniPioI2LtuW2i2E57PHbaeOqcbOR3fj9I=; b=byN87QM4
        UYn6NH+V3RiHHF4UUx7+ktSdmM47Na5Qh0/3h2IEfR2VYK3OmacrO/4V1Mk0mPp4
        /6akuzAzl0kcweaAoBzqYA4LfBUs05Wcib9vCQDuEY3i5FPdZfcGN52+f9UqPpV/
        gM95PqkxXz5lVtSluDgnBIUm2iOl3DShOXhoTTv476FphljjjNzAWGxaq6xQWWyQ
        Z++8cowJxbwKu5Ss4UX673yXWlWeE8PzWYGGwz0tnxciAzBHdjQHZ2JzFtdCVw8H
        3NMuR0Pl2OGgqp1vUl2h5QXXpMdQ4PG8WoTt7FI5to9/7hWar0U7w+1/wouJ9HXS
        rzCsVfaywsmpsA==
X-ME-Sender: <xms:pGapYd9GLSaqF4kbYgDrVfEiyiZ9Y-f7S7S6wYAgewH7Ioqp-cYyHw>
    <xme:pGapYRujfe6vjyRUpyLVOpENzojcjLylzbIJmNc1VqNRKa4UCp00WMksGYf582rV_
    3Lp8bxKL3Ktc4ZsNr4>
X-ME-Received: <xmr:pGapYbAMTSpqgOwbkZkDrADH8QgFv1xJUlhJik-6-XQe5GxU3Smxco6vKmlH9p3lcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:pGapYRfzV9MLld3gGTDcySQW89m5JpJVzH5Rz23Kaxc_GsEFtM8UEQ>
    <xmx:pGapYSPvUEi-ViUF8EIOUae70xc5Xo9KjUlYPx1hmbDtZgKWBYUX9w>
    <xmx:pGapYTngedC5ns80JUwiQP4IBvdHU8fRAtueCUoSCNnIJwiFU18sPw>
    <xmx:pWapYTiBGE84dBnUTv59pdY6D-Tbd3XJfYRlpFkNFRrBmNJIiCS6wQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:51 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 05/10] x86/fpu: Cache xstate_is_aligned
Date:   Fri,  3 Dec 2021 00:36:31 +0000
Message-Id: <20211203003636.11417-6-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're now calculating xsate addr on fly, we are going to
access xfeature_is_aligned frequently. Cache it to speed up
calculation.

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/kernel/fpu/xstate.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e3ed3d0f3741..df8a70a055a9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -83,6 +83,8 @@ static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
+static bool xstate_is_aligned[XFEATURE_MAX] __ro_after_init =
+	{ [ 0 ... XFEATURE_MAX - 1] = -1};	
 
 /*
  * Return whether the system supports a given xfeature.
@@ -261,10 +263,6 @@ static void __init print_xstate_features(void)
 	WARN_ON(nr >= XFEATURE_MAX);	\
 } while (0)
 
-/*
- * We could cache this like xstate_size[], but we only use
- * it here, so it would be a waste of space.
- */
 static int xfeature_is_aligned(int xfeature_nr)
 {
 	u32 eax, ebx, ecx, edx;
@@ -286,6 +284,18 @@ static int xfeature_is_aligned(int xfeature_nr)
 	return !!(ecx & 2);
 }
 
+/*
+ * Setup a cache to tell if a xstate needs to care alignment:
+ */
+static void __init setup_is_aligned(void)
+{
+	int i;
+
+	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
+		xstate_is_aligned[i] = xfeature_is_aligned(i);
+	}
+}
+
 /*
  * Setup offsets of a supervisor-state-only XSAVES buffer:
  *
@@ -302,7 +312,7 @@ static void __init setup_supervisor_only_offsets(void)
 		if (!xfeature_is_supervisor(i))
 			continue;
 
-		if (xfeature_is_aligned(i))
+		if (xstate_is_aligned[i])
 			next_offset = ALIGN(next_offset, 64);
 
 		xstate_supervisor_only_offsets[i] = next_offset;
@@ -595,7 +605,7 @@ static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 
 	for_each_extended_xfeature(i, xfeatures) {
 		/* Align from the end of the previous feature */
-		if (xfeature_is_aligned(i))
+		if (xstate_is_aligned[i])
 			size = ALIGN(size, 64);
 		/*
 		 * In compacted format the enabled features are packed,
@@ -881,6 +891,7 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 
 	/* Enable xstate instructions to be able to continue with initialization: */
 	fpu__init_cpu_xstate();
+	setup_is_aligned();
 	err = init_xstate_size();
 	if (err)
 		goto out_disable;
@@ -966,7 +977,7 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	/* Calculate compact ext state offsets */
 	offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	for_each_extended_xfeature(i, xsave->header.xcomp_bv) {
-		if (xfeature_is_aligned(i))
+		if (xstate_is_aligned[i])
 			offset = ALIGN(offset, 64);
 
 		if (i == xfeature_nr)
-- 
2.30.2

