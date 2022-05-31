Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C72F538DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245219AbiEaJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245199AbiEaJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:27:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB32C10C;
        Tue, 31 May 2022 02:27:25 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24V827SS006595;
        Tue, 31 May 2022 09:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UDbPX2U1YNbiL7zOmx5MyeyBIyYdzLIQg588rIW/XEY=;
 b=LJek+H4oteqqW76QKmDzYwZbWxqthtNVCr1BAQwQtzxW0y1HBcFl8ie9Yd4Q/kizdBYY
 lhtmDGyYvh30lnnW9nHKNIOIajpgjxATjYr5zSgFMrAnc3MaCh3r0RMMM5c+GOMPlDAH
 HgomXu5A6LKtjlt9jfuqKxYlvZ/3hy0Pubu7FPZeuD30GYXNvugEWuD+jADnlCX7O67L
 q8hKjA5B3l5eTyTpsllp+sCVN2wcFQIG5Mj9VRnIm7gfCwx/ZYen6ttaVjmy3ofG3zyV
 myiXOtV7GzOIxiSGzw86gJDvVZJwKUlQcUUP28SoBTmME2V2EPAifjzwb2x3bVoTGyQl 2A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdc0en4rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 09:27:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24V9L9WG007342;
        Tue, 31 May 2022 09:27:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3gbcae3v3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 09:27:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24V9CrD647317384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 09:12:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9476A405B;
        Tue, 31 May 2022 09:27:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 984CDA4054;
        Tue, 31 May 2022 09:27:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 May 2022 09:27:14 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 6/7] perf list: Update event description for IBM z196/z114 to latest level
Date:   Tue, 31 May 2022 11:27:05 +0200
Message-Id: <20220531092706.1931503-6-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220531092706.1931503-1-tmricht@linux.ibm.com>
References: <20220531092706.1931503-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rh6IUMB_YrJoFZ5QLaRHJQKVKpGnEIRY
X-Proofpoint-ORIG-GUID: rh6IUMB_YrJoFZ5QLaRHJQKVKpGnEIRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_03,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update IBM z196/z114 event counter description to the latest level
as described in the documents
1. SA23-2260-07:
   "The Load-Program-Parameter and the CPU-Measurement Facilities."
   released on May, 2022
for the following counter sets:
   * Basic counter set
   * Problem counter set
   * Crypto counter set

2. SA23-2261-07:
   "The CPU-Measurement Facility Extended Counters Definition
    for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15 and z16"
released on April 29, 2022
for the following counter sets:
   * Extended counter set
   * MT-Diagnostic counter set

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z196/basic.json   | 48 +++++++-------
 .../pmu-events/arch/s390/cf_z196/crypto.json  | 64 +++++++++----------
 .../arch/s390/cf_z196/extended.json           | 44 ++++++-------
 3 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
index 783de7f1aeaa..9bd20a5f47af 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
@@ -3,84 +3,84 @@
 		"Unit": "CPU-M-CF",
 		"EventCode": "0",
 		"EventName": "CPU_CYCLES",
-		"BriefDescription": "CPU Cycles",
-		"PublicDescription": "Cycle Count"
+		"BriefDescription": "Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles, excluding the number of cycles while the CPU is in the wait state."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "1",
 		"EventName": "INSTRUCTIONS",
-		"BriefDescription": "Instructions",
-		"PublicDescription": "Instruction Count"
+		"BriefDescription": "Instruction Count",
+		"PublicDescription": "This counter counts the total number of instructions executed by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "2",
 		"EventName": "L1I_DIR_WRITES",
-		"BriefDescription": "L1I Directory Writes",
-		"PublicDescription": "Level-1 I-Cache Directory Write Count"
+		"BriefDescription": "Level-1 I-Cache Directory Write Count",
+		"PublicDescription": "This counter counts the total number of level-1 instruction-cache or unified-cache directory writes."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "3",
 		"EventName": "L1I_PENALTY_CYCLES",
-		"BriefDescription": "L1I Penalty Cycles",
-		"PublicDescription": "Level-1 I-Cache Penalty Cycle Count"
+		"BriefDescription": "Level-1 I-Cache Penalty Cycle Count",
+		"PublicDescription": "This counter counts the total number of cache penalty cycles for level-1 instruction cache or unified cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "4",
 		"EventName": "L1D_DIR_WRITES",
-		"BriefDescription": "L1D Directory Writes",
-		"PublicDescription": "Level-1 D-Cache Directory Write Count"
+		"BriefDescription": "Level-1 D-Cache Directory Write Count",
+		"PublicDescription": "This counter counts the total number of level-1 data-cache directory writes."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "5",
 		"EventName": "L1D_PENALTY_CYCLES",
