Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDD580785
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiGYWiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiGYWhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:37:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02525EBE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f448bb552so3973137b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 15:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=xXqV291vXveNfD7KYJrMFhpp8g+Iw0cUlr+194C0NDA=;
        b=KmyDaN/wjes3xjdsZD2jZhulyJMNcVRJX0R/4IH3pVIpo3uWKvcMTJtdcWVHYtnhV9
         8yJ7CkpjvdWtyDpsaPUMYlbwAUFvd6Gk1I1rSar1Fje9xaUfAL8oeqwk12bbCOtq5a8S
         gUc2jns4sKiMyqzSv4bw0/4UfDgcQ1zjTuRp24ihMrt3awceV0yhQDXhQA0J+7w6BZSz
         H/7iBn+rCzqO5tFtbFqIP6keuaqJszHXr+6JfVHeVrpsRK2tjOdzIFIGzoGYJhwPPdLi
         0jsMGhl+AkYNTBrsZHIc4Vf3jgpnfNPMpaNtH92MjIXzZOjTBDlPwHwhia1mRcWuQcla
         4uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=xXqV291vXveNfD7KYJrMFhpp8g+Iw0cUlr+194C0NDA=;
        b=lyzKnSXxBzbXCfvjypXjHnYQir9trB1AmZa4EW4VutjLkQzWrDXFXVTxtotc5uBqqo
         C2X+alOExxDLmn+fXLzvMheuoU9GCiBxs1NKePPBJHJBeegnDyKa89qiEpjJYp/tuO5u
         Nh6oWPGXtEdVwJ8h29BAd04KwEkYyyGHGRayZF53lNswdOf1dhRh3WOk2btyrf/b0bLB
         jlMN7ROc2go/5zSCSE/zaMdObifGpy55VTIAPIwKn8unEkXYm4kotomdsJKG7aOM5DA9
         QsuLSPN258n6GMbTsfZtb8hgih4bEvyJPACZ2Ha25ycAbwD3XTKktYm5SGaxFP4L77tS
         ntKA==
X-Gm-Message-State: AJIora8+41Byc9F+GhMGj1x6IBem970hDgAgwHkhukZeWb+w2LNchFOg
        a+JQkaBmFao4TxqLSDBR5oFflLUs9mSg
X-Google-Smtp-Source: AGRyM1sjiMqOZTLwioqZvyGVckb9EF3v6u8tLt8urOIKwOKSmDBWgDX5U3vWMvct7gm2WaHd/qv60cdsVNJf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7fbf:ee64:7f7:3631])
 (user=irogers job=sendgmr) by 2002:a25:1c04:0:b0:660:1ffc:fb9 with SMTP id
 c4-20020a251c04000000b006601ffc0fb9mr11007625ybc.431.1658788626396; Mon, 25
 Jul 2022 15:37:06 -0700 (PDT)
Date:   Mon, 25 Jul 2022 15:36:09 -0700
In-Reply-To: <20220725223633.2301737-1-irogers@google.com>
Message-Id: <20220725223633.2301737-9-irogers@google.com>
Mime-Version: 1.0
References: <20220725223633.2301737-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v2 08/32] perf vendor events: Update Intel elkhartlake
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to v1.03. Elkhartlake metrics aren't in TMA but basic metrics are
left unchanged.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/downloa=
d_and_gen.py

to download and generate the latest events and metrics. Manually copy
the elkhartlake files into perf and update mapfile.csv.

Tested on a non-elkhartlake with 'perf test':
 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : Ok
 10.2: PMU event map aliases                                         : Ok
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/elkhartlake/cache.json           | 956 +++++++++++++++++-
 .../arch/x86/elkhartlake/floating-point.json  |  19 +-
 .../arch/x86/elkhartlake/frontend.json        |  34 +-
 .../arch/x86/elkhartlake/memory.json          | 388 ++++++-
 .../arch/x86/elkhartlake/other.json           | 527 +++++++++-
 .../arch/x86/elkhartlake/pipeline.json        | 203 +++-
 .../arch/x86/elkhartlake/virtual-memory.json  | 151 ++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 8 files changed, 2150 insertions(+), 130 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/cache.json b/tools/=
