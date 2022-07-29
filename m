Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1ED584C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiG2HFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiG2HFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:05:09 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1474881B07
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1659078278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jq4vj1RzUhUFD8chOtnp1zUxZquW4wk6DMoEc5oQx0w=;
  b=QBR3Bp9bfTXoRVtQajCeu9NoVMlt1lPS1btoaAPyyRW7bX5hXQ4kUlom
   dkD7y1i/aWJ6Cs1UqFoC8XDpMKp8ALYVYJYPnKkGBGArzY9ph0HWXlfZx
   Ou/mQ2rxqaZgucEKTtBvtr3qzNtwxVfHTTZ6S/USknu+PajaPfoXp5put
   U=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 2.7
X-MesageID: 76181499
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:ki9Ej6rdfjn3IQcXgiWvvWXVZnFeBmJ+YhIvgKrLsJaIsI4StFCzt
 garIBmFM/mINmLwf9h/aIW08kIFucXTmNVgSFFk/y5kFyMW9JuZCYyVIHmrMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlVEliefSAOKU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YTdJ4BYpdDNPg06/gEk35q6q52lJ5gVWic1j5zcyqVFEVPrzGonpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Ior4+lpTWhRiro/6ZWBiuFIPM0SRqkEqShgJ+rQ6LJIhhXJ/0F1lqTzTJ
 OJl7vRcQS9xVkHFdX90vxNwS0mSNoUekFPLzOTWXWV+ACQqflO1q8iCAn3aMqUk5/RbHXMTt
 scUKQBTQCuoqsjrm6mkH7wEasQLdKEHPasas3BkizrYEewnUdbIRKCiCd1whWlqwJoURLCHO
 pRfOWEHgBfoOnWjPn81AZQz2sKhgnD7ejtVgFmUubA28y7YywkZPL3Fb4SMKoXWFJQ9ckCwq
 kH+707kAQsgO+OdzH2Y1mqvn/bGknauMG4VPOLhraM76LGJ/UQUDBAVTlK9reOOll+lW9lfJ
 koX/QIjtaE3skesS7HVRAakqXSJuhodXdt4EOAg7gyJjK3O7G6xFjhaZj1MctorsIkxXzNC/
 l2GhdTyHhR0raaYD3ma89+8vT60fCQYM2IGTSsFVhcepcnuppkpiRDCRcolF7S65vXwGTzhx
 T2ipS03lbIVy8IGv425913ahzOnprDSUxU4oA7QWwqN8gx9dKahZoq19ULc6/dQaoqUJnGLu
 2IFgI6Z9/wUCo+Wlz2lR/8EF7Wkof2CNVX0hV9pAolk9Dm3/XOnVZ5f7Ss4J0pzNMsAPzjzb
 yf7vAJX65h7JnambaZrJYm2DqwCzbDpPcb0SvfOKNFJZ/BZeAaZ8WdubEiL0mbFlEkqjLF5O
 JGHfMLqBnEfYYxt1BK/Q+YQ1+9tyi1W+I/IbcmllVL9i+PYPSPLD+deWLeTUgwnxJ+ZsinJ4
 YscDMeL+0txa8bTSHSM6pFGeDjmMkMH6YDKR91/L7Dec1I7STx5Wpc90pt6JdU7wv09evPgu
 yjkBxQGkAeXaWjvc13iV5x1VF/4sX+TR1ofNDdkA1un0mNLjW2HvPZGLMtfkVXKGYVeIR9Io
 xotIZzo7gxnEGivxtjkRcCVQHZeXBqqnxmSGCGufSIyeZVtLySQpIK1JlC0r3lSUXDo3Sfbn
 1FH/lqBKafvuiw4VJqGAB5R5wjZUYchdBJaABKTf4g7lLTE+4l2MS3h5sIKzzU3AUyanlOyi
 lfJaSr0UMGX/OfZBvGV2v3fx2poesMidndn857ztOvvaneGpDb5nOetko+gJFjgaY89w436D
 c098h02GKdvcIpi22akL4tW8A==
