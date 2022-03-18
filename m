Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6135F4DD6E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiCRJNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiCRJNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:13:41 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE12C5433;
        Fri, 18 Mar 2022 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647594742; x=1679130742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Me0Fezbbe+gbJZhEitD9VhzLftBh+k3c91S9F31AJ2Y=;
  b=X2NF+GQjBqiwg3F0JndbztgTVS1OLdGyHiJAyh8T6QgQWGD388uNIwUJ
   L5OyZphz1xWBk452tHuQa8gVHv89ifGDvviCK4Jd1wXleuP4L9h09M1D9
   8dpCFrQzlD/YwkHsQqNStWVOfI6C9oCciNrGt9d3DHgdpA67LauC2CeNA
   9SDunID1h5oR/2dvUyfKNnTmFw+7gkxM0vvVj4hA0HEtIzv1EAPmqyEW2
   puorPU0AbE2k/lw00mvFiXUOGomhIoGcre8o75pE04Imz7rs64NA4Y/oJ
   I0qpcYDXKQLbo38N4PDacIO36W/sQE27U8WmIgc9Px+K9LFLBDb1jaYgL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="317816728"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="317816728"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:12:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558337101"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.171]) ([10.255.31.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:12:17 -0700
Message-ID: <07278c8f-e8af-d042-a0e2-7ba8a510ef78@linux.intel.com>
Date:   Fri, 18 Mar 2022 17:12:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/8] perf vendor events: Update events for Elkhartlake
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
 <20220317182858.484474-2-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220317182858.484474-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
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
> moved certain "other" type of events in to the pipeline topic. Update the
> perf json files for this change.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

> ---
>   .../arch/x86/elkhartlake/other.json           | 241 ------------------
>   .../arch/x86/elkhartlake/pipeline.json        | 241 ++++++++++++++++++
>   2 files changed, 241 insertions(+), 241 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json b/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
> index 627691404155..de55b199ba79 100644
> --- a/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
> +++ b/tools/perf/pmu-events/arch/x86/elkhartlake/other.json
> @@ -179,246 +179,5 @@
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear. Only issue slots wasted due to fast nukes such as memory ordering nukes are counted. Other nukes are not accounted for. Counts all issue slots blocked during this recovery window including relevant microcode flows and while uops are not yet available in the instruction queue (IQ). Also includes the issue slots that were consumed by the backend but were thrown away because they were younger than the mispredict or machine clear.",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x6"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to fast nukes such as memory ordering and memory disambiguation machine clears.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a machine clear (nuke) of any kind including memory ordering and memory disambiguation.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to branch mispredicts.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "This event is deprecated. Refer to new event TOPDOWN_BAD_SPECULATION.FASTNUKE",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.MONUKE",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the total number of issue slots every cycle that were not consumed by the backend due to backend stalls.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.ALL",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to certain allocation restrictions.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to memory reservation stalls in which a scheduler is not able to accept uops.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to IEC or FPC RAT stalls, which can be due to FIQ or IEC reservation stalls in which the integer, floating point or SIMD scheduler is not able to accept uops.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the physical register file unable to accept an entry (marble stalls).",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x20"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the reorder buffer being full (ROB stalls).",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x40"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to scoreboards from the instruction queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x10"
> -    },
> -    {
> -        "BriefDescription": "This event is deprecated.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.STORE_BUFFER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to frontend stalls.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.ALL",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS, which occurs when the Branch Target Buffer (BTB) prediction or lack thereof, was corrected by a later branch predictor in the frontend. Includes BACLEARS due to all branch types including conditional and unconditional jumps, returns, and indirect branches.",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS, which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x40"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to the microcode sequencer (MS).",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.CISC",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to decode stalls.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.DECODE",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to ITLB misses.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.ITLB",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB) misses.",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x10"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to other common frontend stalls not categorized.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.OTHER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x80"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to wrong predecodes.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "Counts the total number of consumed retirement slots.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xc2",
> -        "EventName": "TOPDOWN_RETIRING.ALL",
> -        "PEBS": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
> index 41e5dfad8f51..31816c6543a8 100644
> --- a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
> @@ -262,6 +262,247 @@
>           "PEBScounters": "0,1,2,3",
>           "SampleAfterValue": "20003"
>       },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear. Only issue slots wasted due to fast nukes such as memory ordering nukes are counted. Other nukes are not accounted for. Counts all issue slots blocked during this recovery window including relevant microcode flows and while uops are not yet available in the instruction queue (IQ). Also includes the issue slots that were consumed by the backend but were thrown away because they were younger than the mispredict or machine clear.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x6"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to fast nukes such as memory ordering and memory disambiguation machine clears.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a machine clear (nuke) of any kind including memory ordering and memory disambiguation.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to branch mispredicts.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event TOPDOWN_BAD_SPECULATION.FASTNUKE",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.MONUKE",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots every cycle that were not consumed by the backend due to backend stalls.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.ALL",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to certain allocation restrictions.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to memory reservation stalls in which a scheduler is not able to accept uops.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to IEC or FPC RAT stalls, which can be due to FIQ or IEC reservation stalls in which the integer, floating point or SIMD scheduler is not able to accept uops.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the physical register file unable to accept an entry (marble stalls).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the reorder buffer being full (ROB stalls).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to scoreboards from the instruction queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.STORE_BUFFER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to frontend stalls.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.ALL",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS, which occurs when the Branch Target Buffer (BTB) prediction or lack thereof, was corrected by a later branch predictor in the frontend. Includes BACLEARS due to all branch types including conditional and unconditional jumps, returns, and indirect branches.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS, which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to the microcode sequencer (MS).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.CISC",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to decode stalls.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.DECODE",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to ITLB misses.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.ITLB",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB) misses.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to other common frontend stalls not categorized.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.OTHER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to wrong predecodes.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of consumed retirement slots.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xc2",
> +        "EventName": "TOPDOWN_RETIRING.ALL",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003"
> +    },
>       {
>           "BriefDescription": "Counts the number of uops that are from complex flows issued by the micro-sequencer (MS).",
>           "CollectPEBSRecord": "2",

-- 
Zhengjun Xing
