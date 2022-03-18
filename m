Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EA04DD6EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiCRJRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiCRJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:17:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31CD21F77B;
        Fri, 18 Mar 2022 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647594947; x=1679130947;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sYE+7IgdOsMvwbkZOVVdksmxotsDdpk3rPqrkQlk0sY=;
  b=DI4lugs0d97wtUZGmdS6RBuAlJbxJlwbB4fZGzO3F2BCjSlEGSoeMt7D
   wPS0yBCW1WzMHZjDexC/DqlEzEO9T4SCb75rz7H6LPrWBb/V6Tsz90T44
   wP+FQNQzzaba1TnpYK31kmq/5VQr1jj+c/cxhMJMBh8ZDCHnZYsM0mF+u
   HHFbZEizVZIg6GWdU7vSCz4b4FveJ4Kgivo4sjNrSWb8+UwYw147HGdl1
   4hvaIULrh3V9736AzvGEvDpYzt7TDdeMjYXtDo0LqtQoMI4JnROIqhiYz
   K9SusUWxwInBno1rHLtMV+7m7bHSn/wQXjwkbQyp6muO5DVauciGwgLhf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237712083"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="237712083"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:15:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558338001"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.171]) ([10.255.31.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:15:41 -0700
Message-ID: <ed3cd331-92ae-5f27-0a5a-0e9b8457e401@linux.intel.com>
Date:   Fri, 18 Mar 2022 17:15:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/8] perf vendor events: Update events for Icelake
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220317182858.484474-1-irogers@google.com>
 <20220317182858.484474-3-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220317182858.484474-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2022 2:28 AM, Ian Rogers wrote:
> The change:
> https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e394eed6a1ebd909c9f649d3ed3ef
> moved certain "other" type of events in to the cache and pipeline topic.
> Update the perf json files for this change.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

> ---
>   .../pmu-events/arch/x86/icelake/cache.json    | 633 +++++++++++++++
>   .../pmu-events/arch/x86/icelake/other.json    | 752 +-----------------
>   .../pmu-events/arch/x86/icelake/pipeline.json |  47 ++
>   3 files changed, 716 insertions(+), 716 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/cache.json b/tools/perf/pmu-events/arch/x86/icelake/cache.json
> index 96dcd387c70e..375ce490833c 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/cache.json
> @@ -553,6 +553,591 @@
>           "SampleAfterValue": "50021",
>           "UMask": "0x20"
>       },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.ANY",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FC03C0004",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0004",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0004",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0004",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0004",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop was sent.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_SENT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1E003C0004",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.ANY",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FC03C0001",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0001",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0001",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0001",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0001",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop was sent.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_SENT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1E003C0001",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.ANY",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FC03C0002",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0002",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0002",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0002",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0002",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop was sent.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_SENT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1E003C0002",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.ANY",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FC03C0400",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0400",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0400",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.ANY",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FC03C0010",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0010",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0010",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0010",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0010",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop was sent.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_SENT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1E003C0010",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.ANY",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FC03C0020",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0020",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0020",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0020",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0020",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop was sent.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_SENT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1E003C0020",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetches to the L3 only that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L3.L3_HIT.ANY",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FC03C2380",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C8000",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.OTHER.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C8000",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C8000",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that hit a cacheline in the L3 where a snoop was sent.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.OTHER.L3_HIT.SNOOP_SENT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1E003C8000",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts streaming stores that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.STREAMING_WR.L3_HIT.ANY",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FC03C0800",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Demand and prefetch data reads",
>           "CollectPEBSRecord": "2",
> @@ -674,5 +1259,53 @@
>           "SampleAfterValue": "100003",
>           "Speculative": "1",
>           "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.NTA",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHNTA instructions executed.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHW instructions executed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHW instructions executed.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T0",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHT0 instructions executed.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> +        "SampleAfterValue": "100003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/other.json b/tools/perf/pmu-events/arch/x86/icelake/other.json
> index 10e8582774ce..08f6321025e8 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/other.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/other.json
> @@ -78,418 +78,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop was sent or not.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.ANY",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3FC03C0004",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0004",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0004",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0004",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0004",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a cacheline in the L3 where a snoop was sent.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_SENT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1E003C0004",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that DRAM supplied the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000004",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that have any type of response.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that DRAM supplied the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop was sent or not.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.ANY",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3FC03C0001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop was sent.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_SENT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1E003C0001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that DRAM supplied the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that DRAM supplied the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop was sent or not.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.ANY",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3FC03C0002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop was sent.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_SENT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1E003C0002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that DRAM supplied the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that have any type of response.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10400",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that DRAM supplied the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L1D_AND_SWPF.DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000400",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.ANY",
> +        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3FC03C0400",
> +        "MSRValue": "0x184000004",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -498,13 +93,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> +        "BriefDescription": "Counts demand data reads that have any type of response.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_MISS",
> +        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0400",
> +        "MSRValue": "0x10001",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -513,13 +108,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> +        "BriefDescription": "Counts demand data reads that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_NOT_NEEDED",
> +        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0400",
> +        "MSRValue": "0x184000001",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -528,13 +123,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that DRAM supplied the request.",
> +        "BriefDescription": "Counts demand data reads that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L1D_AND_SWPF.LOCAL_DRAM",
> +        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000400",
> +        "MSRValue": "0x184000001",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -543,13 +138,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that have any type of response.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
> +        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10010",
> +        "MSRValue": "0x10002",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -558,13 +153,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that DRAM supplied the request.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
> +        "EventName": "OCR.DEMAND_RFO.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000010",
> +        "MSRValue": "0x184000002",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -573,13 +168,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop was sent or not.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.ANY",
> +        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3FC03C0010",
> +        "MSRValue": "0x184000002",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -588,13 +183,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> +        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that have any type of response.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0010",
> +        "MSRValue": "0x10400",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -603,13 +198,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> +        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "EventName": "OCR.HWPF_L1D_AND_SWPF.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0010",
> +        "MSRValue": "0x184000400",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -618,13 +213,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> +        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
> +        "EventName": "OCR.HWPF_L1D_AND_SWPF.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0010",
> +        "MSRValue": "0x184000400",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -633,13 +228,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> +        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that have any type of response.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0010",
> +        "MSRValue": "0x10010",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -648,13 +243,13 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that hit a cacheline in the L3 where a snoop was sent.",
> +        "BriefDescription": "Counts hardware prefetch data reads (which bring data to L2)  that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_SENT",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1E003C0010",
> +        "MSRValue": "0x184000010",
>           "Offcore": "1",
>           "PEBScounters": "0,1,2,3",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> @@ -707,96 +302,6 @@
>           "Speculative": "1",
>           "UMask": "0x1"
>       },
> -    {
> -        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop was sent or not.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.ANY",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3FC03C0020",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0020",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0020",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0020",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0020",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that hit a cacheline in the L3 where a snoop was sent.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_SENT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1E003C0020",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
>       {
>           "BriefDescription": "Counts hardware prefetch RFOs (which bring data to L2) that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
> @@ -812,21 +317,6 @@
>           "Speculative": "1",
>           "UMask": "0x1"
>       },
> -    {
> -        "BriefDescription": "Counts hardware prefetches to the L3 only that hit a cacheline in the L3 where a snoop was sent or not.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L3.L3_HIT.ANY",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3FC03C2380",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
>       {
>           "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that have any type of response.",
>           "CollectPEBSRecord": "2",
> @@ -857,66 +347,6 @@
>           "Speculative": "1",
>           "UMask": "0x1"
>       },
> -    {
> -        "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that hit a cacheline in the L3 where a snoop hit in another core, data forwarding is not required.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.OTHER.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C8000",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that hit a cacheline in the L3 where a snoop was sent but no other cores had the data.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.OTHER.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C8000",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that hit a cacheline in the L3 where a snoop was not needed to satisfy the request.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.OTHER.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C8000",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that hit a cacheline in the L3 where a snoop was sent.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.OTHER.L3_HIT.SNOOP_SENT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1E003C8000",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
>       {
>           "BriefDescription": "Counts miscellaneous requests, such as I/O and un-cacheable accesses that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
> @@ -962,21 +392,6 @@
>           "Speculative": "1",
>           "UMask": "0x1"
>       },
> -    {
> -        "BriefDescription": "Counts streaming stores that hit a cacheline in the L3 where a snoop was sent or not.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.STREAMING_WR.L3_HIT.ANY",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3FC03C0800",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
>       {
>           "BriefDescription": "Counts streaming stores that DRAM supplied the request.",
>           "CollectPEBSRecord": "2",
> @@ -991,100 +406,5 @@
>           "SampleAfterValue": "100003",
>           "Speculative": "1",
>           "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.NTA",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of PREFETCHNTA instructions executed.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHW instructions executed.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of PREFETCHW instructions executed.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.T0",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of PREFETCHT0 instructions executed.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> -        "SampleAfterValue": "100003",
> -        "Speculative": "1",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "TMA slots where no uops were being issued due to lack of back-end resources.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0xa4",
> -        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
> -        "PEBScounters": "0,1,2,3,4,5,6,7",
> -        "PublicDescription": "Counts the number of Top-down Microarchitecture Analysis (TMA) method's  slots where no micro-operations were being issued from front-end to back-end of the machine due to lack of back-end resources.",
> -        "SampleAfterValue": "10000003",
> -        "Speculative": "1",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "TMA slots wasted due to incorrect speculation by branch mispredictions",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0xa4",
> -        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
> -        "PEBScounters": "0,1,2,3,4,5,6,7",
> -        "PublicDescription": "Number of TMA slots that were wasted due to incorrect speculation by branch mispredictions. This event estimates number of operations that were issued but not retired from the specualtive path as well as the out-of-order engine recovery past a branch misprediction.",
> -        "SampleAfterValue": "10000003",
> -        "Speculative": "1",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "Fixed counter 3",
> -        "EventName": "TOPDOWN.SLOTS",
> -        "PEBScounters": "35",
> -        "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
> -        "SampleAfterValue": "10000003",
> -        "Speculative": "1",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "TMA slots available for an unhalted logical processor. General counter - architectural event",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0xa4",
> -        "EventName": "TOPDOWN.SLOTS_P",
> -        "PEBScounters": "0,1,2,3,4,5,6,7",
> -        "PublicDescription": "Counts the number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method. The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core.",
> -        "SampleAfterValue": "10000003",
> -        "Speculative": "1",
> -        "UMask": "0x1"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
> index 2b305bdc8cfc..573ac7ac8879 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
> @@ -730,6 +730,53 @@
>           "Speculative": "1",
>           "UMask": "0x1"
>       },
> +    {
> +        "BriefDescription": "TMA slots where no uops were being issued due to lack of back-end resources.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of Top-down Microarchitecture Analysis (TMA) method's  slots where no micro-operations were being issued from front-end to back-end of the machine due to lack of back-end resources.",
> +        "SampleAfterValue": "10000003",
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "TMA slots wasted due to incorrect speculation by branch mispredictions",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Number of TMA slots that were wasted due to incorrect speculation by branch mispredictions. This event estimates number of operations that were issued but not retired from the specualtive path as well as the out-of-order engine recovery past a branch misprediction.",
> +        "SampleAfterValue": "10000003",
> +        "Speculative": "1",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "Fixed counter 3",
> +        "EventName": "TOPDOWN.SLOTS",
> +        "PEBScounters": "35",
> +        "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
> +        "SampleAfterValue": "10000003",
> +        "Speculative": "1",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logical processor. General counter - architectural event",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.SLOTS_P",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method. The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core.",
> +        "SampleAfterValue": "10000003",
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Number of uops decoded out of instructions exclusively fetched by decoder 0",
>           "CollectPEBSRecord": "2",

-- 
Zhengjun Xing
