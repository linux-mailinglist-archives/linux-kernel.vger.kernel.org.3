Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33E94F0E61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 06:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377221AbiDDEyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 00:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377204AbiDDEx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 00:53:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74C61396B7;
        Sun,  3 Apr 2022 21:51:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FCF51FB;
        Sun,  3 Apr 2022 21:51:30 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.36.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 329FF3F5A1;
        Sun,  3 Apr 2022 21:51:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, acme@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V5 8/8] perf/tools: Add PERF_BR_NEW_ARCH_[N] map for BRBE on arm64 platform
Date:   Mon,  4 Apr 2022 10:20:46 +0530
Message-Id: <20220404045046.634522-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404045046.634522-1-anshuman.khandual@arm.com>
References: <20220404045046.634522-1-anshuman.khandual@arm.com>
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

This updates the perf tool with arch specific branch type classification
used for BRBE on arm64 platform as added in the kernel earlier.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/include/uapi/linux/perf_event.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 193dba2ecdc1..4cf1c8e22cab 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -282,6 +282,12 @@ enum {
 	PERF_BR_PRIV_HV		= 3,
 };
 
+#define PERF_BR_ARM64_FIQ		PERF_BR_NEW_ARCH_1
+#define PERF_BR_ARM64_DEBUG_HALT	PERF_BR_NEW_ARCH_2
+#define PERF_BR_ARM64_DEBUG_EXIT	PERF_BR_NEW_ARCH_3
+#define PERF_BR_ARM64_DEBUG_INST	PERF_BR_NEW_ARCH_4
+#define PERF_BR_ARM64_DEBUG_DATA	PERF_BR_NEW_ARCH_5
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
-- 
2.25.1

