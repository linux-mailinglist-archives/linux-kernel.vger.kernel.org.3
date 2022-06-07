Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5363953F9CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbiFGJ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbiFGJ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:29:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B5384A2E;
        Tue,  7 Jun 2022 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654594127; x=1686130127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A/+t11wZpjeiYKVRhEj28r8oTrWhE6TcLHjTBCVXrKA=;
  b=ZxPupoZIU3xVIMY5/2QIC9Apd0fEEPAkHJHwY8G0PlWal9OPXsWzyEPy
   cVMZdCU+SJBS45VrMVIWNZ6b/GLXUqSGLl1VuGlPyBUQ52zUJW0Co7bjB
   jgLRvR3ajmOsRxs0QOQn3UbaQ0rnmk+RRb55PqIdcvOHHBqj+4S+s6nQb
   F4A5L02vC24+V6SYjlJaljR0eGRiH+TPuqAbINa56WSt/P9UddtrUz11W
   X0B1tB41K7mB1vufPNdks+8GA9e/7pUuQ/2Ol8/Fkl6737yImuHcjxGx7
   rLqcFJZnMEkeZmj00MFW0jqmqGO9QsTxBwSqGKZJ8VlXDRckaB6KMRqNm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="277106398"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="277106398"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 02:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="906970111"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2022 02:28:42 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, zhengjun.xing@linux.intel.com
Subject: [PATCH 2/2] perf vendor events intel: Update event list for Sapphirerapids
Date:   Tue,  7 Jun 2022 17:27:49 +0800
Message-Id: <20220607092749.1976878-2-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607092749.1976878-1-zhengjun.xing@linux.intel.com>
References: <20220607092749.1976878-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update JSON event list for Sapphirerapids to perf.

Based on JSON list v1.02:

https://download.01.org/perfmon/SPR/

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../arch/x86/sapphirerapids/cache.json        | 89 +++++++++++++++++--
 .../x86/sapphirerapids/floating-point.json    |  6 ++
 .../arch/x86/sapphirerapids/frontend.json     | 16 ++++
 .../arch/x86/sapphirerapids/memory.json       | 12 ++-
 .../arch/x86/sapphirerapids/other.json        |  4 +
 .../arch/x86/sapphirerapids/pipeline.json     | 81 ++++++++++++++++-
 .../x86/sapphirerapids/virtual-memory.json    | 20 +++++
 7 files changed, 217 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/cache.json
index 6fa723c9a6f6..92c55ef996aa 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/cache.json
@@ -1,4 +1,15 @@
 [
+    {
+        "BriefDescription": "L1D.HWPF_MISS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x51",
+        "EventName": "L1D.HWPF_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "Speculative": "1",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of cache lines replaced in =
L1 data cache.",
         "CollectPEBSRecord": "2",
@@ -8,6 +19,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -19,6 +31,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailablability. Demand requests incl=
ude cacheable/uncacheable demand load, store, lock or SW prefetch accesses.=
",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -32,6 +45,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of phases a demand request has=
 waited due to L1D Fill Buffer (FB) unavailablability. Demand requests incl=
ude cacheable/uncacheable demand load, store, lock or SW prefetch accesses.=
",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -42,6 +56,7 @@
         "EventName": "L1D_PEND_MISS.L2_STALL",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -53,6 +68,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -64,6 +80,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -76,6 +93,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts duration of L1D miss outstanding in c=
ycles.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -87,6 +105,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1f"
     },
     {
@@ -97,6 +116,7 @@
         "EventName": "L2_LINES_OUT.NON_SILENT",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -108,17 +128,19 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache when triggered by an L2 cache fill. These lines are ty=
pically in Shared or Exclusive state. A non-threaded event.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "All L2 requests.[This event is alias to L2_RQ=
STS.REFERENCES]",
+        "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_RQSTS.REFERENCES]",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts all L2 requests.[This event is alias =
to L2_RQSTS.REFERENCES]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_RQSTS.REFERENCES]",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xff"
     },
     {
@@ -130,6 +152,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_RQSTS.MISS]",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x3f"
     },
     {
@@ -141,17 +164,19 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of L2 code requests.=
",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe4"
     },
     {
-        "BriefDescription": "Demand Data Read requests",
+        "BriefDescription": "Demand Data Read access L2 cache",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of demand Data Read reques=
ts (including requests from L1D hardware prefetchers). These loads may hit =
or miss L2 cache. Only non rejected loads are counted.",
+        "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe1"
     },
     {
@@ -163,6 +188,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand requests that miss L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x27"
     },
     {
@@ -174,8 +200,20 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts demand requests to L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe7"
     },
