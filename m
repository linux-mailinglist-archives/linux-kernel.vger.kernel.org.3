Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA184C2B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiBXMAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiBXL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:59:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DFE4BB81;
        Thu, 24 Feb 2022 03:59:27 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:59:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645703966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8OWy+tjadW9xSPgZaeMfCBWkLjVoT2j6ZVeoBDXqug=;
        b=GQ6P1qdBSRPC0wA/2IS+aoaPVLn/WIss/88CP1oBUIQnulFOPNwBgmLIVQDioPN6cbEB4G
        0rVLjN0uq9aHwuiCA3uQxBSLCS93hJKkcjBEf57cmiMvVC3Lm6g7/CpLDxde6247yvC5C4
        m3YGEl5kuDtO4ywRorjs6Iqdd70B0d2R5sPMQxxdVgoSQfwRnQ64MjO8I33oCIhGyVdiGg
        Ss4jcdLlwFq+kV7Bsy8AOT451txwBi1I9o0J6LBdZ1k2Ar/+M3klhLld+quNbkvRU4yIFl
        t7Kgn9SeRNsFbf5xu+YFLHtHpQHoSNGcO//KzTBGa4YM4jkY8H2MbfL92EMGAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645703966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8OWy+tjadW9xSPgZaeMfCBWkLjVoT2j6ZVeoBDXqug=;
        b=8HXsWmNYl5JiaZ4WyPv1QViX8tQb8nBhBE0Tcu2IZ1YU7+IahXh5nkS0fEReHnWXZBFIIG
        2474n/+8iD23SKDA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/coco: Explicitly declare type of confidential
 computing platform
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220222185740.26228-4-kirill.shutemov@linux.intel.com>
References: <20220222185740.26228-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164570396500.16921.10243057058805282631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     655a0fa34b4f7ac6e2b1406fab15e52a7b6accb1
Gitweb:        https://git.kernel.org/tip/655a0fa34b4f7ac6e2b1406fab15e52a7b6accb1
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 22 Feb 2022 21:57:39 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Feb 2022 19:14:16 +01:00

x86/coco: Explicitly declare type of confidential computing platform

The kernel derives the confidential computing platform
type it is running as from sme_me_mask on AMD or by using
hv_is_isolation_supported() on HyperV isolation VMs. This detection
process will be more complicated as more platforms get added.

Declare a confidential computing vendor variable explicitly and set it
via cc_set_vendor() on the respective platform.

  [ bp: Massage commit message, fixup HyperV check. ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20220222185740.26228-4-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/core.c               | 29 +++++++++++++++++------------
 arch/x86/include/asm/coco.h        | 14 ++++++++++++++-
 arch/x86/kernel/cpu/mshyperv.c     |  6 ++++++-
 arch/x86/mm/mem_encrypt_identity.c | 11 +++++++----
 4 files changed, 44 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/include/asm/coco.h

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 6a6ffcd..476dcd1 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -9,18 +9,15 @@
 
 #include <linux/export.h>
 #include <linux/cc_platform.h>
-#include <linux/mem_encrypt.h>
 
-#include <asm/mshyperv.h>
+#include <asm/coco.h>
 #include <asm/processor.h>
 
-static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
+static enum cc_vendor vendor __ro_after_init;
+
+static bool intel_cc_platform_has(enum cc_attr attr)
 {
-#ifdef CONFIG_INTEL_TDX_GUEST
-	return false;
-#else
 	return false;
-#endif
 }
 
 /*
@@ -74,12 +71,20 @@ static bool hyperv_cc_platform_has(enum cc_attr attr)
 
 bool cc_platform_has(enum cc_attr attr)
 {
-	if (sme_me_mask)
+	switch (vendor) {
+	case CC_VENDOR_AMD:
 		return amd_cc_platform_has(attr);
-
-	if (hv_is_isolation_supported())
+	case CC_VENDOR_INTEL:
+		return intel_cc_platform_has(attr);
+	case CC_VENDOR_HYPERV:
 		return hyperv_cc_platform_has(attr);
-
-	return false;
+	default:
+		return false;
+	}
 }
 EXPORT_SYMBOL_GPL(cc_platform_has);
+
+__init void cc_set_vendor(enum cc_vendor v)
+{
+	vendor = v;
+}
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
new file mode 100644
index 0000000..e49f9dd
--- /dev/null
+++ b/arch/x86/include/asm/coco.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_COCO_H
+#define _ASM_X86_COCO_H
+
+enum cc_vendor {
+	CC_VENDOR_NONE,
+	CC_VENDOR_AMD,
+	CC_VENDOR_HYPERV,
+	CC_VENDOR_INTEL,
+};
+
+void cc_set_vendor(enum cc_vendor v);
+
+#endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5a99f99..e0a5724 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -33,6 +33,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/coco.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -344,6 +345,11 @@ static void __init ms_hyperv_init_platform(void)
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
 #endif
+		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
+		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
+			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+				cc_set_vendor(CC_VENDOR_HYPERV);
+		}
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 3f0abb4..06314ae 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -44,6 +44,7 @@
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cmdline.h>
+#include <asm/coco.h>
 
 #include "mm_internal.h"
 
@@ -565,8 +566,7 @@ void __init sme_enable(struct boot_params *bp)
 	} else {
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
-		physical_mask &= ~sme_me_mask;
-		return;
+		goto out;
 	}
 
 	/*
@@ -600,6 +600,9 @@ void __init sme_enable(struct boot_params *bp)
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
-
-	physical_mask &= ~sme_me_mask;
+out:
+	if (sme_me_mask) {
+		physical_mask &= ~sme_me_mask;
+		cc_set_vendor(CC_VENDOR_AMD);
+	}
 }
