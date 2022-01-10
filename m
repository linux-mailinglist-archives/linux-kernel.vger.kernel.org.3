Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E81D489EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbiAJRvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:51:54 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4381 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiAJRvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:51:53 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JXhCR3lc3z6GCp4;
        Tue, 11 Jan 2022 01:49:07 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 18:51:50 +0100
Received: from [10.47.24.251] (10.47.24.251) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 10 Jan
 2022 17:51:49 +0000
Subject: Re: [PATCH v4 02/48] perf stat: Add aggr creators that are passed a
 cpu.
To:     Ian Rogers <irogers@google.com>
CC:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Riccardo Mancini" <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vineet Singh <vineet.singh@intel.com>,
        "James Clark" <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhengjun.xing@intel.com>,
        <eranian@google.com>
References: <20220105061351.120843-1-irogers@google.com>
 <20220105061351.120843-3-irogers@google.com>
 <57ab982e-ecc1-3f49-c580-0a251e29698b@huawei.com>
 <CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b2377d2c-e061-fccd-c31d-589cba3ab1b6@huawei.com>
Date:   Mon, 10 Jan 2022 17:51:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com>
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

On 10/01/2022 17:36, Ian Rogers wrote:
> I think you are asking to squash:
> https://lore.kernel.org/lkml/20220105061351.120843-8-irogers@google.com/
> into this change. 

That's the general idea.

 > There are other similar related changes that may
 > also be squashed. The changes are trying to introduce a new API and
 > then add changes to switch over to using it. This is with a view to
 > making bisection easier, have each change only do 1 thing and so on. I
 > believe the format of the patches is house style, but it is fine to
 > squash changes together too. Having sent patches to Arnaldo and having
 > had them split I'm reluctant to do a v5 with them squashed without him
 > expressing a preference.
 >

I don't feel so strongly. But I do think that ability to review should 
take preference to providing simple bisections.

Anyway, I'll stop talking and actually have a look.

Cheers,
John
