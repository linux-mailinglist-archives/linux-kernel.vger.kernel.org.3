Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0A85055C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbiDRN0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 09:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbiDRNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:02:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FBC329AA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650285773; x=1681821773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vh3DQilFivTLKU7aiHrGhIrC0B7OlrJdqfHNsLm4ZYQ=;
  b=jEZ/a/DiMOgvJokIb7MpmR7vaSybIZk/3an//iLVOURsooNz18PS+azs
   jvsOBen5tBhAoaGxQDGWSZ8RbXIW750paOxV3HgYpA0zWBO7xoMmgArvn
   8aYWlJ++iMC9pZ/ZBGTV4NDbsSA58uNs34EO9PTTRlBhjEGAI1vjsJT+5
   qWBJh4RPvInHLi+M+6AAyyBZNfBqBxKIM8jwiH65qhmTbwJ0gyedFdrnm
   uwx1/MNT2VyfXYSZbp4lZe74RGjXa5sw4M1ZVZHDvI7aXUhy+s21ifRfV
   0rUITSwSlhBUXTdnc4qw3/DRkUhMIreezymGENks+7iAIGUksTDiDNtW/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="323951800"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="323951800"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 05:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="528850158"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 18 Apr 2022 05:42:52 -0700
Received: from [10.212.211.251] (kliang2-MOBL.ccr.corp.intel.com [10.212.211.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B96D45808AE;
        Mon, 18 Apr 2022 05:42:50 -0700 (PDT)
Message-ID: <fd562e7b-75f5-0db3-3677-89b052312083@linux.intel.com>
Date:   Mon, 18 Apr 2022 08:42:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [LKP] Re: [perf vendor events] 3f5f0df7bf:
 perf-sanity-tests.perf_all_metrics_test.fail
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Carel Si <beibei.si@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        alexandre.torgue@foss.st.com, Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>, mcoquelin.stm32@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
References: <20220304083329.GC20556@xsang-OptiPlex-9020>
 <CAP-5=fVz=arWo19PQR_4UKY_PyywyXoyp+MUnfAJxCFZy5rhWg@mail.gmail.com>
 <20220413070529.GA1320@linux.intel.com>
 <CAP-5=fXGqODZYGu781qjEEVtGFpCQJ=dCXi5shYOAbBSt5wQkw@mail.gmail.com>
 <85eed89f-e4a8-2887-a0b3-579704304357@linux.intel.com>
 <CAP-5=fXj+WT3ExNo-fL4d9b_Wm5swnKaCWd67rU85Q=QFg5KUw@mail.gmail.com>
 <74d36e66-5b16-ee10-bcae-171e2b681845@linux.intel.com>
 <CAP-5=fX+Hqf5xYTCqBXNCz5-ZPaZ7ChNUgoRyH1+JhiAqj79nQ@mail.gmail.com>
 <f020f05e-0e54-cc59-0666-810cf3a4fd14@linux.intel.com>
 <CAM9d7cic6AhJGrNF7wmyowUBpp0mPu8TdiVebL4XXcotFtLUuQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7cic6AhJGrNF7wmyowUBpp0mPu8TdiVebL4XXcotFtLUuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2022 6:58 PM, Namhyung Kim wrote:
> Hi Kan,
> 
> On Thu, Apr 14, 2022 at 12:06 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 4/14/2022 12:09 PM, Ian Rogers wrote:
>>> ```
>>> $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,cycles,cycles}:W'
>>> -a sleep 1
>>>    Performance counter stats for 'system wide':
>>>
>>>        <not counted>      BR_INST_RETIRED.NEAR_CALL
>>>                  (0.00%)
>>>        <not counted>      BR_INST_RETIRED.NEAR_TAKEN
>>>                   (0.00%)
>>>        <not counted>      BR_INST_RETIRED.NOT_TAKEN
>>>                  (0.00%)
>>>        <not counted>      cycles
>>>                  (0.00%)
>>>        <not counted>      cycles
>>>                  (0.00%)
>>>
>>>          1.005599088 seconds time elapsed
>>>
>>> Some events weren't counted. Try disabling the NMI watchdog:
>>>           echo 0 > /proc/sys/kernel/nmi_watchdog
>>>           perf stat ...
>>>           echo 1 > /proc/sys/kernel/nmi_watchdog
>>> The events in group usually have to be from the same PMU. Try
>>> reorganizing the group.
>>> ```
>>>
>>> If we add two extra cycles or the original group is smaller then it is "fixed":
>>> ```
>>> $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,cycles}:W'
>>> -a sleep 1
>>>
>>>    Performance counter stats for 'system wide':
>>>
>>>           20,378,789      BR_INST_RETIRED.NEAR_CALL
>>>          168,420,963      BR_INST_RETIRED.NEAR_TAKEN
>>>           96,330,608      BR_INST_RETIRED.NOT_TAKEN
>>>        1,652,230,042      cycles
>>>
>>>          1.008757590 seconds time elapsed
>>>
>>> $ perf stat -e '{BR_INST_RETIRED.NEAR_CALL,BR_INST_RETIRED.NEAR_TAKEN,BR_INST_RETIRED.NOT_TAKEN,cycles,cycles,cycles}:W'
>>> -a sleep 1
>>>
>>>    Performance counter stats for 'system wide':
>>>
>>>           37,696,638      BR_INST_RETIRED.NEAR_CALL
>>>                  (66.62%)
>>>          298,535,151      BR_INST_RETIRED.NEAR_TAKEN
>>>                   (66.63%)
>>>          297,011,663      BR_INST_RETIRED.NOT_TAKEN
>>>                  (66.63%)
>>>        3,155,711,474      cycles
>>>                  (66.65%)
>>>        3,194,919,959      cycles
>>>                  (66.74%)
>>>        3,126,664,102      cycles
>>>                  (66.72%)
>>>
>>>          1.006237962 seconds time elapsed
>>> ```
>>>
>>> So the extra cycles is needed to fix weak groups when the nmi watchdog
>>> is enabled and the group is an architecture dependent size.
>>
>> Yes, the size of the group depends on the architecture, but perf tool
>> doesn't need to know the HW details. For this case, perf tool just sends
>> the request with an extra cycles event in the group and lets kernel decide.
> 
> I prefer doing this in the kernel even if it'd be incomplete.

I tried a generic way to check all active pinned events from the kernel 
side, but it's rejected.
https://lore.kernel.org/lkml/1565977750-76693-1-git-send-email-kan.liang@linux.intel.com/

> For the NMI watchdog, is it possible to check if it's enabled
> at the moment, and set the fake_cpuc->idxmsk to prevent
> scheduling events in validate_group()?

I think it's possible to check the status of the NMI watchdog via 
nmi_watchdog_user_enabled. But I don't think we can simply change the 
fake_cpuc->idxmsk. Because the fake_cpuc->event_constraint points to the 
shared static event_constraint value, which should not be modified. What 
we can do is to apply the dynamic constraint flag for all the events. 
The kernel will create a copy of the constraint for each event. We can 
change the idxmsk of the copy.

No matter how we update the idxmsk. The critical path 
x86_schedule_events() has to be modified, which may slightly impact the 
performance I guess. Not sure whether it worth.

Another benefit to implement the fix in the perf tool is that the fix 
can be easily deployed on the stable env. It's much easier to upgrade 
the perf tool than the kernel, right?

Thanks,
Kan
