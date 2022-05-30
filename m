Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD5537982
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiE3K5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiE3K51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:57:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D566640E;
        Mon, 30 May 2022 03:57:23 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24UAhkb7028173;
        Mon, 30 May 2022 10:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+cdgOpXyWwgVMh/IFi5rVbwOJjLrJ7dNDOMKiOvKNjk=;
 b=oZUaslMxap2WpamsNRAsgIHvMwqoO3wsCsxCJ0D5nfAOXtaW5Ds9GnmY24Ofkf1X/K8U
 ArJu0+dXPVEvl43LP4wdwF8PoeQFvMNMhcUpxtYu7J5AxUmPXcxMu0lFNDmh9ILz4MNK
 N0N0MOe/cfAej2YXIekUnaRzXLu8hE62st0ibo3ucev8wsUk9/JzRyODY1q1mpBwmuu8
 H2mawXVADzVaF/hxFs1S081t+excn4Ac7j2mM+2e2z1iELXsKWk49npTDL3oNT85v9qe
 zoqeldAfrmZutcOlMy4heQCSL0IuxoYUzsLZvsoCgYFFB6ISnhw/J0l36/Jmoh4w/YKD Ig== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gcve006h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 10:57:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24UAr1wJ016773;
        Mon, 30 May 2022 10:57:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3gbbynjkt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 10:57:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24UAu2WP31654176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 10:56:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DC64A404D;
        Mon, 30 May 2022 10:57:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A14C2A4040;
        Mon, 30 May 2022 10:57:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 May 2022 10:57:04 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2] perf list: Update event description for s390 machines to latest level
Date:   Mon, 30 May 2022 12:56:57 +0200
Message-Id: <20220530105657.2700635-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220530105657.2700635-1-tmricht@linux.ibm.com>
References: <20220530105657.2700635-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DHBQUot5nnRA0Qz-LkzmU6AqoUrEW0Pg
X-Proofpoint-ORIG-GUID: DHBQUot5nnRA0Qz-LkzmU6AqoUrEW0Pg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_03,2022-05-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205300055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update all s390 event counter description to the latest level
as described in the documents
1. SA23-2260-07:
   "The Load-Program-Parameter and the CPU-Measurement Facilities."
   released on May, 2022
for the following counter sets:
  * Basic counter set
  * Crypto counter set
  * MT-Diagnostic counter set

2. SA23-2261-07:
   "The CPU-Measurement Facility Extended Counters Definition
    for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15 and z16"
    released on April 29, 2022.
for the following counter sets:
  * Extended counter set
  * MT-Diagnostic counter set

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z10/basic.json    |  48 ++++----
 .../pmu-events/arch/s390/cf_z10/crypto.json   |  64 +++++-----
 .../pmu-events/arch/s390/cf_z10/extended.json |  36 +++---
 .../pmu-events/arch/s390/cf_z13/basic.json    |  48 ++++----
 .../pmu-events/arch/s390/cf_z13/crypto.json   |  64 +++++-----
 .../pmu-events/arch/s390/cf_z13/extended.json | 100 +++++++--------
 .../pmu-events/arch/s390/cf_z14/basic.json    |  32 ++---
 .../pmu-events/arch/s390/cf_z14/crypto.json   |  64 +++++-----
 .../pmu-events/arch/s390/cf_z14/extended.json | 102 ++++++++--------
 .../pmu-events/arch/s390/cf_z15/basic.json    |  32 ++---
 .../pmu-events/arch/s390/cf_z15/crypto.json   | 114 ------------------
 .../pmu-events/arch/s390/cf_z15/crypto6.json  | 112 +++++++++++++++++
 .../pmu-events/arch/s390/cf_z15/extended.json | 108 ++++++++---------
 .../pmu-events/arch/s390/cf_z196/basic.json   |  48 ++++----
 .../pmu-events/arch/s390/cf_z196/crypto.json  |  64 +++++-----
 .../arch/s390/cf_z196/extended.json           |  44 +++----
 .../pmu-events/arch/s390/cf_zec12/basic.json  |  48 ++++----
 .../pmu-events/arch/s390/cf_zec12/crypto.json |  64 +++++-----
 .../arch/s390/cf_zec12/extended.json          |  66 +++++-----
 19 files changed, 628 insertions(+), 630 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/s390/cf_z15/crypto.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json b/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
