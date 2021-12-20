Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB8047B128
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbhLTQew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:34:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:33476 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhLTQev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:34:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240439889"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="240439889"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 08:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="507748865"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 20 Dec 2021 08:34:50 -0800
Received: from [10.212.163.213] (kliang2-MOBL.ccr.corp.intel.com [10.212.163.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4CEA9580684;
        Mon, 20 Dec 2021 08:34:49 -0800 (PST)
Message-ID: <eb0fc722-5de6-04be-8440-5df6a8236847@linux.intel.com>
Date:   Mon, 20 Dec 2021 11:34:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        zhengjun.xing@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
 <Yb09t/AAFexaGE+j@kernel.org>
 <d596837e-e3f1-33ed-b17e-d420bfcf3bd1@huawei.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <d596837e-e3f1-33ed-b17e-d420bfcf3bd1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/2021 3:38 AM, John Garry wrote:
> On 18/12/2021 01:47, Arnaldo Carvalho de Melo wrote:
>>> Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu 
>>> type")
>>> changed the list for uncore PMUs, such that duplicate aliases are now
>>> listed per PMU (which they should not be), like:
>>>
>>> ./perf list
>>> ...
>>> unc_cbo_cache_lookup.any_es
>>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>>> line in E or S-state]
>>> unc_cbo_cache_lookup.any_es
>>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>>> line in E or S-state]
>>> unc_cbo_cache_lookup.any_i
>>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>>> line in I-state]
>>> unc_cbo_cache_lookup.any_i
>>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>>> line in I-state]
>>> ...
>>>
>>> Notice how the events are listed twice.
>> Hi Jin,
>>
>>     Can I have your acked-by/tested-by?
> 
> Hi Arnaldo,
> 
> I assume that address is bouncing for you also.
> 

Yes, Jin Yao has left Intel.

> So if anyone else has one of these hybrid PMU x86 systems then it would 
> be appreciated to check this change.
> 

+ Zhengjun

Zhengjun,

Could you please help to verify the change?

Thanks,
Kan
