Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634BA480D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhL1VA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:00:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4326 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbhL1VAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:00:24 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JNmyh2Yj2z685wS;
        Wed, 29 Dec 2021 04:55:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 22:00:22 +0100
Received: from [10.47.90.53] (10.47.90.53) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 28 Dec
 2021 21:00:21 +0000
Subject: Re: [PATCH v2] perf pmu: Fix alias events list
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <kan.liang@linux.intel.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhengjun.xing@linux.intel.com>
References: <1640103090-140490-1-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <05dcd009-084c-b8ee-c4a5-35c0862ee26d@huawei.com>
Date:   Tue, 28 Dec 2021 21:00:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1640103090-140490-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.53]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2021 16:11, John Garry wrote:
> Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
> changes the event list for uncore PMUs or arm64 heterogeneous CPU systems,
> such that duplicate aliases are incorrectly listed per PMU (which they
> should not be), like:
> 
> ./perf list
> ...
> unc_cbo_cache_lookup.any_es
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in E or S-state]
> unc_cbo_cache_lookup.any_es
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in E or S-state]
> unc_cbo_cache_lookup.any_i
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in I-state]
> unc_cbo_cache_lookup.any_i
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in I-state]
> ...
> 
> Notice how the events are listed twice.


Hi Arnaldo,

Can you kindly consider picking up this change for v5.16?

Thanks!
