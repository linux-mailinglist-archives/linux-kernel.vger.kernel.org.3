Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9FC466E88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377780AbhLCAkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:24 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50693 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347771AbhLCAkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D89A15C0396;
        Thu,  2 Dec 2021 19:36:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 02 Dec 2021 19:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=7m6Nw47VAqFPl
        X2swNWroGLQO3lk9qBzjGKx5WoRxsc=; b=xNpt6TCjTrIRkP/e9UMKLhpFv3FPh
        HgGivRWlQj+o52jdkhuym5Ip9ar1gFCop0q5fy4g0WWIZrJ+GQnTq/YFvdGRvt7v
        NtZiSFKkSVysgecavh9QSsRN6T6QyEpDrodCoH4sDCscGMJW108CFhXI6Dv2JBx+
        DoV1vhJCnSGY4OplzZB29dtxYZhuf7wsjzrDMpNTfAvYUXmxD5r1QbKt+hbuX/W1
        R3Yx1XgaJI0ffOEALN/tUogzdXj9t1Ig1h6yJUe0iLPJDrpB7K6e+9KtUBCnI55J
        FDNFXhOXDpI+tOzKD/ok6F7YacS/391AfTRMPp3AvB+GUxlVAz9l0g39w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7m6Nw47VAqFPlX2swNWroGLQO3lk9qBzjGKx5WoRxsc=; b=nBKWcdts
        xniQ5LzhJjLMgPXi/L4aEl4KuANneeUBF80GsmR5Hg1JgUzfdFElEUYNLT73rxUX
        Y9FA+BSUyAJqPpia3oKhm7XXJEEzLbhP3X6cGbQ2rPi4td9IV5P9vMOiFXZ8P0UH
        ZCssfx/jQJ0udJXc5p6svB2U8Xq+vRc8fgaCRJc1biXKTRexyuovVaBlh/fRf6T3
        sO+DTF6SxE7U/Dss+2LG7/B5DqxIoeODcJGZNybHGYSk2tuNpsFAiQlrXBaij85V
        oM+1HnMX8ntGj8wpBenAza6WJLqUr0nGtiFYrb4F4U9JA7dV+DoFIro2aqdeoUwP
        0wA789fZgUcEkg==
X-ME-Sender: <xms:pmapYedP7cU-BvijGpUsDujjecp6SBjbN2FGh60qtHkLMCEgfwJ3tQ>
    <xme:pmapYYOrvr695p-rG1NNGKMgkM1v1nYQIy8mzxIcV_v48HDQ7AUBIWzDMvxtV5kfI
    5NU3zaIV9Tim0n5xRs>
X-ME-Received: <xmr:pmapYfgQazPN0tmvMQBLCFLYs5JiN2EV7qwY_xGNEyV5ktVbedjJyL_kbisaFemWww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:pmapYb91WA9q9FyxJ--gNBmHw89D5YPznMEqpwQRWZGS7WO3K8iZCA>
    <xmx:pmapYauAy2zRNwXjm8y8DBqlXgJimF2GzdaJsH75gP75BByaDUkI7Q>
    <xmx:pmapYSEHypDb81Un22T-rtm57dRXuiMouNbTk4l0CHpsFrL2tYPxeQ>
    <xmx:pmapYYAnYMzmmDX_wRmhFXQllPPrkBNPlC90FA-ZvY0vM4u2Pk1rVQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:53 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 06/10] x86/fpu/xcr: Return all enabled xfeature if CPU doesn't support
Date:   Fri,  3 Dec 2021 00:36:32 +0000
Message-Id: <20211203003636.11417-7-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read from XCR0 when CPU doesn't support X86_FEATURE_XGETBV1.
It just assumes that all enabled features are in use.

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/include/asm/fpu/xcr.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xcr.h b/arch/x86/include/asm/fpu/xcr.h
index 9656a5bc6fea..e718074ef141 100644
--- a/arch/x86/include/asm/fpu/xcr.h
+++ b/arch/x86/include/asm/fpu/xcr.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_FPU_XCR_H
 #define _ASM_X86_FPU_XCR_H
 
+#include <asm/alternative.h>
+
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
 #define XCR_XFEATURE_IN_USE_MASK	0x00000001
 
@@ -25,11 +27,21 @@ static inline void xsetbv(u32 index, u64 value)
  * Return a mask of xfeatures which are currently being tracked
  * by the processor as being in the initial configuration.
  *
- * Callers should check X86_FEATURE_XGETBV1.
+ * It will return XCR0, which is all enabled xfeatures in case
+ * CPU doesn't support X86_FEATURE_XGETBV1.
  */
 static inline u64 xfeatures_in_use(void)
 {
-	return xgetbv(XCR_XFEATURE_IN_USE_MASK);
+	u32 eax, edx;
+
+	asm volatile(ALTERNATIVE(
+			"mov  $0, %%ecx",
+			"mov  $1, %%ecx",
+			X86_FEATURE_XGETBV1)
+			"xgetbv"
+			: "=a" (eax), "=d" (edx) :: "ecx");
+
+	return eax + ((u64)edx << 32);
 }
 
 #endif /* _ASM_X86_FPU_XCR_H */
-- 
2.30.2

