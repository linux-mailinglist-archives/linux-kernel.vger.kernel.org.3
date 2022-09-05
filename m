Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC845AD1B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbiIELkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiIELkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:40:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DADCD27B38;
        Mon,  5 Sep 2022 04:40:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFE64ED1;
        Mon,  5 Sep 2022 04:40:42 -0700 (PDT)
Received: from hype-n1-sdp.warwick.arm.com (hype-n1-sdp.warwick.arm.com [10.32.32.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6D723F7B4;
        Mon,  5 Sep 2022 04:40:34 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] perf vendor events: Add missing Neoverse V1 events
Date:   Mon,  5 Sep 2022 12:40:24 +0100
Message-Id: <20220905114024.7552-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on updated data from:
https://github.com/ARM-software/data/blob/master/pmu/neoverse-v1.json

which is based on PMU event descriptions from the Arm Neoverse V1
Technical Reference Manual.

This adds the following missing events:
ASE_INST_SPEC
SVE_INST_SPEC
SVE_PRED_SPEC
SVE_PRED_EMPTY_SPEC
SVE_PRED_FULL_SPEC
SVE_PRED_PARTIAL_SPEC
SVE_LDFF_SPEC
SVE_LDFF_FAULT_SPEC
FP_SCALE_OPS_SPEC
FP_FIXED_OPS_SPEC

Reviewed-by: John Garry <john.garry@huawei.com> 
Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
V1 -> V2: Remove REMOTE_ACCESS re-categorisation (to be submitted
separately)
 .../arm64/arm/neoverse-v1/instruction.json    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
index 25825e14c535..e29b88fb7f24 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
@@ -85,5 +85,35 @@
     },
     {
         "ArchStdEvent": "RC_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_EMPTY_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_FULL_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_PRED_PARTIAL_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_SPEC"
+    },
+    {
+        "ArchStdEvent": "SVE_LDFF_FAULT_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_SCALE_OPS_SPEC"
+    },
+    {
+        "ArchStdEvent": "FP_FIXED_OPS_SPEC"
     }
 ]
-- 
2.25.1