index 783de7f1aeaa..9bd20a5f47af 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/basic.json
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
index 3f28007d3892..a8d391ddeb8c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json b/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
index 86bd8ba9391d..bf6a9811e014 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z10/extended.json
@@ -4,125 +4,125 @@
 		"EventCode": "128",
 		"EventName": "L1I_L2_SOURCED_WRITES",
 		"BriefDescription": "L1I L2 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from the Level-2 (L1.5) cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache directory where the returned cache line was sourced from the Level-2 (L1.5) cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "129",
 		"EventName": "L1D_L2_SOURCED_WRITES",
 		"BriefDescription": "L1D L2 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the installed cache line was sourced from the Level-2 (L1.5) cache"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the installed cache line was sourced from the Level-2 (L1.5) cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "130",
 		"EventName": "L1I_L3_LOCAL_WRITES",
 		"BriefDescription": "L1I L3 Local Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the installed cache line was sourced from the Level-3 cache that is on the same book as the Instruction cache (Local L2 cache)"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache directory where the installed cache line was sourced from the Level-3 cache that is on the same book as the Instruction cache (Local L2 cache)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "131",
 		"EventName": "L1D_L3_LOCAL_WRITES",
 		"BriefDescription": "L1D L3 Local Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the installtion cache line was source from the Level-3 cache that is on the same book as the Data cache (Local L2 cache)"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the installed cache line was source from the Level-3 cache that is on the same book as the Data cache (Local L2 cache)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "132",
 		"EventName": "L1I_L3_REMOTE_WRITES",
 		"BriefDescription": "L1I L3 Remote Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the installed cache line was sourced from a Level-3 cache that is not on the same book as the Instruction cache (Remote L2 cache)"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache directory where the installed cache line was sourced from a Level-3 cache that is not on the same book as the Instruction cache (Remote L2 cache)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "133",
 		"EventName": "L1D_L3_REMOTE_WRITES",
 		"BriefDescription": "L1D L3 Remote Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the installed cache line was sourced from a Level-3 cache that is not on the same book as the Data cache (Remote L2 cache)"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the installed cache line was sourced from a Level-3 cache that is not on the same book as the Data cache (Remote L2 cache)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "134",
 		"EventName": "L1D_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1D Local Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)"
+		"PublicDescription": "A directory write to the Level-1 Data Cache directory where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "L1I_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1I Local Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 I-Cache where the installed cache line was sourced from memory that is attached to the s ame book as the Instruction cache (Local Memory)"
+		"PublicDescription": "A directory write to the Level-1 Instruction Cache where the installed cache line was sourced from memory that is attached to the s ame book as the Instruction cache (Local Memory)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "136",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "137",
 		"EventName": "L1I_CACHELINE_INVALIDATES",
 		"BriefDescription": "L1I Cacheline Invalidates",
-		"PublicDescription": "A cache line in the Level-1 I-Cache has been invalidated by a store on the same CPU as the Level-1 I-Cache"
+		"PublicDescription": "A cache line in the Level-1 Instruction Cache has been invalidated by a store on the same CPU as the Level-1 Instruction Cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "ITLB1_WRITES",
 		"BriefDescription": "ITLB1 Writes",
-		"PublicDescription": "A translation entry has been written into the Level-1 Instruction Translation Lookaside Buffer"
+		"PublicDescription": "A translation entry has been written into the Level-1 Instruction Translation Lookaside Buffer (ITLB1)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "DTLB1_WRITES",
 		"BriefDescription": "DTLB1 Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer (DTLB1)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "140",
 		"EventName": "TLB2_PTE_WRITES",
 		"BriefDescription": "TLB2 PTE Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "141",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "142",
 		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
 		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "ITLB1_MISSES",
 		"BriefDescription": "ITLB1 Misses",
-		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle an ITLB1 miss is in progress"
+		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle an ITLB1 miss is in progress."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "DTLB1_MISSES",
 		"BriefDescription": "DTLB1 Misses",
