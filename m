Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A351F5F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbiEIHyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiEIHgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:36:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608317DDC9;
        Mon,  9 May 2022 00:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652081573; x=1683617573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wERExfFN4da+yvy6wTuFfIJiQfEIoBVwmFHXMJLKJKE=;
  b=FSzOO98vDd/t8TtoXthwvxzdhNhsYZlHZa+x7thUPzySAbXe+xXAncTi
   KrqN7IASoN+xBqjzOlTTC0MrtTAP+Z4mXvBKtSI63M4cuQN4aHvTKAStM
   Tp1C0BNEKbCJmLWKLrbIGjzk/1CDzds7Sx88smOKvNP/XkDA38Gkt3O+j
   MZAmIJiBNUPZHd7Z17ePpd/Ql2wz7UJIOZzvYS34ZJoRudJmxEJm4xE30
   2NHoC04Z76jp02pnkvaGQkHoPew8i1xYMmCdA6BdqAm/4J87ibxP1I8Ul
   AmjSWowgfa08pIWdYFaEm19QdJUqfWhhbtnNm/Le3bN7AQpK65sG23OjS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="355396841"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="355396841"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 00:32:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="696265365"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.170.11]) ([10.249.170.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 00:32:48 -0700
Message-ID: <bbf7d42a-d8c3-4253-f4d1-0be1ce836ca3@linux.intel.com>
Date:   Mon, 9 May 2022 15:32:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] perf vendor events: Update alderlake to v1.10
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220504025220.2754910-1-irogers@google.com>
 <20220504025220.2754910-2-irogers@google.com>
 <4955454f-8d10-cdc9-189d-8e66a1a86bac@linux.intel.com>
 <CAP-5=fXhrN9w7f32EwGunKtUKSP7nf8o8E1HPTNA-f+wR=KOnw@mail.gmail.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAP-5=fXhrN9w7f32EwGunKtUKSP7nf8o8E1HPTNA-f+wR=KOnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2022 11:38 PM, Ian Rogers wrote:
> On Wed, May 4, 2022 at 5:40 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 5/3/2022 10:52 PM, Ian Rogers wrote:
>>> Events from:
>>> https://download.01.org/perfmon/ADL/
>>>
>>> Converted to perf json using:
>>> https://github.com/intel/event-converter-for-linux-perf/pull/11
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>    .../arch/x86/alderlake/adl-metrics.json       | 70 ++++++++++++++--
>>>    .../pmu-events/arch/x86/alderlake/cache.json  | 42 ++++++----
>>>    .../arch/x86/alderlake/frontend.json          | 17 +++-
>>>    .../pmu-events/arch/x86/alderlake/memory.json | 22 ++---
>>>    .../pmu-events/arch/x86/alderlake/other.json  | 27 ++-----
>>>    .../arch/x86/alderlake/pipeline.json          | 81 +++++++++++++++++--
>>>    .../arch/x86/alderlake/uncore-other.json      |  4 +-
>>>    .../arch/x86/alderlake/virtual-memory.json    |  4 +-
>>>    8 files changed, 205 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
>>> index 4d172687f936..27a60e183c61 100644
>>> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
>>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
>>> @@ -190,7 +190,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Average number of Uops issued by front-end when it issued something",
>>> -        "MetricExpr": "UOPS_ISSUED.ANY / cpu_core@UOPS_ISSUED.ANY\\,cmask\\=1@",
>>> +        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=1@",
>>
>> For the hybrid platform, the current PMU name is either cpu_atom or
>> cpu_core. "cpu" is not supported.
>>
>> Is it a bug of the converter tool?
> 
> Thanks Kan, it could be something with the converter tool. Perhaps
> related to this option:
> https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.sh#L188
> I'll dig in and post a v2 when it is fixed.
> 
The perf event convert tools have fixed the "cpu_core" issue for the 
hybrid system.

> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>
>>>            "MetricGroup": "Fed;FetchBW",
>>>            "MetricName": "Fetch_UpC",
>>>            "Unit": "cpu_core"
>>> @@ -435,6 +435,66 @@
>>>            "MetricName": "IpFarBranch",
>>>            "Unit": "cpu_core"
>>>        },
>>> +    {
>>> +        "BriefDescription": "C1 residency percent per core",
>>> +        "MetricExpr": "(cstate_core@c1\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C1_Core_Residency"
>>> +    },
The origin code already has the "cstate" metrics, this should duplicate 
the metrics.
>>> +    {
>>> +        "BriefDescription": "C6 residency percent per core",
>>> +        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C6_Core_Residency"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "C7 residency percent per core",
>>> +        "MetricExpr": "(cstate_core@c7\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C7_Core_Residency"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "C2 residency percent per package",
>>> +        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C2_Pkg_Residency"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "C3 residency percent per package",
>>> +        "MetricExpr": "(cstate_pkg@c3\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C3_Pkg_Residency"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "C6 residency percent per package",
>>> +        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C6_Pkg_Residency"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "C7 residency percent per package",
>>> +        "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C7_Pkg_Residency"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "C8 residency percent per package",
>>> +        "MetricExpr": "(cstate_pkg@c8\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C8_Pkg_Residency"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "C9 residency percent per package",
>>> +        "MetricExpr": "(cstate_pkg@c9\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C9_Pkg_Residency"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "C10 residency percent per package",
>>> +        "MetricExpr": "(cstate_pkg@c10\\-residency@ / msr@tsc@) * 100",
>>> +        "MetricGroup": "Power",
>>> +        "MetricName": "C10_Pkg_Residency"
>>> +    },
>>>        {
>>>            "BriefDescription": "Counts the number of issue slots  that were not consumed by the backend due to frontend stalls.",
>>>            "MetricExpr": "TOPDOWN_FE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)",
>>> @@ -461,7 +521,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls",
>>> -        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)",
>>> +        "MetricExpr": "(TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE))",
>>>            "MetricGroup": "TopdownL1",
>>>            "MetricName": "Backend_Bound_Aux",
>>>            "PublicDescription": "Counts the total number of issue slots  that were not consumed by the backend due to backend stalls.  Note that UOPS must be available for consumption in order for this event to count.  If a uop is not available (IQ is empty), this event will not count.  All of these subevents count backend stalls, in slots, due to a resource limitation.   These are not cycle based events and therefore can not be precisely added or subtracted from the Backend_Bound subevents which are cycle based.  These subevents are supplementary to Backend_Bound and can be used to analyze results from a resource perspective at allocation.  ",
>>> @@ -538,14 +598,14 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
>>> +        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
>>>            "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>>>            "MetricGroup": " ",
>>>            "MetricName": "IpBranch",
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Instruction per (near) call (lower number means higher occurrence rate)",
>>> +        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
>>>            "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
>>>            "MetricGroup": " ",
>>>            "MetricName": "IpCall",
>>> @@ -644,7 +704,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Estimated Pause cost. In percent",
>>> -        "MetricExpr": "100 * SERIALIZATION.NON_C01_MS_SCB / ( 5 * CPU_CLK_UNHALTED.CORE )",
>>> +        "MetricExpr": "100 * SERIALIZATION.NON_C01_MS_SCB / (5 * CPU_CLK_UNHALTED.CORE)",
>>>            "MetricGroup": " ",
>>>            "MetricName": "Estimated_Pause_Cost",
>>>            "Unit": "cpu_atom"
>>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
>>> index b83ed129c454..ea973ff5a216 100644
>>> --- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
>>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
>>> @@ -1,6 +1,6 @@
>>>    [
>>>        {
>>> -        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or tlb miss which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
>>> +        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x34",
>>> @@ -11,7 +11,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or tlb miss which hit in DRAM or MMIO (Non-DRAM).",
>>> +        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non-DRAM).",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x34",
>>> @@ -22,7 +22,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or tlb miss which hit in the L2 cache.",
>>> +        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the L2 cache.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x34",
>>> @@ -33,7 +33,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or tlb miss which hit in the last level cache or other core with HITE/F/M.",
>>> +        "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the LLC or other core with HITE/F/M.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x34",
>>> @@ -88,7 +88,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of load ops retired that hit in DRAM.",
>>> +        "BriefDescription": "Counts the number of load uops retired that hit in DRAM.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "Data_LA": "1",
>>> @@ -101,7 +101,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of load ops retired that hit in the L2 cache.",
>>> +        "BriefDescription": "Counts the number of load uops retired that hit in the L2 cache.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "Data_LA": "1",
>>> @@ -114,7 +114,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of load ops retired that hit in the L3 cache.",
>>> +        "BriefDescription": "Counts the number of load uops retired that hit in the L3 cache.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0xd1",
>>> @@ -202,6 +202,7 @@
>>>            "Data_LA": "1",
>>>            "EventCode": "0xd0",
>>>            "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
>>> +        "L1_Hit_Indication": "1",
>>>            "MSRIndex": "0x3F6",
>>>            "MSRValue": "0x80",
>>>            "PEBS": "2",
>>> @@ -218,6 +219,7 @@
>>>            "Data_LA": "1",
>>>            "EventCode": "0xd0",
>>>            "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
>>> +        "L1_Hit_Indication": "1",
>>>            "MSRIndex": "0x3F6",
>>>            "MSRValue": "0x10",
>>>            "PEBS": "2",
>>> @@ -234,6 +236,7 @@
>>>            "Data_LA": "1",
>>>            "EventCode": "0xd0",
>>>            "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
>>> +        "L1_Hit_Indication": "1",
>>>            "MSRIndex": "0x3F6",
>>>            "MSRValue": "0x100",
>>>            "PEBS": "2",
>>> @@ -250,6 +253,7 @@
>>>            "Data_LA": "1",
>>>            "EventCode": "0xd0",
>>>            "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
>>> +        "L1_Hit_Indication": "1",
>>>            "MSRIndex": "0x3F6",
>>>            "MSRValue": "0x20",
>>>            "PEBS": "2",
>>> @@ -266,6 +270,7 @@
>>>            "Data_LA": "1",
>>>            "EventCode": "0xd0",
>>>            "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
>>> +        "L1_Hit_Indication": "1",
>>>            "MSRIndex": "0x3F6",
>>>            "MSRValue": "0x4",
>>>            "PEBS": "2",
>>> @@ -282,6 +287,7 @@
>>>            "Data_LA": "1",
>>>            "EventCode": "0xd0",
>>>            "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
>>> +        "L1_Hit_Indication": "1",
>>>            "MSRIndex": "0x3F6",
>>>            "MSRValue": "0x200",
>>>            "PEBS": "2",
>>> @@ -298,6 +304,7 @@
>>>            "Data_LA": "1",
>>>            "EventCode": "0xd0",
>>>            "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
>>> +        "L1_Hit_Indication": "1",
>>>            "MSRIndex": "0x3F6",
>>>            "MSRValue": "0x40",
>>>            "PEBS": "2",
>>> @@ -314,6 +321,7 @@
>>>            "Data_LA": "1",
>>>            "EventCode": "0xd0",
>>>            "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
>>> +        "L1_Hit_Indication": "1",
>>>            "MSRIndex": "0x3F6",
>>>            "MSRValue": "0x8",
>>>            "PEBS": "2",
>>> @@ -324,7 +332,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts all the retired split loads.",
>>> +        "BriefDescription": "Counts the number of retired split load uops.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "Data_LA": "1",
>>> @@ -338,11 +346,13 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts the number of stores uops retired. Counts with or without PEBS enabled.",
>>> -        "CollectPEBSRecord": "2",
>>> +        "CollectPEBSRecord": "3",
>>>            "Counter": "0,1,2,3,4,5",
>>> +        "Data_LA": "1",
>>>            "EventCode": "0xd0",
>>>            "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
>>> -        "PEBS": "1",
>>> +        "L1_Hit_Indication": "1",
>>> +        "PEBS": "2",
>>>            "PEBScounters": "0,1,2,3,4,5",
>>>            "SampleAfterValue": "1000003",
>>>            "UMask": "0x6",
>>> @@ -350,7 +360,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0xB7",
>>>            "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -983,7 +993,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand data reads that resulted in a snoop hit in another cores caches, data forwarding is required as the data is modified.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>>            "EventCode": "0x2A,0x2B",
>>>            "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -993,8 +1003,8 @@
>>>            "Unit": "cpu_core"
>>>        },
>>>        {
>>> -        "BriefDescription": "DEMAND_DATA_RD & L3_HIT & SNOOP_HIT_WITH_FWD",
>>> -        "Counter": "0,1,2,3",
>>> +        "BriefDescription": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>>            "EventCode": "0x2A,0x2B",
>>>            "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -1005,7 +1015,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that resulted in a snoop hit in another cores caches, data forwarding is required as the data is modified.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>>            "EventCode": "0x2A,0x2B",
>>>            "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -1137,4 +1147,4 @@
>>>            "UMask": "0x4",
>>>            "Unit": "cpu_core"
>>>        }
>>> -]
>>> \ No newline at end of file
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
>>> index 908588f63314..2c27d5806625 100644
>>> --- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
>>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
>>> @@ -294,6 +294,21 @@
>>>            "UMask": "0x1",
>>>            "Unit": "cpu_core"
>>>        },
>>> +    {
>>> +        "BriefDescription": "TBD",
>>> +        "CollectPEBSRecord": "2",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>> +        "EventCode": "0xc6",
>>> +        "EventName": "FRONTEND_RETIRED.MS_FLOWS",
>>> +        "MSRIndex": "0x3F7",
>>> +        "MSRValue": "0x8",
>>> +        "PEBS": "1",
>>> +        "PEBScounters": "0,1,2,3,4,5,6,7",
>>> +        "SampleAfterValue": "100007",
>>> +        "TakenAlone": "1",
>>> +        "UMask": "0x1",
>>> +        "Unit": "cpu_core"
>>> +    },
>>>        {
>>>            "BriefDescription": "Retired Instructions who experienced STLB (2nd level TLB) true miss.",
>>>            "CollectPEBSRecord": "2",
>>> @@ -488,4 +503,4 @@
>>>            "UMask": "0x1",
>>>            "Unit": "cpu_core"
>>>        }
>>> -]
>>> \ No newline at end of file
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
>>> index 1d4d1ebe2a74..95ff71c9b176 100644
>>> --- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
>>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
>>> @@ -1,24 +1,28 @@
>>>    [
>>>        {
>>>            "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to any number of reasons, including an L1 miss, WCB full, pagewalk, store address block or store data block, on a load that retires.",
>>> +        "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x05",
>>>            "EventName": "LD_HEAD.ANY_AT_RET",
>>> +        "PEBScounters": "0,1,2,3,4,5",
>>>            "SampleAfterValue": "1000003",
>>>            "UMask": "0xff",
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>>            "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a core bound stall including a store address match, a DTLB miss or a page walk that detains the load from retiring.",
>>> -        "Counter": "0,1,2,3",
>>> +        "CollectPEBSRecord": "2",
>>> +        "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x05",
>>>            "EventName": "LD_HEAD.L1_BOUND_AT_RET",
>>> +        "PEBScounters": "0,1,2,3,4,5",
>>>            "SampleAfterValue": "1000003",
>>>            "UMask": "0xf4",
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to other block cases when load subsequently retires when load subsequently retires.",
>>> +        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to other block cases.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x05",
>>> @@ -29,7 +33,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a pagewalk when load subsequently retires.",
>>> +        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a pagewalk.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x05",
>>> @@ -40,7 +44,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a store address match when load subsequently retires.",
>>> +        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a store address match.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x05",
>>> @@ -63,7 +67,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0xB7",
>>>            "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -74,7 +78,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0xB7",
>>>            "EventName": "OCR.DEMAND_RFO.L3_MISS",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -295,7 +299,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>>            "EventCode": "0x2A,0x2B",
>>>            "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -306,7 +310,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>>            "EventCode": "0x2A,0x2B",
>>>            "EventName": "OCR.DEMAND_RFO.L3_MISS",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -315,4 +319,4 @@
>>>            "UMask": "0x1",
>>>            "Unit": "cpu_core"
>>>        }
>>> -]
>>> \ No newline at end of file
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/perf/pmu-events/arch/x86/alderlake/other.json
>>> index dc810f093fb0..7a03b6bc0d44 100644
>>> --- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
>>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
>>> @@ -1,7 +1,7 @@
>>>    [
>>>        {
>>>            "BriefDescription": "Counts demand data reads that have any type of response.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0xB7",
>>>            "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -12,7 +12,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0xB7",
>>>            "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -23,7 +23,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts streaming stores that have any type of response.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0xB7",
>>>            "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -33,18 +33,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
>>> -        "CollectPEBSRecord": "2",
>>> -        "Counter": "0,1,2,3,4,5,6,7",
>>> -        "EventCode": "0xc1",
>>> -        "EventName": "ASSISTS.ANY",
>>> -        "PEBScounters": "0,1,2,3,4,5,6,7",
>>> -        "SampleAfterValue": "100003",
>>> -        "UMask": "0x1f",
>>> -        "Unit": "cpu_core"
>>> -    },
>>> -    {
>>> -        "BriefDescription": "Count all other microcode assist beyond FP, AVX_TILE_MIX and A/D assists (counted by their own sub-events). This includes assists at uop writeback like AVX* load/store (non-FP) assists, Null Assist in SNC (due to lack of FP precision format convert with FMA3x3 uarch) or assists generated by ROB (like assists to due to Missprediction for FSW register - fixed in SNC)",
>>> +        "BriefDescription": "TBD",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5,6,7",
>>>            "EventCode": "0xc1",
>>> @@ -100,7 +89,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand data reads that have any type of response.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>>            "EventCode": "0x2A,0x2B",
>>>            "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -111,7 +100,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>>            "EventCode": "0x2A,0x2B",
>>>            "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -122,7 +111,7 @@
>>>        },
>>>        {
>>>            "BriefDescription": "Counts streaming stores that have any type of response.",
>>> -        "Counter": "0,1,2,3",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>>            "EventCode": "0x2A,0x2B",
>>>            "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
>>>            "MSRIndex": "0x1a6,0x1a7",
>>> @@ -143,4 +132,4 @@
>>>            "UMask": "0x1",
>>>            "Unit": "cpu_core"
>>>        }
>>> -]
>>> \ No newline at end of file
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
>>> index de2c6e0ef654..eb5e5a889eed 100644
>>> --- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
>>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
>>> @@ -23,7 +23,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of far branch instructions retired, includes far jump, far call and return, and Interrupt call and return.",
>>> +        "BriefDescription": "Counts the number of far branch instructions retired, includes far jump, far call and return, and interrupt call and return.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0xc4",
>>> @@ -108,7 +108,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of instructions retired. (Fixed event)",
>>> +        "BriefDescription": "Counts the total number of instructions retired. (Fixed event)",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "32",
>>>            "EventName": "INST_RETIRED.ANY",
>>> @@ -182,7 +182,6 @@
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0xc3",
>>>            "EventName": "MACHINE_CLEARS.PAGE_FAULT",
>>> -        "PEBS": "1",
>>>            "PEBScounters": "0,1,2,3,4,5",
>>>            "SampleAfterValue": "20003",
>>>            "UMask": "0x20",
>>> @@ -211,7 +210,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of issue slots not consumed due to a micro-sequencer (MS) scoreboard, which stalls the front-end from issuing uops from the UROM until a specified older uop retires.",
>>> +        "BriefDescription": "Counts the number of issue slots not consumed by the backend due to a micro-sequencer (MS) scoreboard, which stalls the front-end from issuing from the UROM until a specified older uop retires.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x75",
>>> @@ -555,7 +554,18 @@
>>>            "Unit": "cpu_core"
>>>        },
>>>        {
>>> -        "BriefDescription": "TBD",
>>> +        "BriefDescription": "This event counts the cycles the integer divider is busy.",
>>> +        "CollectPEBSRecord": "2",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>> +        "EventCode": "0xb0",
>>> +        "EventName": "ARITH.IDIV_ACTIVE",
>>> +        "PEBScounters": "0,1,2,3,4,5,6,7",
>>> +        "SampleAfterValue": "1000003",
>>> +        "UMask": "0x8",
>>> +        "Unit": "cpu_core"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "This event is deprecated. Refer to new event ARITH.IDIV_ACTIVE",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5,6,7",
>>>            "CounterMask": "1",
>>> @@ -566,6 +576,17 @@
>>>            "UMask": "0x8",
>>>            "Unit": "cpu_core"
>>>        },
>>> +    {
>>> +        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware.",
>>> +        "CollectPEBSRecord": "2",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>> +        "EventCode": "0xc1",
>>> +        "EventName": "ASSISTS.ANY",
>>> +        "PEBScounters": "0,1,2,3,4,5,6,7",
>>> +        "SampleAfterValue": "100003",
>>> +        "UMask": "0x1f",
>>> +        "Unit": "cpu_core"
>>> +    },
>>>        {
>>>            "BriefDescription": "All branch instructions retired.",
>>>            "CollectPEBSRecord": "2",
>>> @@ -756,6 +777,39 @@
>>>            "UMask": "0x8",
>>>            "Unit": "cpu_core"
>>>        },
>>> +    {
>>> +        "BriefDescription": "Core clocks when the thread is in the C0.1 light-weight slower wakeup time but more power saving optimized state.",
>>> +        "CollectPEBSRecord": "2",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>> +        "EventCode": "0xec",
>>> +        "EventName": "CPU_CLK_UNHALTED.C01",
>>> +        "PEBScounters": "0,1,2,3,4,5,6,7",
>>> +        "SampleAfterValue": "2000003",
>>> +        "UMask": "0x10",
>>> +        "Unit": "cpu_core"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "Core clocks when the thread is in the C0.2 light-weight faster wakeup time but less power saving optimized state.",
>>> +        "CollectPEBSRecord": "2",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>> +        "EventCode": "0xec",
>>> +        "EventName": "CPU_CLK_UNHALTED.C02",
>>> +        "PEBScounters": "0,1,2,3,4,5,6,7",
>>> +        "SampleAfterValue": "2000003",
>>> +        "UMask": "0x20",
>>> +        "Unit": "cpu_core"
>>> +    },
>>> +    {
>>> +        "BriefDescription": "Core clocks when the thread is in the C0.1 or C0.2 or running a PAUSE in C0 ACPI state.",
>>> +        "CollectPEBSRecord": "2",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>> +        "EventCode": "0xec",
>>> +        "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
>>> +        "PEBScounters": "0,1,2,3,4,5,6,7",
>>> +        "SampleAfterValue": "2000003",
>>> +        "UMask": "0x70",
>>> +        "Unit": "cpu_core"
>>> +    },
>>>        {
>>>            "BriefDescription": "Cycle counts are evenly distributed between active threads in the Core.",
>>>            "CollectPEBSRecord": "2",
>>> @@ -981,6 +1035,17 @@
>>>            "UMask": "0x40",
>>>            "Unit": "cpu_core"
>>>        },
>>> +    {
>>> +        "BriefDescription": "Cycles no uop executed while RS was not empty, the SB was not full and there was no outstanding load.",
>>> +        "CollectPEBSRecord": "2",
>>> +        "Counter": "0,1,2,3,4,5,6,7",
>>> +        "EventCode": "0xa6",
>>> +        "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
>>> +        "PEBScounters": "0,1,2,3,4,5,6,7",
>>> +        "SampleAfterValue": "1000003",
>>> +        "UMask": "0x80",
>>> +        "Unit": "cpu_core"
>>> +    },
>>>        {
>>>            "BriefDescription": "Instruction decoders utilized in a cycle",
>>>            "CollectPEBSRecord": "2",
>>> @@ -1244,7 +1309,7 @@
>>>            "CounterMask": "1",
>>>            "EventCode": "0xa8",
>>>            "EventName": "LSD.CYCLES_ACTIVE",
>>> -        "PEBScounters": "0,1,2,3",
>>> +        "PEBScounters": "0,1,2,3,4,5,6,7",
>>>            "SampleAfterValue": "2000003",
>>>            "UMask": "0x1",
>>>            "Unit": "cpu_core"
>>> @@ -1256,7 +1321,7 @@
>>>            "CounterMask": "6",
>>>            "EventCode": "0xa8",
>>>            "EventName": "LSD.CYCLES_OK",
>>> -        "PEBScounters": "0,1,2,3",
>>> +        "PEBScounters": "0,1,2,3,4,5,6,7",
>>>            "SampleAfterValue": "2000003",
>>>            "UMask": "0x1",
>>>            "Unit": "cpu_core"
>>> @@ -1718,4 +1783,4 @@
>>>            "UMask": "0x2",
>>>            "Unit": "cpu_core"
>>>        }
>>> -]
>>> \ No newline at end of file
>>> +]
>>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
>>> index 50de82c29944..acc6cab7ab3c 100644
>>> --- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
>>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
>>> @@ -3,10 +3,10 @@
>>>            "BriefDescription": "This 48-bit fixed counter counts the UCLK cycles",
>>>            "Counter": "Fixed",
>>>            "CounterType": "PGMABLE",
>>> -     "EventCode": "0xff",
>>>            "EventName": "UNC_CLOCK.SOCKET",
>>>            "PerPkg": "1",
>>> -        "Unit": "CLOCK"
>>> +        "UMask": "0x01",
>>> +        "Unit": "NCU"
>>>        },
>>>        {
>>>            "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC",
>>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
>>> index 1cc39aa032e1..85516c64b9c0 100644
>>> --- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
>>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
>>> @@ -22,7 +22,7 @@
>>>            "Unit": "cpu_atom"
>>>        },
>>>        {
>>> -        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a DTLB miss when load subsequently retires.",
>>> +        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a DTLB miss.",
>>>            "CollectPEBSRecord": "2",
>>>            "Counter": "0,1,2,3,4,5",
>>>            "EventCode": "0x05",
>>> @@ -255,4 +255,4 @@
>>>            "UMask": "0x10",
>>>            "Unit": "cpu_core"
>>>        }
>>> -]
>>> \ No newline at end of file
>>> +]

-- 
Zhengjun Xing
