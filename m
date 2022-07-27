Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16885581CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiG0BHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiG0BHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:07:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1578C1EADE;
        Tue, 26 Jul 2022 18:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658884054; x=1690420054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p2tfzdKNeiGSZUO8v71iymS+s0i4NaQD3wVFu6+LezU=;
  b=Q2u992qqfhWGUkC0tS6X9icL91Ef1dNyTvVN2sQTYHSDhpgK7fhTIeba
   wcodv2FxsOWMNpwNwWZhLXC7irnx7cSQqBJSAMJt6fHN8u/gtslQuaLqX
   QE0FPWL0WZohLvEg0re02HQ3WOPAwSpvaqtL8wwXfPLae8u10cTjtRvgT
   2+MOKIybxFoovCtVthaQOQ+L6dT1rgOdjyi48Gzvrt4iH2s9A0Dv5Ud8w
   r1Ceb5rXKn+41nJ1LktpaNEoczOoVmaXQ8yUoMSZgg9Uxq1wnHivf2ytQ
   3BlfvxHAUnCWpWG4UxIokjdEzSlD6CQM9/wM00A068yJEcXlhrtlM5ahH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="268499528"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="268499528"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:07:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="628163142"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.5.76]) ([10.238.5.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:07:27 -0700
Message-ID: <0b4162a3-78f0-0175-d88c-110c0663f7e6@linux.intel.com>
Date:   Wed, 27 Jul 2022 09:07:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 02/31] perf vendor events: Update Intel broadwellx
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        "Bopardikar, Kshipra" <kshipra.bopardikar@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Stephane Eranian <eranian@google.com>
References: <20220722223240.1618013-1-irogers@google.com>
 <20220722223240.1618013-3-irogers@google.com>
 <2c29ab7e-5fc5-5458-926c-11430e7c3c3b@linux.intel.com>
 <CAP-5=fV65fiadnaAmebYS1CjxwuFy4oKxV88v6oHdVPCc=n+Ow@mail.gmail.com>
 <752d163c-fc58-2dc4-6448-a1ccec2f3b80@linux.intel.com>
 <CAP-5=fVRq_a44fqMnL03kAKT5sDWdgbYk2cw8zxVit0H8UqatQ@mail.gmail.com>
 <0db83a8a-1a7f-56b4-4de1-12e98d7cbb2e@linux.intel.com>
 <YuAHSVz5SsIpCpOI@kernel.org>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <YuAHSVz5SsIpCpOI@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 7/26/2022 11:24 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 26, 2022 at 01:19:02PM +0800, Xing Zhengjun escreveu:
>> On 7/26/2022 12:49 PM, Ian Rogers wrote:
>>> On Mon, Jul 25, 2022 at 6:25 PM Xing Zhengjun
>>> <zhengjun.xing@linux.intel.com> wrote:
>>>> On 7/25/2022 9:06 PM, Ian Rogers wrote:
>>>>> On Sun, Jul 24, 2022, 6:34 PM Xing Zhengjun
>>>>> <zhengjun.xing@linux.intel.com <mailto:zhengjun.xing@linux.intel.com>>
>>>>> wrote:
>>>>>
>>>>>       Hi Ian,
>>>>>
>>>>>       On 7/23/2022 6:32 AM, Ian Rogers wrote:
>>>>>        > Use script at:
>>>>>        >
>>>>>       https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py
>>>>>       <https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py>
>>>>>        >
>>>>>
>>>>>       It is better to add the event JSON file version and TMA version for the
>>>>>       future track. For example, the event list is based on broadwellx JSON
>>>>>       file v19, the metrics are based on TMA4.4-full.
>>>>>
>>>>>
>>>>> Thanks Xing,
>>>>>
>>>>> I'll add that in v2. I'd skipped it this time as I'd been adding it to
>>>>> the mapfile. I'll also break apart the tremontx to snowridgex change to
>>>>> match yours. I also will rebase to see if that'll fix the git am issue.
>>>>> Apologies in advance to everyone's inboxes :-)
>>>>>
>>>> Hi Arnaldo,
>>>>
>>>> Except for Snowridgex, I also post SPR/ADL/HSX/BDX event list last
>>>> month, Can these be merged in or do I need to update them?  Thanks.
>>>>
>>>> https://lore.kernel.org/all/20220609094222.2030167-1-zhengjun.xing@linux.intel.com/
>>>> https://lore.kernel.org/all/20220609094222.2030167-2-zhengjun.xing@linux.intel.com/
>>>>
>>>> https://lore.kernel.org/all/20220607092749.1976878-1-zhengjun.xing@linux.intel.com/
>>>> https://lore.kernel.org/all/20220607092749.1976878-2-zhengjun.xing@linux.intel.com/
>>>> https://lore.kernel.org/all/20220614145019.2177071-1-zhengjun.xing@linux.intel.com/
>>>> https://lore.kernel.org/all/20220614145019.2177071-2-zhengjun.xing@linux.intel.com/
>>>
>>> Thanks Zhengjun,
>>>
>>> I think those patches are all stale over what is posted here.
>>
>> I think sometimes the middle version is also useful when we need back trace
>> issues.
> 
> Yeah, I'll see if I can do the legwork on applying your previous
> patches, then Ian's so that we have the more finer grained history,
> which indeed can be useful.
> 

Thank you very much!

> - Arnaldo
>   
>>> Particular issues are:
>>>    - fixing the files to only contain ascii characters
>>>    - updating the version information in mapfile.csv
>>>    - for BDX and SPR (HSX isn't posted yet, although I've done some
>>> private testing) adding in the metrics from:
>>> https://github.com/intel/perfmon-metrics/tree/main/BDX/metrics/perf
>>> https://github.com/intel/perfmon-metrics/tree/main/SPR/metrics/perf
>>>    - the event data on 01.org was updated. ADL, HSX and SPR were all
>>> updated last Friday prior to my v1 patches.
>>>    - I also tested all the patches on the respective architectures,
>>> hence discovering the fake event parsing fix that is in patch 1.
>>>
>>> As stated in the cover letter, the goal is to make it so that what is
>>> in the Linux tree exactly matches the download_and_gen.py output,
>>> however, there were same changes I made that are in this pull request:
>>> https://github.com/intel/event-converter-for-linux-perf/pull/15
>>>
>>> Given the size of the new metrics and particularly the previously
>>> missed uncore data, it'd be nice to land the "compression" in:
>>> https://lore.kernel.org/lkml/20220715063653.3203761-1-irogers@google.com/
>>> which prior to this change was reducing the binary size for x86 by
>>> 12.5% as well as reducing over a megabytes worth of dirty pages for
>>> relocated data.
>>>
>>> Thanks,
>>> Ian
>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
>>>>>
>>>>>        > to download and generate the latest events and metrics. Manually copy
>>>>>        > the broadwellx files into perf and update mapfile.csv.
>>>>>        >
>>>>>        > Tested with 'perf test':
>>>>>        >   10: PMU events
>>>>>            :
>>>>>        >   10.1: PMU event table sanity
>>>>>            : Ok
>>>>>        >   10.2: PMU event map aliases
>>>>>             : Ok
>>>>>        >   10.3: Parsing of PMU event table metrics
>>>>>            : Ok
>>>>>        >   10.4: Parsing of PMU event table metrics with fake PMUs
>>>>>             : Ok
>>>>>        >   90: perf all metricgroups test
>>>>>            : Ok
>>>>>        >   91: perf all metrics test
>>>>>             : Skip
>>>>>        >   93: perf all PMU test
>>>>>             : Ok
>>>>>        >
>>>>>        > Signed-off-by: Ian Rogers <irogers@google.com
>>>>>       <mailto:irogers@google.com>>
>>>>>        > ---
>>>>>        >   .../arch/x86/broadwellx/bdx-metrics.json      |  570 ++-
>>>>>        >   .../pmu-events/arch/x86/broadwellx/cache.json |   22 +-
>>>>>        >   .../arch/x86/broadwellx/floating-point.json   |    9 +-
>>>>>        >   .../arch/x86/broadwellx/frontend.json         |    2 +-
>>>>>        >   .../arch/x86/broadwellx/memory.json           |   39 +-
>>>>>        >   .../pmu-events/arch/x86/broadwellx/other.json |    2 +-
>>>>>        >   .../arch/x86/broadwellx/pipeline.json         |    4 +-
>>>>>        >   .../arch/x86/broadwellx/uncore-cache.json     | 3788
>>>>>       ++++++++++++++++-
>>>>>        >   .../x86/broadwellx/uncore-interconnect.json   | 1438 ++++++-
>>>>>        >   .../arch/x86/broadwellx/uncore-memory.json    | 2849 ++++++++++++-
>>>>>        >   .../arch/x86/broadwellx/uncore-other.json     | 3252 ++++++++++++++
>>>>>        >   .../arch/x86/broadwellx/uncore-power.json     |  437 +-
>>>>>        >   .../arch/x86/broadwellx/virtual-memory.json   |    2 +-
>>>>>        >   tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
>>>>>        >   14 files changed, 12103 insertions(+), 313 deletions(-)
>>>>>        >   create mode 100644
>>>>>       tools/perf/pmu-events/arch/x86/broadwellx/uncore-other.json
>>>>>        >
>>>>>        > diff --git
>>>>>       a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
>>>>>       b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
>>>>>        > index b055947c0afe..720ee7c9332d 100644
>>>>>        > --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
>>>>>        > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
>>>>>        > @@ -74,12 +74,6 @@
>>>>>        >           "MetricGroup": "Branches;Fed;FetchBW",
>>>>>        >           "MetricName": "UpTB"
>>>>>        >       },
>>>>>        > -    {
>>>>>        > -        "BriefDescription": "Cycles Per Instruction (per Logical
>>>>>       Processor)",
>>>>>        > -        "MetricExpr": "1 / (INST_RETIRED.ANY /
>>>>>       CPU_CLK_UNHALTED.THREAD)",
>>>>>        > -        "MetricGroup": "Pipeline;Mem",
>>>>>        > -        "MetricName": "CPI"
>>>>>        > -    },
>>>>>        >       {
>>>>>        >           "BriefDescription": "Per-Logical Processor actual
>>>>>       clocks when the Logical Processor is active.",
>>>>>        >           "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
>>>>>        > @@ -130,43 +124,25 @@
>>>>>        >           "MetricName": "FLOPc_SMT"
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "Actual per-core usage of the
>>>>>       Floating Point execution units (regardless of the vector width)",
>>>>>        > +        "BriefDescription": "Actual per-core usage of the
>>>>>       Floating Point non-X87 execution units (regardless of precision or
>>>>>       vector-width)",
>>>>>        >           "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE +
>>>>>       FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) +
>>>>>       (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE +
>>>>>       FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE +
>>>>>       FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE +
>>>>>       FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) ) / ( 2 *
>>>>>       CPU_CLK_UNHALTED.THREAD )",
>>>>>        >           "MetricGroup": "Cor;Flops;HPC",
>>>>>        >           "MetricName": "FP_Arith_Utilization",
>>>>>        > -        "PublicDescription": "Actual per-core usage of the
>>>>>       Floating Point execution units (regardless of the vector width).
>>>>>       Values > 1 are possible due to Fused-Multiply Add (FMA) counting."
>>>>>        > +        "PublicDescription": "Actual per-core usage of the
>>>>>       Floating Point non-X87 execution units (regardless of precision or
>>>>>       vector-width). Values > 1 are possible due to ([BDW+] Fused-Multiply
>>>>>       Add (FMA) counting - common; [ADL+] use all of ADD/MUL/FMA in Scalar
>>>>>       or 128/256-bit vectors - less common)."
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "Actual per-core usage of the
>>>>>       Floating Point execution units (regardless of the vector width). SMT
>>>>>       version; use when SMT is enabled and measuring per logical CPU.",
>>>>>        > +        "BriefDescription": "Actual per-core usage of the
>>>>>       Floating Point non-X87 execution units (regardless of precision or
>>>>>       vector-width). SMT version; use when SMT is enabled and measuring
>>>>>       per logical CPU.",
>>>>>        >           "MetricExpr": "( (FP_ARITH_INST_RETIRED.SCALAR_SINGLE +
>>>>>       FP_ARITH_INST_RETIRED.SCALAR_DOUBLE) +
>>>>>       (FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE +
>>>>>       FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE +
>>>>>       FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE +
>>>>>       FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE) ) / ( 2 * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
>>>>>       CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ) )",
>>>>>        >           "MetricGroup": "Cor;Flops;HPC_SMT",
>>>>>        >           "MetricName": "FP_Arith_Utilization_SMT",
>>>>>        > -        "PublicDescription": "Actual per-core usage of the
>>>>>       Floating Point execution units (regardless of the vector width).
>>>>>       Values > 1 are possible due to Fused-Multiply Add (FMA) counting.
>>>>>       SMT version; use when SMT is enabled and measuring per logical CPU."
>>>>>        > +        "PublicDescription": "Actual per-core usage of the
>>>>>       Floating Point non-X87 execution units (regardless of precision or
>>>>>       vector-width). Values > 1 are possible due to ([BDW+] Fused-Multiply
>>>>>       Add (FMA) counting - common; [ADL+] use all of ADD/MUL/FMA in Scalar
>>>>>       or 128/256-bit vectors - less common). SMT version; use when SMT is
>>>>>       enabled and measuring per logical CPU."
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "Instruction-Level-Parallelism
>>>>>       (average number of uops executed when there is at least 1 uop
>>>>>       executed)",
>>>>>        > +        "BriefDescription": "Instruction-Level-Parallelism
>>>>>       (average number of uops executed when there is execution) per-core",
>>>>>        >           "MetricExpr": "UOPS_EXECUTED.THREAD / ((
>>>>>       cpu@UOPS_EXECUTED.CORE\\,cmask\\=1@ / 2 ) if #SMT_on else
>>>>>       UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC)",
>>>>>        >           "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
>>>>>        >           "MetricName": "ILP"
>>>>>        >       },
>>>>>        > -    {
>>>>>        > -        "BriefDescription": "Branch Misprediction Cost: Fraction
>>>>>       of TMA slots wasted per non-speculative branch misprediction
>>>>>       (retired JEClear)",
>>>>>        > -        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / (
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * ((
>>>>>       UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 *
>>>>>       INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) + (4 *
>>>>>       IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 *
>>>>>       CPU_CLK_UNHALTED.THREAD)) * (BR_MISP_RETIRED.ALL_BRANCHES * (12 * (
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY )
>>>>>       / CPU_CLK_UNHALTED.THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES +
>>>>>       MACHINE_CLEARS.COUNT + BACLEARS.ANY )) / #(4 *
>>>>>       IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 *
>>>>>       CPU_CLK_UNHALTED.THREAD)) ) * (4 * CPU_CLK_UNHALTED.THREAD) /
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES",
>>>>>        > -        "MetricGroup": "Bad;BrMispredicts",
>>>>>        > -        "MetricName": "Branch_Misprediction_Cost"
>>>>>        > -    },
>>>>>        > -    {
>>>>>        > -        "BriefDescription": "Branch Misprediction Cost: Fraction
>>>>>       of TMA slots wasted per non-speculative branch misprediction
>>>>>       (retired JEClear)",
>>>>>        > -        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / (
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * ((
>>>>>       UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
>>>>>       CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK )
>>>>>       )))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (
>>>>>       ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
>>>>>       CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))
>>>>>       * (BR_MISP_RETIRED.ALL_BRANCHES * (12 * (
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY )
>>>>>       / CPU_CLK_UNHALTED.THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES +
>>>>>       MACHINE_CLEARS.COUNT + BACLEARS.ANY )) / #(4 *
>>>>>       IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
>>>>>       CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))
>>>>>       ) * (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
>>>>>       CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))
>>>>>       / BR_MISP_RETIRED.ALL_BRANCHES",
>>>>>        > -        "MetricGroup": "Bad;BrMispredicts_SMT",
>>>>>        > -        "MetricName": "Branch_Misprediction_Cost_SMT"
>>>>>        > -    },
>>>>>        > -    {
>>>>>        > -        "BriefDescription": "Number of Instructions per
>>>>>       non-speculative Branch Misprediction (JEClear)",
>>>>>        > -        "MetricExpr": "INST_RETIRED.ANY /
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES",
>>>>>        > -        "MetricGroup": "Bad;BadSpec;BrMispredicts",
>>>>>        > -        "MetricName": "IpMispredict"
>>>>>        > -    },
>>>>>        >       {
>>>>>        >           "BriefDescription": "Core actual clocks when any
>>>>>       Logical Processor is active on the Physical Core",
>>>>>        >           "MetricExpr": "( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1
>>>>>       + CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )",
>>>>>        > @@ -256,6 +232,18 @@
>>>>>        >           "MetricGroup": "Summary;TmaL1",
>>>>>        >           "MetricName": "Instructions"
>>>>>        >       },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average number of Uops retired in
>>>>>       cycles where at least one uop has retired.",
>>>>>        > +        "MetricExpr": "UOPS_RETIRED.RETIRE_SLOTS /
>>>>>       cpu@UOPS_RETIRED.RETIRE_SLOTS\\,cmask\\=1@",
>>>>>        > +        "MetricGroup": "Pipeline;Ret",
>>>>>        > +        "MetricName": "Retire"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "",
>>>>>        > +        "MetricExpr": "UOPS_EXECUTED.THREAD /
>>>>>       cpu@UOPS_EXECUTED.THREAD\\,cmask\\=1@",
>>>>>        > +        "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
>>>>>        > +        "MetricName": "Execute"
>>>>>        > +    },
>>>>>        >       {
>>>>>        >           "BriefDescription": "Fraction of Uops delivered by the
>>>>>       DSB (aka Decoded ICache; or Uop Cache)",
>>>>>        >           "MetricExpr": "IDQ.DSB_UOPS / (( IDQ.DSB_UOPS +
>>>>>       LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS ) )",
>>>>>        > @@ -263,35 +251,34 @@
>>>>>        >           "MetricName": "DSB_Coverage"
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "Actual Average Latency for L1
>>>>>       data-cache miss demand load instructions (in core cycles)",
>>>>>        > -        "MetricExpr": "L1D_PEND_MISS.PENDING / (
>>>>>       MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
>>>>>        > -        "MetricGroup": "Mem;MemoryBound;MemoryLat",
>>>>>        > -        "MetricName": "Load_Miss_Real_Latency",
>>>>>        > -        "PublicDescription": "Actual Average Latency for L1
>>>>>       data-cache miss demand load instructions (in core cycles). Latency
>>>>>       may be overestimated for multi-load instructions - e.g. repeat strings."
>>>>>        > +        "BriefDescription": "Number of Instructions per
>>>>>       non-speculative Branch Misprediction (JEClear) (lower number means
>>>>>       higher occurrence rate)",
>>>>>        > +        "MetricExpr": "INST_RETIRED.ANY /
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES",
>>>>>        > +        "MetricGroup": "Bad;BadSpec;BrMispredicts",
>>>>>        > +        "MetricName": "IpMispredict"
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "Memory-Level-Parallelism (average
>>>>>       number of L1 miss demand load when there is at least one such miss.
>>>>>       Per-Logical Processor)",
>>>>>        > -        "MetricExpr": "L1D_PEND_MISS.PENDING /
>>>>>       L1D_PEND_MISS.PENDING_CYCLES",
>>>>>        > -        "MetricGroup": "Mem;MemoryBound;MemoryBW",
>>>>>        > -        "MetricName": "MLP"
>>>>>        > +        "BriefDescription": "Branch Misprediction Cost: Fraction
>>>>>       of TMA slots wasted per non-speculative branch misprediction
>>>>>       (retired JEClear)",
>>>>>        > +        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / (
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * ((
>>>>>       UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 *
>>>>>       INT_MISC.RECOVERY_CYCLES ) / (4 * CPU_CLK_UNHALTED.THREAD))) + (4 *
>>>>>       IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 *
>>>>>       CPU_CLK_UNHALTED.THREAD)) * (BR_MISP_RETIRED.ALL_BRANCHES * (12 * (
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY )
>>>>>       / CPU_CLK_UNHALTED.THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES +
>>>>>       MACHINE_CLEARS.COUNT + BACLEARS.ANY )) / #(4 *
>>>>>       IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 *
>>>>>       CPU_CLK_UNHALTED.THREAD)) ) * (4 * CPU_CLK_UNHALTED.THREAD) /
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES",
>>>>>        > +        "MetricGroup": "Bad;BrMispredicts",
>>>>>        > +        "MetricName": "Branch_Misprediction_Cost"
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "Average data fill bandwidth to the
>>>>>       L1 data cache [GB / sec]",
>>>>>        > -        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 /
>>>>>       duration_time",
>>>>>        > -        "MetricGroup": "Mem;MemoryBW",
>>>>>        > -        "MetricName": "L1D_Cache_Fill_BW"
>>>>>        > +        "BriefDescription": "Branch Misprediction Cost: Fraction
>>>>>       of TMA slots wasted per non-speculative branch misprediction
>>>>>       (retired JEClear)",
>>>>>        > +        "MetricExpr": " ( ((BR_MISP_RETIRED.ALL_BRANCHES / (
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT )) * ((
>>>>>       UOPS_ISSUED.ANY - UOPS_RETIRED.RETIRE_SLOTS + 4 * (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) ) / (4 * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
>>>>>       CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK )
>>>>>       )))) + (4 * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * (
>>>>>       ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
>>>>>       CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))
>>>>>       * (BR_MISP_RETIRED.ALL_BRANCHES * (12 * (
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY )
>>>>>       / CPU_CLK_UNHALTED.THREAD) / ( BR_MISP_RETIRED.ALL_BRANCHES +
>>>>>       MACHINE_CLEARS.COUNT + BACLEARS.ANY )) / #(4 *
>>>>>       IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / (4 * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
>>>>>       CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) )))
>>>>>       ) * (4 * ( ( CPU_CLK_UNHALTED.THREAD / 2 ) * ( 1 +
>>>>>       CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_XCLK ) ))
>>>>>       / BR_MISP_RETIRED.ALL_BRANCHES",
>>>>>        > +        "MetricGroup": "Bad;BrMispredicts_SMT",
>>>>>        > +        "MetricName": "Branch_Misprediction_Cost_SMT"
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "Average data fill bandwidth to the
>>>>>       L2 cache [GB / sec]",
>>>>>        > -        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 /
>>>>>       duration_time",
>>>>>        > -        "MetricGroup": "Mem;MemoryBW",
>>>>>        > -        "MetricName": "L2_Cache_Fill_BW"
>>>>>        > +        "BriefDescription": "Actual Average Latency for L1
>>>>>       data-cache miss demand load operations (in core cycles)",
>>>>>        > +        "MetricExpr": "L1D_PEND_MISS.PENDING / (
>>>>>       MEM_LOAD_UOPS_RETIRED.L1_MISS + mem_load_uops_retired.hit_lfb )",
>>>>>        > +        "MetricGroup": "Mem;MemoryBound;MemoryLat",
>>>>>        > +        "MetricName": "Load_Miss_Real_Latency"
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "Average per-core data fill
>>>>>       bandwidth to the L3 cache [GB / sec]",
>>>>>        > -        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000
>>>>>       / duration_time",
>>>>>        > -        "MetricGroup": "Mem;MemoryBW",
>>>>>        > -        "MetricName": "L3_Cache_Fill_BW"
>>>>>        > +        "BriefDescription": "Memory-Level-Parallelism (average
>>>>>       number of L1 miss demand load when there is at least one such miss.
>>>>>       Per-Logical Processor)",
>>>>>        > +        "MetricExpr": "L1D_PEND_MISS.PENDING /
>>>>>       L1D_PEND_MISS.PENDING_CYCLES",
>>>>>        > +        "MetricGroup": "Mem;MemoryBound;MemoryBW",
>>>>>        > +        "MetricName": "MLP"
>>>>>        >       },
>>>>>        >       {
>>>>>        >           "BriefDescription": "L1 cache true misses per kilo
>>>>>       instruction for retired demand loads",
>>>>>        > @@ -306,13 +293,13 @@
>>>>>        >           "MetricName": "L2MPKI"
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "L2 cache misses per kilo
>>>>>       instruction for all request types (including speculative)",
>>>>>        > +        "BriefDescription": "L2 cache ([RKL+] true) misses per
>>>>>       kilo instruction for all request types (including speculative)",
>>>>>        >           "MetricExpr": "1000 * L2_RQSTS.MISS / INST_RETIRED.ANY",
>>>>>        >           "MetricGroup": "Mem;CacheMisses;Offcore",
>>>>>        >           "MetricName": "L2MPKI_All"
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "L2 cache misses per kilo
>>>>>       instruction for all demand loads  (including speculative)",
>>>>>        > +        "BriefDescription": "L2 cache ([RKL+] true) misses per
>>>>>       kilo instruction for all demand loads  (including speculative)",
>>>>>        >           "MetricExpr": "1000 * L2_RQSTS.DEMAND_DATA_RD_MISS /
>>>>>       INST_RETIRED.ANY",
>>>>>        >           "MetricGroup": "Mem;CacheMisses",
>>>>>        >           "MetricName": "L2MPKI_Load"
>>>>>        > @@ -348,6 +335,48 @@
>>>>>        >           "MetricGroup": "Mem;MemoryTLB_SMT",
>>>>>        >           "MetricName": "Page_Walks_Utilization_SMT"
>>>>>        >       },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average per-core data fill
>>>>>       bandwidth to the L1 data cache [GB / sec]",
>>>>>        > +        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 /
>>>>>       duration_time",
>>>>>        > +        "MetricGroup": "Mem;MemoryBW",
>>>>>        > +        "MetricName": "L1D_Cache_Fill_BW"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average per-core data fill
>>>>>       bandwidth to the L2 cache [GB / sec]",
>>>>>        > +        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 /
>>>>>       duration_time",
>>>>>        > +        "MetricGroup": "Mem;MemoryBW",
>>>>>        > +        "MetricName": "L2_Cache_Fill_BW"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average per-core data fill
>>>>>       bandwidth to the L3 cache [GB / sec]",
>>>>>        > +        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000
>>>>>       / duration_time",
>>>>>        > +        "MetricGroup": "Mem;MemoryBW",
>>>>>        > +        "MetricName": "L3_Cache_Fill_BW"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average per-thread data fill
>>>>>       bandwidth to the L1 data cache [GB / sec]",
>>>>>        > +        "MetricExpr": "(64 * L1D.REPLACEMENT / 1000000000 /
>>>>>       duration_time)",
>>>>>        > +        "MetricGroup": "Mem;MemoryBW",
>>>>>        > +        "MetricName": "L1D_Cache_Fill_BW_1T"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average per-thread data fill
>>>>>       bandwidth to the L2 cache [GB / sec]",
>>>>>        > +        "MetricExpr": "(64 * L2_LINES_IN.ALL / 1000000000 /
>>>>>       duration_time)",
>>>>>        > +        "MetricGroup": "Mem;MemoryBW",
>>>>>        > +        "MetricName": "L2_Cache_Fill_BW_1T"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average per-thread data fill
>>>>>       bandwidth to the L3 cache [GB / sec]",
>>>>>        > +        "MetricExpr": "(64 * LONGEST_LAT_CACHE.MISS / 1000000000
>>>>>       / duration_time)",
>>>>>        > +        "MetricGroup": "Mem;MemoryBW",
>>>>>        > +        "MetricName": "L3_Cache_Fill_BW_1T"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average per-thread data access
>>>>>       bandwidth to the L3 cache [GB / sec]",
>>>>>        > +        "MetricExpr": "0",
>>>>>        > +        "MetricGroup": "Mem;MemoryBW;Offcore",
>>>>>        > +        "MetricName": "L3_Cache_Access_BW_1T"
>>>>>        > +    },
>>>>>        >       {
>>>>>        >           "BriefDescription": "Average CPU Utilization",
>>>>>        >           "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
>>>>>        > @@ -364,7 +393,8 @@
>>>>>        >           "BriefDescription": "Giga Floating Point Operations Per
>>>>>       Second",
>>>>>        >           "MetricExpr": "( ( 1 * (
>>>>>       FP_ARITH_INST_RETIRED.SCALAR_SINGLE +
>>>>>       FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 *
>>>>>       FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * (
>>>>>       FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE +
>>>>>       FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 *
>>>>>       FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE ) / 1000000000 ) /
>>>>>       duration_time",
>>>>>        >           "MetricGroup": "Cor;Flops;HPC",
>>>>>        > -        "MetricName": "GFLOPs"
>>>>>        > +        "MetricName": "GFLOPs",
>>>>>        > +        "PublicDescription": "Giga Floating Point Operations Per
>>>>>       Second. Aggregate across all supported options of: FP precisions,
>>>>>       scalar and vector instructions, vector-width and AMX engine."
>>>>>        >       },
>>>>>        >       {
>>>>>        >           "BriefDescription": "Average Frequency Utilization
>>>>>       relative nominal frequency",
>>>>>        > @@ -461,5 +491,439 @@
>>>>>        >           "MetricExpr": "(cstate_pkg@c7\\-residency@ / msr@tsc@)
>>>>>       * 100",
>>>>>        >           "MetricGroup": "Power",
>>>>>        >           "MetricName": "C7_Pkg_Residency"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "CPU operating frequency (in GHz)",
>>>>>        > +        "MetricExpr": "( CPU_CLK_UNHALTED.THREAD /
>>>>>       CPU_CLK_UNHALTED.REF_TSC * #SYSTEM_TSC_FREQ ) / 1000000000",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "cpu_operating_frequency",
>>>>>        > +        "ScaleUnit": "1GHz"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Cycles per instruction retired;
>>>>>       indicating how much time each executed instruction took; in units of
>>>>>       cycles.",
>>>>>        > +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "cpi",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "The ratio of number of completed
>>>>>       memory load instructions to the total number completed instructions",
>>>>>        > +        "MetricExpr": "MEM_UOPS_RETIRED.ALL_LOADS /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "loads_per_instr",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "The ratio of number of completed
>>>>>       memory store instructions to the total number completed instructions",
>>>>>        > +        "MetricExpr": "MEM_UOPS_RETIRED.ALL_STORES /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "stores_per_instr",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of requests missing
>>>>>       L1 data cache (includes data+rfo w/ prefetches) to the total number
>>>>>       of completed instructions",
>>>>>        > +        "MetricExpr": "L1D.REPLACEMENT / INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "l1d_mpi_includes_data_plus_rfo_with_prefetches",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of demand load
>>>>>       requests hitting in L1 data cache to the total number of completed
>>>>>       instructions",
>>>>>        > +        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L1_HIT /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "l1d_demand_data_read_hits_per_instr",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of code read
>>>>>       requests missing in L1 instruction cache (includes prefetches) to
>>>>>       the total number of completed instructions",
>>>>>        > +        "MetricExpr": "L2_RQSTS.ALL_CODE_RD / INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "l1_i_code_read_misses_with_prefetches_per_instr",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of completed demand
>>>>>       load requests hitting in L2 cache to the total number of completed
>>>>>       instructions",
>>>>>        > +        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_HIT /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "l2_demand_data_read_hits_per_instr",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of requests missing
>>>>>       L2 cache (includes code+data+rfo w/ prefetches) to the total number
>>>>>       of completed instructions",
>>>>>        > +        "MetricExpr": "L2_LINES_IN.ALL / INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "l2_mpi_includes_code_plus_data_plus_rfo_with_prefetches",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of completed data
>>>>>       read request missing L2 cache to the total number of completed
>>>>>       instructions",
>>>>>        > +        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_MISS /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "l2_demand_data_read_mpi",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of code read
>>>>>       request missing L2 cache to the total number of completed instructions",
>>>>>        > +        "MetricExpr": "L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "l2_demand_code_mpi",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of data read
>>>>>       requests missing last level core cache (includes demand w/
>>>>>       prefetches) to the total number of completed instructions",
>>>>>        > +        "MetricExpr": "(
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ +
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x192@ ) /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of code read
>>>>>       requests missing last level core cache (includes demand w/
>>>>>       prefetches) to the total number of completed instructions",
>>>>>        > +        "MetricExpr": "(
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x181@ +
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x191@ ) /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average latency of a last level
>>>>>       cache (LLC) demand and prefetch data read miss (read memory access)
>>>>>       in nano seconds",
>>>>>        > +        "MetricExpr": "( 1000000000 * (
>>>>>       cbox@UNC_C_TOR_OCCUPANCY.MISS_OPCODE\\,filter_opc\\=0x182@ /
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ ) / (
>>>>>       UNC_C_CLOCKTICKS / ( source_count(UNC_C_CLOCKTICKS) * #num_packages
>>>>>       ) ) ) * duration_time",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "llc_data_read_demand_plus_prefetch_miss_latency",
>>>>>        > +        "ScaleUnit": "1ns"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average latency of a last level
>>>>>       cache (LLC) demand and prefetch data read miss (read memory access)
>>>>>       addressed to local memory in nano seconds",
>>>>>        > +        "MetricExpr": "( 1000000000 * (
>>>>>       cbox@UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE\\,filter_opc\\=0x182@ /
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ ) / (
>>>>>       UNC_C_CLOCKTICKS / ( source_count(UNC_C_CLOCKTICKS) * #num_packages
>>>>>       ) ) ) * duration_time",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "llc_data_read_demand_plus_prefetch_miss_latency_for_local_requests",
>>>>>        > +        "ScaleUnit": "1ns"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Average latency of a last level
>>>>>       cache (LLC) demand and prefetch data read miss (read memory access)
>>>>>       addressed to remote memory in nano seconds",
>>>>>        > +        "MetricExpr": "( 1000000000 * (
>>>>>       cbox@UNC_C_TOR_OCCUPANCY.MISS_REMOTE_OPCODE\\,filter_opc\\=0x182@ /
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ ) / (
>>>>>       UNC_C_CLOCKTICKS / ( source_count(UNC_C_CLOCKTICKS) * #num_packages
>>>>>       ) ) ) * duration_time",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "llc_data_read_demand_plus_prefetch_miss_latency_for_remote_requests",
>>>>>        > +        "ScaleUnit": "1ns"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of completed page
>>>>>       walks (for all page sizes) caused by a code fetch to the total
>>>>>       number of completed instructions. This implies it missed in the ITLB
>>>>>       (Instruction TLB) and further levels of TLB.",
>>>>>        > +        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "itlb_mpi",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of completed page
>>>>>       walks (for 2 megabyte and 4 megabyte page sizes) caused by a code
>>>>>       fetch to the total number of completed instructions. This implies it
>>>>>       missed in the Instruction Translation Lookaside Buffer (ITLB) and
>>>>>       further levels of TLB.",
>>>>>        > +        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "itlb_large_page_mpi",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of completed page
>>>>>       walks (for all page sizes) caused by demand data loads to the total
>>>>>       number of completed instructions. This implies it missed in the DTLB
>>>>>       and further levels of TLB.",
>>>>>        > +        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "dtlb_load_mpi",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Ratio of number of completed page
>>>>>       walks (for all page sizes) caused by demand data stores to the total
>>>>>       number of completed instructions. This implies it missed in the DTLB
>>>>>       and further levels of TLB.",
>>>>>        > +        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED /
>>>>>       INST_RETIRED.ANY",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "dtlb_store_mpi",
>>>>>        > +        "ScaleUnit": "1per_instr"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Memory read that miss the last
>>>>>       level cache (LLC) addressed to local DRAM as a percentage of total
>>>>>       memory read accesses, does not include LLC prefetches.",
>>>>>        > +        "MetricExpr": "100 *
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ / (
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ +
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ )",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "numa_percent_reads_addressed_to_local_dram",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Memory reads that miss the last
>>>>>       level cache (LLC) addressed to remote DRAM as a percentage of total
>>>>>       memory read accesses, does not include LLC prefetches.",
>>>>>        > +        "MetricExpr": "100 *
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ / (
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ +
>>>>>       cbox@UNC_C_TOR_INSERTS.MISS_OPCODE\\,filter_opc\\=0x182@ )",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "numa_percent_reads_addressed_to_remote_dram",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Uncore operating frequency in GHz",
>>>>>        > +        "MetricExpr": "UNC_C_CLOCKTICKS / (
>>>>>       source_count(UNC_C_CLOCKTICKS) * #num_packages ) / 1000000000",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "uncore_frequency",
>>>>>        > +        "ScaleUnit": "1GHz"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Intel(R) Quick Path Interconnect
>>>>>       (QPI) data transmit bandwidth (MB/sec)",
>>>>>        > +        "MetricExpr": "( UNC_Q_TxL_FLITS_G0.DATA * 8 / 1000000)
>>>>>       / duration_time",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "qpi_data_transmit_bw_only_data",
>>>>>        > +        "ScaleUnit": "1MB/s"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
>>>>>        > +        "MetricExpr": "( UNC_M_CAS_COUNT.RD * 64 / 1000000) /
>>>>>       duration_time",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "memory_bandwidth_read",
>>>>>        > +        "ScaleUnit": "1MB/s"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
>>>>>        > +        "MetricExpr": "( UNC_M_CAS_COUNT.WR * 64 / 1000000) /
>>>>>       duration_time",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "memory_bandwidth_write",
>>>>>        > +        "ScaleUnit": "1MB/s"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "DDR memory bandwidth (MB/sec)",
>>>>>        > +        "MetricExpr": "(( UNC_M_CAS_COUNT.RD +
>>>>>       UNC_M_CAS_COUNT.WR ) * 64 / 1000000) / duration_time",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "memory_bandwidth_total",
>>>>>        > +        "ScaleUnit": "1MB/s"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Bandwidth of IO reads that are
>>>>>       initiated by end device controllers that are requesting memory from
>>>>>       the CPU.",
>>>>>        > +        "MetricExpr": "(
>>>>>       cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=0x19e@ * 64 / 1000000)
>>>>>       / duration_time",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "io_bandwidth_read",
>>>>>        > +        "ScaleUnit": "1MB/s"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Bandwidth of IO writes that are
>>>>>       initiated by end device controllers that are writing memory to the
>>>>>       CPU.",
>>>>>        > +        "MetricExpr": "((
>>>>>       cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=0x1c8\\,filter_tid\\=0x3e@
>>>>>       +
>>>>>       cbox@UNC_C_TOR_INSERTS.OPCODE\\,filter_opc\\=0x180\\,filter_tid\\=0x3e@
>>>>>       ) * 64 / 1000000) / duration_time",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName": "io_bandwidth_write",
>>>>>        > +        "ScaleUnit": "1MB/s"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Uops delivered from decoded
>>>>>       instruction cache (decoded stream buffer or DSB) as a percent of
>>>>>       total uops delivered to Instruction Decode Queue",
>>>>>        > +        "MetricExpr": "100 * ( IDQ.DSB_UOPS / UOPS_ISSUED.ANY )",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "percent_uops_delivered_from_decoded_icache_dsb",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Uops delivered from legacy decode
>>>>>       pipeline (Micro-instruction Translation Engine or MITE) as a percent
>>>>>       of total uops delivered to Instruction Decode Queue",
>>>>>        > +        "MetricExpr": "100 * ( IDQ.MITE_UOPS / UOPS_ISSUED.ANY )",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "percent_uops_delivered_from_legacy_decode_pipeline_mite",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Uops delivered from microcode
>>>>>       sequencer (MS) as a percent of total uops delivered to Instruction
>>>>>       Decode Queue",
>>>>>        > +        "MetricExpr": "100 * ( IDQ.MS_UOPS / UOPS_ISSUED.ANY )",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "percent_uops_delivered_from_microcode_sequencer_ms",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "Uops delivered from loop stream
>>>>>       detector(LSD) as a percent of total uops delivered to Instruction
>>>>>       Decode Queue",
>>>>>        > +        "MetricExpr": "100 * ( LSD.UOPS / UOPS_ISSUED.ANY )",
>>>>>        > +        "MetricGroup": "",
>>>>>        > +        "MetricName":
>>>>>       "percent_uops_delivered_from_loop_stream_detector_lsd",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This category represents fraction
>>>>>       of slots where the processor's Frontend undersupplies its Backend.
>>>>>       Frontend denotes the first part of the processor core responsible to
>>>>>       fetch operations that are executed later on by the Backend part.
>>>>>       Within the Frontend; a branch predictor predicts the next address to
>>>>>       fetch; cache-lines are fetched from the memory subsystem; parsed
>>>>>       into instructions; and lastly decoded into micro-operations (uops).
>>>>>       Ideally the Frontend can issue Machine_Width uops every cycle to the
>>>>>       Backend. Frontend Bound denotes unutilized issue-slots when there is
>>>>>       no Backend stall; i.e. bubbles where Frontend delivered no uops
>>>>>       while Backend could have accepted them. For example; stalls due to
>>>>>       instruction-cache misses would be categorized under Frontend Bound.",
>>>>>        > +        "MetricExpr": "100 * ( IDQ_UOPS_NOT_DELIVERED.CORE / ( (
>>>>>       4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) )",
>>>>>        > +        "MetricGroup": "TmaL1;PGO",
>>>>>        > +        "MetricName": "tma_frontend_bound_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       slots the CPU was stalled due to Frontend latency issues.  For
>>>>>       example; instruction-cache misses; iTLB misses or fetch stalls after
>>>>>       a branch misprediction are categorized under Frontend Latency. In
>>>>>       such cases; the Frontend eventually delivers no uops for some period.",
>>>>>        > +        "MetricExpr": "100 * ( ( 4 ) *
>>>>>       IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "Frontend;TmaL2;m_tma_frontend_bound_percent",
>>>>>        > +        "MetricName": "tma_fetch_latency_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       cycles the CPU was stalled due to instruction cache misses.",
>>>>>        > +        "MetricExpr": "100 * ( ICACHE.IFDATA_STALL / (
>>>>>       CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "BigFoot;FetchLat;IcMiss;TmaL3;m_tma_fetch_latency_percent",
>>>>>        > +        "MetricName": "tma_icache_misses_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       cycles the CPU was stalled due to Instruction TLB (ITLB) misses.",
>>>>>        > +        "MetricExpr": "100 * ( ( 14 * ITLB_MISSES.STLB_HIT +
>>>>>       cpu@ITLB_MISSES.WALK_DURATION\\,cmask\\=0x1@ + 7 *
>>>>>       ITLB_MISSES.WALK_COMPLETED ) / ( CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "BigFoot;FetchLat;MemoryTLB;TmaL3;m_tma_fetch_latency_percent",
>>>>>        > +        "MetricName": "tma_itlb_misses_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       cycles the CPU was stalled due to Branch Resteers. Branch Resteers
>>>>>       estimates the Frontend delay in fetching operations from corrected
>>>>>       path; following all sorts of miss-predicted branches. For example;
>>>>>       branchy code with lots of miss-predictions might get categorized
>>>>>       under Branch Resteers. Note the value of this node may overlap with
>>>>>       its siblings.",
>>>>>        > +        "MetricExpr": "100 * ( ( 12 ) * (
>>>>>       BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT + BACLEARS.ANY )
>>>>>       / ( CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup": "FetchLat;TmaL3;m_tma_fetch_latency_percent",
>>>>>        > +        "MetricName": "tma_branch_resteers_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       cycles the CPU was stalled due to switches from DSB to MITE
>>>>>       pipelines. The DSB (decoded i-cache) is a Uop Cache where the
>>>>>       front-end directly delivers Uops (micro operations) avoiding heavy
>>>>>       x86 decoding. The DSB pipeline has shorter latency and delivered
>>>>>       higher bandwidth than the MITE (legacy instruction decode pipeline).
>>>>>       Switching between the two pipelines can cause penalties hence this
>>>>>       metric measures the exposed penalty.",
>>>>>        > +        "MetricExpr": "100 * ( DSB2MITE_SWITCHES.PENALTY_CYCLES
>>>>>       / ( CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "DSBmiss;FetchLat;TmaL3;m_tma_fetch_latency_percent",
>>>>>        > +        "MetricName": "tma_dsb_switches_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       cycles CPU was stalled due to Length Changing Prefixes (LCPs). Using
>>>>>       proper compiler flags or Intel Compiler by default will certainly
>>>>>       avoid this. #Link: Optimization Guide about LCP BKMs.",
>>>>>        > +        "MetricExpr": "100 * ( ILD_STALL.LCP / (
>>>>>       CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup": "FetchLat;TmaL3;m_tma_fetch_latency_percent",
>>>>>        > +        "MetricName": "tma_lcp_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric estimates the fraction
>>>>>       of cycles when the CPU was stalled due to switches of uop delivery
>>>>>       to the Microcode Sequencer (MS). Commonly used instructions are
>>>>>       optimized for delivery by the DSB (decoded i-cache) or MITE (legacy
>>>>>       instruction decode) pipelines. Certain operations cannot be handled
>>>>>       natively by the execution pipeline; and must be performed by
>>>>>       microcode (small programs injected into the execution stream).
>>>>>       Switching to the MS too often can negatively impact performance. The
>>>>>       MS is designated to deliver long uop flows required by CISC
>>>>>       instructions like CPUID; or uncommon conditions like Floating Point
>>>>>       Assists when dealing with Denormals.",
>>>>>        > +        "MetricExpr": "100 * ( ( 2 ) * IDQ.MS_SWITCHES / (
>>>>>       CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "FetchLat;MicroSeq;TmaL3;m_tma_fetch_latency_percent",
>>>>>        > +        "MetricName": "tma_ms_switches_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       slots the CPU was stalled due to Frontend bandwidth issues.  For
>>>>>       example; inefficiencies at the instruction decoders; or restrictions
>>>>>       for caching in the DSB (decoded uops cache) are categorized under
>>>>>       Fetch Bandwidth. In such cases; the Frontend typically delivers
>>>>>       suboptimal amount of uops to the Backend.",
>>>>>        > +        "MetricExpr": "100 * ( ( IDQ_UOPS_NOT_DELIVERED.CORE / (
>>>>>       ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( 4 ) *
>>>>>       IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "FetchBW;Frontend;TmaL2;m_tma_frontend_bound_percent",
>>>>>        > +        "MetricName": "tma_fetch_bandwidth_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents Core
>>>>>       fraction of cycles in which CPU was likely limited due to the MITE
>>>>>       pipeline (the legacy decode pipeline). This pipeline is used for
>>>>>       code that was not pre-cached in the DSB or LSD. For example;
>>>>>       inefficiencies due to asymmetric decoders; use of long immediate or
>>>>>       LCP can manifest as MITE fetch bandwidth bottleneck.",
>>>>>        > +        "MetricExpr": "100 * ( ( IDQ.ALL_MITE_CYCLES_ANY_UOPS -
>>>>>       IDQ.ALL_MITE_CYCLES_4_UOPS ) / ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 )
>>>>>       if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) / 2 )",
>>>>>        > +        "MetricGroup":
>>>>>       "DSBmiss;FetchBW;TmaL3;m_tma_fetch_bandwidth_percent",
>>>>>        > +        "MetricName": "tma_mite_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents Core
>>>>>       fraction of cycles in which CPU was likely limited due to DSB
>>>>>       (decoded uop cache) fetch pipeline.  For example; inefficient
>>>>>       utilization of the DSB cache structure or bank conflict when reading
>>>>>       from it; are categorized here.",
>>>>>        > +        "MetricExpr": "100 * ( ( IDQ.ALL_DSB_CYCLES_ANY_UOPS -
>>>>>       IDQ.ALL_DSB_CYCLES_4_UOPS ) / ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 )
>>>>>       if #SMT_on else ( CPU_CLK_UNHALTED.THREAD ) ) / 2 )",
>>>>>        > +        "MetricGroup":
>>>>>       "DSB;FetchBW;TmaL3;m_tma_fetch_bandwidth_percent",
>>>>>        > +        "MetricName": "tma_dsb_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This category represents fraction
>>>>>       of slots wasted due to incorrect speculations. This include slots
>>>>>       used to issue uops that do not eventually get retired and slots for
>>>>>       which the issue-pipeline was blocked due to recovery from earlier
>>>>>       incorrect speculation. For example; wasted work due to
>>>>>       miss-predicted branches are categorized under Bad Speculation
>>>>>       category. Incorrect data speculation followed by Memory Ordering
>>>>>       Nukes is another example.",
>>>>>        > +        "MetricExpr": "100 * ( ( UOPS_ISSUED.ANY - (
>>>>>       UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else
>>>>>       INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) )",
>>>>>        > +        "MetricGroup": "TmaL1",
>>>>>        > +        "MetricName": "tma_bad_speculation_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       slots the CPU has wasted due to Branch Misprediction.  These slots
>>>>>       are either wasted by uops fetched from an incorrectly speculated
>>>>>       program path; or stalls when the out-of-order part of the machine
>>>>>       needs to recover its state from a speculative path.",
>>>>>        > +        "MetricExpr": "100 * ( ( BR_MISP_RETIRED.ALL_BRANCHES /
>>>>>       ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT ) ) * ( (
>>>>>       UOPS_ISSUED.ANY - ( UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else
>>>>>       INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "BadSpec;BrMispredicts;TmaL2;m_tma_bad_speculation_percent",
>>>>>        > +        "MetricName": "tma_branch_mispredicts_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       slots the CPU has wasted due to Machine Clears.  These slots are
>>>>>       either wasted by uops fetched prior to the clear; or stalls the
>>>>>       out-of-order portion of the machine needs to recover its state after
>>>>>       the clear. For example; this can happen due to memory ordering Nukes
>>>>>       (e.g. Memory Disambiguation) or Self-Modifying-Code (SMC) nukes.",
>>>>>        > +        "MetricExpr": "100 * ( ( ( UOPS_ISSUED.ANY - (
>>>>>       UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else
>>>>>       INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( BR_MISP_RETIRED.ALL_BRANCHES /
>>>>>       ( BR_MISP_RETIRED.ALL_BRANCHES + MACHINE_CLEARS.COUNT ) ) * ( (
>>>>>       UOPS_ISSUED.ANY - ( UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else
>>>>>       INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "BadSpec;MachineClears;TmaL2;m_tma_bad_speculation_percent",
>>>>>        > +        "MetricName": "tma_machine_clears_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This category represents fraction
>>>>>       of slots where no uops are being delivered due to a lack of required
>>>>>       resources for accepting new uops in the Backend. Backend is the
>>>>>       portion of the processor core where the out-of-order scheduler
>>>>>       dispatches ready uops into their respective execution units; and
>>>>>       once completed these uops get retired according to program order.
>>>>>       For example; stalls due to data-cache misses or stalls due to the
>>>>>       divider unit being overloaded are both categorized under Backend
>>>>>       Bound. Backend Bound is further divided into two main categories:
>>>>>       Memory Bound and Core Bound.",
>>>>>        > +        "MetricExpr": "100 * ( 1 - ( (
>>>>>       IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) + ( ( UOPS_ISSUED.ANY - (
>>>>>       UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else
>>>>>       INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) + ( ( UOPS_RETIRED.RETIRE_SLOTS ) /
>>>>>       ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) ) )",
>>>>>        > +        "MetricGroup": "TmaL1",
>>>>>        > +        "MetricName": "tma_backend_bound_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       slots the Memory subsystem within the Backend was a bottleneck.
>>>>>       Memory Bound estimates fraction of slots where pipeline is likely
>>>>>       stalled due to demand load or store instructions. This accounts
>>>>>       mainly for (1) non-completed in-flight memory demand loads which
>>>>>       coincides with execution units starvation; in addition to (2) cases
>>>>>       where stores could impose backpressure on the pipeline when many of
>>>>>       them get buffered at the same time (less common out of the two).",
>>>>>        > +        "MetricExpr": "100 * ( ( ( CYCLE_ACTIVITY.STALLS_MEM_ANY
>>>>>       + RESOURCE_STALLS.SB <http://RESOURCE_STALLS.SB> ) / ( (
>>>>>       CYCLE_ACTIVITY.STALLS_TOTAL + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (
>>>>>       UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if ( ( INST_RETIRED.ANY / (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) > 1.8 ) else
>>>>>       UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC ) - ( RS_EVENTS.EMPTY_CYCLES if
>>>>>       ( ( ( 4 ) * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / ( ( 4
>>>>>       ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) > 0.1 ) else 0 ) +
>>>>>       RESOURCE_STALLS.SB <http://RESOURCE_STALLS.SB> ) ) ) * ( 1 - ( (
>>>>>       IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) + ( ( UOPS_ISSUED.ANY - (
>>>>>       UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else
>>>>>       INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) + ( ( UOPS_RETIRED.RETIRE_SLOTS ) /
>>>>>       ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) ) ) )",
>>>>>        > +        "MetricGroup": "Backend;TmaL2;m_tma_backend_bound_percent",
>>>>>        > +        "MetricName": "tma_memory_bound_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric estimates how often the
>>>>>       CPU was stalled without loads missing the L1 data cache.  The L1
>>>>>       data cache typically has the shortest latency.  However; in certain
>>>>>       cases like loads blocked on older stores; a load might suffer due to
>>>>>       high latency even though it is being satisfied by the L1. Another
>>>>>       example is loads who miss in the TLB. These cases are characterized
>>>>>       by execution unit stalls; while some non-completed demand load lives
>>>>>       in the machine without having that demand load missing the L1 cache.",
>>>>>        > +        "MetricExpr": "100 * ( max( (
>>>>>       CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY.STALLS_L1D_MISS ) / (
>>>>>       CPU_CLK_UNHALTED.THREAD ) , 0 ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memory_bound_percent",
>>>>>        > +        "MetricName": "tma_l1_bound_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric estimates how often the
>>>>>       CPU was stalled due to L2 cache accesses by loads.  Avoiding cache
>>>>>       misses (i.e. L1 misses/L2 hits) can improve the latency and increase
>>>>>       performance.",
>>>>>        > +        "MetricExpr": "100 * ( ( CYCLE_ACTIVITY.STALLS_L1D_MISS
>>>>>       - CYCLE_ACTIVITY.STALLS_L2_MISS ) / ( CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memory_bound_percent",
>>>>>        > +        "MetricName": "tma_l2_bound_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric estimates how often the
>>>>>       CPU was stalled due to loads accesses to L3 cache or contended with
>>>>>       a sibling Core.  Avoiding cache misses (i.e. L2 misses/L3 hits) can
>>>>>       improve the latency and increase performance.",
>>>>>        > +        "MetricExpr": "100 * ( ( MEM_LOAD_UOPS_RETIRED.L3_HIT /
>>>>>       ( MEM_LOAD_UOPS_RETIRED.L3_HIT + ( 7 ) *
>>>>>       MEM_LOAD_UOPS_RETIRED.L3_MISS ) ) * CYCLE_ACTIVITY.STALLS_L2_MISS /
>>>>>       ( CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "CacheMisses;MemoryBound;TmaL3mem;TmaL3;m_tma_memory_bound_percent",
>>>>>        > +        "MetricName": "tma_l3_bound_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric estimates how often the
>>>>>       CPU was stalled on accesses to external memory (DRAM) by loads.
>>>>>       Better caching can improve the latency and increase performance.",
>>>>>        > +        "MetricExpr": "100 * ( min( ( ( 1 - (
>>>>>       MEM_LOAD_UOPS_RETIRED.L3_HIT / ( MEM_LOAD_UOPS_RETIRED.L3_HIT + ( 7
>>>>>       ) * MEM_LOAD_UOPS_RETIRED.L3_MISS ) ) ) *
>>>>>       CYCLE_ACTIVITY.STALLS_L2_MISS / ( CPU_CLK_UNHALTED.THREAD ) ) , ( 1
>>>>>       ) ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "MemoryBound;TmaL3mem;TmaL3;m_tma_memory_bound_percent",
>>>>>        > +        "MetricName": "tma_dram_bound_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric estimates how often CPU
>>>>>       was stalled  due to RFO store memory accesses; RFO store issue a
>>>>>       read-for-ownership request before the write. Even though store
>>>>>       accesses do not typically stall out-of-order CPUs; there are few
>>>>>       cases where stores can lead to actual stalls. This metric will be
>>>>>       flagged should RFO stores be a bottleneck.",
>>>>>        > +        "MetricExpr": "100 * ( RESOURCE_STALLS.SB
>>>>>       <http://RESOURCE_STALLS.SB> / ( CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "MemoryBound;TmaL3mem;TmaL3;m_tma_memory_bound_percent",
>>>>>        > +        "MetricName": "tma_store_bound_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       slots where Core non-memory issues were of a bottleneck.  Shortage
>>>>>       in hardware compute resources; or dependencies in software's
>>>>>       instructions are both categorized under Core Bound. Hence it may
>>>>>       indicate the machine ran out of an out-of-order resource; certain
>>>>>       execution units are overloaded or dependencies in program's data- or
>>>>>       instruction-flow are limiting the performance (e.g. FP-chained
>>>>>       long-latency arithmetic operations).",
>>>>>        > +        "MetricExpr": "100 * ( ( 1 - ( (
>>>>>       IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) + ( ( UOPS_ISSUED.ANY - (
>>>>>       UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else
>>>>>       INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) + ( ( UOPS_RETIRED.RETIRE_SLOTS ) /
>>>>>       ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) ) ) - ( ( (
>>>>>       CYCLE_ACTIVITY.STALLS_MEM_ANY + RESOURCE_STALLS.SB
>>>>>       <http://RESOURCE_STALLS.SB> ) / ( ( CYCLE_ACTIVITY.STALLS_TOTAL +
>>>>>       UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (
>>>>>       UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if ( ( INST_RETIRED.ANY / (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) > 1.8 ) else
>>>>>       UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC ) - ( RS_EVENTS.EMPTY_CYCLES if
>>>>>       ( ( ( 4 ) * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / ( ( 4
>>>>>       ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) > 0.1 ) else 0 ) +
>>>>>       RESOURCE_STALLS.SB <http://RESOURCE_STALLS.SB> ) ) ) * ( 1 - ( (
>>>>>       IDQ_UOPS_NOT_DELIVERED.CORE / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) + ( ( UOPS_ISSUED.ANY - (
>>>>>       UOPS_RETIRED.RETIRE_SLOTS ) + ( 4 ) * ( (
>>>>>       INT_MISC.RECOVERY_CYCLES_ANY / 2 ) if #SMT_on else
>>>>>       INT_MISC.RECOVERY_CYCLES ) ) / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) + ( ( UOPS_RETIRED.RETIRE_SLOTS ) /
>>>>>       ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) ) ) ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "Backend;TmaL2;Compute;m_tma_backend_bound_percent",
>>>>>        > +        "MetricName": "tma_core_bound_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       cycles where the Divider unit was active. Divide and square root
>>>>>       instructions are performed by the Divider unit and can take
>>>>>       considerably longer latency than integer or Floating Point addition;
>>>>>       subtraction; or multiplication.",
>>>>>        > +        "MetricExpr": "100 * ( ARITH.FPU_DIV_ACTIVE / ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) )",
>>>>>        > +        "MetricGroup": "TmaL3;m_tma_core_bound_percent",
>>>>>        > +        "MetricName": "tma_divider_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric estimates fraction of
>>>>>       cycles the CPU performance was potentially limited due to Core
>>>>>       computation issues (non divider-related).  Two distinct categories
>>>>>       can be attributed into this metric: (1) heavy data-dependency among
>>>>>       contiguous instructions would manifest in this metric - such cases
>>>>>       are often referred to as low Instruction Level Parallelism (ILP).
>>>>>       (2) Contention on some hardware execution unit other than Divider.
>>>>>       For example; when there are too many multiply operations.",
>>>>>        > +        "MetricExpr": "100 * ( ( ( ( CYCLE_ACTIVITY.STALLS_TOTAL
>>>>>       + UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC - (
>>>>>       UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC if ( ( INST_RETIRED.ANY / (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) > 1.8 ) else
>>>>>       UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC ) - ( RS_EVENTS.EMPTY_CYCLES if
>>>>>       ( ( ( 4 ) * IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE / ( ( 4
>>>>>       ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) > 0.1 ) else 0 ) +
>>>>>       RESOURCE_STALLS.SB <http://RESOURCE_STALLS.SB> ) ) -
>>>>>       RESOURCE_STALLS.SB <http://RESOURCE_STALLS.SB> -
>>>>>       CYCLE_ACTIVITY.STALLS_MEM_ANY ) / ( CPU_CLK_UNHALTED.THREAD ) )",
>>>>>        > +        "MetricGroup": "PortsUtil;TmaL3;m_tma_core_bound_percent",
>>>>>        > +        "MetricName": "tma_ports_utilization_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This category represents fraction
>>>>>       of slots utilized by useful work i.e. issued uops that eventually
>>>>>       get retired. Ideally; all pipeline slots would be attributed to the
>>>>>       Retiring category.  Retiring of 100% would indicate the maximum
>>>>>       Pipeline_Width throughput was achieved.  Maximizing Retiring
>>>>>       typically increases the Instructions-per-cycle (see IPC metric).
>>>>>       Note that a high Retiring value does not necessary mean there is no
>>>>>       room for more performance.  For example; Heavy-operations or
>>>>>       Microcode Assists are categorized under Retiring. They often
>>>>>       indicate suboptimal performance and can often be optimized or
>>>>>       avoided. ",
>>>>>        > +        "MetricExpr": "100 * ( ( UOPS_RETIRED.RETIRE_SLOTS ) / (
>>>>>       ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) )",
>>>>>        > +        "MetricGroup": "TmaL1",
>>>>>        > +        "MetricName": "tma_retiring_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       slots where the CPU was retiring light-weight operations --
>>>>>       instructions that require no more than one uop (micro-operation).
>>>>>       This correlates with total number of instructions used by the
>>>>>       program. A uops-per-instruction (see UPI metric) ratio of 1 or less
>>>>>       should be expected for decently optimized software running on Intel
>>>>>       Core/Xeon products. While this often indicates efficient X86
>>>>>       instructions were executed; high value does not necessarily mean
>>>>>       better performance cannot be achieved.",
>>>>>        > +        "MetricExpr": "100 * ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) /
>>>>>       ( ( 4 ) * ( ( CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) - ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS
>>>>>       ) / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) ) )",
>>>>>        > +        "MetricGroup": "Retire;TmaL2;m_tma_retiring_percent",
>>>>>        > +        "MetricName": "tma_light_operations_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents overall
>>>>>       arithmetic floating-point (FP) operations fraction the CPU has
>>>>>       executed (retired). Note this metric's value may exceed its parent
>>>>>       due to use of \"Uops\" CountDomain and FMA double-counting.",
>>>>>        > +        "MetricExpr": "100 * ( ( INST_RETIRED.X87 * ( (
>>>>>       UOPS_RETIRED.RETIRE_SLOTS ) / INST_RETIRED.ANY ) / (
>>>>>       UOPS_RETIRED.RETIRE_SLOTS ) ) + ( (
>>>>>       FP_ARITH_INST_RETIRED.SCALAR_SINGLE +
>>>>>       FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) / ( UOPS_RETIRED.RETIRE_SLOTS
>>>>>       ) ) + ( min( ( ( FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE +
>>>>>       FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE +
>>>>>       FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE +
>>>>>       FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE ) / (
>>>>>       UOPS_RETIRED.RETIRE_SLOTS ) ) , ( 1 ) ) ) )",
>>>>>        > +        "MetricGroup": "HPC;TmaL3;m_tma_light_operations_percent",
>>>>>        > +        "MetricName": "tma_fp_arith_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       slots where the CPU was retiring heavy-weight operations --
>>>>>       instructions that require two or more uops or microcoded sequences.
>>>>>       This highly-correlates with the uop length of these
>>>>>       instructions/sequences.",
>>>>>        > +        "MetricExpr": "100 * ( ( ( ( UOPS_RETIRED.RETIRE_SLOTS )
>>>>>       / UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) ) )",
>>>>>        > +        "MetricGroup": "Retire;TmaL2;m_tma_retiring_percent",
>>>>>        > +        "MetricName": "tma_heavy_operations_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        > +    },
>>>>>        > +    {
>>>>>        > +        "BriefDescription": "This metric represents fraction of
>>>>>       slots the CPU was retiring uops fetched by the Microcode Sequencer
>>>>>       (MS) unit.  The MS is used for CISC instructions not supported by
>>>>>       the default decoders (like repeat move strings; or CPUID); or by
>>>>>       microcode assists used to address some operation modes (like in
>>>>>       Floating Point assists). These cases can often be avoided.",
>>>>>        > +        "MetricExpr": "100 * ( ( ( UOPS_RETIRED.RETIRE_SLOTS ) /
>>>>>       UOPS_ISSUED.ANY ) * IDQ.MS_UOPS / ( ( 4 ) * ( (
>>>>>       CPU_CLK_UNHALTED.THREAD_ANY / 2 ) if #SMT_on else (
>>>>>       CPU_CLK_UNHALTED.THREAD ) ) ) )",
>>>>>        > +        "MetricGroup":
>>>>>       "MicroSeq;TmaL3;m_tma_heavy_operations_percent",
>>>>>        > +        "MetricName": "tma_microcode_sequencer_percent",
>>>>>        > +        "ScaleUnit": "1%"
>>>>>        >       }
>>>>>        >   ]
>>>>>        > diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
>>>>>       b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
>>>>>        > index 127abe08362f..2efc4c0ee740 100644
>>>>>        > --- a/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
>>>>>        > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/cache.json
>>>>>        > @@ -814,9 +814,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x04003C0244",
>>>>>        > +        "MSRValue": "0x4003C0244",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch code
>>>>>       reads hit in the L3 and the snoops to sibling cores hit in either
>>>>>       E/S state and the line is not forwarded",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -829,7 +828,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x10003C0091",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch data
>>>>>       reads hit in the L3 and the snoop to one of the sibling cores hits
>>>>>       the line in M state and the line is forwarded",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -840,9 +838,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x04003C0091",
>>>>>        > +        "MSRValue": "0x4003C0091",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch data
>>>>>       reads hit in the L3 and the snoops to sibling cores hit in either
>>>>>       E/S state and the line is not forwarded",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -855,7 +852,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x10003C07F7",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all data/code/rfo reads
>>>>>       (demand & prefetch) hit in the L3 and the snoop to one of the
>>>>>       sibling cores hits the line in M state and the line is forwarded",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -866,9 +862,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_READS.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x04003C07F7",
>>>>>        > +        "MSRValue": "0x4003C07F7",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all data/code/rfo reads
>>>>>       (demand & prefetch) hit in the L3 and the snoops to sibling cores
>>>>>       hit in either E/S state and the line is not forwarded",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -881,7 +876,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x3F803C8FFF",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all requests hit in the L3",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -894,7 +888,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x10003C0122",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch RFOs
>>>>>       hit in the L3 and the snoop to one of the sibling cores hits the
>>>>>       line in M state and the line is forwarded",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -905,9 +898,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_RFO.LLC_HIT.HIT_OTHER_CORE_NO_FWD",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x04003C0122",
>>>>>        > +        "MSRValue": "0x4003C0122",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch RFOs
>>>>>       hit in the L3 and the snoops to sibling cores hit in either E/S
>>>>>       state and the line is not forwarded",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -920,7 +912,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x3F803C0002",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand data writes
>>>>>       (RFOs) hit in the L3",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -933,7 +924,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x10003C0002",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand data writes
>>>>>       (RFOs) hit in the L3 and the snoop to one of the sibling cores hits
>>>>>       the line in M state and the line is forwarded",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -946,7 +936,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x3F803C0200",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts prefetch (that bring data
>>>>>       to LLC only) code reads hit in the L3",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -959,7 +948,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x3F803C0100",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all prefetch (that bring
>>>>>       data to LLC only) RFOs hit in the L3",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -973,4 +961,4 @@
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x10"
>>>>>        >       }
>>>>>        > -]
>>>>>        > \ No newline at end of file
>>>>>        > +]
>>>>>        > diff --git
>>>>>       a/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
>>>>>       b/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
>>>>>        > index 9ad37dddb354..93bbc8600321 100644
>>>>>        > --- a/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
>>>>>        > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
>>>>>        > @@ -5,6 +5,7 @@
>>>>>        >           "CounterHTOff": "0,1,2,3",
>>>>>        >           "EventCode": "0xc7",
>>>>>        >           "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
>>>>>        > +        "PublicDescription": "Number of SSE/AVX computational
>>>>>       128-bit packed double precision floating-point instructions retired;
>>>>>       some instructions will count twice as noted below.  Each count
>>>>>       represents 2 computation operations, one for each element.  Applies
>>>>>       to SSE* and AVX* packed double precision floating-point
>>>>>       instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT DPP
>>>>>       FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they
>>>>>       perform 2 calculations per element. The DAZ and FTZ flags in the
>>>>>       MXCSR register need to be set when using these events.",
>>>>>        >           "SampleAfterValue": "2000003",
>>>>>        >           "UMask": "0x4"
>>>>>        >       },
>>>>>        > @@ -14,6 +15,7 @@
>>>>>        >           "CounterHTOff": "0,1,2,3",
>>>>>        >           "EventCode": "0xc7",
>>>>>        >           "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
>>>>>        > +        "PublicDescription": "Number of SSE/AVX computational
>>>>>       128-bit packed single precision floating-point instructions retired;
>>>>>       some instructions will count twice as noted below.  Each count
>>>>>       represents 4 computation operations, one for each element.  Applies
>>>>>       to SSE* and AVX* packed single precision floating-point
>>>>>       instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT
>>>>>       RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice
>>>>>       as they perform 2 calculations per element. The DAZ and FTZ flags in
>>>>>       the MXCSR register need to be set when using these events.",
>>>>>        >           "SampleAfterValue": "2000003",
>>>>>        >           "UMask": "0x8"
>>>>>        >       },
>>>>>        > @@ -23,6 +25,7 @@
>>>>>        >           "CounterHTOff": "0,1,2,3",
>>>>>        >           "EventCode": "0xc7",
>>>>>        >           "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
>>>>>        > +        "PublicDescription": "Number of SSE/AVX computational
>>>>>       256-bit packed double precision floating-point instructions retired;
>>>>>       some instructions will count twice as noted below.  Each count
>>>>>       represents 4 computation operations, one for each element.  Applies
>>>>>       to SSE* and AVX* packed double precision floating-point
>>>>>       instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT
>>>>>       FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform
>>>>>       2 calculations per element. The DAZ and FTZ flags in the MXCSR
>>>>>       register need to be set when using these events.",
>>>>>        >           "SampleAfterValue": "2000003",
>>>>>        >           "UMask": "0x10"
>>>>>        >       },
>>>>>        > @@ -32,6 +35,7 @@
>>>>>        >           "CounterHTOff": "0,1,2,3",
>>>>>        >           "EventCode": "0xc7",
>>>>>        >           "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
>>>>>        > +        "PublicDescription": "Number of SSE/AVX computational
>>>>>       256-bit packed single precision floating-point instructions retired;
>>>>>       some instructions will count twice as noted below.  Each count
>>>>>       represents 8 computation operations, one for each element.  Applies
>>>>>       to SSE* and AVX* packed single precision floating-point
>>>>>       instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT
>>>>>       RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice
>>>>>       as they perform 2 calculations per element. The DAZ and FTZ flags in
>>>>>       the MXCSR register need to be set when using these events.",
>>>>>        >           "SampleAfterValue": "2000003",
>>>>>        >           "UMask": "0x20"
>>>>>        >       },
>>>>>        > @@ -59,6 +63,7 @@
>>>>>        >           "CounterHTOff": "0,1,2,3",
>>>>>        >           "EventCode": "0xc7",
>>>>>        >           "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
>>>>>        > +        "PublicDescription": "Number of SSE/AVX computational
>>>>>       scalar single precision and double precision floating-point
>>>>>       instructions retired; some instructions will count twice as noted
>>>>>       below.  Each count represents 1 computational operation. Applies to
>>>>>       SSE* and AVX* scalar single precision floating-point instructions:
>>>>>       ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB
>>>>>       instructions count twice as they perform 2 calculations per element.
>>>>>       The DAZ and FTZ flags in the MXCSR register need to be set when
>>>>>       using these events.",
>>>>>        >           "SampleAfterValue": "2000003",
>>>>>        >           "UMask": "0x3"
>>>>>        >       },
>>>>>        > @@ -68,6 +73,7 @@
>>>>>        >           "CounterHTOff": "0,1,2,3",
>>>>>        >           "EventCode": "0xc7",
>>>>>        >           "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
>>>>>        > +        "PublicDescription": "Number of SSE/AVX computational
>>>>>       scalar double precision floating-point instructions retired; some
>>>>>       instructions will count twice as noted below.  Each count represents
>>>>>       1 computational operation. Applies to SSE* and AVX* scalar double
>>>>>       precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT
>>>>>       FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform
>>>>>       2 calculations per element. The DAZ and FTZ flags in the MXCSR
>>>>>       register need to be set when using these events.",
>>>>>        >           "SampleAfterValue": "2000003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -77,6 +83,7 @@
>>>>>        >           "CounterHTOff": "0,1,2,3",
>>>>>        >           "EventCode": "0xc7",
>>>>>        >           "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
>>>>>        > +        "PublicDescription": "Number of SSE/AVX computational
>>>>>       scalar single precision floating-point instructions retired; some
>>>>>       instructions will count twice as noted below.  Each count represents
>>>>>       1 computational operation. Applies to SSE* and AVX* scalar single
>>>>>       precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT
>>>>>       RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as
>>>>>       they perform 2 calculations per element. The DAZ and FTZ flags in
>>>>>       the MXCSR register need to be set when using these events.",
>>>>>        >           "SampleAfterValue": "2000003",
>>>>>        >           "UMask": "0x2"
>>>>>        >       },
>>>>>        > @@ -190,4 +197,4 @@
>>>>>        >           "SampleAfterValue": "2000003",
>>>>>        >           "UMask": "0x3"
>>>>>        >       }
>>>>>        > -]
>>>>>        > \ No newline at end of file
>>>>>        > +]
>>>>>        > diff --git
>>>>>       a/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
>>>>>       b/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
>>>>>        > index f0bcb945ff76..37ce8034b2ed 100644
>>>>>        > --- a/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
>>>>>        > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
>>>>>        > @@ -292,4 +292,4 @@
>>>>>        >           "SampleAfterValue": "2000003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       }
>>>>>        > -]
>>>>>        > \ No newline at end of file
>>>>>        > +]
>>>>>        > diff --git
>>>>>       a/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
>>>>>       b/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
>>>>>        > index cce993b197e3..545f61f691b9 100644
>>>>>        > --- a/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
>>>>>        > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/memory.json
>>>>>        > @@ -247,7 +247,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x3FBFC00244",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch code
>>>>>       reads miss in the L3",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -258,9 +257,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_CODE_RD.LLC_MISS.LOCAL_DRAM",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x0604000244",
>>>>>        > +        "MSRValue": "0x604000244",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch code
>>>>>       reads miss the L3 and the data is returned from local dram",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -273,7 +271,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x3FBFC00091",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch data
>>>>>       reads miss in the L3",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -284,9 +281,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.LOCAL_DRAM",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x0604000091",
>>>>>        > +        "MSRValue": "0x604000091",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch data
>>>>>       reads miss the L3 and the data is returned from local dram",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -297,9 +293,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.REMOTE_DRAM",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x063BC00091",
>>>>>        > +        "MSRValue": "0x63BC00091",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch data
>>>>>       reads miss the L3 and the data is returned from remote dram",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -312,7 +307,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x103FC00091",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch data
>>>>>       reads miss the L3 and the modified data is transferred from remote
>>>>>       cache",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -323,9 +317,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_DATA_RD.LLC_MISS.REMOTE_HIT_FORWARD",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x087FC00091",
>>>>>        > +        "MSRValue": "0x87FC00091",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch data
>>>>>       reads miss the L3 and clean or shared data is transferred from
>>>>>       remote cache",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -338,20 +331,18 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x3FBFC007F7",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all data/code/rfo reads
>>>>>       (demand & prefetch) miss in the L3",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        >       {
>>>>>        > -        "BriefDescription": "Counts all data/code/rfo reads
>>>>>       (demand & prefetch)miss the L3 and the data is returned from local
>>>>>       dram",
>>>>>        > +        "BriefDescription": "Counts all data/code/rfo reads
>>>>>       (demand & prefetch) miss the L3 and the data is returned from local
>>>>>       dram",
>>>>>        >           "Counter": "0,1,2,3",
>>>>>        >           "CounterHTOff": "0,1,2,3",
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.LOCAL_DRAM",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x06040007F7",
>>>>>        > +        "MSRValue": "0x6040007F7",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all data/code/rfo reads
>>>>>       (demand & prefetch)miss the L3 and the data is returned from local
>>>>>       dram",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -362,9 +353,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_DRAM",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x063BC007F7",
>>>>>        > +        "MSRValue": "0x63BC007F7",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all data/code/rfo reads
>>>>>       (demand & prefetch) miss the L3 and the data is returned from remote
>>>>>       dram",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -377,7 +367,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x103FC007F7",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all data/code/rfo reads
>>>>>       (demand & prefetch) miss the L3 and the modified data is transferred
>>>>>       from remote cache",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -388,9 +377,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_READS.LLC_MISS.REMOTE_HIT_FORWARD",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x087FC007F7",
>>>>>        > +        "MSRValue": "0x87FC007F7",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all data/code/rfo reads
>>>>>       (demand & prefetch) miss the L3 and clean or shared data is
>>>>>       transferred from remote cache",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -403,7 +391,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x3FBFC08FFF",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all requests miss in the L3",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -416,7 +403,6 @@
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        >           "MSRValue": "0x3FBFC00122",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & prefetch RFOs
>>>>>       miss in the L3",
>>>>>        >           "SampleAfterValue": "100003",
>>>>>        >           "UMask": "0x1"
>>>>>        >       },
>>>>>        > @@ -427,9 +413,8 @@
>>>>>        >           "EventCode": "0xB7, 0xBB",
>>>>>        >           "EventName":
>>>>>       "OFFCORE_RESPONSE.ALL_RFO.LLC_MISS.LOCAL_DRAM",
>>>>>        >           "MSRIndex": "0x1a6,0x1a7",
>>>>>        > -        "MSRValue": "0x0604000122",
>>>>>        > +        "MSRValue": "0x604000122",
>>>>>        >           "Offcore": "1",
>>>>>        > -        "PublicDescription": "Counts all demand & pref
>>>>>
>>>>
>>>> --
>>>> Zhengjun Xing
>>
>> -- 
>> Zhengjun Xing
> 

-- 
Zhengjun Xing