-		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle an DTLB1 miss is in progress"
+		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle an DTLB1 miss is in progress."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "L2C_STORES_SENT",
 		"BriefDescription": "L2C Stores Sent",
-		"PublicDescription": "Incremented by one for every store sent to Level-2 (L1.5) cache"
+		"PublicDescription": "Incremented by one for every store sent to Level-2 (L1.5) cache."
 	}
 ]
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
index fc762e9f1d6e..1023d47028ce 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/basic.json
@@ -3,56 +3,56 @@
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
 	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
index 3f28007d3892..a8d391ddeb8c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/crypto.json
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index 4942b20a1ea1..ad40cc4f9727 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -4,357 +4,357 @@
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "129",
 		"EventName": "DTLB2_WRITES",
 		"BriefDescription": "DTLB2 Writes",
-		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the data cache"
+		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the data cache. This is a replacement for what was provided for the DTLB on prior machines."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "130",
 		"EventName": "DTLB2_MISSES",
 		"BriefDescription": "DTLB2 Misses",
-		"PublicDescription": "A TLB2 miss is in progress for a request made by the data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle"
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle. This is a replacement for what was provided for the DTLB on prior machines."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "131",
 		"EventName": "DTLB2_HPAGE_WRITES",
 		"BriefDescription": "DTLB2 One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page or a Last Host Translation was done"
+		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page or a Last Host Translation was done."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "132",
 		"EventName": "DTLB2_GPAGE_WRITES",
 		"BriefDescription": "DTLB2 Two-Gigabyte Page Writes",
-		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB"
+		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "133",
 		"EventName": "L1D_L2D_SOURCED_WRITES",
 		"BriefDescription": "L1D L2D Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "134",
 		"EventName": "ITLB2_WRITES",
 		"BriefDescription": "ITLB2 Writes",
-		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the instruction cache"
+		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the instruction cache. This is a replacement for what was provided for the ITLB on prior machines."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "ITLB2_MISSES",
 		"BriefDescription": "ITLB2 Misses",
-		"PublicDescription": "A TLB2 miss is in progress for a request made by the instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle"
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle. This is a replacement for what was provided for the ITLB on prior machines."
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
-		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB"
+		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
-		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB"
+		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "TLB2_ENGINES_BUSY",
 		"BriefDescription": "TLB2 Engines Busy",
-		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle"
+		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle."
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
 		"EventCode": "143",
 		"EventName": "L1C_TLB2_MISSES",
 		"BriefDescription": "L1C TLB2 Misses",
-		"PublicDescription": "Increments by one for any cycle where a level-1 cache or level-2 TLB miss is in progress"
+		"PublicDescription": "Increments by one for any cycle where a level-1 cache or level-2 TLB miss is in progress."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "144",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "L1D_ONCHIP_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Cluster L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Cluster Level-3 cache withountervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Cluster Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "L1D_ONCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Cluster Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "149",
 		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Cluster L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "151",
 		"EventName": "L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Cluster Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Cluster memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Cluster memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "154",
 		"EventName": "L1D_OFFDRAWER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "156",
 		"EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "157",
 		"EventName": "L1D_OFFDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "158",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_RO",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes read-only",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip L3 but a read-only invalidate was done to remove other copies of the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip L3 but a read-only invalidate was done to remove other copies of the cache line."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "162",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "163",
 		"EventName": "L1I_ONCHIP_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from On-Chip memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from On-Chip memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "164",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "165",
 		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Cluster L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "166",
 		"EventName": "L1I_ONCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Cluster Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "167",
 		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Cluster L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Cluster Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Cluster Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "168",
 		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "169",
 		"EventName": "L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Cluster Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Cluster memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Cluster memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "170",
 		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "171",
 		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "172",
 		"EventName": "L1I_OFFDRAWER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "173",
 		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "174",
 		"EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "175",
 		"EventName": "L1I_OFFDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "224",
 		"EventName": "BCD_DFP_EXECUTION_SLOTS",
 		"BriefDescription": "BCD DFP Execution Slots",
