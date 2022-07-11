Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2DE5706EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiGKPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGKPYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:24:06 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 08:24:04 PDT
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA366F591
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1657553044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pZGb0cAgf2x8v4lEYbVef+sU13jY0Ld25ol2N9KqxBE=;
  b=UE63ZgaaKJn8XQPbY1FBMzM8V/RKtg1zCGJ1zD8zBEdU4lDbfBL4ZeVs
   TQ1F4npRIqacau5VuUViAziUV5Kwq+n30kZDYnGfrlaiamMTaysbFHMxs
   NW3n4hreqdHXrImnDui6MZRz1H5lNN4q4C6XiNwC2b+5pp3olJa99H2Vx
   o=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 5.1
X-MesageID: 75346842
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:qL/hcak6oBccjp5pBgR02zvo5gzmIURdPkR7XQ2eYbSJt1+Wr1Gzt
 xJNCzrUMvqCMDH1KYh2YYqx/U4EsZXczN9iTARrryw1HyMWpZLJC+rCIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EgLd9IR2NYy24DmWlrV4
 7senuWEULOb828sWo4rw/rrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOhKmVgJcaoR
 v6r8V2M1jixEyHBqD+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRa1hIg+ZzihxrhMJ
 NtxWZOYQg0xMaeSiPYmXxRKTAEiBKkew5HbGC3q2SCT5xWun3rExvxvCAc9PJEC+/YxCmZLn
 RAaAGlTNFbZ3bvwme/lDLk37iggBJCD0Ic3mHhmwHf8BPIvRZnFTo3B5MNC3Sd2jcdLdRrbT
 5VEMmYxPEiaC/FJEg8VOb4Mw9uvv0DidiFpuUCn5o1w4kGGmWSd15CyaYGIK7RmX/59m0aVt
 2TL1238CwMdMpqTxFKt9XahhfTGmy/hb54DD72z9vNsg1q7y3QaDVsdUl7TieKilke0VtZbK
 koV0ikjt64/8AqsVNaVdx+3unmfpTYHRsFdVeY97Wml2qfSpgqUGGUAZjpAc8A98t87QyQw0
 V2ElM+vAiZg2JWeTnac8PGXrDW9ESkTMWIGIyQDSGMt4dPuvYUyhRLnVct4Hei+ididMSGgn
 RiJoTI4irFVitQEv42n8lTXqzatoIXVVAkz5xWRUm/Nxgl+fo++IYuz9ULc8+1DPa6eVFCKu
 HVCkM+bhMgKDJeQhGmOTf8LEbWB+fmIKnvfjERpEp1n8C6ik1amfIZf5xlkKUtpO9pCcjjsC
 GfToQp59o5PO2HsZqhyC6q9Atoni6jpE8/oUNjQb9xTct5wchOK+GdlYkv492r1uEEokKw5a
 dGXfK6R4W0yUPo9imDsHqFEjOFtlntWKX7vqY7TxB6/3rDAdGyuRboXb3vSV+Rh142YmVCAm
 zpADPdm2ymzQcWnPHSIqtZJcAlTRZQoLcuo8pIKL4ZvNiIjQTh8UKGJnNvNbqQ/x8xoevH0E
 mZRs6Oy4H72njX5JAqDcRiPg5u/DM8k/RrX0cHBVGtEOkTPgq71tc/zj7NtIdEaGBVLlJaYt
 cUtdcSaGehoQT/a4TkbZpSVhNU8KUv32lLXYHb0OmRXk3tcq+vho4WMQ+cS3HNWUnrfWTUW+
 dVMKT83sbJcHl8/Xa46mdqkzk+rvGh1pd+eq3Dge4EJEG21qdACA3Wo0pcffpBXQT2el2Ty6
 upjKUpBzQU7i9RtoIehaGHth9rBLtaS6WIATjOEtufmb3OAlodhqKcZONu1kfnmfDuc0M2fi
 S99lJkQ7NVvcI52jrdB
IronPort-HdrOrdr: A9a23:MJzeIaq7dYPlArvywvnORXsaV5oneYIsimQD101hICG8cqSj+f
 xG+85rsiMc6QxhPE3I9urhBEDtex/hHP1OkOws1NWZLWrbUQKTRekIh+bfKlXbakvDH4VmtJ
 uIHZIQNDSJNykZsfrH
X-IronPort-AV: E=Sophos;i="5.92,263,1650945600"; 
   d="scan'208";a="75346842"
From:   Jane Malalane <jane.malalane@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Jane Malalane <jane.malalane@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        "Jan Beulich" <jbeulich@suse.com>,
        Colin Ian King <colin.king@intel.com>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Date:   Mon, 11 Jul 2022 16:22:30 +0100
