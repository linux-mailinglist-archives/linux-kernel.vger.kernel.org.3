Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727404FA91D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiDIOyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiDIOym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B21BAA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 07:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C516D6152E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 14:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03DFC385A5;
        Sat,  9 Apr 2022 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649515954;
        bh=AweAUoBdAKuzo1n+8/CrQflOA7W+9f6gR5vJfLoviyo=;
        h=Date:From:To:Cc:Subject:From;
        b=t3YCYVQnfQT5+xhCKVHhDLni1IwpqO1FpJKFlEY0guKkzYuOlvoC15fMHgPtlDOza
         IWxYaJOE6yMhxkbrvzaj89+f0QgNlpqtChVfeSlFn/0si/9+EraGc4/lWinvH31Cnj
         yw6qfw6eDbESFPaCqQHJ8AZRL4oTJBjKTV4Gj0qnA+HxsJCEqLvNVMUsT0M9egkfm6
         +9/wsH2iOC0+vQiSZv7ndvQo1B+22mvXOTCDypkP28Gvr2bKtLa1WX0vMNAfNI1a4z
         f0fKZzdoHt5pgWMf4FykgXJuJLPwW3OR8Xs1PwpUiFPQ9aTcOwhPjrkwq/J9BoyM8I
         PasrH2Ve5lKNQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A8B9740407; Sat,  9 Apr 2022 11:52:31 -0300 (-03)
Date:   Sat, 9 Apr 2022 11:52:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ali Saidi <alisaidi@amazon.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools headers arm64: Sync arm64's cputype.h with the
 kernel sources
Message-ID: <YlGdr2pha0creLPo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

---

To get the changes in:

  83bea32ac7ed37bb ("arm64: Add part number for Arm Cortex-A78AE")

That addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Cc: Ali Saidi <alisaidi@amazon.com>
Cc: Andrew Kilroy <andrew.kilroy@arm.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: German Gomez <german.gomez@arm.com>
Cc: James Clark <james.clark@arm.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Will Deacon <will@kernel.org>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 9afcc6467a095c35..e09d6908a21d36b1 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -75,6 +75,7 @@
 #define ARM_CPU_PART_CORTEX_A77		0xD0D
 #define ARM_CPU_PART_NEOVERSE_V1	0xD40
 #define ARM_CPU_PART_CORTEX_A78		0xD41
+#define ARM_CPU_PART_CORTEX_A78AE	0xD42
 #define ARM_CPU_PART_CORTEX_X1		0xD44
 #define ARM_CPU_PART_CORTEX_A510	0xD46
 #define ARM_CPU_PART_CORTEX_A710	0xD47
@@ -130,6 +131,7 @@
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
 #define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
+#define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
 #define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
 #define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
 #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
-- 
2.35.1

