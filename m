Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2565746D353
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhLHMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:34:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4231 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhLHMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:34:40 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8Gcs2p5cz685wS;
        Wed,  8 Dec 2021 20:26:53 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 13:31:07 +0100
Received: from [10.47.91.245] (10.47.91.245) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 8 Dec
 2021 12:31:05 +0000
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
 <2e1a7a96-4ec6-e1f2-5bd4-133480391053@huawei.com>
 <e7aaacd8-7972-6ab9-ff0c-e286bf23993a@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e22a2fe2-051f-5395-9118-99617ffcab3d@huawei.com>
Date:   Wed, 8 Dec 2021 12:30:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <e7aaacd8-7972-6ab9-ff0c-e286bf23993a@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.91.245]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2021 12:13, Andrew Kilroy wrote:
> On 07/12/2021 09:57, John Garry wrote:
>> On 03/12/2021 12:35, Andrew Kilroy wrote:
>>> Updates the common and microarch json file to add counters
>>> available in the Neoverse N2 chip, but should also apply to other ArmV8
>>> and ArmV9 cpus.  Specified in ArmV8 architecture reference manual
>>>
>>> https://developer.arm.com/documentation/ddi0487/gb/?lang=en
>>>
>>> Some of the counters added to armv8-common-and-microarch.json are
>>> specified in the ArmV9 architecture reference manual supplement
>>> (issue A.a):
>>>
>>> https://developer.arm.com/documentation/ddi0608/aa
>>>
>>> The additional ArmV9 counters are
>>>
>>>    TRB_WRAP
>>>    TRCEXTOUT0
>>>    TRCEXTOUT1
>>>    TRCEXTOUT2
>>>    TRCEXTOUT3
>>>    CTI_TRIGOUT4
>>>    CTI_TRIGOUT5
>>>    CTI_TRIGOUT6
>>>    CTI_TRIGOUT7
>>>
>>> This patch also adds files in pmu-events/arch/arm64/arm/neoverse-n2 for
>>> perf list to output the counter names in categories.
>>>
>>> A subsequent patch renames armv8-common-and-microarch.json and
>>> armv8-recommended.json to reflect that counters for armv9 are being
>>> added.
>>
>> This commentary should be in a cover letter. Please do that.
>>
>> And did you consider just adding a armv9-common-and-microarch.json and
>> armv9-recommended.json instead of adding to and renaming the v8 version?
>> I know that it creates scattered definitions, but we already have that in
>> dividing the common and the recommended JSONs.
>>
> 
> I considered it, but I wasn't sure what was preferable.  I thought I'd 
> get some feedback.  Do you consider the separation important?  Any 
> particular reason?

At the moment I don't think that it's a big issue. I just thought it 
better to keep a structured and distinct file organisation by having 
separate files. v9 stuff is quite new, so we can wait for other input here.

Thanks,
John