-		"BriefDescription": "L1D Penalty Cycles",
-		"PublicDescription": "Level-1 D-Cache Penalty Cycle Count"
+		"BriefDescription": "Level-1 D-Cache Penalty Cycle Count",
+		"PublicDescription": "This counter counts the total number of cache penalty cycles for level-1 data cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "32",
 		"EventName": "PROBLEM_STATE_CPU_CYCLES",
-		"BriefDescription": "Problem-State CPU Cycles",
-		"PublicDescription": "Problem-State Cycle Count"
+		"BriefDescription": "Problem-State Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the CPU is in the problem state, excluding the number of cycles while the CPU is in the wait state."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "33",
 		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
-		"BriefDescription": "Problem-State Instructions",
-		"PublicDescription": "Problem-State Instruction Count"
+		"BriefDescription": "Problem-State Instruction Count",
+		"PublicDescription": "This counter counts the total number of instructions executed by the CPU while in the problem state."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "34",
 		"EventName": "PROBLEM_STATE_L1I_DIR_WRITES",
-		"BriefDescription": "Problem-State L1I Directory Writes",
-		"PublicDescription": "Problem-State Level-1 I-Cache Directory Write Count"
+		"BriefDescription": "Problem-State Level-1 I-Cache Directory Write Count",
+		"PublicDescription": "This counter counts the total number of level-1 instruction-cache or unified-cache directory writes while the CPU is in the problem state."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "35",
 		"EventName": "PROBLEM_STATE_L1I_PENALTY_CYCLES",
-		"BriefDescription": "Problem-State L1I Penalty Cycles",
-		"PublicDescription": "Problem-State Level-1 I-Cache Penalty Cycle Count"
+		"BriefDescription": "Level-1 I-Cache Penalty Cycle Count",
+		"PublicDescription": "This counter counts the total number of penalty cycles for level-1 instruction cache or unified cache while the CPU is in the problem state."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "36",
 		"EventName": "PROBLEM_STATE_L1D_DIR_WRITES",
-		"BriefDescription": "Problem-State L1D Directory Writes",
-		"PublicDescription": "Problem-State Level-1 D-Cache Directory Write Count"
+		"BriefDescription": "Problem-State Level-1 D-Cache Directory Write Count",
+		"PublicDescription": "This counter counts the total number of level-1 data-cache directory writes while the CPU is in the problem state."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "37",
 		"EventName": "PROBLEM_STATE_L1D_PENALTY_CYCLES",
-		"BriefDescription": "Problem-State L1D Penalty Cycles",
-		"PublicDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count"
+		"BriefDescription": "Problem-State Level-1 D-Cache Penalty Cycle Count",
+		"PublicDescription": "This counter counts the total number of penalty cycles for level-1 data cache while the CPU is in the problem state."
 	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
index 3f28007d3892..a8d391ddeb8c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
@@ -3,112 +3,112 @@
 		"Unit": "CPU-M-CF",
 		"EventCode": "64",
 		"EventName": "PRNG_FUNCTIONS",
-		"BriefDescription": "PRNG Functions",
-		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
+		"BriefDescription": "PRNG Function Count",
+		"PublicDescription": "This counter counts the total number of the pseudorandom-number-generation functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "65",
 		"EventName": "PRNG_CYCLES",
-		"BriefDescription": "PRNG Cycles",
-		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
+		"BriefDescription": "PRNG Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES/SHA coprocessor is busy performing the pseudorandom- number-generation functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "66",
 		"EventName": "PRNG_BLOCKED_FUNCTIONS",
-		"BriefDescription": "PRNG Blocked Functions",
-		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+		"BriefDescription": "PRNG Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the pseudorandom-number-generation functions that are issued by the CPU and are blocked because the DEA/AES/SHA coprocessor is busy performing a function issued by another CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "67",
 		"EventName": "PRNG_BLOCKED_CYCLES",
-		"BriefDescription": "PRNG Blocked Cycles",
-		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+		"BriefDescription": "PRNG Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the pseudorandom-number-generation functions issued by the CPU because the DEA/AES/SHA coprocessor is busy performing a function issued by another CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "68",
 		"EventName": "SHA_FUNCTIONS",
-		"BriefDescription": "SHA Functions",
-		"PublicDescription": "Total number of SHA functions issued by the CPU"
+		"BriefDescription": "SHA Function Count",
+		"PublicDescription": "This counter counts the total number of the SHA functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "69",
 		"EventName": "SHA_CYCLES",