IronPort-HdrOrdr: A9a23:/Mq4x64O5NXyLOROZQPXwMTXdLJyesId70hD6qhwISY6TiX+rb
 HIoB17726RtN9/YhEdcLy7VJVoIkmskKKdg7NhXotKNTOO0ADDQb2KhbGSpQEIcBeeygcy78
 hdmtBFeb/NMWQ=
X-IronPort-AV: E=Sophos;i="5.93,200,1654574400"; 
   d="scan'208";a="76181499"
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
        Jan Beulich <jbeulich@suse.com>,
        "Maximilian Heyne" <mheyne@amazon.de>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH v4] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Date:   Fri, 29 Jul 2022 08:04:16 +0100
Message-ID: <20220729070416.23306-1-jane.malalane@citrix.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
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
CC: Jan Beulich <jbeulich@suse.com>
CC: Maximilian Heyne <mheyne@amazon.de>
CC: xen-devel@lists.xenproject.org

v4:
 * amend code comment

v3:
 * comment style
 * add comment on toolstack trick
 * remove unnecessary variable and function call
 * surround x86-specific code with #ifdef

v2:
 * remove no_vector_callback
 * make xen_have_vector_callback a bool
 * rename xen_ack_upcall to xen_percpu_upcall
 * fail to bring CPU up on init instead of crashing kernel
 * add and use xen_set_upcall_vector where suitable
 * xen_setup_upcall_vector -> xen_init_setup_upcall_vector for clarity
---
 arch/x86/include/asm/xen/cpuid.h   |  2 ++
 arch/x86/include/asm/xen/events.h  |  3 ++-
 arch/x86/xen/enlighten.c           |  2 +-
 arch/x86/xen/enlighten_hvm.c       | 24 ++++++++++++-----
 arch/x86/xen/suspend_hvm.c         | 10 ++++++-
 drivers/xen/events/events_base.c   | 53 +++++++++++++++++++++++++++++++++-----
 include/xen/hvm.h                  |  2 ++
 include/xen/interface/hvm/hvm_op.h | 19 ++++++++++++++
 8 files changed, 100 insertions(+), 15 deletions(-)

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
index 068d9b067c83..62bdceb594f1 100644
--- a/arch/x86/include/asm/xen/events.h
+++ b/arch/x86/include/asm/xen/events.h
@@ -23,7 +23,7 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 /* No need for a barrier -- XCHG is a barrier on x86. */
 #define xchg_xen_ulong(ptr, val) xchg((ptr), (val))
 
-extern int xen_have_vector_callback;
+extern bool xen_have_vector_callback;
 
 /*
  * Events delivered via platform PCI interrupts are always
@@ -34,4 +34,5 @@ static inline bool xen_support_evtchn_rebind(void)
 	return (!xen_hvm_domain() || xen_have_vector_callback);
 }
 
+extern bool xen_percpu_upcall;
 #endif /* _ASM_X86_XEN_EVENTS_H */
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 30c6e986a6cd..b8db2148c07d 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL_GPL(xen_start_info);
 
 struct shared_info xen_dummy_shared_info;
 