perf/pmu-events/arch/x86/elkhartlake/cache.json
index 734be4ea095f..d674ee88c3a5 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
@@ -1,25 +1,94 @@
 [
     {
-        "BriefDescription": "Counts the number of first level data cacheli=
ne (dirty) evictions caused by misses, stores, and prefetches.",
+        "BriefDescription": "Counts the number of core requests (demand an=
d L1 prefetchers) rejected by the L2 queue (L2Q) due to a full condition.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x31",
+        "EventName": "CORE_REJECT_L2Q.ANY",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2 queue (L2Q) due to a full or nearly f=
ull condition, which likely indicates back pressure from L2Q.  It also coun=
ts requests that would have gone directly to the External Queue (XQ), but a=
re rejected due to a full or nearly full condition, indicating back pressur=
e from the IDI link.  The L2Q may also reject transactions  from a core to =
ensure fairness between cores, or to delay a cores dirty eviction when the =
address conflicts incoming external snoops.  (Note that L2 prefetcher reque=
sts that are dropped are not counted by this event).  Counts on a per core =
basis.",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Counts the number of L1D cacheline (dirty) ev=
ictions caused by load misses, stores, and prefetches.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "DL1.DIRTY_EVICTION",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of L1D cacheline (dirty) e=
victions caused by load misses, stores, and prefetches.  Does not count evi=
ctions or dirty writebacks caused by snoops.  Does not count a replacement =
unless a (dirty) line was written back.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of demand and prefetch tran=
sactions that the External Queue (XQ) rejects due to a full or near full co=
ndition.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "L2_REJECT_XQ.ANY",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The XQ ma=
y reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses=
) and WOB (L2 write-back victims).",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Counts the total number of L2 Cache accesses.=
 Counts on a per core basis.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the total number of L2 Cache Accesses=
, includes hits, misses, rejects  front door requests for CRd/DRd/RFO/ItoM/=
L2 Prefetches only.  Counts on a per core basis.",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 Cache accesses that r=
esulted in a hit. Counts on a per core basis.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of L2 Cache accesses that =
resulted in a hit from a front door request only (does not include rejects =
or recycles), Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 Cache accesses that r=
esulted in a miss. Counts on a per core basis.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of first level data cachel=
ine (dirty) evictions caused by misses, stores, and prefetches.  Does not c=
ount evictions or dirty writebacks caused by snoops.  Does not count a repl=
acement unless a (dirty) line was written back.",
+        "PublicDescription": "Counts the number of L2 Cache accesses that =
resulted in a miss from a front door request only (does not include rejects=
 or recycles). Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of L2 Cache accesses that m=
iss the L2 and get rejected. Counts on a per core basis.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.REJECTS",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of L2 Cache accesses that =
miss the L2 and get BBL reject  short and long rejects (includes those coun=
ted in L2_reject_XQ.any). Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). If the platform has an L3 cache=
, the LLC is the L3 cache, otherwise it is the L2 cache. Counts on a per co=
re basis.",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 =
cache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
@@ -29,21 +98,31 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x4f"
     },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM o=
r MMIO (Non-DRAM).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.IFETCH",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x38"
+    },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non-D=
RAM).",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_DRAM_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of cycles a core is stalle=
d due to an instruction cache or translation lookaside buffer (TLB) access =
which hit in DRAM or MMIO (non-DRAM).",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or translation lookaside buffer (TLB) miss =
which hit in DRAM or MMIO (non-DRAM).",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
     },
