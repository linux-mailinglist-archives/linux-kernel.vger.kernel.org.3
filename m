Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A41B467782
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380861AbhLCMky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:40:54 -0500
Received: from foss.arm.com ([217.140.110.172]:48836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380554AbhLCMkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:40:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF7211396;
        Fri,  3 Dec 2021 04:37:21 -0800 (PST)
Received: from e124483.arm.com (unknown [10.57.35.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 224C63F7D7;
        Fri,  3 Dec 2021 04:37:18 -0800 (PST)
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] perf vendor events: Fix whitespace
Date:   Fri,  3 Dec 2021 12:35:22 +0000
Message-Id: <20211203123525.31127-2-andrew.kilroy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203123525.31127-1-andrew.kilroy@arm.com>
References: <20211203123525.31127-1-andrew.kilroy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct indentation to 4 spaces, same as the other json files.

Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
---
 .../arch/arm64/armv8-recommended.json         | 202 +++++++++---------
 1 file changed, 101 insertions(+), 101 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
index d0a19866563d..210afa856091 100644
--- a/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
+++ b/tools/perf/pmu-events/arch/arm64/armv8-recommended.json
@@ -148,305 +148,305 @@
         "EventCode": "0x60",
         "EventName": "BUS_ACCESS_RD",
         "BriefDescription": "Bus access read"
-   },
-   {
+    },
+    {
         "PublicDescription": "Bus access write",
         "EventCode": "0x61",
         "EventName": "BUS_ACCESS_WR",
         "BriefDescription": "Bus access write"
-   },
-   {
+    },
+    {
         "PublicDescription": "Bus access, Normal, Cacheable, Shareable",
         "EventCode": "0x62",
         "EventName": "BUS_ACCESS_SHARED",
         "BriefDescription": "Bus access, Normal, Cacheable, Shareable"
-   },
-   {
+    },
+    {
         "PublicDescription": "Bus access, not Normal, Cacheable, Shareable",
         "EventCode": "0x63",
         "EventName": "BUS_ACCESS_NOT_SHARED",
         "BriefDescription": "Bus access, not Normal, Cacheable, Shareable"
-   },
-   {
+    },
+    {
         "PublicDescription": "Bus access, Normal",
         "EventCode": "0x64",
         "EventName": "BUS_ACCESS_NORMAL",
         "BriefDescription": "Bus access, Normal"
-   },
-   {
+    },
+    {
         "PublicDescription": "Bus access, peripheral",
         "EventCode": "0x65",
         "EventName": "BUS_ACCESS_PERIPH",
         "BriefDescription": "Bus access, peripheral"
-   },
-   {
+    },
+    {
         "PublicDescription": "Data memory access, read",
         "EventCode": "0x66",
         "EventName": "MEM_ACCESS_RD",
         "BriefDescription": "Data memory access, read"
-   },
-   {
+    },
+    {
         "PublicDescription": "Data memory access, write",
         "EventCode": "0x67",
         "EventName": "MEM_ACCESS_WR",
         "BriefDescription": "Data memory access, write"
-   },
-   {
+    },
+    {
         "PublicDescription": "Unaligned access, read",
         "EventCode": "0x68",
         "EventName": "UNALIGNED_LD_SPEC",
         "BriefDescription": "Unaligned access, read"
-   },
-   {
+    },
+    {
         "PublicDescription": "Unaligned access, write",
         "EventCode": "0x69",
         "EventName": "UNALIGNED_ST_SPEC",
         "BriefDescription": "Unaligned access, write"
-   },
-   {
+    },
+    {
         "PublicDescription": "Unaligned access",
         "EventCode": "0x6a",
         "EventName": "UNALIGNED_LDST_SPEC",
         "BriefDescription": "Unaligned access"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exclusive operation speculatively executed, LDREX or LDX",
         "EventCode": "0x6c",
         "EventName": "LDREX_SPEC",
         "BriefDescription": "Exclusive operation speculatively executed, LDREX or LDX"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exclusive operation speculatively executed, STREX or STX pass",
         "EventCode": "0x6d",
         "EventName": "STREX_PASS_SPEC",
         "BriefDescription": "Exclusive operation speculatively executed, STREX or STX pass"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exclusive operation speculatively executed, STREX or STX fail",
         "EventCode": "0x6e",
         "EventName": "STREX_FAIL_SPEC",
         "BriefDescription": "Exclusive operation speculatively executed, STREX or STX fail"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exclusive operation speculatively executed, STREX or STX",
         "EventCode": "0x6f",
         "EventName": "STREX_SPEC",
         "BriefDescription": "Exclusive operation speculatively executed, STREX or STX"
-   },
-   {
+    },
+    {
         "PublicDescription": "Operation speculatively executed, load",
         "EventCode": "0x70",
         "EventName": "LD_SPEC",
         "BriefDescription": "Operation speculatively executed, load"
-   },
-   {
+    },
+    {
         "PublicDescription": "Operation speculatively executed, store",
         "EventCode": "0x71",
         "EventName": "ST_SPEC",
         "BriefDescription": "Operation speculatively executed, store"
-   },
-   {
+    },
+    {
         "PublicDescription": "Operation speculatively executed, load or store",
         "EventCode": "0x72",
         "EventName": "LDST_SPEC",
         "BriefDescription": "Operation speculatively executed, load or store"
-   },
-   {
+    },
+    {
         "PublicDescription": "Operation speculatively executed, integer data processing",
         "EventCode": "0x73",
         "EventName": "DP_SPEC",
         "BriefDescription": "Operation speculatively executed, integer data processing"
-   },
-   {
+    },
+    {
         "PublicDescription": "Operation speculatively executed, Advanced SIMD instruction",
         "EventCode": "0x74",
         "EventName": "ASE_SPEC",
         "BriefDescription": "Operation speculatively executed, Advanced SIMD instruction"
-   },
-   {
+    },
+    {
         "PublicDescription": "Operation speculatively executed, floating-point instruction",
         "EventCode": "0x75",
         "EventName": "VFP_SPEC",
         "BriefDescription": "Operation speculatively executed, floating-point instruction"
-   },
-   {
+    },
+    {
         "PublicDescription": "Operation speculatively executed, software change of the PC",
         "EventCode": "0x76",
         "EventName": "PC_WRITE_SPEC",
         "BriefDescription": "Operation speculatively executed, software change of the PC"
-   },
-   {
+    },
+    {
         "PublicDescription": "Operation speculatively executed, Cryptographic instruction",
         "EventCode": "0x77",
         "EventName": "CRYPTO_SPEC",
         "BriefDescription": "Operation speculatively executed, Cryptographic instruction"
-   },
-   {
+    },
+    {
         "PublicDescription": "Branch speculatively executed, immediate branch",
         "EventCode": "0x78",
         "EventName": "BR_IMMED_SPEC",
         "BriefDescription": "Branch speculatively executed, immediate branch"
-   },
-   {
+    },
+    {
         "PublicDescription": "Branch speculatively executed, procedure return",
         "EventCode": "0x79",
         "EventName": "BR_RETURN_SPEC",
         "BriefDescription": "Branch speculatively executed, procedure return"
-   },
-   {
+    },
+    {
         "PublicDescription": "Branch speculatively executed, indirect branch",
         "EventCode": "0x7a",
         "EventName": "BR_INDIRECT_SPEC",
         "BriefDescription": "Branch speculatively executed, indirect branch"
-   },
-   {
+    },
+    {
         "PublicDescription": "Barrier speculatively executed, ISB",
         "EventCode": "0x7c",
         "EventName": "ISB_SPEC",
         "BriefDescription": "Barrier speculatively executed, ISB"
-   },
-   {
+    },
+    {
         "PublicDescription": "Barrier speculatively executed, DSB",
         "EventCode": "0x7d",
         "EventName": "DSB_SPEC",
         "BriefDescription": "Barrier speculatively executed, DSB"
-   },
-   {
+    },
+    {
         "PublicDescription": "Barrier speculatively executed, DMB",
         "EventCode": "0x7e",
         "EventName": "DMB_SPEC",
         "BriefDescription": "Barrier speculatively executed, DMB"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, Other synchronous",
         "EventCode": "0x81",
         "EventName": "EXC_UNDEF",
         "BriefDescription": "Exception taken, Other synchronous"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, Supervisor Call",
         "EventCode": "0x82",
         "EventName": "EXC_SVC",
         "BriefDescription": "Exception taken, Supervisor Call"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, Instruction Abort",
         "EventCode": "0x83",
         "EventName": "EXC_PABORT",
         "BriefDescription": "Exception taken, Instruction Abort"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, Data Abort and SError",
         "EventCode": "0x84",
         "EventName": "EXC_DABORT",
         "BriefDescription": "Exception taken, Data Abort and SError"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, IRQ",
         "EventCode": "0x86",
         "EventName": "EXC_IRQ",
         "BriefDescription": "Exception taken, IRQ"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, FIQ",
         "EventCode": "0x87",
         "EventName": "EXC_FIQ",
         "BriefDescription": "Exception taken, FIQ"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, Secure Monitor Call",
         "EventCode": "0x88",
         "EventName": "EXC_SMC",
         "BriefDescription": "Exception taken, Secure Monitor Call"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, Hypervisor Call",
         "EventCode": "0x8a",
         "EventName": "EXC_HVC",
         "BriefDescription": "Exception taken, Hypervisor Call"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, Instruction Abort not taken locally",
         "EventCode": "0x8b",
         "EventName": "EXC_TRAP_PABORT",
         "BriefDescription": "Exception taken, Instruction Abort not taken locally"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, Data Abort or SError not taken locally",
         "EventCode": "0x8c",
         "EventName": "EXC_TRAP_DABORT",
         "BriefDescription": "Exception taken, Data Abort or SError not taken locally"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, Other traps not taken locally",
         "EventCode": "0x8d",
         "EventName": "EXC_TRAP_OTHER",
         "BriefDescription": "Exception taken, Other traps not taken locally"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, IRQ not taken locally",
         "EventCode": "0x8e",
         "EventName": "EXC_TRAP_IRQ",
         "BriefDescription": "Exception taken, IRQ not taken locally"
-   },
-   {
+    },
+    {
         "PublicDescription": "Exception taken, FIQ not taken locally",
         "EventCode": "0x8f",
         "EventName": "EXC_TRAP_FIQ",
         "BriefDescription": "Exception taken, FIQ not taken locally"
-   },
-   {
+    },
+    {
         "PublicDescription": "Release consistency operation speculatively executed, Load-Acquire",
         "EventCode": "0x90",
         "EventName": "RC_LD_SPEC",
         "BriefDescription": "Release consistency operation speculatively executed, Load-Acquire"
-   },
-   {
+    },
+    {
         "PublicDescription": "Release consistency operation speculatively executed, Store-Release",
         "EventCode": "0x91",
         "EventName": "RC_ST_SPEC",
         "BriefDescription": "Release consistency operation speculatively executed, Store-Release"
-   },
-   {
+    },
+    {
         "PublicDescription": "Attributable Level 3 data or unified cache access, read",
         "EventCode": "0xa0",
         "EventName": "L3D_CACHE_RD",
         "BriefDescription": "Attributable Level 3 data or unified cache access, read"
-   },
-   {
+    },
+    {
         "PublicDescription": "Attributable Level 3 data or unified cache access, write",
         "EventCode": "0xa1",
         "EventName": "L3D_CACHE_WR",
         "BriefDescription": "Attributable Level 3 data or unified cache access, write"
-   },
-   {
+    },
+    {
         "PublicDescription": "Attributable Level 3 data or unified cache refill, read",
         "EventCode": "0xa2",
         "EventName": "L3D_CACHE_REFILL_RD",
         "BriefDescription": "Attributable Level 3 data or unified cache refill, read"
-   },
-   {
+    },
+    {
         "PublicDescription": "Attributable Level 3 data or unified cache refill, write",
         "EventCode": "0xa3",
         "EventName": "L3D_CACHE_REFILL_WR",
         "BriefDescription": "Attributable Level 3 data or unified cache refill, write"
-   },
-   {
+    },
+    {
         "PublicDescription": "Attributable Level 3 data or unified cache Write-Back, victim",
         "EventCode": "0xa6",
         "EventName": "L3D_CACHE_WB_VICTIM",
         "BriefDescription": "Attributable Level 3 data or unified cache Write-Back, victim"
-   },
-   {
+    },
+    {
         "PublicDescription": "Attributable Level 3 data or unified cache Write-Back, cache clean",
         "EventCode": "0xa7",
         "EventName": "L3D_CACHE_WB_CLEAN",
         "BriefDescription": "Attributable Level 3 data or unified cache Write-Back, cache clean"
-   },
-   {
+    },
+    {
         "PublicDescription": "Attributable Level 3 data or unified cache access, invalidate",
         "EventCode": "0xa8",
         "EventName": "L3D_CACHE_INVAL",
         "BriefDescription": "Attributable Level 3 data or unified cache access, invalidate"
-   }
+    }
 ]
-- 
2.17.1

