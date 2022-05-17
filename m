Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50011529F54
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbiEQKXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344810AbiEQKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:21:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E22084BFD0;
        Tue, 17 May 2022 03:20:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF2B912FC;
        Tue, 17 May 2022 03:20:19 -0700 (PDT)
Received: from e121896.warwick.arm.com (e121896.warwick.arm.com [10.32.33.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F8EC3F66F;
        Tue, 17 May 2022 03:20:17 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org
Cc:     german.gomez@arm.com, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] perf tools: arm64: Copy perf_regs.h from the kernel
Date:   Tue, 17 May 2022 11:20:02 +0100
Message-Id: <20220517102005.3022017-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220517102005.3022017-1-james.clark@arm.com>
References: <20220517102005.3022017-1-james.clark@arm.com>
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

Get the updated header for the newly added VG register.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/arch/arm64/include/uapi/asm/perf_regs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
index d54daafa89e3..fd157f46727e 100644
--- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
+++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
@@ -36,6 +36,11 @@ enum perf_event_arm_regs {
 	PERF_REG_ARM64_LR,
 	PERF_REG_ARM64_SP,
 	PERF_REG_ARM64_PC,
-	PERF_REG_ARM64_MAX,
+
+	/* Extended/pseudo registers */
+	PERF_REG_ARM64_VG = 46, // SVE Vector Granule
+
+	PERF_REG_ARM64_MAX = PERF_REG_ARM64_PC + 1,
+	PERF_REG_ARM64_EXTENDED_MAX = PERF_REG_ARM64_VG + 1
 };
 #endif /* _ASM_ARM64_PERF_REGS_H */
-- 
2.28.0