+    {
+        "BriefDescription": "L2_RQSTS.ALL_HWPF",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.ALL_HWPF",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0xf0"
+    },
     {
         "BriefDescription": "RFO requests to L2 cache",
         "CollectPEBSRecord": "2",
@@ -185,6 +223,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xe2"
     },
     {
@@ -196,6 +235,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc4"
     },
     {
@@ -207,6 +247,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x24"
     },
     {
@@ -218,19 +259,32 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc1"
     },
     {
-        "BriefDescription": "Demand Data Read miss L2, no rejects",
+        "BriefDescription": "Demand Data Read miss L2 cache",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of demand Data Read reques=
ts that miss L2 cache. Only not rejected loads are counted.",
+        "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x21"
     },
+    {
+        "BriefDescription": "L2_RQSTS.HWPF_MISS",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HWPF_MISS",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "Speculative": "1",
+        "UMask": "0x30"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache.[Thi=
s event is alias to L2_REQUEST.MISS]",
         "CollectPEBSRecord": "2",
@@ -240,17 +294,19 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses.[This event is alias to L2_REQUEST.MISS]",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x3f"
     },
     {
-        "BriefDescription": "All L2 requests.[This event is alias to L2_RE=
QUEST.ALL]",
+        "BriefDescription": "All accesses to L2 cache[This event is alias =
to L2_REQUEST.ALL]",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts all L2 requests.[This event is alias =
to L2_REQUEST.ALL]",
+        "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses.[This event is alias to L2_REQUEST.ALL]",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xff"
     },
     {
@@ -262,6 +318,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc2"
     },
     {
@@ -273,6 +330,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x22"
     },
     {
@@ -284,6 +342,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0xc8"
     },
     {
@@ -295,6 +354,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x28"
     },
     {
@@ -305,6 +365,7 @@
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x41"
     },
     {
@@ -424,6 +485,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xfd"
     },
     {
@@ -970,6 +1032,7 @@
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -981,6 +1044,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -992,6 +1056,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1002,6 +1067,7 @@
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -1013,6 +1079,7 @@
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -1024,6 +1091,7 @@
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -1034,6 +1102,7 @@
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -1045,6 +1114,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1056,6 +1126,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -1067,6 +1138,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1078,6 +1150,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
index 53d35dddd313..32074d455691 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/floating-point.json
@@ -8,6 +8,7 @@
         "EventName": "ARITH.FPDIV_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -19,6 +20,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts all microcode Floating Point assists.=
",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -29,6 +31,7 @@
         "EventName": "ASSISTS.SSE_AVX_MIX",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -39,6 +42,7 @@
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -49,6 +53,7 @@
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -59,6 +64,7 @@
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
index 04ba0269c73c..44ecf38ad970 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/frontend.json
@@ -8,6 +8,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -19,6 +20,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -313,6 +315,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -324,6 +327,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
         "SampleAfterValue": "200003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -336,6 +340,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles uops were delive=
red to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) p=
ath.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -348,6 +353,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -359,6 +365,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -371,6 +378,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles uops were delive=
red to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipe=
line) path. During these cycles uops are not being delivered from the Decod=
e Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -383,6 +391,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -394,6 +403,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -406,6 +416,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles during which uops are being de=
livered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS=
) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -419,6 +430,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of switches from DSB (Decode Stream B=
uffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -430,6 +442,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -441,6 +454,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -453,6 +467,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of cycles when no uops wer=
e delivered by the Instruction Decode Queue (IDQ) to the back-end of the pi=
peline when there was no back-end stalls. This event counts for one SMT thr=
ead in a given cycle.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -466,6 +481,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of cycles when the optimal=
 number of uops were delivered by the Instruction Decode Queue (IDQ) to the=
 back-end of the pipeline when there was no back-end stalls. This event cou=
nts for one SMT thread in a given cycle.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json b/to=
ols/perf/pmu-events/arch/x86/sapphirerapids/memory.json
index 7436ced3e04e..cb861211b7bc 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/memory.json
@@ -8,6 +8,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x6"
     },
     {
@@ -19,6 +20,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -30,6 +32,7 @@
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -41,6 +44,7 @@
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x3"
     },
     {
@@ -52,6 +56,7 @@
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x5"
     },
     {
@@ -63,6 +68,7 @@
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x9"
     },
     {
@@ -194,12 +200,13 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Retired instructions with at least 1 store uo=
p. This PEBS event is the trigger for stores sampled by the PEBS Store Faci=
lity.",
+        "BriefDescription": "Retired memory store access operations. A PDi=
st event for PEBS Store Latency Facility.",
         "CollectPEBSRecord": "2",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
         "PEBS": "2",
+        "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -388,6 +395,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional reads",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -399,6 +407,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Speculatively counts the number of Transacti=
onal Synchronization Extensions (TSX) aborts due to a data capacity limitat=
ion for transactional writes.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -410,6 +419,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a TSX line had a =
cache conflict.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json b/too=
ls/perf/pmu-events/arch/x86/sapphirerapids/other.json
index 7d6f8e25bb10..acef4a2b8968 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/other.json
@@ -7,6 +7,7 @@
         "EventName": "ASSISTS.PAGE_FAULT",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -16,6 +17,7 @@
         "EventName": "EXE.AMX_BUSY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -346,6 +348,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x7"
     },
     {
@@ -357,6 +360,7 @@
         "EventName": "XQ.FULL_CYCLES",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
index b0920f5b25ed..bceea0304620 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
@@ -22,6 +22,7 @@
         "EventName": "ARITH.DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x9"
     },
     {
@@ -34,6 +35,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when divide unit is busy execu=
ting divide or square root operations. Accounts for integer and floating-po=
int operations.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x9"
     },
     {
@@ -45,6 +47,7 @@
         "EventName": "ARITH.FP_DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -56,6 +59,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "ARITH.IDIV_ACTIVE",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -67,6 +71,7 @@
         "EventName": "ARITH.INT_DIVIDER_ACTIVE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -78,6 +83,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware Examples include AD (page Access Dirty=
), FP and AVX related assists.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1f"
     },
     {
@@ -291,6 +297,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -302,6 +309,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -313,6 +321,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x70"
     },
     {
@@ -324,6 +333,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -335,6 +345,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
         "SampleAfterValue": "25003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -345,6 +356,7 @@
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x40"
     },
     {
@@ -356,6 +368,7 @@
         "EventName": "CPU_CLK_UNHALTED.PAUSE_INST",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x40"
     },
     {
@@ -366,6 +379,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -376,6 +390,7 @@
         "PEBScounters": "34",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x3"
     },
     {
@@ -386,6 +401,7 @@
         "PEBScounters": "33",
         "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -396,7 +412,8 @@
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
-        "SampleAfterValue": "2000003"
+        "SampleAfterValue": "2000003",
+        "Speculative": "1"
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
@@ -407,6 +424,7 @@
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -418,6 +436,7 @@
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -429,6 +448,7 @@
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -440,6 +460,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0xc"
     },
     {
@@ -451,6 +472,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x5"
     },
     {
@@ -462,6 +484,7 @@
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -473,6 +496,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -484,6 +508,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -495,6 +520,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -506,6 +532,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -517,6 +544,7 @@
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x21"
     },
     {
@@ -529,6 +557,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles where the Store Buffer was ful=
l and no loads caused an execution stall.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x40"
     },
     {
@@ -540,6 +569,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -551,6 +581,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -625,6 +656,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -634,6 +666,7 @@
         "EventName": "INT_MISC.MBA_STALLS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -645,6 +678,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
         "SampleAfterValue": "500009",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -657,6 +691,7 @@
         "MSRValue": "0x7",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "TakenAlone": "1",
         "UMask": "0x40"
     },
