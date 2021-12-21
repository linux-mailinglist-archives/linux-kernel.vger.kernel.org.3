Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE38447BA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhLUG7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:59:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:57715 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233417AbhLUG7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:59:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="221015349"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="221015349"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 22:59:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="521128571"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.155]) ([10.238.4.155])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 22:59:05 -0800
Message-ID: <c63144a6-efd4-d266-a584-11eb34391569@linux.intel.com>
Date:   Tue, 21 Dec 2021 14:59:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
 <Yb09t/AAFexaGE+j@kernel.org>
 <d596837e-e3f1-33ed-b17e-d420bfcf3bd1@huawei.com>
 <eb0fc722-5de6-04be-8440-5df6a8236847@linux.intel.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <eb0fc722-5de6-04be-8440-5df6a8236847@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/2021 12:34 AM, Liang, Kan wrote:
> 
> 
> On 12/20/2021 3:38 AM, John Garry wrote:
>> On 18/12/2021 01:47, Arnaldo Carvalho de Melo wrote:
>>>> Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu 
>>>> type")
>>>> changed the list for uncore PMUs, such that duplicate aliases are now
>>>> listed per PMU (which they should not be), like:
>>>>
>>>> ./perf list
>>>> ...
>>>> unc_cbo_cache_lookup.any_es
>>>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>>>> line in E or S-state]
>>>> unc_cbo_cache_lookup.any_es
>>>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>>>> line in E or S-state]
>>>> unc_cbo_cache_lookup.any_i
>>>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>>>> line in I-state]
>>>> unc_cbo_cache_lookup.any_i
>>>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>>>> line in I-state]
>>>> ...
>>>>
>>>> Notice how the events are listed twice.
>>> Hi Jin,
>>>
>>>     Can I have your acked-by/tested-by?
>>
>> Hi Arnaldo,
>>
>> I assume that address is bouncing for you also.
>>
> 
> Yes, Jin Yao has left Intel.
> 
>> So if anyone else has one of these hybrid PMU x86 systems then it 
>> would be appreciated to check this change.
>>
> 
> + Zhengjun
> 
> Zhengjun,
> 
> Could you please help to verify the change?
> 
> Thanks,
> Kan

Tested this patch on one hybrid PMU x86 system, it works OK.

Tested-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

-- 
Zhengjun Xing
