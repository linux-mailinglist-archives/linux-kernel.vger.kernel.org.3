Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB5447A61E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhLTIjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:39:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4308 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbhLTIjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:39:16 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JHXyf64hxz67dbJ;
        Mon, 20 Dec 2021 16:37:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 09:39:13 +0100
Received: from [10.47.87.38] (10.47.87.38) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 20 Dec
 2021 08:39:12 +0000
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
 <Yb09t/AAFexaGE+j@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d596837e-e3f1-33ed-b17e-d420bfcf3bd1@huawei.com>
Date:   Mon, 20 Dec 2021 08:38:40 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Yb09t/AAFexaGE+j@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.38]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2021 01:47, Arnaldo Carvalho de Melo wrote:
>> Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
>> changed the list for uncore PMUs, such that duplicate aliases are now
>> listed per PMU (which they should not be), like:
>>
>> ./perf list
>> ...
>> unc_cbo_cache_lookup.any_es
>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>> line in E or S-state]
>> unc_cbo_cache_lookup.any_es
>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>> line in E or S-state]
>> unc_cbo_cache_lookup.any_i
>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>> line in I-state]
>> unc_cbo_cache_lookup.any_i
>> [Unit: uncore_cbox L3 Lookup any request that access cache and found
>> line in I-state]
>> ...
>>
>> Notice how the events are listed twice.
> Hi Jin,
> 
> 	Can I have your acked-by/tested-by?

Hi Arnaldo,

I assume that address is bouncing for you also.

So if anyone else has one of these hybrid PMU x86 systems then it would 
be appreciated to check this change.

Thanks!