-		"BriefDescription": "SHA Cycles",
-		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
+		"BriefDescription": "SHA Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "70",
 		"EventName": "SHA_BLOCKED_FUNCTIONS",
-		"BriefDescription": "SHA Blocked Functions",
-		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
+		"BriefDescription": "SHA Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "71",
 		"EventName": "SHA_BLOCKED_CYCLES",
-		"BriefDescription": "SHA Bloced Cycles",
-		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
+		"BriefDescription": "SHA Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "72",
 		"EventName": "DEA_FUNCTIONS",
-		"BriefDescription": "DEA Functions",
-		"PublicDescription": "Total number of the DEA functions issued by the CPU"
+		"BriefDescription": "DEA Function Count",
+		"PublicDescription": "This counter counts the total number of the DEA functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "73",
 		"EventName": "DEA_CYCLES",
-		"BriefDescription": "DEA Cycles",
-		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
+		"BriefDescription": "DEA Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "74",
 		"EventName": "DEA_BLOCKED_FUNCTIONS",
-		"BriefDescription": "DEA Blocked Functions",
-		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+		"BriefDescription": "DEA Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "75",
 		"EventName": "DEA_BLOCKED_CYCLES",
-		"BriefDescription": "DEA Blocked Cycles",
-		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+		"BriefDescription": "DEA Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "76",
 		"EventName": "AES_FUNCTIONS",
-		"BriefDescription": "AES Functions",
-		"PublicDescription": "Total number of AES functions issued by the CPU"
+		"BriefDescription": "AES Function Count",
+		"PublicDescription": "This counter counts the total number of the AES functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "77",
 		"EventName": "AES_CYCLES",
-		"BriefDescription": "AES Cycles",
-		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
+		"BriefDescription": "AES Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "78",
 		"EventName": "AES_BLOCKED_FUNCTIONS",
-		"BriefDescription": "AES Blocked Functions",
-		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+		"BriefDescription": "AES Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "79",
 		"EventName": "AES_BLOCKED_CYCLES",
-		"BriefDescription": "AES Blocked Cycles",
-		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
+		"BriefDescription": "AES Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU."
 	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
index 86b29fd181cf..6ebbdbaf7951 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
@@ -4,14 +4,14 @@
 		"EventCode": "128",
 		"EventName": "L1D_L2_SOURCED_WRITES",
 		"BriefDescription": "L1D L2 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from the Level-2 cache"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the returned cache line was sourced from the Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "129",
 		"EventName": "L1I_L2_SOURCED_WRITES",
 		"BriefDescription": "L1I L2 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from the Level-2 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache directory where the returned cache line was sourced from the Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
@@ -32,139 +32,139 @@
 		"EventCode": "133",
 		"EventName": "L2C_STORES_SENT",
 		"BriefDescription": "L2C Stores Sent",
-		"PublicDescription": "Incremented by one for every store sent to Level-2 cache"
+		"PublicDescription": "Incremented by one for every store sent to Level-2 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "134",
 		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Book L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Book Level-3 cache"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the returned cache line was sourced from an Off Book Level-3 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "L1D_ONBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Book L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the returned cache line was sourced from an On Book Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "136",
 		"EventName": "L1I_ONBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Book L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache directory where the returned cache line was sourced from an On Book Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "137",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "L1D_OFFBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Book L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the returned cache line was sourced from an Off Book Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "L1I_OFFBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Book L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache directory where the returned cache line was sourced from an Off Book Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "140",
 		"EventName": "DTLB1_HPAGE_WRITES",
 		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "141",
 		"EventName": "L1D_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1D Local Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)"
+		"PublicDescription": "A directory write to the Level-1 Data Cache where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "142",
 		"EventName": "L1I_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1I Local Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache where the installed cache line was sourced from memory that is attached to the same book as the Instruction cache (Local Memory)"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache where the installed cache line was sourced from memory that is attached to the same book as the Instruction cache (Local Memory)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "143",
 		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Book L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Book Level-3 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache directory where the returned cache line was sourced from an Off Book Level-3 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "144",
 		"EventName": "DTLB1_WRITES",
 		"BriefDescription": "DTLB1 Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer (DTLB1)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "ITLB1_WRITES",
 		"BriefDescription": "ITLB1 Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
+		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer (ITLB1)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "TLB2_PTE_WRITES",
 		"BriefDescription": "TLB2 PTE Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
 		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an On Chip Level-3 cache"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the returned cache line was sourced from an On Chip Level-3 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an On Chip Level-3 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache directory where the returned cache line was sourced from an On Chip Level-3 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache."
 	}
 ]
-- 
2.36.1

