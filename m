Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB947591F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbhLOMxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:53:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4284 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhLOMxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:53:40 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDZnR0k02z6H74V;
        Wed, 15 Dec 2021 20:49:15 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 13:53:38 +0100
Received: from [10.47.93.135] (10.47.93.135) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 12:53:37 +0000
From:   John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        Ian Rogers <irogers@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
 <CAP-5=fXJeH0ZvcHPa20N5KfLwnYSw29rpK3OrnvE0o3u-vGTLA@mail.gmail.com>
 <b1640897-10d7-c11e-4a7a-d17633916c8e@huawei.com>
 <d91a1b98-2c2b-a961-543f-d540b3c7a146@arm.com>
Message-ID: <0a14914c-063d-f9ae-be49-ae9cc6aa7ff1@huawei.com>
Date:   Wed, 15 Dec 2021 12:53:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <d91a1b98-2c2b-a961-543f-d540b3c7a146@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.93.135]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> In addition we could also add a --topdown arg to force using JSON 
>> metricgroups.
>>
> 
> What arg do think would be supplied?

something like -json or -metricgroup, meaning "Use pmu-events metric 
events to calculate topdown results rather than kernel CPU PMU events. 
This is default fallback if the kernel CPU PMU does not support topdown 
events"

> 
>> Did you actually test this patch? I have something experimental 
>> working from some time ago, and it was more complicated than this. I 
>> need to check the code again...
>>
> 
> I got stats back from this implementation, yes.  Let me know if there's 
> things my patch isn't catering for.

I'll give it a spin...

Thanks,
John
