Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3519466E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347929AbhLCAk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:28 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54755 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377707AbhLCAkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:21 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D60685C0397;
        Thu,  2 Dec 2021 19:36:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 19:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=XgNBgMjDe0R28
        lBI1BidBGIKF+hthdn34tp+rclKXPo=; b=cYR+Y5AWnQMP90Nc3VuD4xSJgcpT/
        qagasNKn2D8mYenKoeMnK8swCU5Z5duxwPHjuPd93ZTFEZK5oIkXEf6aKT3ugFrg
        a7F+chgkIVInqb3e98quVK7Pkf30B1+1br7kbYePAufRc5l+7X4Frm/QrcBaUp3D
        2CKgb+V0E5iFNra2RBpDUbX2qr3u5584TtX/4/+vJfomURMu5atQUbOYfKpe3MPv
        4u30pwUN/tGUPiLWWqluFtVPCmw37O9YMMGQ/TDTiweKXfS+TFiJqHJrDsIipIme
        n32gBTFLzqIFPJYn9o2ErIkkQ599UFzkgmnVpE0VWuPDhdXg4YlTFY7qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=XgNBgMjDe0R28lBI1BidBGIKF+hthdn34tp+rclKXPo=; b=bwPFo2VJ
        x8JSglP0epAf5WS1fXFeYTHywRoI51cp8bXeLJ/VGu2VsA0NFbZNU3SEshCCQBbG
        co7jNoypGFKzP9PbIpcwg3jGiqCFM+OmkJRbRtGpURMhA7V509BNdwq7jGspaUzo
        sJyt3ekgBE5hUyu6yiWUo62pqA+mSkjugj8qOkey9jI+A0hD5rkH9P/iGcnYqECa
        EfbtzQWHVxUIH2CFgRqGjVlMeRuTUPD+NelsdbwLMNqulm46ENJeSKyVtki2Rebq
        p1XYXyEf2sdDqwjnLuTWOT4f7ccpVtZRW2F6pJRonAnxzH/t9xjkcToZCsLTdaZJ
        Qvb825ENG0t5yA==
X-ME-Sender: <xms:qWapYX9qTAUAJHUKsfpECXyNLCiI9r9fUWVazWcbWFPnxHLa3Y8p5g>
    <xme:qWapYTuOQYDEXlD7GHAJ1nWgeCT4ATGHrk65ODjFhbJOMgSpwImQ5l-dGNf-gDbbS
    uDfL2e2s-mr6Ak8Kx4>
X-ME-Received: <xmr:qWapYVDpdsGQI70yxrW0sWd8e_Qug1mupfdHyBZe7jx5RDiZCYtIhUoK7BlnJZsH3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    vdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:qWapYTej4u8zL298xUTmDk-yeafCTwFelHtUoCzVXannWOJEdwxeEA>
    <xmx:qWapYcOsGienNJZW52dOYHXPsFuiplDiLacv9O-4LK680AXfu6VmLQ>
    <xmx:qWapYVldPXxkbZFoAHiO2_l6DvTtvvMP0iCX5KtI_T0Ll4rBp6CLcg>
    <xmx:qWapYdjF8vwxRaImiEBoqnmlIrihJMtEYax-IFeihSN-b2DTtjmdSA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:56 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 08/10] x86/fpu: Don't keep state_size in perm struct
Date:   Fri,  3 Dec 2021 00:36:34 +0000
Message-Id: <20211203003636.11417-9-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we are now calculating kernel fpstate size accroading
to features actually in use, there is no need to keep the
size of states permitted.

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/include/asm/fpu/types.h | 8 --------
 arch/x86/kernel/fpu/core.c       | 1 -
 arch/x86/kernel/fpu/xstate.c     | 8 ++------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 3c06c82ab355..a2cadaa9c305 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -409,14 +409,6 @@ struct fpu_state_perm {
 	 */
 	u64				__state_perm;
 
-	/*
-	 * @__state_size:
-	 *
-	 * The size required for @__state_perm. Only valid to access
-	 * with sighand locked.
-	 */
-	unsigned int			__state_size;
-
 	/*
 	 * @__user_state_size:
 	 *
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 861cbfc51c17..b257e2dac39a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -473,7 +473,6 @@ void fpstate_reset(struct fpu *fpu)
 
 	/* Initialize the permission related info in fpu */
 	fpu->perm.__state_perm		= fpu_kernel_cfg.default_features;
-	fpu->perm.__state_size		= fpu_kernel_cfg.default_size;
 	fpu->perm.__user_state_size	= fpu_user_cfg.default_size;
 }
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 8519a6286d0d..4621b51d1b20 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1590,9 +1590,8 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
 	 * vendors into extending XFD for the pre AMX states, especially
 	 * AVX512.
 	 */
-	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
 	struct fpu *fpu = &current->group_leader->thread.fpu;
-	unsigned int ksize, usize;
+	unsigned int usize;
 	u64 mask;
 	int ret;
 
@@ -1602,7 +1601,6 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
 
 	/* Calculate the resulting kernel state size */
 	mask = permitted | requested;
-	ksize = xstate_calculate_size(mask, compacted);
 
 	/* Calculate the resulting user state size */
 	mask &= XFEATURE_MASK_USER_SUPPORTED;
@@ -1615,7 +1613,6 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
 	/* Pairs with the READ_ONCE() in xstate_get_group_perm() */
 	WRITE_ONCE(fpu->perm.__state_perm, requested);
 	/* Protected by sighand lock */
-	fpu->perm.__state_size = ksize;
 	fpu->perm.__user_state_size = usize;
 	return ret;
 }
@@ -1663,7 +1660,7 @@ static int xstate_request_perm(unsigned long idx)
 int xfd_enable_feature(u64 xfd_err)
 {
 	u64 xfd_event = xfd_err & XFEATURE_MASK_USER_DYNAMIC;
-	unsigned int ksize, usize;
+	unsigned int usize;
 	struct fpu *fpu;
 
 	if (!xfd_event) {
@@ -1681,7 +1678,6 @@ int xfd_enable_feature(u64 xfd_err)
 	}
 
 	fpu = &current->group_leader->thread.fpu;
-	ksize = fpu->perm.__state_size;
 	usize = fpu->perm.__user_state_size;
 	/*
 	 * The feature is permitted. State size is sufficient.  Dropping
-- 
2.30.2

