Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA58046D2EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhLHMJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:09:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4230 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhLHMJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:09:43 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8G7c27GDz67b2S;
        Wed,  8 Dec 2021 20:05:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 13:06:09 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 8 Dec
 2021 12:06:08 +0000
Subject: Re: [PATCH 01/22] libperf: Add comments to perf_cpu_map.
To:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Vineet Singh" <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <eranian@google.com>
References: <20211208024607.1784932-1-irogers@google.com>
 <20211208024607.1784932-2-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a3cf5b74-1a1b-ef85-1ad3-034e797848e2@huawei.com>
Date:   Wed, 8 Dec 2021 12:05:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211208024607.1784932-2-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2021 02:45, Ian Rogers wrote:
> diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> index 840d4032587b..1c1726f4a04e 100644
> --- a/tools/lib/perf/include/internal/cpumap.h
> +++ b/tools/lib/perf/include/internal/cpumap.h
> @@ -4,9 +4,16 @@
>   
>   #include <linux/refcount.h>
>   
> +/**
> + * A sized, reference counted, sorted array of integers representing CPU
> + * numbers. This is commonly used to capture which CPUs a PMU is associated
> + * with.
> + */
>   struct perf_cpu_map {
>   	refcount_t	refcnt;
> +	/** Length of the map array. */
>   	int		nr;
> +	/** The CPU values. */
>   	int		map[];

would simply more distinct names for the variables help instead of or in 
addition to comments?

Generally developers don't always check comments where the struct is 
defined when the meaning could be judged intuitively

Thanks,
John

