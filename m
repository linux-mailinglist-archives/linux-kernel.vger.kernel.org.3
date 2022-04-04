Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A2C4F1562
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348539AbiDDNFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiDDNFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:05:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 598B03D1F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:03:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 122DB1474;
        Mon,  4 Apr 2022 06:03:24 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 284023F5A1;
        Mon,  4 Apr 2022 06:03:23 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] ARM: vexpress/spc: Fix all the doxygen build warnings
Date:   Mon,  4 Apr 2022 14:02:07 +0100
Message-Id: <20220404130207.1162445-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220404130207.1162445-1-sudeep.holla@arm.com>
References: <20220404130207.1162445-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more doxygen build warnings as below than the ones reported
by kernel test robot recently.

  |  arch/arm/mach-vexpress/spc.c:125: warning: missing initial short description on line:
  |   * ve_spc_global_wakeup_irq()
  |  arch/arm/mach-vexpress/spc.c:131: warning: contents before sections
  |  arch/arm/mach-vexpress/spc.c:148: warning: missing initial short description on line:
  |   * ve_spc_cpu_wakeup_irq()
  |  arch/arm/mach-vexpress/spc.c:154: warning: contents before sections
  |  arch/arm/mach-vexpress/spc.c:203: warning: missing initial short description on line:
  |   * ve_spc_powerdown()
  |  arch/arm/mach-vexpress/spc.c:209: warning: contents before sections
  |  arch/arm/mach-vexpress/spc.c:231: warning: missing initial short description on line:
  |   * ve_spc_cpu_in_wfi()
  |  7 warnings

Fix all the warnings.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/mach-vexpress/spc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 8f99d47d4b89..6e6985e756af 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -122,13 +122,13 @@ static inline bool cluster_is_a15(u32 cluster)
 }
 
 /**
- * ve_spc_global_wakeup_irq()
+ * ve_spc_global_wakeup_irq() - sets/clears global wakeup IRQs
+ *
+ * @set: if true, global wake-up IRQs are set, if false they are cleared
  *
  * Function to set/clear global wakeup IRQs. Not protected by locking since
  * it might be used in code paths where normal cacheable locks are not
  * working. Locking must be provided by the caller to ensure atomicity.
- *
- * @set: if true, global wake-up IRQs are set, if false they are cleared
  */
 void ve_spc_global_wakeup_irq(bool set)
 {
@@ -145,15 +145,15 @@ void ve_spc_global_wakeup_irq(bool set)
 }
 
 /**
- * ve_spc_cpu_wakeup_irq()
- *
- * Function to set/clear per-CPU wake-up IRQs. Not protected by locking since
- * it might be used in code paths where normal cacheable locks are not
- * working. Locking must be provided by the caller to ensure atomicity.
+ * ve_spc_cpu_wakeup_irq() - sets/clears per-CPU wake-up IRQs
  *
  * @cluster: mpidr[15:8] bitfield describing cluster affinity level
  * @cpu: mpidr[7:0] bitfield describing cpu affinity level
  * @set: if true, wake-up IRQs are set, if false they are cleared
+ *
+ * Function to set/clear per-CPU wake-up IRQs. Not protected by locking since
+ * it might be used in code paths where normal cacheable locks are not
+ * working. Locking must be provided by the caller to ensure atomicity.
  */
 void ve_spc_cpu_wakeup_irq(u32 cluster, u32 cpu, bool set)
 {
@@ -200,14 +200,14 @@ void ve_spc_set_resume_addr(u32 cluster, u32 cpu, u32 addr)
 }
 
 /**
- * ve_spc_powerdown()
+ * ve_spc_powerdown() - enables/disables cluster powerdown
+ *
+ * @cluster: mpidr[15:8] bitfield describing cluster affinity level
+ * @enable: if true enables powerdown, if false disables it
  *
  * Function to enable/disable cluster powerdown. Not protected by locking
  * since it might be used in code paths where normal cacheable locks are not
  * working. Locking must be provided by the caller to ensure atomicity.
- *
- * @cluster: mpidr[15:8] bitfield describing cluster affinity level
- * @enable: if true enables powerdown, if false disables it
  */
 void ve_spc_powerdown(u32 cluster, bool enable)
 {
@@ -228,7 +228,7 @@ static u32 standbywfi_cpu_mask(u32 cpu, u32 cluster)
 }
 
 /**
- * ve_spc_cpu_in_wfi()
+ * ve_spc_cpu_in_wfi() - Checks if the specified CPU is in WFI or not
  *
  * @cpu: mpidr[7:0] bitfield describing CPU affinity level within cluster
  * @cluster: mpidr[15:8] bitfield describing cluster affinity level
-- 
2.35.1