-		"PublicDescription": "Count of floating point execution slots used for finished Binary Coded Decimal to Decimal Floating Point conversions. Instructions: CDZT, CXZT, CZDT, CZXT"
+		"PublicDescription": "Count of floating point execution slots used for finished Binary Coded Decimal to Decimal Floating Point conversions. Instructions: CDZT, CXZT, CZDT, CZXT."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "225",
 		"EventName": "VX_BCD_EXECUTION_SLOTS",
 		"BriefDescription": "VX BCD Execution Slots",
-		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG"
+		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "226",
 		"EventName": "DECIMAL_INSTRUCTIONS",
 		"BriefDescription": "Decimal Instructions",
-		"PublicDescription": "Decimal instructions dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP"
+		"PublicDescription": "Decimal instructions dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "232",
 		"EventName": "LAST_HOST_TRANSLATIONS",
 		"BriefDescription": "Last host translation done",
-		"PublicDescription": "Last Host Translation done"
+		"PublicDescription": "Last Host Translation done."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "243",
 		"EventName": "TX_NC_TABORT",
 		"BriefDescription": "Aborted transactions in non-constrained TX mode",
-		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode"
+		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "244",
 		"EventName": "TX_C_TABORT_NO_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
-		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "245",
 		"EventName": "TX_C_TABORT_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
-		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete."
 	},
 	{
 		"Unit": "CPU-M-CF",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/basic.json b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
index fc762e9f1d6e..1023d47028ce 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/basic.json
@@ -3,56 +3,56 @@
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
 	}
 ]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
