Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE06546BAC7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbhLGMRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:17:13 -0500
Received: from foss.arm.com ([217.140.110.172]:58418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236151AbhLGMQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:16:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D3A11FB;
        Tue,  7 Dec 2021 04:13:28 -0800 (PST)
Received: from [10.57.34.196] (unknown [10.57.34.196])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E07FF3F5A1;
        Tue,  7 Dec 2021 04:13:25 -0800 (PST)
Message-ID: <e7aaacd8-7972-6ab9-ff0c-e286bf23993a@arm.com>
Date:   Tue, 7 Dec 2021 12:13:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] perf vendor events: For the Neoverse N2
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211203123525.31127-1-andrew.kilroy@arm.com>
 <2e1a7a96-4ec6-e1f2-5bd4-133480391053@huawei.com>
From:   Andrew Kilroy <andrew.kilroy@arm.com>
In-Reply-To: <2e1a7a96-4ec6-e1f2-5bd4-133480391053@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2021 09:57, John Garry wrote:
> On 03/12/2021 12:35, Andrew Kilroy wrote:
>> Updates the common and microarch json file to add counters
>> available in the Neoverse N2 chip, but should also apply to other ArmV8
>> and ArmV9 cpus.  Specified in ArmV8 architecture reference manual
>>
>>    https://developer.arm.com/documentation/ddi0487/gb/?lang=en
>>
>> Some of the counters added to armv8-common-and-microarch.json are
>> specified in the ArmV9 architecture reference manual supplement
>> (issue A.a):
>>
>>    https://developer.arm.com/documentation/ddi0608/aa
>>
>> The additional ArmV9 counters are
>>
>>    TRB_WRAP
>>    TRCEXTOUT0
>>    TRCEXTOUT1
>>    TRCEXTOUT2
>>    TRCEXTOUT3
>>    CTI_TRIGOUT4
>>    CTI_TRIGOUT5
>>    CTI_TRIGOUT6
>>    CTI_TRIGOUT7
>>
>> This patch also adds files in pmu-events/arch/arm64/arm/neoverse-n2 for
>> perf list to output the counter names in categories.
>>
>> A subsequent patch renames armv8-common-and-microarch.json and
>> armv8-recommended.json to reflect that counters for armv9 are being
>> added.
> 
> This commentary should be in a cover letter. Please do that.
> 
> And did you consider just adding a armv9-common-and-microarch.json and
> armv9-recommended.json instead of adding to and renaming the v8 version?
> I know that it creates scattered definitions, but we already have that in
> dividing the common and the recommended JSONs.
> 

I considered it, but I wasn't sure what was preferable.  I thought I'd 
get some feedback.  Do you consider the separation important?  Any 
particular reason?


> Thanks,
> John

Andrew
