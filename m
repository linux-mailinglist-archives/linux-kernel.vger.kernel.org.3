Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533264DD6FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiCRJVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiCRJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:21:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED0D22C8FF;
        Fri, 18 Mar 2022 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647595194; x=1679131194;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N6MReWR1r4L4dw6IImRH6ufItuQC0LQjZHQuSSaWB+w=;
  b=Te2tRcdZQyV75GpBEvvUdv+kSGVXgREY0kuJLf6x5HmRrm0HjjcTacgb
   i9aLIv6qiX9bjQvogZaUWuGTHpCkJJnUU25jwEyVJSq5U9i47a7oHObVa
   glnXSbQz2qPrZZMyeb1CH4MtQmlf5WH57qR3dGKRVOcmEc72ZotXrwG6c
   UdF3Wb3IbGZOuhuh8II/8l0LdaD6umdVv0hkeFHpwtDMlYPb+hy546tWA
   VHkHuGG/vwAQQwk0seWucIPK1n+uPKiZrTFNw6rinwwdRwKPrhWCGR4Oj
   LcqUgY/8I1LVX5Toa9jJOXIn4DJeBi6DEX2v480ZqVSXWGMOqAxwvkzFo
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="237046061"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="237046061"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:19:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558339124"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.171]) ([10.255.31.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:19:48 -0700
Message-ID: <b05f4132-14de-579b-528c-5bfe877725ae@linux.intel.com>
Date:   Fri, 18 Mar 2022 17:19:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/8] perf vendor events: Update events for Skylake
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
 <20220317182858.484474-5-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220317182858.484474-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2022 2:28 AM, Ian Rogers wrote:
> The change:
> https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e394eed6a1ebd909c9f649d3ed3ef
> moved certain "other" type of events in to the cache topic. Update the
> perf json files for this change.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

> ---
>   .../pmu-events/arch/x86/skylake/cache.json    | 36 +++++++++++++++++++
>   .../pmu-events/arch/x86/skylake/other.json    | 36 -------------------
>   2 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/cache.json b/tools/perf/pmu-events/arch/x86/skylake/cache.json
> index 529c5e6e117f..c5d9a4ed10d7 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/cache.json
> @@ -2937,5 +2937,41 @@
>           "PublicDescription": "Counts the number of cache line split locks sent to the uncore.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
> +        "Counter": "0,1,2,3",
> +        "CounterHTOff": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.NTA",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHW instructions executed.",
> +        "Counter": "0,1,2,3",
> +        "CounterHTOff": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
> +        "Counter": "0,1,2,3",
> +        "CounterHTOff": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T0",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> +        "Counter": "0,1,2,3",
> +        "CounterHTOff": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x4"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/other.json b/tools/perf/pmu-events/arch/x86/skylake/other.json
> index 5c0e81f76a5b..4f4839024915 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/other.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/other.json
> @@ -16,41 +16,5 @@
>           "EventName": "MEMORY_DISAMBIGUATION.HISTORY_RESET",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
> -        "Counter": "0,1,2,3",
> -        "CounterHTOff": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.NTA",
> -        "SampleAfterValue": "2000003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHW instructions executed.",
> -        "Counter": "0,1,2,3",
> -        "CounterHTOff": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> -        "SampleAfterValue": "2000003",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
> -        "Counter": "0,1,2,3",
> -        "CounterHTOff": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.T0",
> -        "SampleAfterValue": "2000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> -        "Counter": "0,1,2,3",
> -        "CounterHTOff": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> -        "SampleAfterValue": "2000003",
> -        "UMask": "0x4"
>       }
>   ]
> \ No newline at end of file

-- 
Zhengjun Xing
