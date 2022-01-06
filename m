Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4211A4869B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbiAFSYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:24:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4363 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiAFSYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:24:45 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JVF4h2LFQz67bjw;
        Fri,  7 Jan 2022 02:19:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 19:24:43 +0100
Received: from [10.47.27.56] (10.47.27.56) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 6 Jan
 2022 18:24:41 +0000
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
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
 <0a14914c-063d-f9ae-be49-ae9cc6aa7ff1@huawei.com>
 <3e8c7fb6-97aa-f84e-e594-b6eb2cb674e4@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4fefb1bc-49b2-bc5b-23cd-cd8fabe8c588@huawei.com>
Date:   Thu, 6 Jan 2022 18:24:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <3e8c7fb6-97aa-f84e-e594-b6eb2cb674e4@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.27.56]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2022 16:33, Andrew Kilroy wrote:
> 
> Andi requested that the json metrics be disabled on x86 in
> 
> 
> https://lore.kernel.org/linux-perf-users/12e0deef-08db-445f-4958-bcd5c3e10367@linux.intel.com/#t 
> 
> 
> If we do that, do you still think the --topdown=<arg>  modification is 
> needed? 

Probably not. I assumed that the metricgroup solution could work for x86 
also, so now no need for this option.

> I guess it would have to report an error if someone requests 
> --topdown=json-metrics on x86.
> 

Thanks,
John
