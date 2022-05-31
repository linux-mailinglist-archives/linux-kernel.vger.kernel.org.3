Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8E538DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbiEaJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245201AbiEaJ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:27:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0742AE2E;
        Tue, 31 May 2022 02:27:25 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24V8opMt011724;
        Tue, 31 May 2022 09:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PCdYYeNj4zdQRlviCp94ABzeLSZuSY3j/lfabiITTOY=;
 b=PX7xc7tiZgzRC3bzhgW0XXMOQGxodAKT7Tn8J2TiNJGVmsbpTCKxUPKTpyW93TIzUABL
 p6is2+ORhnUiwkkaPAIFtMzYL/PyIVHuWrM3pOHSeJICsByf8Cvu43ES3T02R7Ssvpac
 7+rKlD6aRzLS/vZ3N3gMHA4k8ZGQ5n8Nj5nVKYxvvxKbZAkgVT3struY4S0B88r/ELll
 wDAswAzZhT39LLW+EgC3zZ5Y8eLYa0hu6LmX1ejWOhiLqvBfxQFRgeG4Qeg1ztMLjpK/
 VQ2Ry+FpCWV9cUzWBaGXwjlR6sRZ8fJVyfViyOXWYD2zXBSX+rSm2UCbObP3ykNYDZim Sg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdfva0qpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 09:27:20 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24V9LDb6003382;
        Tue, 31 May 2022 09:27:15 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3gbcc6awj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 09:27:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24V9Q7kl33554824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 09:26:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD5F6A405C;
        Tue, 31 May 2022 09:27:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C6EAA405B;
        Tue, 31 May 2022 09:27:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 May 2022 09:27:11 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/7] perf list: Update event description for IBM z13 to latest level
Date:   Tue, 31 May 2022 11:27:02 +0200
Message-Id: <20220531092706.1931503-3-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220531092706.1931503-1-tmricht@linux.ibm.com>
References: <20220531092706.1931503-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mutfej-gVvtNbXjYNspbdnXqiPeY65NV
X-Proofpoint-GUID: mutfej-gVvtNbXjYNspbdnXqiPeY65NV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_03,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2205310047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update IBM z13 event counter description to the latest level
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
 .../pmu-events/arch/s390/cf_z13/basic.json    |  48 ++++-----
 .../pmu-events/arch/s390/cf_z13/crypto.json   |  64 +++++------
 .../pmu-events/arch/s390/cf_z13/extended.json | 100 +++++++++---------
 3 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
index 783de7f1aeaa..9bd20a5f47af 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/basic.json
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
index 3f28007d3892..a8d391ddeb8c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/crypto.json
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
index 1a5e4f89c57e..99c1b93a7e36 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
@@ -11,7 +11,7 @@
 		"EventCode": "129",
 		"EventName": "DTLB1_WRITES",
 		"BriefDescription": "DTLB1 Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer (DTLB1)."
 	},
 	{
 		"Unit": "CPU-M-CF",
@@ -25,7 +25,7 @@
 		"EventCode": "131",
 		"EventName": "DTLB1_HPAGE_WRITES",
 		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page."
 	},
 	{
 		"Unit": "CPU-M-CF",
@@ -39,63 +39,63 @@
 		"EventCode": "133",
 		"EventName": "L1D_L2D_SOURCED_WRITES",
 		"BriefDescription": "L1D L2D Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "134",
 		"EventName": "ITLB1_WRITES",
 		"BriefDescription": "ITLB1 Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
+		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer (ITLB1)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "ITLB1_MISSES",
 		"BriefDescription": "ITLB1 Misses",
-		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle an ITLB1 miss is in progress"
+		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle an ITLB1 miss is in progress."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "136",
 		"EventName": "L1I_L2I_SOURCED_WRITES",
 		"BriefDescription": "L1I L2I Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "137",
 		"EventName": "TLB2_PTE_WRITES",
 		"BriefDescription": "TLB2 PTE Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
 		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Combined Region Segment Table Entry arrays for a one-megabyte large page translation"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Combined Region Segment Table Entry arrays for a one-megabyte large page translation."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Combined Region Segment Table Entry arrays"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Combined Region Segment Table Entry arrays."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "140",
 		"EventName": "TX_C_TEND",
 		"BriefDescription": "Completed TEND instructions in constrained TX mode",
-		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode"
+		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "141",
 		"EventName": "TX_NC_TEND",
 		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
-		"PublicDescription": "A TEND instruction has completed in a non-constrained transactional-execution mode"
+		"PublicDescription": "A TEND instruction has completed in a non-constrained transactional-execution mode."
 	},
 	{
 		"Unit": "CPU-M-CF",
@@ -109,273 +109,273 @@
 		"EventCode": "144",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "L1D_ONNODE_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Node L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "L1D_ONNODE_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Node L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "L1D_ONNODE_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Node L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Node Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "149",
 		"EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "L1D_ONDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Drawer L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "151",
 		"EventName": "L1D_ONDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Drawer L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "L1D_OFFDRAWER_SCOL_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Same-Column L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Drawer Same-Column L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "154",
 		"EventName": "L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Same-Column L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "L1D_OFFDRAWER_FCOL_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "156",
 		"EventName": "L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "157",
 		"EventName": "L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Far-Column L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "158",
 		"EventName": "L1D_ONNODE_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Node Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Node memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Node memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "159",
 		"EventName": "L1D_ONDRAWER_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Drawer Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "160",
 		"EventName": "L1D_OFFDRAWER_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "161",
 		"EventName": "L1D_ONCHIP_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "162",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "163",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "164",
 		"EventName": "L1I_ONNODE_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "165",
 		"EventName": "L1I_ONNODE_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Node L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "166",
 		"EventName": "L1I_ONNODE_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Node L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Node Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "167",
 		"EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "168",
 		"EventName": "L1I_ONDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Drawer L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "169",
 		"EventName": "L1I_ONDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Drawer L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "170",
 		"EventName": "L1I_OFFDRAWER_SCOL_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Same-Column L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "171",
 		"EventName": "L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Drawer Same-Column L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "172",
 		"EventName": "L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Same-Column L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Same-Column Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "173",
 		"EventName": "L1I_OFFDRAWER_FCOL_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Far-Column L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "174",
 		"EventName": "L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Drawer Far-Column L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "175",
 		"EventName": "L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Far-Column L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Far-Column Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "176",
 		"EventName": "L1I_ONNODE_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Node Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Node memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Node memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "177",
 		"EventName": "L1I_ONDRAWER_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Drawer Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "178",
 		"EventName": "L1I_OFFDRAWER_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "179",
 		"EventName": "L1I_ONCHIP_MEM_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Chip memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Chip memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "218",
 		"EventName": "TX_NC_TABORT",
 		"BriefDescription": "Aborted transactions in non-constrained TX mode",
-		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode"
+		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "219",
 		"EventName": "TX_C_TABORT_NO_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
-		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "220",
 		"EventName": "TX_C_TABORT_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
-		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete."
 	},
 	{
 		"Unit": "CPU-M-CF",
-- 
2.36.1

