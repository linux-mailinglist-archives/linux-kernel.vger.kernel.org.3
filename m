Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E69466E84
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbhLCAkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:12 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39953 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347503AbhLCAkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C7E235C0198;
        Thu,  2 Dec 2021 19:36:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 19:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=4BDe1IifB1auX
        /rHrjkN/XoRnmQaaJIY/WpOaCjuWJ8=; b=oQRKK1sbWvxALX+AJ2633cSLGAOiB
        ogf0oIB2CJaykXgvV+hkUNkXZJbslPMq/3kmcgBVS5x0ahOUeJ5lBDG6J+5zFucY
        R0lccYZSyh1lJUnhEND8/Bct1f63dkBeUBV25+O8kK4xkQUhen8EDq0FkqcC2VYR
        ZmOYYjZqgHrucKpY34HOr9+XGAziM1Ug5UpjKC2evS4m4tdLA2FKmm9t1cHoe1ux
        ENFQWBzdpk2B7qJPW+F8pllSE/RmyRI6yRA4xpx8zcAhRcRE/E81Ww+TQml7VMQu
        a4Dat961ZJLLE/S0ORYwgbaMkcmzkIS9G0o7I2Sd9T1nPGEvJTGAu+pqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=4BDe1IifB1auX/rHrjkN/XoRnmQaaJIY/WpOaCjuWJ8=; b=NtljzXa8
        m2Ee628j4FYpK6Lem8S/+/8FPDu2KEYnJ3qs8HKDM/USL7k8i+ye/uklYc5Gedkh
        x7UyFQPnZv6jJpJHM3P5Fj7OAM+oSkJhbOKzjJ8W7qhGiV+MVVBQT5hGQ/18nOgL
        s3FhhrxikN9dr1N6+W9Ih9j/Y/G6bLMKtPDuQtG7VvAE8zZoupdwoBBW4qXE728y
        XmBwq2ePW5wTWKPpHWaPTSPDn2i4xMJnXImjvtLqzkCG28viTwkddBMRHgJ/ubA5
        WijklPLR5EDarGMVkocNJ+tiR/0mI7UOb1dJEw6Hf79p9wO5OW+qNGpMDH/ASgu2
        0H/qo/QqEEav6w==
X-ME-Sender: <xms:n2apYXCISfn-gxmtOO7nzzdJpVvRFTsnu_1dQmldC02tvbdi5BZEaw>
    <xme:n2apYdjTGWTQQl810x9e1ZtEmltL3esBVm-jhHmn1JdRtvAsze6kGAduGOPT7sO5a
    i6HQXgZ8nPtkLSZ4A8>
X-ME-Received: <xmr:n2apYSmb02V29U1GRVAle48Z_7lNY-GNltRBaZuoCobODpIVo2xI4ycPoLqOffbXxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:n2apYZxSL1WoqDi54jJVLA4s2_IBGN9EwpvVAOM9jXNI8hyA6THJmA>
    <xmx:n2apYcQYcnXeh9E_m16a24MMkuyuUcBMe8XuGFd4AEu1e9SpGIxnNw>
    <xmx:n2apYcY_a9EW47sGoxHx2EKlL8lJWt9JRi7NlNDAMISfAotXvSMoOA>
    <xmx:n2apYfGfM2gR4SQvvHTGLmI0RRX3YPpa8rpvzVyDmNUZBg44E2Qnfw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:46 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 02/10] x86/fpu: Split fpu_xfd_enabled from fpu_state_size_dynamic
Date:   Fri,  3 Dec 2021 00:36:28 +0000
Message-Id: <20211203003636.11417-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following patches will make fpu_state_size_dynamic nolonger depend
on XFD, so split XFD related static branch from fpu_state_size_dynamic.

Also make fpu_state_size_dynamic available on both x86 and x86_64.

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/include/asm/fpu/xstate.h | 11 +++++++++--
 arch/x86/kernel/fpu/core.c        |  3 ++-
 arch/x86/kernel/fpu/xstate.c      | 31 +++++++++++++++++++------------
 arch/x86/kernel/fpu/xstate.h      |  2 +-
 4 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index fb83534e92f6..c46d3dd591bd 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -111,15 +111,22 @@ void xrstors(struct xregs_state *xsave, u64 mask);
 
 int xfd_enable_feature(u64 xfd_err);
 
-#ifdef CONFIG_X86_64
 DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
 
 static __always_inline __pure bool fpu_state_size_dynamic(void)
 {
 	return static_branch_unlikely(&__fpu_state_size_dynamic);
 }
+
+#ifdef CONFIG_X86_64
+DECLARE_STATIC_KEY_FALSE(__fpu_xfd_enabled);
+
+static __always_inline __pure bool fpu_xfd_enabled(void)
+{
+	return static_branch_unlikely(&__fpu_xfd_enabled);
+}
 #else
-static __always_inline __pure bool fpu_state_size_dynamic(void)
+static __always_inline __pure bool fpu_xfd_enabled(void)
 {
 	return false;
 }
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index dd3777ac0443..88dbbbde7a3a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -26,8 +26,9 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/fpu.h>
 
-#ifdef CONFIG_X86_64
 DEFINE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+#ifdef CONFIG_X86_64
+DEFINE_STATIC_KEY_FALSE(__fpu_xfd_enabled);
 DEFINE_PER_CPU(u64, xfd_state);
 #endif
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d28829403ed0..353c661f8027 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -995,7 +995,7 @@ void fpu__resume_cpu(void)
 				     xfeatures_mask_independent());
 	}
 
-	if (fpu_state_size_dynamic())
+	if (fpu_xfd_enabled())
 		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
 }
 
@@ -1422,6 +1422,23 @@ void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature)
 EXPORT_SYMBOL_GPL(fpstate_clear_xstate_component);
 #endif
 
+static int __init xstate_update_static_branch(void)
+{
+	if (fpu_kernel_cfg.max_features != fpu_kernel_cfg.default_features)
+		static_branch_enable(&__fpu_state_size_dynamic);
+
+#ifdef CONFIG_X86_64
+	/*
+	 * If init_fpstate.xfd has bits set then dynamic features are
+	 * available and the dynamic sizing must be enabled.
+	 */
+	if (init_fpstate.xfd)
+		static_branch_enable(&__fpu_xfd_enabled);
+#endif
+	return 0;
+}
+arch_initcall(xstate_update_static_branch)
+
 #ifdef CONFIG_X86_64
 
 #ifdef CONFIG_X86_DEBUG_FPU
@@ -1481,17 +1498,7 @@ void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
 }
 #endif /* CONFIG_X86_DEBUG_FPU */
 
-static int __init xfd_update_static_branch(void)
-{
-	/*
-	 * If init_fpstate.xfd has bits set then dynamic features are
-	 * available and the dynamic sizing must be enabled.
-	 */
-	if (init_fpstate.xfd)
-		static_branch_enable(&__fpu_state_size_dynamic);
-	return 0;
-}
-arch_initcall(xfd_update_static_branch)
+
 
 void fpstate_free(struct fpu *fpu)
 {
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 86ea7c0fa2f6..f6bebaeea4ad 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -140,7 +140,7 @@ static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rs
 #ifdef CONFIG_X86_64
 static inline void xfd_update_state(struct fpstate *fpstate)
 {
-	if (fpu_state_size_dynamic()) {
+	if (fpu_xfd_enabled()) {
 		u64 xfd = fpstate->xfd;
 
 		if (__this_cpu_read(xfd_state) != xfd) {
-- 
2.30.2

