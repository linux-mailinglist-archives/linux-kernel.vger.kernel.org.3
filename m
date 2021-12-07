Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072AF46B837
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhLGKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:01:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4222 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLGKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:01:30 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J7bLD1gybz67slf;
        Tue,  7 Dec 2021 17:56:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:57:58 +0100
Received: from [10.47.82.161] (10.47.82.161) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 09:57:57 +0000
Subject: Re: [PATCH 1/3] perf vendor events: For the Neoverse N2
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211203123525.31127-1-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2e1a7a96-4ec6-e1f2-5bd4-133480391053@huawei.com>
Date:   Tue, 7 Dec 2021 09:57:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211203123525.31127-1-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.161]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2021 12:35, Andrew Kilroy wrote:
> Updates the common and microarch json file to add counters
> available in the Neoverse N2 chip, but should also apply to other ArmV8
> and ArmV9 cpus.  Specified in ArmV8 architecture reference manual
> 
>    https://developer.arm.com/documentation/ddi0487/gb/?lang=en
> 
> Some of the counters added to armv8-common-and-microarch.json are
> specified in the ArmV9 architecture reference manual supplement
> (issue A.a):
> 
>    https://developer.arm.com/documentation/ddi0608/aa
> 
> The additional ArmV9 counters are
> 
>    TRB_WRAP
>    TRCEXTOUT0
>    TRCEXTOUT1
>    TRCEXTOUT2
>    TRCEXTOUT3
>    CTI_TRIGOUT4
>    CTI_TRIGOUT5
>    CTI_TRIGOUT6
>    CTI_TRIGOUT7
> 
> This patch also adds files in pmu-events/arch/arm64/arm/neoverse-n2 for
> perf list to output the counter names in categories.
> 
> A subsequent patch renames armv8-common-and-microarch.json and
> armv8-recommended.json to reflect that counters for armv9 are being
> added.

This commentary should be in a cover letter. Please do that.

And did you consider just adding a armv9-common-and-microarch.json and
armv9-recommended.json instead of adding to and renaming the v8 version?
I know that it creates scattered definitions, but we already have that in
dividing the common and the recommended JSONs.

Thanks,
John
