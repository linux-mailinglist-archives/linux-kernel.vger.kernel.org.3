Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D551466E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377798AbhLCAk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:29 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54755 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377778AbhLCAkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:24 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DA6365C03A1;
        Thu,  2 Dec 2021 19:37:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 19:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=whpe0O5FNWuwd
        79JFGbO7kHAMeA0B81wujV4Khs/2nE=; b=g8vK1xTq570aPdG/IeKLi/3QQE0NQ
        88WGg+ooo/ogAPo5bz7r3DJ3Uc5I+yNdCAoSjScZoLQjS1qotPeQosoUZb94lLVm
        mRMw3GTS8a+HjxNh9+ERQaJwfW4QI6DpohGusTNqbQNi25SOBr6DtTAAAuo6t/dp
        i2QnjNNBvr8Ey2xl/YbJse8rCt4DBOKMHVU078V/cN6PM0qIoNUn8cwIzxIJamR1
        qunXB8UkaAJJxHJI9p+qoLusiFE7u/sc2ZBJZW06z1Fbl9a3BNPBRc+FkUzpoMzq
        aNFCFrLDD0+BNlRewjhYRBTeGGGH3d3kTJulvHrW+CUsme0OoE/55axeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=whpe0O5FNWuwd79JFGbO7kHAMeA0B81wujV4Khs/2nE=; b=MWGGckvI
        brzL3Ynw9mQtpYoyiJ029i0uvU9VLhrjMR+7+PB9Mq++xprvEg0hJzgd0rdhzUBh
        P+tCtA8nsdcVK48U00YRiSBe/12fvqjQEdmtEUrbA4+HUA59ktQcopGsGSCCHS7P
        llYuVwrXcs2ZFt3VOYMZCsOqNLF6fwhXEOdVY3UmzQwS1e4S9bDpbI/UPWtRxm0V
        aFpzkxgdJW/oSQNbixf6JkjlYxqX/StvsChQ53g1x0loCGDUY1wpL5t7GsBMjQML
        fqcTMy0wlQvRG5XE8qRRqDb+eAn+9DKUjUOtnq4KZqwWhMj0zwZLlwGetKtfqUwD
        fs5Ut1MRMR40jw==
X-ME-Sender: <xms:rGapYWXO8sYcqLqPIrGzM0kXp2f7pP78oXruHAYsvGHKI483LSE7XA>
    <xme:rGapYSm74v3MFx9Kb-A-EvXa8WbGI2bL5fxAZRil07rK4rrsG3DOoAJuCJG-Jj3gg
    M_ycnugd4Kuo3v0QF8>
X-ME-Received: <xmr:rGapYabe3NwlYAq4ZdGkRm0tEAILkePtxL3khrV0XBamNOfzD35S4-GrUQjq0KdUrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    vdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:rGapYdVc__MMUNO-SEHFkkAalIAFYl-6gaoN4mmXe4KZDwUOnoi3dA>
    <xmx:rGapYQmpwdf4Fbmldi-8yeJYSK9aDuMmluhEHaZoWyT-1XLqJiJUSg>
    <xmx:rGapYSerhf5gOrkY45pqYwj9y0lsR4E8bCKAM43uuJZGfoC4D82lIA>
    <xmx:rGapYa68uCgt7VzG-0rtUV2nkdTTjyJkgrbZXGeAzOSg43qJEgZV2g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:59 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 10/10] x86/fpu: Mark AVX512 xfeatures as kernel dynamic
Date:   Fri,  3 Dec 2021 00:36:36 +0000
Message-Id: <20211203003636.11417-11-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As only a few user space processes use AVX512, only
allocate state buffer for AVX512 when in use can save
some memory.

Also we are going to have heterogeneous processors that
only some cores support AVX512, it can be helpful when
dealing with such processors.

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/include/asm/fpu/xstate.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index d3a8c0855a5d..ac2744732264 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -50,7 +50,8 @@
 #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
 
 /* Features which are dynamically allocated only when in use */
-#define XFEATURE_MASK_KERNEL_DYNAMIC	XFEATURE_MASK_XTILE_DATA
+#define XFEATURE_MASK_KERNEL_DYNAMIC	\
+	(XFEATURE_MASK_AVX512 | XFEATURE_MASK_XTILE_DATA)
 
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
-- 
2.30.2