-__read_mostly int xen_have_vector_callback;
+__read_mostly bool xen_have_vector_callback = true;
 EXPORT_SYMBOL_GPL(xen_have_vector_callback);
 
 /*
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 8b71b1dd7639..198d3cd3e9a5 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -7,6 +7,8 @@
 
 #include <xen/features.h>
 #include <xen/events.h>
+#include <xen/hvm.h>
+#include <xen/interface/hvm/hvm_op.h>
 #include <xen/interface/memory.h>
 
 #include <asm/apic.h>
@@ -30,6 +32,9 @@
 
 static unsigned long shared_info_pfn;
 
+__ro_after_init bool xen_percpu_upcall;
+EXPORT_SYMBOL_GPL(xen_percpu_upcall);
+
 void xen_hvm_init_shared_info(void)
 {
 	struct xen_add_to_physmap xatp;
@@ -125,6 +130,9 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_xen_hvm_callback)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
+	if (xen_percpu_upcall)
+		ack_APIC_irq();
+
 	inc_irq_stat(irq_hv_callback_count);
 
 	xen_hvm_evtchn_do_upcall();
@@ -168,6 +176,15 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
 	if (!xen_have_vector_callback)
 		return 0;
 
+	if (xen_percpu_upcall) {
+		rc = xen_set_upcall_vector(cpu);
+		if (rc) {
+			WARN(1, "HVMOP_set_evtchn_upcall_vector"
+			     " for CPU %d failed: %d\n", cpu, rc);
+			return rc;
+		}
+	}
+
 	if (xen_feature(XENFEAT_hvm_safe_pvclock))
 		xen_setup_timer(cpu);
 
@@ -188,8 +205,6 @@ static int xen_cpu_dead_hvm(unsigned int cpu)
 	return 0;
 }
 
-static bool no_vector_callback __initdata;
-
 static void __init xen_hvm_guest_init(void)
 {
 	if (xen_pv_domain())
@@ -211,9 +226,6 @@ static void __init xen_hvm_guest_init(void)
 
 	xen_panic_handler_init();
 
-	if (!no_vector_callback && xen_feature(XENFEAT_hvm_callback_vector))
-		xen_have_vector_callback = 1;
-
 	xen_hvm_smp_init();
 	WARN_ON(xen_cpuhp_setup(xen_cpu_up_prepare_hvm, xen_cpu_dead_hvm));
 	xen_unplug_emulated_devices();
@@ -239,7 +251,7 @@ early_param("xen_nopv", xen_parse_nopv);
 
 static __init int xen_parse_no_vector_callback(char *arg)
 {
-	no_vector_callback = true;
+	xen_have_vector_callback = false;
 	return 0;
 }
 early_param("xen_no_vector_callback", xen_parse_no_vector_callback);
diff --git a/arch/x86/xen/suspend_hvm.c b/arch/x86/xen/suspend_hvm.c
index 9d548b0c772f..0c4f7554b7cc 100644
--- a/arch/x86/xen/suspend_hvm.c
+++ b/arch/x86/xen/suspend_hvm.c
@@ -5,6 +5,7 @@
 #include <xen/hvm.h>
 #include <xen/features.h>
 #include <xen/interface/features.h>
+#include <xen/events.h>
 
 #include "xen-ops.h"
 
@@ -14,6 +15,13 @@ void xen_hvm_post_suspend(int suspend_cancelled)
 		xen_hvm_init_shared_info();
 		xen_vcpu_restore();
 	}
-	xen_setup_callback_vector();
+	if (xen_percpu_upcall) {
+		unsigned int cpu;
+
+		for_each_online_cpu(cpu)
+			BUG_ON(xen_set_upcall_vector(cpu));
+	} else {
+		xen_setup_callback_vector();
+	}
 	xen_unplug_emulated_devices();
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 46d9295d9a6e..206d4b466e44 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -45,6 +45,7 @@
 #include <asm/irq.h>
 #include <asm/io_apic.h>
 #include <asm/i8259.h>
+#include <asm/xen/cpuid.h>
 #include <asm/xen/pci.h>
 #endif
 #include <asm/sync_bitops.h>
@@ -2183,6 +2184,7 @@ static struct irq_chip xen_percpu_chip __read_mostly = {
 	.irq_ack		= ack_dynirq,
 };
 
+#ifdef CONFIG_X86
 #ifdef CONFIG_XEN_PVHVM
 /* Vector callbacks are better than PCI interrupts to receive event
  * channel notifications because we can receive vector callbacks on any
@@ -2195,11 +2197,48 @@ void xen_setup_callback_vector(void)
 		callback_via = HVM_CALLBACK_VECTOR(HYPERVISOR_CALLBACK_VECTOR);
 		if (xen_set_callback_via(callback_via)) {
 			pr_err("Request for Xen HVM callback vector failed\n");
-			xen_have_vector_callback = 0;
+			xen_have_vector_callback = false;
 		}
 	}
 }
 
+/*
+ * Setup per-vCPU vector-type callbacks. If this setup is unavailable,
+ * fallback to the global vector-type callback.
+ */
+static __init void xen_init_setup_upcall_vector(void)
+{
+	if (!xen_have_vector_callback)
+		return;
+
+	if ((cpuid_eax(xen_cpuid_base() + 4) & XEN_HVM_CPUID_UPCALL_VECTOR) &&
+	    !xen_set_upcall_vector(0))
+		xen_percpu_upcall = true;
+	else if (xen_feature(XENFEAT_hvm_callback_vector))
+		xen_setup_callback_vector();
+	else
+		xen_have_vector_callback = false;
+}
+
+int xen_set_upcall_vector(unsigned int cpu)
+{
+	int rc;
+	xen_hvm_evtchn_upcall_vector_t op = {
+		.vector = HYPERVISOR_CALLBACK_VECTOR,
+		.vcpu = per_cpu(xen_vcpu_id, cpu),
+	};
+
+	rc = HYPERVISOR_hvm_op(HVMOP_set_evtchn_upcall_vector, &op);
+	if (rc)
+		return rc;
+
+	/* Trick toolstack to think we are enlightened. */
+	if (!cpu)
+		rc = xen_set_callback_via(1);
+
+	return rc;
+}
+
 static __init void xen_alloc_callback_vector(void)
 {
 	if (!xen_have_vector_callback)
@@ -2210,8 +2249,11 @@ static __init void xen_alloc_callback_vector(void)
 }
 #else
 void xen_setup_callback_vector(void) {}
