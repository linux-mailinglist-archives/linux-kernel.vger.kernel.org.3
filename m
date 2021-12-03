Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1291466E8C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377791AbhLCAke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38655 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377762AbhLCAkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:22 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6ADAE5C039B;
        Thu,  2 Dec 2021 19:36:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 02 Dec 2021 19:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=NhgI1hRQ5vifG
        fVgWjP5Z76oNY2mpCU7A0+hURs6wqI=; b=XmGD0mjfJtRhrC6vQzi6JVfa4+FN+
        /GveVlHegEFV4gETWdD31BK9mXW8Qx5pptRrf8G6YSgSsUNqKy1uev6NgUPKyG1F
        unACYFJ20yH8HtmimLzeJDxDUPE43h9zTOUpon9P9bUlOiyERRZ+mR0JyNhgtQBL
        xC3eJHj2uhK6Ou8ubPC4w+DXs2k1Rz6HJ0/N6MBJnWrHIlA2UZrdiCZ3nuoUAZ6t
        r3wTxg3pQ6PmKqoVUXC8htbBsqjZOtRz3nJSJDl4dft0HVHkoAlbj2mkK+52eQnV
        FeA6YIoioyDo9deILnJw/P2FHYvG81uO1DB3UXOCGLcaVmXrCIf79V4RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=NhgI1hRQ5vifGfVgWjP5Z76oNY2mpCU7A0+hURs6wqI=; b=EgQR7wDu
        3Tnu3XXQG/2jgkzpSDervpxrTGB8gPEoZBfvk1DBslQ8sI70U1RZnogTTK3gXS/1
        En2X3Co5ne4xKuhxoUZEy3uQzbC5xKbhaPNbMy8RcAanx7RYCk3lSUVU7+XP05Br
        i8Mg5HH7I/SsbkNtYFqOgBLUwKp/nchKr/DQtg+SzTxOR3eQvDw2JRruhgD0yvBh
        CVbtfJ32BOfr4VYtPDAR99uAqZrUzIX4pPB5KMdDFMXZUFFrBqwds0HIh9Z+nc9T
        5Lcjfb2UDx4ts22+fewSD4LLDPqo8CswiypmK4+nYoFKhrTJMGdK4jVo/ZI/x3jc
        Wpj/Ss/Z7k3cxw==
X-ME-Sender: <xms:q2apYeJS5IVdvuGCxIETRFQywAVEw-o2FnFj2nZOX9F9NbUXJP-MnQ>
    <xme:q2apYWJy_NA8euMFM3vRV2PTbDYVc4S_xs9-D6j9mKhoLqtDpxta7eGb1ZsvzfjHL
    H-dSP6AF-puD5mjam4>
X-ME-Received: <xmr:q2apYesX-S87A29_8_2xszKdLBacil0PoGbGGm01xk_DOUr8pyXRTgzzq6rznPmyvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    vdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:q2apYTa9E1Q4oCaYObCWTX0nreReuI0gNlxE5yAIyYta525orzSZBg>
    <xmx:q2apYVbYcQZxI-thGoV7JaXEP4jMxuQONcde6wyA-xp7Eg-yqnqreQ>
    <xmx:q2apYfD8BIsv8_yG6RQShZJievrkbHB-857UVoUoqpnv6Gh2ywZthA>
    <xmx:q2apYTPRmU4GLDL8HlmLPrsWwrpmCkOIr2_ddyFAA6UbTnymNIHJ5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:57 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 09/10] x86/fpu: Split out XFEATURE_MASK_KERNEL_DYNAMIC
Date:   Fri,  3 Dec 2021 00:36:35 +0000
Message-Id: <20211203003636.11417-10-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, we can have features that is not XFD entitled
dynamically allocated on fxstate buffer.

Split out XFEATURE_MASK_KERNEL_DYNAMIC, and make it depend
on XSAVES (actually XSAVEC but os_xsave only generate
compact format when XSAVES present).

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/include/asm/fpu/xstate.h | 3 +++
 arch/x86/kernel/fpu/xstate.c      | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index c46d3dd591bd..d3a8c0855a5d 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -49,6 +49,9 @@
 /* Features which are dynamically enabled for a process on request */
 #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
 
+/* Features which are dynamically allocated only when in use */
+#define XFEATURE_MASK_KERNEL_DYNAMIC	XFEATURE_MASK_XTILE_DATA
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4621b51d1b20..1837e379777f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -875,7 +875,8 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 
 	/* Clean out dynamic features from default */
 	fpu_kernel_cfg.default_features = fpu_kernel_cfg.max_features;
-	fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		fpu_kernel_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
 
 	fpu_user_cfg.default_features = fpu_user_cfg.max_features;
 	fpu_user_cfg.default_features &= ~XFEATURE_MASK_USER_DYNAMIC;
-- 
2.30.2

