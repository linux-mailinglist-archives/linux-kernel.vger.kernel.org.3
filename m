Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33824867BF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbiAFQd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:33:59 -0500
Received: from foss.arm.com ([217.140.110.172]:56406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbiAFQd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:33:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A70E1042;
        Thu,  6 Jan 2022 08:33:57 -0800 (PST)
Received: from [10.57.37.41] (unknown [10.57.37.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC33C3F5A1;
        Thu,  6 Jan 2022 08:33:54 -0800 (PST)
Message-ID: <3e8c7fb6-97aa-f84e-e594-b6eb2cb674e4@arm.com>
Date:   Thu, 6 Jan 2022 16:33:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
 <CAP-5=fXJeH0ZvcHPa20N5KfLwnYSw29rpK3OrnvE0o3u-vGTLA@mail.gmail.com>
 <b1640897-10d7-c11e-4a7a-d17633916c8e@huawei.com>
 <d91a1b98-2c2b-a961-543f-d540b3c7a146@arm.com>
 <0a14914c-063d-f9ae-be49-ae9cc6aa7ff1@huawei.com>
From:   Andrew Kilroy <andrew.kilroy@arm.com>
In-Reply-To: <0a14914c-063d-f9ae-be49-ae9cc6aa7ff1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/12/2021 12:53, John Garry wrote:
>>> In addition we could also add a --topdown arg to force using JSON 
>>> metricgroups.
>>>
>>
>> What arg do think would be supplied?
> 
> something like -json or -metricgroup, meaning "Use pmu-events metric 
> events to calculate topdown results rather than kernel CPU PMU events. 
> This is default fallback if the kernel CPU PMU does not support topdown 
> events"
> 

John,

Andi requested that the json metrics be disabled on x86 in

 
https://lore.kernel.org/linux-perf-users/12e0deef-08db-445f-4958-bcd5c3e10367@linux.intel.com/#t

If we do that, do you still think the --topdown=<arg>  modification is 
needed?  I guess it would have to report an error if someone requests 
--topdown=json-metrics on x86.

Thanks,
Andrew

