Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0124D466E86
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347923AbhLCAkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:18 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35561 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347722AbhLCAkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:14 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 692915C036A;
        Thu,  2 Dec 2021 19:36:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 02 Dec 2021 19:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ZFN2NtW/uqkBK
        4Qsz6Rfpyo3y1BMOmXp42xnPC65bWM=; b=oiQUANSfCTj3oVM5LE2HlNNqQdTRM
        +16e3Nl6721TYnt07Ie+gcs466ksI92cWzeebQuSNspAeIqKgCgOUlrVAJhNPhhR
        vE781/4g9rihENi76dBxVZqTlbg5kCT9btZsoK8lk1RquywU5bMbhMVEGXtqRIsm
        Z7Q2G7H+3knfoe0hehVDTth1AAD25XGDEEuH2I7VxdinOeYqREDTGQCOmpXVCj74
        w9MeSi1gJt8uZbDmeLMEg7cKbZ4YsRs6aOweyEJUjGQm+o91iIXtfsnWvGkUT4A1
        RcBVyaWDOfT4z+Weh/FL4jfh+NYYErQzHHkrwwyu5z4i9uitVXFrA8bLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=ZFN2NtW/uqkBK4Qsz6Rfpyo3y1BMOmXp42xnPC65bWM=; b=R5HishZi
        7mdf1iEgGu1WU/ZAwNM5kOjnQq/kxiNiN1MYunQG0PTbkz9fGvLOKDaJsyXdjZO+
        vyhhTOQjq/PwU5TgRhA4RQKMh6Bk/rh6p4J4vzXYAHmmiBR7zdOj33igYIUeDqbC
        hSajpTx+guiJZURe26z+Wd6Y9S+KRstUQF57c7hJbDbakMNHPvBQ1fDFn89z8EU2
        geYVVvDoEdtO7tBqDS08kZgyrG4dXX4Dl2ddRTct79qYILLLSAAgADhhtDpQ6Qel
        bTggpvoNSa09NhkEkyobtchL0YXlkQXwFITFn9XYCH4WAQXl4TEgaGh0vuzwIuFb
        yTdwXuHDMTE0dw==
X-ME-Sender: <xms:o2apYSL_fCHuw2XXMqTU_jL2V-T_-BpBe_hLJ6-rPY1-wLGN0XK1iQ>
    <xme:o2apYaJJv4bB4UZ3rdY4QA_BV7CVHLLe0U1HzQzMM2S_Xu9pgc8Bv4oUA7Ki-fx28
    HXR1P-hlGJx63yCrWk>
X-ME-Received: <xmr:o2apYSs-UpBBTceEWVe0DTpdJzOftZqqRTGG7WefFTZJy50Ap1lLh4pZvmweVbpfLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:o2apYXaGZjXBliDdvAaGC0viwnienXmK68MVg48LgGUcio7s4VRwnw>
    <xmx:o2apYZYIgV5vLzQWQ58dxkVrq4P4KXtWTcF68-aPTIjaUNStNQZT2w>
    <xmx:o2apYTAI1qnY-iB9xMf36R-qzCninNuBSfO1Hs8jexfHkKhoFOJp6g>
    <xmx:o2apYXMHicwrlYZHKFtQouMnJdz-jkCdz01D1fkWbr6MF8QIZgkASA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:49 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 04/10] x86/fpu: Remove xstate_comp_offsets cache
Date:   Fri,  3 Dec 2021 00:36:30 +0000
Message-Id: <20211203003636.11417-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As xsave addr is now calculated on fly, the cache nolonger works.

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/kernel/fpu/xstate.c | 58 +-----------------------------------
 1 file changed, 1 insertion(+), 57 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 06f6214e9dd7..e3ed3d0f3741 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -81,8 +81,6 @@ static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
-static unsigned int xstate_comp_offsets[XFEATURE_MAX] __ro_after_init =
-	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 static unsigned int xstate_supervisor_only_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
 
@@ -288,49 +286,10 @@ static int xfeature_is_aligned(int xfeature_nr)
 	return !!(ecx & 2);
 }
 
-/*
- * This function sets up offsets and sizes of all extended states in
- * xsave area. This supports both standard format and compacted format
- * of the xsave area.
- */
-static void __init setup_xstate_comp_offsets(void)
-{
-	unsigned int next_offset;
-	int i;
-
-	/*
-	 * The FP xstates and SSE xstates are legacy states. They are always
-	 * in the fixed offsets in the xsave area in either compacted form
-	 * or standard form.
-	 */
-	xstate_comp_offsets[XFEATURE_FP] = 0;
-	xstate_comp_offsets[XFEATURE_SSE] = offsetof(struct fxregs_state,
-						     xmm_space);
-
-	if (!cpu_feature_enabled(X86_FEATURE_XSAVES)) {
-		for_each_extended_xfeature(i, fpu_kernel_cfg.max_features)
-			xstate_comp_offsets[i] = xstate_offsets[i];
-		return;
-	}
-
-	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
-
-	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		if (xfeature_is_aligned(i))
-			next_offset = ALIGN(next_offset, 64);
-
-		xstate_comp_offsets[i] = next_offset;
-		next_offset += xstate_sizes[i];
-	}
-}
-
 /*
  * Setup offsets of a supervisor-state-only XSAVES buffer:
  *
- * The offsets stored in xstate_comp_offsets[] only work for one specific
- * value of the Requested Feature BitMap (RFBM).  In cases where a different
- * RFBM value is used, a different set of offsets is required.  This set of
- * offsets is for when RFBM=xfeatures_mask_supervisor().
+ * This set of offsets is for when RFBM=xfeatures_mask_supervisor().
  */
 static void __init setup_supervisor_only_offsets(void)
 {
@@ -351,19 +310,6 @@ static void __init setup_supervisor_only_offsets(void)
 	}
 }
 
-/*
- * Print out xstate component offsets and sizes
- */
-static void __init print_xstate_offset_size(void)
-{
-	int i;
-
-	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
-		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
-			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
-	}
-}
-
 /*
  * This function is called only during boot time when x86 caps are not set
  * up and alternative can not be used yet.
@@ -950,7 +896,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 				  fpu_user_cfg.max_features);
 
 	setup_init_fpu_buf();
-	setup_xstate_comp_offsets();
 	setup_supervisor_only_offsets();
 
 	/*
@@ -963,7 +908,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
-	print_xstate_offset_size();
 	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
 		fpu_kernel_cfg.max_features,
 		fpu_kernel_cfg.max_size,
-- 
2.30.2