deleted file mode 100644
index 3f28007d3892..000000000000
--- a/tools/perf/pmu-events/arch/s390/cf_z15/crypto.json
+++ /dev/null
@@ -1,114 +0,0 @@
-[
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "64",
-		"EventName": "PRNG_FUNCTIONS",
-		"BriefDescription": "PRNG Functions",
-		"PublicDescription": "Total number of the PRNG functions issued by the CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "65",
-		"EventName": "PRNG_CYCLES",
-		"BriefDescription": "PRNG Cycles",
-		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing PRNG functions issued by the CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "66",
-		"EventName": "PRNG_BLOCKED_FUNCTIONS",
-		"BriefDescription": "PRNG Blocked Functions",
-		"PublicDescription": "Total number of the PRNG functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "67",
-		"EventName": "PRNG_BLOCKED_CYCLES",
-		"BriefDescription": "PRNG Blocked Cycles",
-		"PublicDescription": "Total number of CPU cycles blocked for the PRNG functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "68",
-		"EventName": "SHA_FUNCTIONS",
-		"BriefDescription": "SHA Functions",
-		"PublicDescription": "Total number of SHA functions issued by the CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "69",
-		"EventName": "SHA_CYCLES",
-		"BriefDescription": "SHA Cycles",
-		"PublicDescription": "Total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "70",
-		"EventName": "SHA_BLOCKED_FUNCTIONS",
-		"BriefDescription": "SHA Blocked Functions",
-		"PublicDescription": "Total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "71",
-		"EventName": "SHA_BLOCKED_CYCLES",
-		"BriefDescription": "SHA Bloced Cycles",
-		"PublicDescription": "Total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "72",
-		"EventName": "DEA_FUNCTIONS",
-		"BriefDescription": "DEA Functions",
-		"PublicDescription": "Total number of the DEA functions issued by the CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "73",
-		"EventName": "DEA_CYCLES",
-		"BriefDescription": "DEA Cycles",
-		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "74",
-		"EventName": "DEA_BLOCKED_FUNCTIONS",
-		"BriefDescription": "DEA Blocked Functions",
-		"PublicDescription": "Total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "75",
-		"EventName": "DEA_BLOCKED_CYCLES",
-		"BriefDescription": "DEA Blocked Cycles",
-		"PublicDescription": "Total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "76",
-		"EventName": "AES_FUNCTIONS",
-		"BriefDescription": "AES Functions",
-		"PublicDescription": "Total number of AES functions issued by the CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "77",
-		"EventName": "AES_CYCLES",
-		"BriefDescription": "AES Cycles",
-		"PublicDescription": "Total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "78",
-		"EventName": "AES_BLOCKED_FUNCTIONS",
-		"BriefDescription": "AES Blocked Functions",
-		"PublicDescription": "Total number of AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	},
-	{
-		"Unit": "CPU-M-CF",
-		"EventCode": "79",
-		"EventName": "AES_BLOCKED_CYCLES",
-		"BriefDescription": "AES Blocked Cycles",
-		"PublicDescription": "Total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU"
-	}
-]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
index ad79189050a0..8b4380b8e489 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/crypto6.json
@@ -1,4 +1,116 @@
 [
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "64",
+		"EventName": "PRNG_FUNCTIONS",
+		"BriefDescription": "PRNG Function Count",
+		"PublicDescription": "This counter counts the total number of the pseudorandom-number-generation functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "65",
+		"EventName": "PRNG_CYCLES",
+		"BriefDescription": "PRNG Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES/SHA coprocessor is busy performing the pseudorandom- number-generation functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "66",
+		"EventName": "PRNG_BLOCKED_FUNCTIONS",
+		"BriefDescription": "PRNG Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the pseudorandom-number-generation functions that are issued by the CPU and are blocked because the DEA/AES/SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "67",
+		"EventName": "PRNG_BLOCKED_CYCLES",
+		"BriefDescription": "PRNG Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the pseudorandom-number-generation functions issued by the CPU because the DEA/AES/SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "68",
+		"EventName": "SHA_FUNCTIONS",
+		"BriefDescription": "SHA Function Count",
+		"PublicDescription": "This counter counts the total number of the SHA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "69",
+		"EventName": "SHA_CYCLES",
+		"BriefDescription": "SHA Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "70",
+		"EventName": "SHA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "SHA Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "71",
+		"EventName": "SHA_BLOCKED_CYCLES",
+		"BriefDescription": "SHA Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "72",
+		"EventName": "DEA_FUNCTIONS",
+		"BriefDescription": "DEA Function Count",
+		"PublicDescription": "This counter counts the total number of the DEA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "73",
+		"EventName": "DEA_CYCLES",
+		"BriefDescription": "DEA Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "74",
+		"EventName": "DEA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "DEA Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "75",
+		"EventName": "DEA_BLOCKED_CYCLES",
+		"BriefDescription": "DEA Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "76",
+		"EventName": "AES_FUNCTIONS",
+		"BriefDescription": "AES Function Count",
+		"PublicDescription": "This counter counts the total number of the AES functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "77",
+		"EventName": "AES_CYCLES",
+		"BriefDescription": "AES Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "78",
+		"EventName": "AES_BLOCKED_FUNCTIONS",
+		"BriefDescription": "AES Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "79",
+		"EventName": "AES_BLOCKED_CYCLES",
+		"BriefDescription": "AES Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "80",
diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
index 8ac61f8f286b..9c691c391086 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z15/extended.json
@@ -4,357 +4,357 @@
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "129",
 		"EventName": "DTLB2_WRITES",
 		"BriefDescription": "DTLB2 Writes",
-		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the data cache"
+		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the data cache. This is a replacement for what was provided for the DTLB on prior machines."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "130",
 		"EventName": "DTLB2_MISSES",
 		"BriefDescription": "DTLB2 Misses",
-		"PublicDescription": "A TLB2 miss is in progress for a request made by the data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle"
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle. This is a replacement for what was provided for the DTLB on prior machines."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "131",
 		"EventName": "DTLB2_HPAGE_WRITES",
 		"BriefDescription": "DTLB2 One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page"
+		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "132",
 		"EventName": "DTLB2_GPAGE_WRITES",
 		"BriefDescription": "DTLB2 Two-Gigabyte Page Writes",
-		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB"
+		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "133",
 		"EventName": "L1D_L2D_SOURCED_WRITES",
 		"BriefDescription": "L1D L2D Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "134",
 		"EventName": "ITLB2_WRITES",
 		"BriefDescription": "ITLB2 Writes",
-		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the instruction cache"
+		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the instruction cache. This is a replacement for what was provided for the ITLB on prior machines."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "ITLB2_MISSES",
 		"BriefDescription": "ITLB2 Misses",
-		"PublicDescription": "A TLB2 miss is in progress for a request made by the instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle"
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle. This is a replacement for what was provided for the ITLB on prior machines."
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
-		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB"
+		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
-		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB"
+		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "TLB2_ENGINES_BUSY",
 		"BriefDescription": "TLB2 Engines Busy",
-		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle"
+		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle."
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
 		"EventCode": "143",
 		"EventName": "L1C_TLB2_MISSES",
 		"BriefDescription": "L1C TLB2 Misses",
-		"PublicDescription": "Increments by one for any cycle where a level-1 cache or level-2 TLB miss is in progress"
+		"PublicDescription": "Increments by one for any cycle where a level-1 cache or level-2 TLB miss is in progress."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "144",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "L1D_ONCHIP_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Cluster L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Cluster Level-3 cache withountervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Cluster Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "L1D_ONCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Cluster Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "149",
 		"EventName": "L1D_ONCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Cluster L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "151",
 		"EventName": "L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Cluster Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Cluster memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Cluster memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "L1D_OFFCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Cluster L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "154",
 		"EventName": "L1D_OFFDRAWER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "L1D_OFFDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Drawer L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "156",
 		"EventName": "L1D_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "157",
 		"EventName": "L1D_OFFDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "158",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_RO",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes read-only",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip L3 but a read-only invalidate was done to remove other copies of the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from On-Chip L3 but a read-only invalidate was done to remove other copies of the cache line."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "162",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "163",
 		"EventName": "L1I_ONCHIP_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from On-Chip memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from On-Chip memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "164",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache ine was sourced from an On-Chip Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "165",
 		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Cluster L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "166",
 		"EventName": "L1I_ONCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Cluster Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Cluster memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "167",
 		"EventName": "L1I_ONCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Cluster L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Cluster Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Cluster Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "168",
 		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "169",
 		"EventName": "L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Cluster Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Cluster memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Cluster memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "170",
 		"EventName": "L1I_OFFCLUSTER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Cluster L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Cluster Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "171",
 		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "172",
 		"EventName": "L1I_OFFDRAWER_MEMORY_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "173",
 		"EventName": "L1I_OFFDRAWER_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Drawer L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "174",
 		"EventName": "L1I_ONDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "175",
 		"EventName": "L1I_OFFDRAWER_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Drawer L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "224",
 		"EventName": "BCD_DFP_EXECUTION_SLOTS",
 		"BriefDescription": "BCD DFP Execution Slots",
-		"PublicDescription": "Count of floating point execution slots used for finished Binary Coded Decimal to Decimal Floating Point conversions. Instructions: CDZT, CXZT, CZDT, CZXT"
+		"PublicDescription": "Count of floating point execution slots used for finished Binary Coded Decimal to Decimal Floating Point conversions. Instructions: CDZT, CXZT, CZDT, CZXT."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "225",
 		"EventName": "VX_BCD_EXECUTION_SLOTS",
 		"BriefDescription": "VX BCD Execution Slots",
-		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG"
+		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMPVMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOPVCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVDVCVDG."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "226",
 		"EventName": "DECIMAL_INSTRUCTIONS",
 		"BriefDescription": "Decimal Instructions",
-		"PublicDescription": "Decimal instructions dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP"
+		"PublicDescription": "Decimal instructions dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "232",
 		"EventName": "LAST_HOST_TRANSLATIONS",
 		"BriefDescription": "Last host translation done",
-		"PublicDescription": "Last Host Translation done"
+		"PublicDescription": "Last Host Translation done."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "243",
 		"EventName": "TX_NC_TABORT",
 		"BriefDescription": "Aborted transactions in non-constrained TX mode",
-		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode"
+		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "244",
 		"EventName": "TX_C_TABORT_NO_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
-		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "245",
 		"EventName": "TX_C_TABORT_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
-		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete."
 	},
 	{
 		"Unit": "CPU-M-CF",
@@ -374,15 +374,15 @@
 		"Unit": "CPU-M-CF",
 		"EventCode": "264",
 		"EventName": "DFLT_CC",
-		"BriefDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed",
+		"BriefDescription": "Increments DEFLATE CONVERSION CALL",
 		"PublicDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed"
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "265",
 		"EventName": "DFLT_CCFINISH",
-		"BriefDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or 2",
-		"PublicDescription": "Increments by one for every DEFLATE CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or 2"
+		"BriefDescription": "Increments completed DEFLATE CONVERSION CALL",
+		"PublicDescription": " Increments by one for every DEFLATE CONVERSION CALL instruction executed that ended in Condition Codes 0, 1 or 2 complete. "
 	},
 	{
 		"Unit": "CPU-M-CF",
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json b/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
index 783de7f1aeaa..9bd20a5f47af 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json b/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
index 3f28007d3892..a8d391ddeb8c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
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
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
index f40cbed89418..9e765581382b 100644
--- a/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
@@ -18,230 +18,230 @@
 		"EventCode": "130",
 		"EventName": "L1D_L2I_SOURCED_WRITES",
 		"BriefDescription": "L1D L2I Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Instruction cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "131",
 		"EventName": "L1I_L2I_SOURCED_WRITES",
 		"BriefDescription": "L1I L2I Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "132",
 		"EventName": "L1D_L2D_SOURCED_WRITES",
 		"BriefDescription": "L1D L2D Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "133",
 		"EventName": "DTLB1_WRITES",
 		"BriefDescription": "DTLB1 Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer (DTLB1)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "135",
 		"EventName": "L1D_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1D Local Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)"
+		"PublicDescription": "A directory write to the Level-1 Data cache where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "137",
 		"EventName": "L1I_LMEM_SOURCED_WRITES",
 		"BriefDescription": "L1I Local Memory Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache where the installed cache line was sourced from memory that is attached to the same book as the Instruction cache (Local Memory)"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache where the installed cache line was sourced from memory that is attached to the same book as the Instruction cache (Local Memory)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "138",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "A directory write to the Level-1 D-Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "A directory write to the Level-1 Data Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "139",
 		"EventName": "DTLB1_HPAGE_WRITES",
 		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "140",
 		"EventName": "ITLB1_WRITES",
 		"BriefDescription": "ITLB1 Writes",
-		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
+		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer (ITLB1)."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "141",
 		"EventName": "TLB2_PTE_WRITES",
 		"BriefDescription": "TLB2 PTE Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "142",
 		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
 		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "143",
 		"EventName": "TLB2_CRSTE_WRITES",
 		"BriefDescription": "TLB2 CRSTE Writes",
-		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays"
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "144",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On Chip Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On Chip Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "145",
 		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "146",
 		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Book L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "147",
 		"EventName": "L1D_ONBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D On-Book L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On Book Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "148",
 		"EventName": "L1D_OFFBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1D Off-Book L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "149",
 		"EventName": "TX_NC_TEND",
 		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
-		"PublicDescription": "A TEND instruction has completed in a nonconstrained transactional-execution mode"
+		"PublicDescription": "A TEND instruction has completed in a nonconstrained transactional-execution mode."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "150",
 		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from a On Chip Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from a On Chip Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "151",
 		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "152",
 		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1D Off-Book L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "153",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "154",
 		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Chip L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "155",
 		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Book L3 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-3 cache without intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-3 cache without intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "156",
 		"EventName": "L1I_ONBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I On-Book L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Book Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "157",
 		"EventName": "L1I_OFFBOOK_L4_SOURCED_WRITES",
 		"BriefDescription": "L1I Off-Book L4 Sourced Writes",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-4 cache."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "158",
 		"EventName": "TX_C_TEND",
 		"BriefDescription": "Completed TEND instructions in constrained TX mode",
-		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode"
+		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "159",
 		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "160",
 		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Chip L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "161",
 		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES_IV",
 		"BriefDescription": "L1I Off-Book L3 Sourced Writes with Intervention",
-		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-3 cache with intervention"
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-3 cache with intervention."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "177",
 		"EventName": "TX_NC_TABORT",
 		"BriefDescription": "Aborted transactions in non-constrained TX mode",
-		"PublicDescription": "A transaction abort has occurred in a nonconstrained transactional-execution mode"
+		"PublicDescription": "A transaction abort has occurred in a nonconstrained transactional-execution mode."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "178",
 		"EventName": "TX_C_TABORT_NO_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
-		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete."
 	},
 	{
 		"Unit": "CPU-M-CF",
 		"EventCode": "179",
 		"EventName": "TX_C_TABORT_SPECIAL",
 		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
-		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete."
 	}
 ]
-- 
2.36.1