+static inline void xen_init_setup_upcall_vector(void) {}
+int xen_set_upcall_vector(unsigned int cpu) {}
 static inline void xen_alloc_callback_vector(void) {}
-#endif
+#endif /* CONFIG_XEN_PVHVM */
+#endif /* CONFIG_X86 */
 
 bool xen_fifo_events = true;
 module_param_named(fifo_events, xen_fifo_events, bool, 0);
@@ -2271,10 +2313,9 @@ void __init xen_init_IRQ(void)
 		if (xen_initial_domain())
 			pci_xen_initial_domain();
 	}
-	if (xen_feature(XENFEAT_hvm_callback_vector)) {
-		xen_setup_callback_vector();
-		xen_alloc_callback_vector();
-	}
+	xen_init_setup_upcall_vector();
+	xen_alloc_callback_vector();
+
 
 	if (xen_hvm_domain()) {
 		native_init_IRQ();
diff --git a/include/xen/hvm.h b/include/xen/hvm.h
index b7fd7fc9ad41..8da7a6747058 100644
--- a/include/xen/hvm.h
+++ b/include/xen/hvm.h
@@ -60,4 +60,6 @@ static inline int hvm_get_parameter(int idx, uint64_t *value)
 
 void xen_setup_callback_vector(void);
 
+int xen_set_upcall_vector(unsigned int cpu);
+
 #endif /* XEN_HVM_H__ */
diff --git a/include/xen/interface/hvm/hvm_op.h b/include/xen/interface/hvm/hvm_op.h
index f3097e79bb03..03134bf3cec1 100644
--- a/include/xen/interface/hvm/hvm_op.h
+++ b/include/xen/interface/hvm/hvm_op.h
@@ -46,4 +46,23 @@ struct xen_hvm_get_mem_type {
 };
 DEFINE_GUEST_HANDLE_STRUCT(xen_hvm_get_mem_type);
 
+#if defined(__i386__) || defined(__x86_64__)
+
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
+#endif /* defined(__i386__) || defined(__x86_64__) */
+
 #endif /* __XEN_PUBLIC_HVM_HVM_OP_H__ */
-- 
2.11.0

