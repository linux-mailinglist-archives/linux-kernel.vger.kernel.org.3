Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FBF5020CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349050AbiDODC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiDODCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:02:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6D75F8C1;
        Thu, 14 Apr 2022 19:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649991596; x=1681527596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/gELS1F9Pc4FaUsgUVWB4DvT6mJyZz4/VNgyHfEwsaM=;
  b=QE/rpkGmZ2ZvRIVpahL8eYVTNCQM6V7QVSRlSmpp9wAhvoLZ0QxdFpoQ
   l4FrFB2U0AKLgKiGxOpW84Qw+dOrJJZQ3ZubytW7WcKmlCdGHM85XkOgk
   1I3tWppcKjl8YW3TDfLrMlftFjL0aPEMbDeDnCRyldIb07j/vENzhSyN2
   YeaqUVEvqPPc3aasMC6otAn5MG4impUhihp9rs/Igc8Ow4ydp02Ys6Y4w
   nwNn9vcVwGSurda76M3fpwT4p9qlO+s2eNYwXfGrm4MOeuykhPggax66P
   lGuXwyN6XebBnYazrU3BkN6Zlop0VPxkMvcjA9OWHK6/O5X+CZR/Jaib0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262834129"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="262834129"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 19:59:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="574124475"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.30.200]) ([10.255.30.200])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 19:59:52 -0700
Message-ID: <b7b8c467-ccb2-913b-66b6-e02e081577e2@linux.intel.com>
Date:   Fri, 15 Apr 2022 10:59:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/14] perf vendor events intel: Add sapphirerapids events
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>
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
References: <20220413210503.3256922-1-irogers@google.com>
 <20220413210503.3256922-3-irogers@google.com>
 <368c5b92-f035-41cc-96a8-4908f1325462@linux.intel.com>
 <CAP-5=fWpECOtC8jc6up4LRFon1v0DBN1Y6LJsimEtuPfXcvJuA@mail.gmail.com>
 <28285c3a-a577-14ca-5e88-6101217ea73f@linux.intel.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <28285c3a-a577-14ca-5e88-6101217ea73f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/2022 2:25 AM, Liang, Kan wrote:
> 
> 
> On 4/14/2022 12:36 PM, Ian Rogers wrote:
>> On Thu, Apr 14, 2022 at 8:03 AM Liang, Kan <kan.liang@linux.intel.com> 
>> wrote:
>>>
>>>
>>>
>>> On 4/13/2022 5:04 PM, Ian Rogers wrote:
>>>> Events were generated from 01.org using:
>>>> https://github.com/intel/event-converter-for-linux-perf
>>>>
>>>> Signed-off-by: Ian Rogers<irogers@google.com>
>>>> ---
>>>>    tools/perf/pmu-events/arch/x86/mapfile.csv    |    1 +
>>>>    .../arch/x86/sapphirerapids/cache.json        | 1083 ++++++++++++++
>>>>    .../x86/sapphirerapids/floating-point.json    |  218 +++
>>>>    .../arch/x86/sapphirerapids/frontend.json     |  471 ++++++
>>>>    .../arch/x86/sapphirerapids/memory.json       |  415 ++++++
>>>>    .../arch/x86/sapphirerapids/other.json        |  329 +++++
>>>>    .../arch/x86/sapphirerapids/pipeline.json     | 1271 
>>>> +++++++++++++++++
>>>>    .../x86/sapphirerapids/virtual-memory.json    |  225 +++
>>>
>>> Thank you very much Ian for the patches. They all looks good to me.
>>>
>>>       Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> BTW: I think the uncore events for SPR are also published in 01.org.
>>> Do you have plan to add them later?
>>
>> Thanks Kan, we need to add the csv file to the github project to make
>> this work. I can make a basic one if that works?
>>
> 
> I think Zhengjun may already have one. Zhengjun?

The CSV file for SPR has been added to the event convert tool, please 
have a try.
> 
> Thanks,
> Kan

-- 
Zhengjun Xing
