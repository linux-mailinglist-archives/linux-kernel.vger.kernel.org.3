Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977BE501B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbiDNS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245321AbiDNS1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:27:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CD1CA6EB;
        Thu, 14 Apr 2022 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649960704; x=1681496704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bxIt+MQ5euzHqb8H1P7gjRCbt4hKJ/40JyCSW+XYNfE=;
  b=RULfNPKnV8ZDEmgtxagLFO1Ar/8WFaIp9T8Dz5djlsKjFZoTDLTKUJ/l
   /DJyxUOgzhdhEULnD+V0PQ5A0sYfPRoyE2BGsYwxiWPAoPTvC2/HqN5py
   eXhjo6+UtdKgB1T8iAwnu8gLRwaGtl5ScDxVkh8ooda4zd1qWxp5aL/4P
   BBGVxAbxP4v54+mNlbclxkGm2v7xORzVkFOc68utBE6dj7+kCgRHyGyZU
   BpgGzFix4hCZFfPA2CEidDfPX0tL9Rdvsi4mRW2+HTHChKH/EhGLUvfV9
   ZmnvU9txqZIF4L/OligHQOR1PlXk20avZnXj8vXOCJzHW0E2GHqZtqfhI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="288060358"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="288060358"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 11:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="527500559"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2022 11:25:03 -0700
Received: from [10.209.96.223] (kliang2-MOBL.ccr.corp.intel.com [10.209.96.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 457AE5805BD;
        Thu, 14 Apr 2022 11:25:02 -0700 (PDT)
Message-ID: <28285c3a-a577-14ca-5e88-6101217ea73f@linux.intel.com>
Date:   Thu, 14 Apr 2022 14:25:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 03/14] perf vendor events intel: Add sapphirerapids events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWpECOtC8jc6up4LRFon1v0DBN1Y6LJsimEtuPfXcvJuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2022 12:36 PM, Ian Rogers wrote:
> On Thu, Apr 14, 2022 at 8:03 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 4/13/2022 5:04 PM, Ian Rogers wrote:
>>> Events were generated from 01.org using:
>>> https://github.com/intel/event-converter-for-linux-perf
>>>
>>> Signed-off-by: Ian Rogers<irogers@google.com>
>>> ---
>>>    tools/perf/pmu-events/arch/x86/mapfile.csv    |    1 +
>>>    .../arch/x86/sapphirerapids/cache.json        | 1083 ++++++++++++++
>>>    .../x86/sapphirerapids/floating-point.json    |  218 +++
>>>    .../arch/x86/sapphirerapids/frontend.json     |  471 ++++++
>>>    .../arch/x86/sapphirerapids/memory.json       |  415 ++++++
>>>    .../arch/x86/sapphirerapids/other.json        |  329 +++++
>>>    .../arch/x86/sapphirerapids/pipeline.json     | 1271 +++++++++++++++++
>>>    .../x86/sapphirerapids/virtual-memory.json    |  225 +++
>>
>> Thank you very much Ian for the patches. They all looks good to me.
>>
>>       Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>
>> BTW: I think the uncore events for SPR are also published in 01.org.
>> Do you have plan to add them later?
> 
> Thanks Kan, we need to add the csv file to the github project to make
> this work. I can make a basic one if that works?
> 

I think Zhengjun may already have one. Zhengjun?

Thanks,
Kan
