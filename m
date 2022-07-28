Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D464C583F50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiG1MxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbiG1MxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:53:22 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5B93D59C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1659012799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ng7b+AAgMXcZ/+TJuJcCEeWQ4bsCFjToHv0fp7P5JkI=;
  b=UG0MiFYqUoXN2bQ9DXWTX5E/lZh0d6nH2/zVZCVfCjayL4S1uMsl+v3n
   thqKLet/t+Tmehjyl9ZG8JfJ4S1rjPYXbRq3vlcy+qk1QvNPIO+T3TlJ9
   o39mkL7qskM4W1DD2Y2lNeIna3RMmaBEqFJEKUblWtNz2rtIPMkugvKzc
   0=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 2.7
X-MesageID: 76112333
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:c5VvaqhWJ3cMKYa7cwBnfNCNX161BhcKZh0ujC45NGQN5FlHY01je
 htvW2uEO/3bN2HyLo1yaI7koxkAsMXWnIUxTQA4/n0zF3wb9cadCdqndUqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9CU6j+fQLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhnglaQr414rZ8Ek15Kuo6GtC1rADTasjUGH2xiF94K03fcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD90V7tJOp6iGqE7aua60Tqm0xK6aID76vR2nQQg075TCRYpQRw/ZwNlPTxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJQWXAP6I0DuKhPRL/tS4E4eFs40x8h2JzF33
 uESEwsRT02FucS6z+fuIgVsrpxLwMjDOYoevjdrzC3DDOZgSpfGK0nIzYYGhnFq3JkIRKuAI
 ZpCAdZsRE2ojxlnGF4RBdQbleOhgnD5fhVTqU6PpLpx6G/WpOB0+OezaYOPIYfRLSlTthuSi
 HPE3UDTOFIDJsW42AqL0S6slNaayEsXX6pNTeblp5aGmma7wWgeCwYfU1ehluWokU61W99ZK
 Es89zInqO4580nDZsLmQxSyrXqAvxgdc9ldCes37EeK0KW8yxbJWEAHQyRHZdhgs9U5LRQo2
 UWOhMjBHiF0vfueTnf13qeZq3a+NDYYKUcGZDQYVk0V7t/7uoYxgxnTCNF5H8adi934CDf96
 zmPpTo5gfMfgKYj1a+24FTGiDKEvYXSQ0g+4QC/dn6q6hNRYI+jepCy7l7a/bBMIe6xRF6bv
 WNCnNOC9ucQFpKcvCuXSe4JEfei4PPtGDndh0N/Wpos7TKg/1a9co1KpjJzPkFkNoADYzCBS
 ErSvwxWzIVeMHujcel8ZIfZI8QyxIDyBMjiTLbfad8mSpR4agLB/ChofkOW92TsllU816A5J
 ZqfN82rCB4yA7xPxT63SuFNl7Mmrh3S3kuKG8q9lU7+l+PDOjjFEt/pLWdicMgSr4+5jgTzo
 +90KsGx8Al+DevARCXYpNt7wU8xEZQrOXzng5UJK77Sf1s4RDhJ5+z5mu14JdE890hBvqKRp
 yzmBBcFoLbqrSefQThmfEyPf18GsXxXiXsgdRIhMl+zs5TISdb+tfxPH3fbkFROyQCC8RKXZ
 6NcEyl4Kq4TIgkrAhxEBXUHkKRsdQ6wmSWFNDe/bT40cvZIHlKUqo64IFq/qnhUU0JbUPfSR
 JX5jGvmrWcrHVw+XK46ltr0p79OgZTtsL0rBBaZSjWiUE7t7JJrO0TMsxPDGOlVcE2r7mbLi
 G6r7eIw/7alT3kdrIaU3shpbu6BT4NDI6atNzKKs+7naneBozvLLE0peL/gQA0xnVjcoM2KD
 di5BdmlWBHbtD6ma7ZBLos=
IronPort-HdrOrdr: A9a23:XtZmI6wElHoWjHQ9EVstKrPwIL1zdoMgy1knxilNoRw8SKKlfq
 eV7ZMmPH7P+VIssR4b+exoVJPtfZq+z+8R3WByB8bAYOCOggLBR+sO0WKL+UyHJ8SUzI9gPM
 lbHJSWcOeAb2RHsQ==
X-IronPort-AV: E=Sophos;i="5.93,198,1654574400"; 
   d="scan'208";a="76112333"
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
Subject: [PATCH v3] x86/xen: Add support for HVMOP_set_evtchn_upcall_vector
Date:   Thu, 28 Jul 2022 13:52:44 +0100
Message-ID: <20220728125244.19163-1-jane.malalane@citrix.com>
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
 drivers/xen/events/events_base.c   | 54 +++++++++++++++++++++++++++++++++-----
 include/xen/hvm.h                  |  2 ++
 include/xen/interface/hvm/hvm_op.h | 19 ++++++++++++++
 8 files changed, 101 insertions(+), 15 deletions(-)

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
index 46d9295d9a6e..3681770589f5 100644
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
@@ -2195,11 +2197,49 @@ void xen_setup_callback_vector(void)
 		callback_via = HVM_CALLBACK_VECTOR(HYPERVISOR_CALLBACK_VECTOR);
 		if (xen_set_callback_via(callback_via)) {
 			pr_err("Request for Xen HVM callback vector failed\n");
-			xen_have_vector_callback = 0;
+			xen_have_vector_callback = false;
 		}
 	}
 }
 
+/*
+ * Setup per-vCPU vector-type callbacks and trick toolstack to think
+ * we are enlightened. If this setup is unavailable, fallback to the
+ * global vector-type callback.
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
@@ -2210,8 +2250,11 @@ static __init void xen_alloc_callback_vector(void)
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
@@ -2271,10 +2314,9 @@ void __init xen_init_IRQ(void)
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