Message-ID: <20220711152230.17749-1-jane.malalane@citrix.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for the HVMOP_set_evtchn_upcall_vector hypercall in
order to set the per-vCPU event channel vector callback on Linux and
use it in preference of HVM_PARAM_CALLBACK_IRQ.

If the per-VCPU vector setup is successful on BSP, use this method
for the APs. If not, fallback to the global vector-type callback.

Also register callback_irq at per-vCPU event channel setup to trick
toolstack to think the domain is enlightened.

Suggested-by: "Roger Pau Monné" <roger.pau@citrix.com>
Signed-off-by: Jane Malalane <jane.malalane@citrix.com>
---
CC: Juergen Gross <jgross@suse.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
CC: Jane Malalane <jane.malalane@citrix.com>
CC: Maximilian Heyne <mheyne@amazon.de>
CC: Jan Beulich <jbeulich@suse.com>
CC: Colin Ian King <colin.king@intel.com>
CC: xen-devel@lists.xenproject.org
---
 arch/x86/include/asm/xen/cpuid.h   |  2 ++
 arch/x86/include/asm/xen/events.h  |  1 +
 arch/x86/xen/enlighten_hvm.c       | 19 +++++++++++++++++--
 arch/x86/xen/suspend_hvm.c         | 20 +++++++++++++++++++-
 drivers/xen/events/events_base.c   | 32 ++++++++++++++++++++++++++++----
 include/xen/interface/hvm/hvm_op.h | 15 +++++++++++++++
 6 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/xen/cpuid.h b/arch/x86/include/asm/xen/cpuid.h
index 78e667a31d6c..6daa9b0c8d11 100644
--- a/arch/x86/include/asm/xen/cpuid.h
+++ b/arch/x86/include/asm/xen/cpuid.h
@@ -107,6 +107,8 @@
  * ID field from 8 to 15 bits, allowing to target APIC IDs up 32768.
  */
 #define XEN_HVM_CPUID_EXT_DEST_ID      (1u << 5)
+/* Per-vCPU event channel upcalls */
+#define XEN_HVM_CPUID_UPCALL_VECTOR    (1u << 6)
 
 /*
  * Leaf 6 (0x40000x05)
diff --git a/arch/x86/include/asm/xen/events.h b/arch/x86/include/asm/xen/events.h
index 068d9b067c83..b2d86c761bf8 100644
--- a/arch/x86/include/asm/xen/events.h
+++ b/arch/x86/include/asm/xen/events.h
@@ -34,4 +34,5 @@ static inline bool xen_support_evtchn_rebind(void)
 	return (!xen_hvm_domain() || xen_have_vector_callback);
 }
 
+extern bool xen_ack_upcall;
 #endif /* _ASM_X86_XEN_EVENTS_H */
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 8b71b1dd7639..847d1da46ff7 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -7,6 +7,7 @@
 
 #include <xen/features.h>
 #include <xen/events.h>
+#include <xen/interface/hvm/hvm_op.h>
 #include <xen/interface/memory.h>
 
 #include <asm/apic.h>
@@ -30,6 +31,9 @@
 
 static unsigned long shared_info_pfn;
 
+__ro_after_init bool xen_ack_upcall;
+EXPORT_SYMBOL_GPL(xen_ack_upcall);
+
 void xen_hvm_init_shared_info(void)
 {
 	struct xen_add_to_physmap xatp;
@@ -125,6 +129,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
+	if (xen_ack_upcall)
+		ack_APIC_irq();
+
 	inc_irq_stat(irq_hv_callback_count);
 
 	xen_hvm_evtchn_do_upcall();
@@ -168,6 +175,15 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 	if (!xen_have_vector_callback)
 		return 0;
 
+	if (xen_ack_upcall) {
+		xen_hvm_evtchn_upcall_vector_t op = {
+			.vector = HYPERVISOR_CALLBACK_VECTOR,
+			.vcpu = per_cpu(xen_vcpu_id, cpu),
+		};
+
+		BUG_ON(HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector, &op));
+	}
+
 	if (xen_feature(XENFEAT_hvm_safe_pvclock))
 		xen_setup_timer(cpu);
 
@@ -211,8 +227,7 @@ static void __init xen_hvm_guest_init(void)
 
 	xen_panic_handler_init();
 
-	if (!no_vector_callback && xen_feature(XENFEAT_hvm_callback_vector))
-		xen_have_vector_callback = 1;
+	xen_have_vector_callback = !no_vector_callback;
 
 	xen_hvm_smp_init();
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_hvm, xen_cpu_dead_hvm));
diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
index 9d548b0c772f..be66e027ef28 100644
--- a/arch/x86/xen/suspend_hvm.c
+++ b/arch/x86/xen/suspend_hvm.c
@@ -5,6 +5,7 @@
 #include <xen/hvm.h>
 #include <xen/features.h>
 #include <xen/interface/features.h>