@@ -669,6 +704,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -762,6 +798,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -773,6 +810,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x88"
     },
     {
@@ -784,6 +822,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x82"
     },
     {
@@ -795,6 +834,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -807,6 +847,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the cycles when at least one uop is d=
elivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -819,6 +860,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the cycles when optimal number of uop=
s is delivered by the LSD (Loop-stream detector).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -830,6 +872,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -843,6 +886,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of machine clears (nukes) =
of any type.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -854,6 +898,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -864,6 +909,7 @@
         "EventName": "MISC2_RETIRED.LFENCE",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "400009",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -886,6 +932,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -896,6 +943,7 @@
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -907,6 +955,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -916,6 +965,7 @@
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
         "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -925,6 +975,7 @@
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
         "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of specualtive operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -935,6 +986,7 @@
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -945,6 +997,7 @@
         "PEBScounters": "35",
         "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -956,6 +1009,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
         "SampleAfterValue": "10000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -966,6 +1020,7 @@
         "EventName": "UOPS_DECODED.DEC0_UOPS",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -977,6 +1032,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -988,6 +1044,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -999,6 +1056,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -1010,6 +1068,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -1021,6 +1080,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -1032,6 +1092,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x40"
     },
     {
@@ -1043,6 +1104,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x80"
     },
     {
@@ -1054,6 +1116,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops executed from any =
thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1066,6 +1129,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 1 micro-op is ex=
ecuted from any thread on physical core.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1078,6 +1142,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 2 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1090,6 +1155,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 3 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1102,6 +1168,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles when at least 4 micro-ops are =
executed from any thread on physical core.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -1114,6 +1181,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 1 uop was executed per=
-thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1126,6 +1194,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 2 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1138,6 +1207,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 3 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1150,6 +1220,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Cycles where at least 4 uops were executed p=
er-thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1163,6 +1234,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts cycles during which no uops were disp=
atched from the Reservation Station (RS) per thread.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1175,6 +1247,7 @@
         "Invert": "1",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1185,6 +1258,7 @@
         "EventName": "UOPS_EXECUTED.THREAD",
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1196,6 +1270,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of x87 uops executed.",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -1207,6 +1282,7 @@
         "PEBScounters": "0,1,2,3,4,5,6,7",
         "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
         "SampleAfterValue": "2000003",
+        "Speculative": "1",
         "UMask": "0x1"
     },
     {
@@ -1222,12 +1298,13 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "UOPS_RETIRED.HEAVY",
+        "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
         "PEBScounters": "0,1,2,3,4,5,6,7",
+        "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.j=
son b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
index cba69368308e..f591f4fedc0b 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/virtual-memory.json
@@ -8,6 +8,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -20,6 +21,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a demand load.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -31,6 +33,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0xe"
     },
     {
@@ -42,6 +45,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -53,6 +57,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -64,6 +69,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -75,6 +81,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -86,6 +93,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -98,6 +106,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a store.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -109,6 +118,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0xe"
     },
     {
@@ -120,6 +130,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x8"
     },
     {
@@ -131,6 +142,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -142,6 +154,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -153,6 +166,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -164,6 +178,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x20"
     },
     {
@@ -176,6 +191,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts cycles when at least one PMH (Page Mi=
ss Handler) is busy with a page walk for a code (instruction fetch) request=
.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     },
     {
@@ -187,6 +203,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0xe"
     },
     {
@@ -198,6 +215,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x4"
     },
     {
@@ -209,6 +227,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x2"
     },
     {
@@ -220,6 +239,7 @@
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
         "SampleAfterValue": "100003",
+        "Speculative": "1",
         "UMask": "0x10"
     }
 ]
--=20
2.25.1

