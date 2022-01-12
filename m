Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244FF48C976
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355621AbiALRda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:33:30 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4407 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242291AbiALRdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:33:22 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JYvh71ndJz67P77;
        Thu, 13 Jan 2022 01:29:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 12 Jan 2022 18:33:19 +0100
Received: from [10.47.88.157] (10.47.88.157) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 12 Jan
 2022 17:33:18 +0000
Subject: Re: [PATCH v3 1/2] perf test: Workload test of metric and
 metricgroups
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>
References: <20210917184240.2181186-1-irogers@google.com>
 <YU4iVcVc6uYAWft4@kernel.org>
 <158a1451-9d69-d67d-3fad-9e947112f9e6@huawei.com>
 <BD3A5CA5-B566-4FD9-9409-0329CC322060@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e7b20497-e2bb-0c63-3cea-b6f541e2361f@huawei.com>
Date:   Wed, 12 Jan 2022 17:32:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <BD3A5CA5-B566-4FD9-9409-0329CC322060@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.157]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 13:34, Arnaldo Carvalho de Melo wrote:
>>>> v3. Fix test condition (thanks to Paul A. Clarke<pc@us.ibm.com>). Add a
>>>>       fallback case of a larger workload so that we don't ignore "<not
>>>>       counted>".
>>>> v2. Switched the workload to something faster.
>> Hi Ian,
>>
>> I just noticed that this test fails on my broadwell machine.
>>
>> I am using acme perf/core @ 09dd3c22daaf
> Hi,
> 
> Can you try with tmp.perf/perf_cpu instead?
> 
> There's a patch there that maybe fixes this.

Yeah, that (metricgroups) test passes on that branch. I assume it's the 
test script -a change...

Cheers,
john