+#include <xen/events.h>
 
 #include "xen-ops.h"
 
@@ -14,6 +15,23 @@ void xen_hvm_post_suspend(int suspend_cancelled)
 		xen_hvm_init_shared_info();
 		xen_vcpu_restore();
 	}
-	xen_setup_callback_vector();
+	if (xen_ack_upcall) {
+		unsigned int cpu;
+
+		for_each_online_cpu(cpu) {
+			xen_hvm_evtchn_upcall_vector_t op = {
+					.vector = HYPERVISOR_CALLBACK_VECTOR,
+					.vcpu = per_cpu(xen_vcpu_id, cpu),
+			};
+
+			BUG_ON(HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector,
+						 &op));
+			/* Trick toolstack to think we are enlightened. */
+			if (!cpu)
+				BUG_ON(xen_set_callback_via(1));
+		}
+	} else {
+		xen_setup_callback_vector();
+	}
 	xen_unplug_emulated_devices();
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 46d9295d9a6e..a2420b66e735 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -48,6 +48,7 @@
 #include <asm/xen/pci.h>
 #endif
 #include <asm/sync_bitops.h>
+#include <asm/xen/cpuid.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>
 #include <xen/page.h>
@@ -2200,6 +2201,29 @@ void xen_setup_callback_vector(void)
 	}
 }
 
+/* Setup per-vCPU vector-type callbacks and trick toolstack to think
+ * we are enlightened. If this setup is unavailable, fallback to the
+ * global vector-type callback. */
+static __init void xen_setup_upcall_vector(void)
+{
+	xen_hvm_evtchn_upcall_vector_t op = {
+		.vector = HYPERVISOR_CALLBACK_VECTOR,
+		.vcpu = per_cpu(xen_vcpu_id, 0),
+	};
+
+	if (!xen_have_vector_callback)
+		return;
+
+	if ((cpuid_eax(xen_cpuid_base() + 4) & XEN_HVM_CPUID_UPCALL_VECTOR) &&
+	    !HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector, &op) &&
+	    !xen_set_callback_via(1))
+		xen_ack_upcall = true;
+	else if (xen_feature(XENFEAT_hvm_callback_vector))
+		xen_setup_callback_vector();
+	else
+		xen_have_vector_callback = 0;
+}
+
 static __init void xen_alloc_callback_vector(void)
 {
 	if (!xen_have_vector_callback)
@@ -2210,6 +2234,7 @@ static __init void xen_alloc_callback_vector(void)
 }
 #else
 void xen_setup_callback_vector(void) {}
+static inline void xen_setup_upcall_vector(void) {}
 static inline void xen_alloc_callback_vector(void) {}
 #endif
 
@@ -2271,10 +2296,9 @@ void __init xen_init_IRQ(void)
 		if (xen_initial_domain())
 			pci_xen_initial_domain();
 	}
-	if (xen_feature(XENFEAT_hvm_callback_vector)) {
-		xen_setup_callback_vector();
-		xen_alloc_callback_vector();
-	}
+	xen_setup_upcall_vector();
+	xen_alloc_callback_vector();
+
 
 	if (xen_hvm_domain()) {
 		native_init_IRQ();
diff --git a/include/xen/interface/hvm/hvm_op.h b/include/xen/interface/hvm/hvm_op.h
index f3097e79bb03..e714d8b6ef89 100644
--- a/include/xen/interface/hvm/hvm_op.h
+++ b/include/xen/interface/hvm/hvm_op.h
@@ -46,4 +46,19 @@ struct xen_hvm_get_mem_type {
 };
 DEFINE_GUEST_HANDLE_STRUCT(xen_hvm_get_mem_type);
 
+/*
+ * HVMOP_set_evtchn_upcall_vector: Set a <vector> that should be used for event
+ *                                 channel upcalls on the specified <vcpu>. If set,
+ *                                 this vector will be used in preference to the
+ *                                 domain global callback via (see
+ *                                 HVM_PARAM_CALLBACK_IRQ).
+ */
+#define HVMOP_set_evtchn_upcall_vector 23
+struct xen_hvm_evtchn_upcall_vector {
+    uint32_t vcpu;
+    uint8_t vector;
+};
+typedef struct xen_hvm_evtchn_upcall_vector xen_hvm_evtchn_upcall_vector_t;
+DEFINE_GUEST_HANDLE_STRUCT(xen_hvm_evtchn_upcall_vector_t);
+
 #endif /* __XEN_PUBLIC_HVM_HVM_OP_H__ */
-- 
2.11.0

