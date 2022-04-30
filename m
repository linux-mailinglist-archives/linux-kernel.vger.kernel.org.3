Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902AE515FF5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiD3TGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbiD3TGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:06:41 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3A78FC9;
        Sat, 30 Apr 2022 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MVdeW0KDEm36SBPCc7oHGXe1uFCurve0F/GxdY6hTRo=;
  b=c3ZEE16Xz+DhnppuoqGFa3YC+DaYXSMLmS7sQzJMxr2HzAdVWx0w84la
   IW9pG4X/LjIsO7o1zv+UeBqkwj7SdM+nPmviv/Ecns8blDQ6xl8mSeNlk
   T7jD8kcLiU/HnoMqDZlmNFXOyk7e43sNxn1CPg9f25v+lnd0uc1xFHyX/
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,188,1647298800"; 
   d="scan'208";a="34084132"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:03:16 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH] MIPS: fix typos in comments
Date:   Sat, 30 Apr 2022 21:03:10 +0200
Message-Id: <20220430190310.7566-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/mips/alchemy/common/dbdma.c                 |    2 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c |    2 +-
 arch/mips/cavium-octeon/executive/cvmx-pko.c     |    2 +-
 arch/mips/cavium-octeon/octeon-irq.c             |    2 +-
 arch/mips/cavium-octeon/octeon-usb.c             |    2 +-
 arch/mips/dec/ioasic-irq.c                       |    4 ++--
 arch/mips/dec/setup.c                            |    2 +-
 arch/mips/fw/arc/memory.c                        |    2 +-
 arch/mips/jazz/irq.c                             |    2 +-
 arch/mips/kernel/cmpxchg.c                       |    2 +-
 arch/mips/kernel/cpu-probe.c                     |    2 +-
 arch/mips/kernel/idle.c                          |    2 +-
 arch/mips/kernel/perf_event_mipsxx.c             |    2 +-
 arch/mips/kvm/tlb.c                              |    2 +-
 arch/mips/net/bpf_jit_comp32.c                   |    2 +-
 arch/mips/pci/pcie-octeon.c                      |    2 +-
 arch/mips/pic32/pic32mzda/config.c               |    2 +-
 arch/mips/tools/loongson3-llsc-check.c           |    2 +-
 arch/mips/txx9/generic/pci.c                     |    2 +-
 19 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 1641d274fe37..c4d6b09136b1 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -329,7 +329,7 @@ static int mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
 	for (i = mipspmu.num_counters - 1; i >= 0; i--) {
 		/*
 		 * Note that some MIPS perf events can be counted by both
-		 * even and odd counters, wheresas many other are only by
+		 * even and odd counters, whereas many other are only by
 		 * even _or_ odd counters. This introduces an issue that
 		 * when the former kind of event takes the counter the
 		 * latter kind of event wants to use, then the "counter
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index a3b50d5e3b25..4e91971daae1 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -153,7 +153,7 @@ EXPORT_SYMBOL_GPL(kvm_vz_host_tlb_inv);
  * kvm_vz_guest_tlb_lookup() - Lookup a guest VZ TLB mapping.
  * @vcpu:	KVM VCPU pointer.
  * @gpa:	Guest virtual address in a TLB mapped guest segment.
- * @gpa:	Ponter to output guest physical address it maps to.
+ * @gpa:	Pointer to output guest physical address it maps to.
  *
  * Converts a guest virtual address in a guest TLB mapped segment to a guest
  * physical address, by probing the guest TLB.
diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 4ca2c28878e0..5ab043000409 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -574,7 +574,7 @@ u32 au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
 		dp++;
 	}
 
-	/* Make last descrptor point to the first. */
+	/* Make last descriptor point to the first. */
 	dp--;
 	dp->dscr_nxtptr = DSCR_NXTPTR(virt_to_phys(ctp->chan_desc_base));
 	ctp->get_ptr = ctp->put_ptr = ctp->cur_ptr = ctp->chan_desc_base;
diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index b63ad5d42cc7..306cee07ce3f 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -318,7 +318,7 @@ int64_t cvmx_bootmem_phy_alloc(uint64_t req_size, uint64_t address_min,
 		}
 
 		/*
-		 * Determine if this is an entry that can satisify the
+		 * Determine if this is an entry that can satisfy the
 		 * request Check to make sure entry is large enough to
 		 * satisfy request.
 		 */
diff --git a/arch/mips/cavium-octeon/executive/cvmx-pko.c b/arch/mips/cavium-octeon/executive/cvmx-pko.c
index ae8806e7bce2..15faca494c80 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-pko.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-pko.c
@@ -377,7 +377,7 @@ cvmx_pko_status_t cvmx_pko_config_port(uint64_t port, uint64_t base_queue,
 			/*
 			 * Check to make sure all static priority
 			 * queues are contiguous.  Also catches some
-			 * cases of static priorites not starting at
+			 * cases of static priorities not starting at
 			 * queue 0.
 			 */
 			if (static_priority_end != -1
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 66cf0e041b6f..e55c87d51df6 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1405,7 +1405,7 @@ static void octeon_irq_init_ciu2_percpu(void)
 	 * completed.
 	 *
 	 * There are 9 registers and 3 IPX levels with strides 0x1000
-	 * and 0x200 respectivly.  Use loops to clear them.
+	 * and 0x200 respectively.  Use loops to clear them.
 	 */
 	for (regx = 0; regx <= 0x8000; regx += 0x1000) {
 		for (ipx = 0; ipx <= 0x400; ipx += 0x200)
diff --git a/arch/mips/cavium-octeon/octeon-usb.c b/arch/mips/cavium-octeon/octeon-usb.c
index 4df919d26b08..5cffe1ed2447 100644
--- a/arch/mips/cavium-octeon/octeon-usb.c
+++ b/arch/mips/cavium-octeon/octeon-usb.c
@@ -419,7 +419,7 @@ static int dwc3_octeon_clocks_start(struct device *dev, u64 base)
 	/* Step 5c: Enable SuperSpeed. */
 	uctl_ctl.s.ref_ssp_en = 1;
 
-	/* Step 5d: Cofngiure PHYs. SKIP */
+	/* Step 5d: Configure PHYs. SKIP */
 
 	/* Step 6a & 6b: Power up PHYs. */
 	uctl_ctl.s.hs_power_en = 1;
diff --git a/arch/mips/fw/arc/memory.c b/arch/mips/fw/arc/memory.c
index ef5fc1ca1b5d..66188739f54d 100644
--- a/arch/mips/fw/arc/memory.c
+++ b/arch/mips/fw/arc/memory.c
@@ -32,7 +32,7 @@ static phys_addr_t prom_mem_size[MAX_PROM_MEM] __initdata;
 static unsigned int nr_prom_mem __initdata;
 
 /*
- * For ARC firmware memory functions the unit of meassuring memory is always
+ * For ARC firmware memory functions the unit of measuring memory is always
  * a 4k page of memory
  */
 #define ARC_PAGE_SHIFT	12
diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
index 495ba7cc56ec..264d453876aa 100644
--- a/arch/mips/jazz/irq.c
+++ b/arch/mips/jazz/irq.c
@@ -141,7 +141,7 @@ void __init plat_time_init(void)
 	/*
 	 * Set clock to 100Hz.
 	 *
-	 * The R4030 timer receives an input clock of 1kHz which is divieded by
+	 * The R4030 timer receives an input clock of 1kHz which is divided by
 	 * a programmable 4-bit divider.  This makes it fairly inflexible.
 	 */
 	r4030_write_reg32(JAZZ_TIMER_INTERVAL, 9);
diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
index ac9c8cfb2ba9..e974a4954df8 100644
--- a/arch/mips/kernel/cmpxchg.c
+++ b/arch/mips/kernel/cmpxchg.c
@@ -22,7 +22,7 @@ unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int s
 
 	/*
 	 * Calculate a shift & mask that correspond to the value we wish to
-	 * exchange within the naturally aligned 4 byte integerthat includes
+	 * exchange within the naturally aligned 4 byte integer that includes
 	 * it.
 	 */
 	shift = (unsigned long)ptr & 0x3;
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index f0ea92937546..d510f628ee03 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -156,7 +156,7 @@ static inline void check_errata(void)
 		/*
 		 * Erratum "RPS May Cause Incorrect Instruction Execution"
 		 * This code only handles VPE0, any SMP/RTOS code
-		 * making use of VPE1 will be responsable for that VPE.
+		 * making use of VPE1 will be responsible for that VPE.
 		 */
 		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
 			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 146d9fa77f75..53adcc1b2ed5 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -228,7 +228,7 @@ void __init check_wait(void)
 			break;
 
 		/*
-		 * Another rev is incremeting c0_count at a reduced clock
+		 * Another rev is incrementing c0_count at a reduced clock
 		 * rate while in WAIT mode.  So we basically have the choice
 		 * between using the cp0 timer as clocksource or avoiding
 		 * the WAIT instruction.  Until more details are known,
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
index d919a0d813a1..50a3394a9d25 100644
--- a/arch/mips/pci/pcie-octeon.c
+++ b/arch/mips/pci/pcie-octeon.c
@@ -1345,7 +1345,7 @@ static int __cvmx_pcie_rc_initialize_gen2(int pcie_port)
 	mem_access_subid.s.esw = 1;	/* Endian-swap for Writes. */
 	mem_access_subid.s.wtype = 0;	/* "No snoop" and "Relaxed ordering" are not set */
 	mem_access_subid.s.rtype = 0;	/* "No snoop" and "Relaxed ordering" are not set */
-	/* PCIe Adddress Bits <63:34>. */
+	/* PCIe Address Bits <63:34>. */
 	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
 		mem_access_subid.cn68xx.ba = 0;
 	else
diff --git a/arch/mips/pic32/pic32mzda/config.c b/arch/mips/pic32/pic32mzda/config.c
index 36afe1b5b9c7..f69532007717 100644
--- a/arch/mips/pic32/pic32mzda/config.c
+++ b/arch/mips/pic32/pic32mzda/config.c
@@ -111,7 +111,7 @@ void __init pic32_config_init(void)
 	pic32_reset_status = readl(pic32_conf_base + PIC32_RCON);
 	writel(-1, PIC32_CLR(pic32_conf_base + PIC32_RCON));
 
-	/* Device Inforation */
+	/* Device Information */
 	pr_info("Device Id: 0x%08x, Device Ver: 0x%04x\n",
 		pic32_get_device_id(),
 		pic32_get_device_version());
diff --git a/arch/mips/tools/loongson3-llsc-check.c b/arch/mips/tools/loongson3-llsc-check.c
index bdbc7b4324ec..5f68a4fa8a7e 100644
--- a/arch/mips/tools/loongson3-llsc-check.c
+++ b/arch/mips/tools/loongson3-llsc-check.c
@@ -217,7 +217,7 @@ static int check_code(uint64_t pc, uint32_t *code, size_t sz)
 )
 
 	/*
-	 * Skip the first instructionm allowing check_ll to look backwards
+	 * Skip the first instruction, allowing check_ll to look backwards
 	 * unconditionally.
 	 */
 	advance();
diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index fb998726bd5d..e98845543b77 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -225,7 +225,7 @@ txx9_alloc_pci_controller(struct pci_controller *pcic,
 static int __init
 txx9_arch_pci_init(void)
 {
-	PCIBIOS_MIN_IO = 0x8000;	/* reseve legacy I/O space */
+	PCIBIOS_MIN_IO = 0x8000;	/* reserve legacy I/O space */
 	return 0;
 }
 arch_initcall(txx9_arch_pci_init);
diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 044b11b65bca..83c975d5cca2 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -722,7 +722,7 @@ static void emit_atomic_r32(struct jit_context *ctx,
 		  0, JIT_RESERVED_STACK);
 	/*
 	 * Argument 1: dst+off if xchg, otherwise src, passed in register a0
-	 * Argument 2: src if xchg, othersize dst+off, passed in register a1
+	 * Argument 2: src if xchg, otherwise dst+off, passed in register a1
 	 */
 	emit(ctx, move, MIPS_R_T9, dst);
 	if (code == BPF_XCHG) {
diff --git a/arch/mips/dec/ioasic-irq.c b/arch/mips/dec/ioasic-irq.c
index 130eb67bd3c9..971f7b46759b 100644
--- a/arch/mips/dec/ioasic-irq.c
+++ b/arch/mips/dec/ioasic-irq.c
@@ -68,13 +68,13 @@ static struct irq_chip ioasic_dma_irq_type = {
  * I/O ASIC implements two kinds of DMA interrupts, informational and
  * error interrupts.
  *
- * The formers do not stop DMA and should be cleared as soon as possible
+ * The former do not stop DMA and should be cleared as soon as possible
  * so that if they retrigger before the handler has completed, usually as
  * a side effect of actions taken by the handler, then they are reissued.
  * These use the `handle_edge_irq' handler that clears the request right
  * away.
  *
- * The latters stop DMA and do not resume it until the interrupt has been
+ * The latter stop DMA and do not resume it until the interrupt has been
  * cleared.  This cannot be done until after a corrective action has been
  * taken and this also means they will not retrigger.  Therefore they use
  * the `handle_fasteoi_irq' handler that only clears the request on the
diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
index 82b00e45ce50..6c3704f51d0d 100644
--- a/arch/mips/dec/setup.c
+++ b/arch/mips/dec/setup.c
@@ -71,7 +71,7 @@ volatile u32 *ioasic_base;
 EXPORT_SYMBOL(ioasic_base);
 
 /*
- * IRQ routing and priority tables.  Priorites are set as follows:
+ * IRQ routing and priority tables.  Priorities are set as follows:
  *
  *		KN01	KN230	KN02	KN02-BA	KN02-CA	KN03
  *

