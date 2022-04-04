Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C324F1561
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbiDDNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbiDDNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:05:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5A8A3CA6B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:03:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CEE8D6E;
        Mon,  4 Apr 2022 06:03:20 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80CB23F5A1;
        Mon,  4 Apr 2022 06:03:19 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] ARM: vexpress/spc: Fix doxygen comments
Date:   Mon,  4 Apr 2022 14:02:06 +0100
Message-Id: <20220404130207.1162445-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.35.1
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

Kbuild bot reported the following doxygen build warning:

  |  arch/arm/mach-versatile/spc.c:231: warning: This comment starts with
  |		'/**', but isn't a kernel-doc comment.
  |		Refer Documentation/doc-guide/kernel-doc.rst
  |  		* ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)

Fix the issue by dropping the parameters specified in the kernel doc.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-doc/202204031026.4ogKxt89-lkp@intel.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/mach-vexpress/spc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 1c6500c4e6a1..8f99d47d4b89 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -228,7 +228,7 @@ static u32 standbywfi_cpu_mask(u32 cpu, u32 cluster)
 }
 
 /**
- * ve_spc_cpu_in_wfi(u32 cpu, u32 cluster)
+ * ve_spc_cpu_in_wfi()
  *
  * @cpu: mpidr[7:0] bitfield describing CPU affinity level within cluster
  * @cluster: mpidr[15:8] bitfield describing cluster affinity level
-- 
2.35.1

