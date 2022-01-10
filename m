Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A66489DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiAJRAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:00:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4379 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237327AbiAJRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:00:46 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JXg4T0Zxhz67x8s;
        Tue, 11 Jan 2022 00:58:01 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 18:00:44 +0100
Received: from [10.47.24.251] (10.47.24.251) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 10 Jan
 2022 17:00:43 +0000
Subject: Re: [PATCH v4 01/48] libperf: Add comments to perf_cpu_map.
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
        <linux-arm-kernel@lists.infradead.org>, <zhengjun.xing@intel.com>
CC:     <eranian@google.com>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-2-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <aea97c61-b684-3322-05a2-f55a7877e1b9@huawei.com>
Date:   Mon, 10 Jan 2022 17:00:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220105061351.120843-2-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.251]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2022 06:13, Ian Rogers wrote:
> A particular observed problem is confusing the index with the CPU value,
> documentation should hopefully reduce this type of problem.
> 
> Reviewed-by: James Clark<james.clark@arm.com>
> Signed-off-by: Ian Rogers<irogers@google.com>

Reviewed-by: John Garry <john.garry@huawei.com>