@@ -53,9 +132,9 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of cycles a core is stalle=
d due to an instruction cache or Translation Lookaside Buffer (TLB) access =
which hit in the L2 cache.",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
@@ -65,19 +144,29 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of cycles a core is stalle=
d due to an instruction cache or Translation Lookaside Buffer (TLB) access =
which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in the L2, LLC, DRAM or MMIO (Non-DR=
AM).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS.LOAD",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x7"
+    },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_DRAM_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
@@ -88,9 +177,8 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of cycles a core is stalle=
d due to a demand load which hit in the L2 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
@@ -100,33 +188,47 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of cycles a core is stalle=
d due to a demand load which hit in the Last Level Cache (LLC) or other cor=
e with HITE/F/M.",
+        "PublicDescription": "Counts the number of cycles the core is stal=
led due to a demand load which hit in the Last Level Cache (LLC) or other c=
ore with HITE/F/M.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a store buffer being full.",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a store buffer being full.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.STORE_BUFFER_FULL",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x40"
     },
     {
-        "BriefDescription": "Counts the number of load ops retired that hi=
t in DRAM.",
+        "BriefDescription": "Counts the number of load uops retired that h=
it in DRAM.",
+        "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
+        "PEBS": "1",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache, in which a snoop was required and modified data was for=
warded from another core or module.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L1 data cache.",
         "CollectPEBSRecord": "2",
@@ -179,6 +281,7 @@
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
+        "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
         "PEBS": "1",
@@ -186,6 +289,19 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of memory uops retired.  A=
 single uop that performs both a load AND a store will be counted as 1, not=
 2 (e.g. ADD [mem], CONST)",
+        "SampleAfterValue": "200003",
+        "UMask": "0x83"
+    },
     {
         "BriefDescription": "Counts the number of load uops retired.",
         "CollectPEBSRecord": "2",
@@ -212,15 +328,811 @@
         "SampleAfterValue": "200003",
         "UMask": "0x82"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that p=
erformed one or more locks.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 were splits.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x43"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split load uops.=
",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split store uops=
.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where a snoop was sent, the snoop hit, and modified data was fo=
rwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where a snoop was sent, the snoop hit, but no data was forwarde=
d.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where a snoop was sent, the snoop hit, and non-modified data wa=
s forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where a snoop was sent but the snoop missed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by t=
he L3 cache where no snoop was needed to satisfy the request.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.COREWB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3001F803C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and modified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and non-modified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent but the snoop missed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where no snoop =
was needed to satisfy the request.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where a snoop was sent, the snoop hit, and modi=
fied data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where a snoop was sent, the snoop hit, but no d=
ata was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD"=
,
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where a snoop was sent, the snoop hit, and non-=
modified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FW=
D",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where a snoop was sent but the snoop missed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache where no snoop was needed to satisfy the reques=
t.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED"=
,
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, but no data was forwa=
rded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent but the snoop missed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where no snoop was needed to satisfy the request.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.FULL_STREAMING_WR.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x801F803C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache hardware prefetches and =
software prefetches (except PREFETCHW and PFRFO) that were supplied by the =
L3 cache where a snoop was sent, the snoop hit, and modified data was forwa=
rded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0400",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, and modified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, and non-modified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent but the snoop missed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache where no =
snoop was needed to satisfy the request.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, and modified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent, the snoop hit, and non-modified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where a s=
noop was sent but the snoop missed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache where no =
snoop was needed to satisfy the request.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and modified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and non-modified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where a snoop w=
as sent but the snoop missed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache where no snoop =
was needed to satisfy the request.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L1WB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1001F803C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L2WB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2001F803C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.PARTIAL_STREAMING_WR.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x401F803C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where a snoop was sent, the snoop hit, and modif=
ied data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where a snoop was sent, the snoop hit, but no da=
ta was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where a snoop was sent, the snoop hit, and non-m=
odified data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where a snoop was sent but the snoop missed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2003C0477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache where no snoop was needed to satisfy the request=
.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1003C0477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that were supplied by=
 the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.STREAMING_WR.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0800",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x101F803C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where a snoop was sent, the snoop hit, and modified data=
 was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1010003C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where a snoop was sent, the snoop hit, but no data was f=
orwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1004003C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where a snoop was sent, the snoop hit, and non-modified =
data was forwarded.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1008003C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where a snoop was sent but the snoop missed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1002003C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by the L3 cache where no snoop was needed to satisfy the request.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_NOT_NEEDED",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1001003C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory writes that were suppl=
ied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_WR.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x201F803C0000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to instruction cache misses.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ICACHE",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
index 2515b9aa6e66..2e1b80c714fd 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
@@ -1,15 +1,28 @@
 [
     {
-        "BriefDescription": "Counts the number of cycles the floating poin=
t divider is busy.  Does not imply a stall waiting for the divider.",
+        "BriefDescription": "Counts the number of cycles the floating poin=
t divider is busy.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xcd",
         "EventName": "CYCLES_DIV_BUSY.FPDIV",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles the floating poi=
nt divider is busy.  Does not imply a stall waiting for the divider.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FP_ASSIST",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
+        "SampleAfterValue": "20003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and SSE, including x87 sqrt).",
         "CollectPEBSRecord": "2",
@@ -21,4 +34,4 @@
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json b/too=
ls/perf/pmu-events/arch/x86/elkhartlake/frontend.json
index b7b8cb7bd868..5d938a5dafcf 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json
@@ -1,11 +1,11 @@
 [
     {
-        "BriefDescription": "Counts the total number of BACLEARS.",
+        "BriefDescription": "Counts the total number of BACLEARS due to al=
l branch types including conditional and unconditional jumps, returns, and =
indirect branches.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of BACLEARS, which o=
ccur when the Branch Target Buffer (BTB) prediction or lack thereof, was co=
rrected by a later branch predictor in the frontend.  Includes BACLEARS due=
 to all branch types including conditional and unconditional jumps, returns=
, and indirect branches.",
         "SampleAfterValue": "200003",
@@ -17,7 +17,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.COND",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
@@ -28,7 +28,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.INDIRECT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
@@ -39,18 +39,18 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.RETURN",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
     },
     {
-        "BriefDescription": "Counts the number of BACLEARS due to a non-in=
direct, non-conditional jump.",
+        "BriefDescription": "Counts the number of BACLEARS due to a direct=
, unconditional jump.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.UNCOND",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
@@ -61,7 +61,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe9",
         "EventName": "DECODE_RESTRICTION.PREDECODE_WRONG",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
@@ -72,22 +72,34 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of requests to the i=
nstruction cache.  The event only counts new cache line accesses, so that m=
ultiple back to back fetches to the exact same cache line or byte chunk cou=
nt as one.  Specifically, the event counts when accesses from sequential co=
de crosses the cache line boundary, or when a branch target is moved to a n=
ew line or to a non-sequential byte chunk of the same line.",
         "SampleAfterValue": "200003",
         "UMask": "0x3"
     },
+    {
+        "BriefDescription": "Counts the number of instruction cache hits."=
,
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.HIT",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of requests that hit in th=
e instruction cache.  The event only counts new cache line accesses, so tha=
t multiple back to back fetches to the exact same cache line and byte chunk=
 count as one.  Specifically, the event counts when accesses from sequentia=
l code crosses the cache line boundary, or when a branch target is moved to=
 a new line or to a non-sequential byte chunk of the same line.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of instruction cache misses=
.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of missed requests to the =
instruction cache.  The event only counts new cache line accesses, so that =
multiple back to back fetches to the exact same cache line and byte chunk c=
ount as one.  Specifically, the event counts when accesses from sequential =
code crosses the cache line boundary, or when a branch target is moved to a=
 new line or to a non-sequential byte chunk of the same line.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/memory.json b/tools=
/perf/pmu-events/arch/x86/elkhartlake/memory.json
index 4e4eab23a300..15eba23796e4 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
@@ -1,25 +1,111 @@
 [
     {
-        "BriefDescription": "Counts the number of memory ordering machine =
clears triggered by a snoop from an external agent.",
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of memory ordering machine=
 clears triggered by a snoop from an external agent. Does not count interna=
lly generated machine clears such as those due to disambiguations.",
         "SampleAfterValue": "20003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts the number of misaligned load uops tha=
t are 4K page splits.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of misaligned store uops th=
at are 4K page splits.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were not supplied =
by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were not supplied =
by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.COREWB_M.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3002184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.COREWB_M.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3002184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2104000001",
+        "MSRValue": "0x2184000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -29,9 +115,8 @@
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2104000001",
+        "MSRValue": "0x2184000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -41,9 +126,8 @@
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2104000001",
+        "MSRValue": "0x2184000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -53,9 +137,8 @@
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2104000001",
+        "MSRValue": "0x2184000001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -65,9 +148,8 @@
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2104000002",
+        "MSRValue": "0x2184000002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -77,10 +159,284 @@
         "EventCode": "0XB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2104000002",
+        "MSRValue": "0x2184000002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.FULL_STREAMING_WR.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x802184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.FULL_STREAMING_WR.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x802184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L1WB_M.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1002184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L1WB_M.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1002184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L2WB_M.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2002184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L2WB_M.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2002184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts miscellaneous requests, such as I/O ac=
cesses, that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.OTHER.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184008000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts miscellaneous requests, such as I/O ac=
cesses, that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.OTHER.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184008000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.PARTIAL_STREAMING_WR.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x402184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.PARTIAL_STREAMING_WR.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x402184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all hardware and software prefetches t=
hat were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.PREFETCHES.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000470",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that were not supplie=
d by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.STREAMING_WR.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000800",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that were not supplie=
d by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.STREAMING_WR.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2184000800",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were not su=
pplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x102184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were not su=
pplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x102184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory writes that were not s=
upplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_WR.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x202184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory writes that were not s=
upplied by the L3 cache.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_WR.L3_MISS_LOCAL",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x202184000000",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json b/tools/=
perf/pmu-events/arch/x86/elkhartlake/other.json
index 8692d4847476..4a1b7cc5aa23 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
@@ -6,7 +6,7 @@
         "EdgeDetect": "1",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.ALL",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003"
     },
@@ -27,7 +27,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.CYCLES_OTHER_BLOCK",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
@@ -38,7 +38,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x63",
         "EventName": "BUS_LOCK.CYCLES_SELF_BLOCK",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
@@ -71,7 +71,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "C0_STALLS.LOAD_DRAM_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
@@ -82,7 +82,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "C0_STALLS.LOAD_L2_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
@@ -93,7 +93,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x34",
         "EventName": "C0_STALLS.LOAD_LLC_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
@@ -104,7 +104,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xcb",
         "EventName": "HW_INTERRUPTS.MASKED",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of core cycles during whic=
h interrupts are masked (disabled). Increments by 1 each core cycle that EF=
LAGS.IF is 0, regardless of whether interrupts are pending or not.",
         "SampleAfterValue": "200003",
@@ -116,7 +116,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xcb",
         "EventName": "HW_INTERRUPTS.PENDING_AND_MASKED",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of core cycles during whic=
h there are pending interrupts while interrupts are masked (disabled). Incr=
ements by 1 each core cycle that both EFLAGS.IF is 0 and an INTR is pending=
 (which means the APIC is telling the ROB to cause an INTR). This event doe=
s not increment if EFLAGS.IF is 0 but all interrupt in the APICs Interrupt =
Request Register (IRR) are inhibited by the PPR (thus either by ISRV or TPR=
)  because in these cases the interrupts would be held up in the APIC and w=
ould not be pended to the ROB. This event does count when an interrupt is o=
nly inhibited by MOV/POP SS state machines or the STI state machine. These =
extra inhibits only last for a single instructions and would not be importa=
nt.",
         "SampleAfterValue": "200003",
@@ -128,11 +128,110 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xcb",
         "EventName": "HW_INTERRUPTS.RECEIVED",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "203",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all code reads that have any type of r=
esponse.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all code reads that have an outstandin=
g request. Returns the number of cycles until the response is received (i.e=
. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000044",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3000000010000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have an outstanding request. Returns the number of cycles unt=
il the response is received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.COREWB_M.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8003000000000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000004",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve any type of response.",
         "Counter": "0,1,2,3",
@@ -141,7 +240,39 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve an outstanding request. Returns the number of cycles until the response =
is received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000001",
+        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -153,7 +284,39 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10001",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000001",
+        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -165,7 +328,347 @@
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10002",
         "Offcore": "1",
-        "PublicDescription": "Offcore response can be programmed only with=
 a specific pair of event select and counter MSR, and with specific event c=
odes and predefine mask bit value in a dedicated MSR to specify attributes =
of the offcore transaction.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have an outstan=
ding request. Returns the number of cycles until the response is received (=
i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000002",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x800000010000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache hardware prefetches and =
software prefetches (except PREFETCHW and PFRFO) that have any type of resp=
onse.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10400",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have an outstanding request. Returns th=
e number of cycles until the response is received (i.e. XQ to XQ latency)."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000040",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000010",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have an outstanding request. Returns the numb=
er of cycles until the response is received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000020",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L1WB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1000000010000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L2WB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2000000010000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts miscellaneous requests, such as I/O ac=
cesses, that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.OTHER.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x18000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x400000010000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all hardware and software prefetches t=
hat have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.PREFETCHES.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10470",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e an outstanding request. Returns the number of cycles until the response i=
s received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000477",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10800",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that have any ty=
pe of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x100000010000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x100184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x100184000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory reads that have an out=
standing request. Returns the number of cycles until the response is receiv=
ed (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000100000000000",
+        "Offcore": "1",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts uncached memory writes that have any t=
ype of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x200000010000",
+        "Offcore": "1",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     }
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
index c18acb422145..09919fdb9a38 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
@@ -131,6 +131,17 @@
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "200003",
+        "UMask": "0xeb"
+    },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
         "CollectPEBSRecord": "2",
@@ -159,7 +170,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xe8",
         "EventName": "BTCLEAR.ANY",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the total number of BTCLEARS which oc=
curs when the Branch Target Buffer (BTB) predicts a taken branch.",
         "SampleAfterValue": "200003"
@@ -169,9 +180,9 @@
         "CollectPEBSRecord": "2",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "33",
-        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. The core frequency may change from time to time. F=
or this reason this event may have a changing ratio with regards to time. T=
his event uses fixed counter 1.",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -181,9 +192,9 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. The core frequency may change from time to time. F=
or this reason this event may have a changing ratio with regards to time. T=
his event uses a programmable general purpose performance counter.",
+        "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003"
     },
     {
@@ -192,7 +203,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
@@ -203,7 +214,7 @@
         "CollectPEBSRecord": "2",
         "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "34",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
@@ -216,7 +227,7 @@
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction.  This event is not affected by core frequency c=
hanges and increments at a fixed frequency that is also used for the Time S=
tamp Counter (TSC). This event uses a programmable general purpose performa=
nce counter.",
+        "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -226,18 +237,19 @@
         "Counter": "0,1,2,3",
         "EventCode": "0xcd",
         "EventName": "CYCLES_DIV_BUSY.ANY",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003"
     },
     {
-        "BriefDescription": "Counts the number of cycles the integer divid=
er is busy.  Does not imply a stall waiting for the divider.",
+        "BriefDescription": "Counts the number of cycles the integer divid=
er is busy.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xcd",
         "EventName": "CYCLES_DIV_BUSY.IDIV",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of cycles the integer divi=
der is busy.  Does not imply a stall waiting for the divider.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
@@ -264,29 +276,107 @@
         "SampleAfterValue": "2000003"
     },
     {
-        "BriefDescription": "Counts the total number of machine clears inc=
luding memory ordering, memory disambiguation, self-modifying code, page fa=
ults and floating point assist.",
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.4K_ALIAS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked for any of the following reasons:  DTLB miss, address alias, store f=
orward or data unknown (includes memory disambiguation blocks and ESP consu=
ming load blocks).",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address partially overlapped with an older store.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the total number of machine clears for=
 any reason including, but not limited to, memory ordering, memory disambig=
uation, SMC, and FP assist.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.ANY",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "20003"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "20003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.PAGE_FAULT",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "20003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "20003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ) even if an FE_bound event occurs during this period. Also i=
ncludes the issue slots that were consumed by the backend but were thrown a=
way because they were younger than the mispredict or machine clear.",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to fast nukes such as memory orde=
ring and memory disambiguation machine clears.",
+        "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
@@ -297,6 +387,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
@@ -311,7 +402,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
@@ -322,7 +413,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MONUKE",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
@@ -333,7 +424,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003"
     },
@@ -343,7 +434,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
@@ -354,7 +445,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
@@ -365,7 +456,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
@@ -376,7 +467,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REGISTER",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x20"
@@ -387,7 +478,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x40"
@@ -398,7 +489,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x10"
@@ -409,18 +500,18 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.STORE_BUFFER",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to frontend stalls.",
+        "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to frontend stalls.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003"
     },
@@ -430,7 +521,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BACLEARS, which occurs when=
 the Branch Target Buffer (BTB) prediction or lack thereof, was corrected b=
y a later branch predictor in the frontend. Includes BACLEARS due to all br=
anch types including conditional and unconditional jumps, returns, and indi=
rect branches.",
         "SampleAfterValue": "1000003",
@@ -442,7 +533,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BTCLEARS, which occurs when=
 the Branch Target Buffer (BTB) predicts a taken branch.",
         "SampleAfterValue": "1000003",
@@ -454,7 +545,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.CISC",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
@@ -465,7 +556,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.DECODE",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
@@ -476,7 +567,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ITLB",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to Instruction Table Lookaside=
 Buffer (ITLB) misses.",
         "SampleAfterValue": "1000003",
@@ -488,7 +579,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.OTHER",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
@@ -499,7 +590,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
@@ -514,17 +605,59 @@
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "Counts the number of uops issued by the front=
 end every cycle.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0e",
+        "EventName": "UOPS_ISSUED.ANY",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of uops issued by the fron=
t end every cycle. When 4-uops are requested and only 2-uops are delivered,=
 the event counts 2.  Uops_issued correlates to the number of ROB entries. =
 If uop takes 2 ROB slots it counts as 2 uops_issued.",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Counts the total number of uops retired.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.ALL",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divide uops reti=
red.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.IDIV",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Counts the number of uops that are from compl=
ex flows issued by the micro-sequencer (MS).",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
-        "PDIR_COUNTER": "na",
         "PEBS": "1",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in MS flows.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.X87",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
index c58b589ff80f..b82f11591f13 100644
--- a/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
@@ -5,18 +5,18 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.PDE_CACHE_MISS",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to loads that did not start a page walk. Account f=
or all pages sizes. Will result in a DTLB write from STLB.",
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccount for all page sizes. Will result in a DTLB write from STLB.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "200003",
         "UMask": "0x20"
@@ -32,13 +32,25 @@
         "SampleAfterValue": "200003",
         "UMask": "0xe"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 1G page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 1GB pages. =
Includes page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 2M or 4M page.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pa=
ges. Includes page walks that page fault.",
         "SampleAfterValue": "200003",
@@ -50,21 +62,21 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 4K pages. I=
ncludes page walks that page fault.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Counts the number of page walks outstanding i=
n the page miss handler (PMH) for loads every cycle.",
+        "BriefDescription": "Counts the number of page walks outstanding i=
n the page miss handler (PMH) for demand loads every cycle.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of page walks outstanding =
in the page miss handler (PMH) for loads every cycle.  A page walk is outst=
anding from start till PMH becomes idle again (ready to serve next walk). I=
ncludes EPT-walk intervals.",
+        "PublicDescription": "Counts the number of page walks outstanding =
in the page miss handler (PMH) for demand loads every cycle.  A page walk i=
s outstanding from start till PMH becomes idle again (ready to serve next w=
alk). Includes EPT-walk intervals.",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
@@ -74,19 +86,52 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.PDE_CACHE_MISS",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
-        "PublicDescription": "Counts the number of page walks due to stors=
e that miss the PDE (Page Directory Entry) cache.",
         "SampleAfterValue": "2000003",
         "UMask": "0x80"
     },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to stores that did not start a page walk. Account =
for all pages sizes. Will result in a DTLB write from STLB.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to any page size.  Includes page walks =
that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 1G page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 1G pages.  Includes page walks that =
page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 2M or 4M page.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includes page walks=
 that page fault.",
         "SampleAfterValue": "2000003",
@@ -98,7 +143,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 4K pages.  Includes page walks that =
page fault.",
         "SampleAfterValue": "2000003",
@@ -110,7 +155,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
in the page miss handler (PMH) for stores every cycle.  A page walk is outs=
tanding from start till PMH becomes idle again (ready to serve next walk). =
Includes EPT-walk intervals.",
         "SampleAfterValue": "200003",
@@ -122,11 +167,11 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.EPDE_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of Extended Page Directory=
 Entry hits.  The Extended Page Directory cache is used by Virtual Machine =
operating systems while the guest operating systems use the standard TLB ca=
ches.",
         "SampleAfterValue": "2000003",
-        "UMask": "0x2"
+        "UMask": "0x1"
     },
     {
         "BriefDescription": "Counts the number of Extended Page Directory =
Entry misses.",
@@ -134,11 +179,11 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.EPDE_MISS",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number Extended Page Directory En=
try misses.  The Extended Page Directory cache is used by Virtual Machine o=
perating systems while the guest operating systems use the standard TLB cac=
hes.",
         "SampleAfterValue": "2000003",
-        "UMask": "0x1"
+        "UMask": "0x2"
     },
     {
         "BriefDescription": "Counts the number of Extended Page Directory =
Pointer Entry hits.",
@@ -146,7 +191,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.EPDPE_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number Extended Page Directory Po=
inter Entry hits.  The Extended Page Directory cache is used by Virtual Mac=
hine operating systems while the guest operating systems use the standard T=
LB caches.",
         "SampleAfterValue": "2000003",
@@ -158,19 +203,31 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4f",
         "EventName": "EPT.EPDPE_MISS",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number Extended Page Directory Po=
inter Entry misses.  The Extended Page Directory cache is used by Virtual M=
achine operating systems while the guest operating systems use the standard=
 TLB caches.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     },
+    {
+        "BriefDescription": "Counts the number of page walks outstanding f=
or an Extended Page table walk including GTLB hits per cycle.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4f",
+        "EventName": "EPT.WALK_PENDING",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks outstanding =
for an Extended Page table walk including GTLB hits per cycle.  The Extende=
d Page Directory cache is used by Virtual Machine operating systems while t=
he guest operating systems use the standard TLB caches.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Counts the number of times there was an ITLB =
miss and a new translation was filled into the ITLB.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x81",
         "EventName": "ITLB.FILLS",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of times the machine was u=
nable to find a translation in the Instruction Translation Lookaside Buffer=
 (ITLB) and a new translation was filled into the ITLB. The event is specul=
ative in nature, but will not count translations (page walks) that are begu=
n and not finished, or translations that are finished but not filled into t=
he ITLB.",
         "SampleAfterValue": "200003",
@@ -182,29 +239,52 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
         "UMask": "0x80"
     },
     {
-        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to an instruction fetch that did not start a page =
walk. Account for all pages sizes. Will results in a DTLB write from STLB."=
,
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to an instruction fetch that did not start a page =
walk. Account for all pages sizes. Will result in an ITLB write from STLB."=
,
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.STLB_HIT",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "SampleAfterValue": "2000003",
         "UMask": "0x20"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 1G page.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_1G",
+        "PDIR_COUNTER": "NA",
+        "PEBScounters": "0,1,2,3",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 1G pages.  Includes pag=
e walks that page fault.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 2M or 4M page.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 2M or 4M pages.  Includ=
es page walks that page fault.",
         "SampleAfterValue": "2000003",
@@ -216,7 +296,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 4K pages.  Includes pag=
e walks that page fault.",
         "SampleAfterValue": "2000003",
@@ -228,14 +308,25 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_PENDING",
-        "PDIR_COUNTER": "na",
+        "PDIR_COUNTER": "NA",
         "PEBScounters": "0,1,2,3",
         "PublicDescription": "Counts the number of page walks outstanding =
in the page miss handler (PMH) for instruction fetches every cycle.  A page=
 walk is outstanding from start till PMH becomes idle again (ready to serve=
 next walk).",
         "SampleAfterValue": "200003",
         "UMask": "0x10"
     },
     {
-        "BriefDescription": "Counts the number of memory retired ops that =
missed in the second level TLB.",
+        "BriefDescription": "Counts the number of retired loads that are b=
locked due to a first level TLB miss.",
+        "CollectPEBSRecord": "2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.DTLB_MISS",
+        "PEBS": "1",
+        "PEBScounters": "0,1,2,3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 missed in the second level TLB.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -247,7 +338,7 @@
         "UMask": "0x13"
     },
     {
-        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the second Level TLB.",
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the second Level TLB.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -259,7 +350,7 @@
         "UMask": "0x11"
     },
     {
-        "BriefDescription": "Counts the number of store ops retired that m=
iss in the second level TLB.",
+        "BriefDescription": "Counts the number of store uops retired that =
miss in the second level TLB.",
         "CollectPEBSRecord": "2",
         "Counter": "0,1,2,3",
         "Data_LA": "1",
@@ -270,4 +361,4 @@
         "SampleAfterValue": "200003",
         "UMask": "0x12"
     }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index d3c78384b885..b105d80d2b7d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -5,6 +5,7 @@ GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v23,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
+GenuineIntel-6-96,v1.03,elkhartlake,core
 GenuineIntel-6-5C,v8,goldmont,core
 GenuineIntel-6-7A,v1,goldmontplus,core
 GenuineIntel-6-3C,v24,haswell,core
@@ -37,7 +38,6 @@ GenuineIntel-6-A7,v1,icelake,core
 GenuineIntel-6-6A,v1,icelakex,core
 GenuineIntel-6-6C,v1,icelakex,core
 GenuineIntel-6-86,v1,tremontx,core
-GenuineIntel-6-96,v1,elkhartlake,core
 GenuineIntel-6-8F,v1,sapphirerapids,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
--=20
2.37.1.359.gd136c6c3e2-goog

