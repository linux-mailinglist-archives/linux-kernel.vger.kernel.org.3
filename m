Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3F9523345
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbiEKMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiEKMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:42:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A4173F311;
        Wed, 11 May 2022 05:42:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72402ED1;
        Wed, 11 May 2022 05:42:12 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8555C3F66F;
        Wed, 11 May 2022 05:42:09 -0700 (PDT)
Message-ID: <b0b92bdd-9ebe-8ce9-abe3-1f4d05a838dc@arm.com>
Date:   Wed, 11 May 2022 13:42:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/2] perf: ARM CoreSight PMU support
Content-Language: en-GB
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509092843.GB26264@willie-the-truck>
 <2e5e09f9-b71b-d936-e291-db8f94554b18@arm.com>
 <20220510110742.ievkihggndpms3fn@bogus>
 <20220510111318.GD27557@willie-the-truck>
 <20220510184025.iwgknfqe5ygz4jwn@bogus>
 <SJ0PR12MB5676E68453A977F1220FF7AFA0C89@SJ0PR12MB5676.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SJ0PR12MB5676E68453A977F1220FF7AFA0C89@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-11 02:29, Besar Wicaksono wrote:
> 
> 
>> -----Original Message-----
>> From: Sudeep Holla <sudeep.holla@arm.com>
>> Sent: Tuesday, May 10, 2022 1:40 PM
>> To: Besar Wicaksono <bwicaksono@nvidia.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>; Will Deacon
>> <will@kernel.org>; Sudeep Holla <sudeep.holla@arm.com>;
>> catalin.marinas@arm.com; mark.rutland@arm.com; linux-arm-
>> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>> tegra@vger.kernel.org; thanu.rangarajan@arm.com;
>> Michael.Williams@arm.com; Thierry Reding <treding@nvidia.com>; Jonathan
>> Hunter <jonathanh@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>;
>> Mathieu Poirier <mathieu.poirier@linaro.org>
>> Subject: Re: [PATCH 0/2] perf: ARM CoreSight PMU support
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On Tue, May 10, 2022 at 12:13:19PM +0100, Will Deacon wrote:
>>> On Tue, May 10, 2022 at 12:07:42PM +0100, Sudeep Holla wrote:
>>>> On Mon, May 09, 2022 at 11:02:23AM +0100, Suzuki K Poulose wrote:
>>>>> Cc: Mike Williams, Mathieu Poirier
>>>>> On 09/05/2022 10:28, Will Deacon wrote:
>>>>>> On Sun, May 08, 2022 at 07:28:08PM -0500, Besar Wicaksono wrote:
>>>>>>>    arch/arm64/configs/defconfig                  |    1 +
>>>>>>>    drivers/perf/Kconfig                          |    2 +
>>>>>>>    drivers/perf/Makefile                         |    1 +
>>>>>>>    drivers/perf/coresight_pmu/Kconfig            |   10 +
>>>>>>>    drivers/perf/coresight_pmu/Makefile           |    7 +
>>>>>>>    .../perf/coresight_pmu/arm_coresight_pmu.c    | 1317
>> +++++++++++++++++
>>>>>>>    .../perf/coresight_pmu/arm_coresight_pmu.h    |  147 ++
>>>>>>>    .../coresight_pmu/arm_coresight_pmu_nvidia.c  |  300 ++++
>>>>>>>    .../coresight_pmu/arm_coresight_pmu_nvidia.h  |   17 +
>>>>>>>    9 files changed, 1802 insertions(+)
>>>>>>
>>>>>> How does this interact with all the stuff we have under
>>>>>> drivers/hwtracing/coresight/?
>>>>>
>>>>> Absolutely zero, except for the name. The standard
>>>>> is named "CoreSight PMU" which is a bit unfortunate,
>>>>> given the only link, AFAIU, with the "CoreSight" architecture
>>>>> is the Lock Access Register(LAR). For reference, the
>>>>> drivers/hwtracing/coresight/ is purely "CoreSight" self-hosted
>>>>> tracing and the PMU is called "cs_etm" (expands to coresight etm).
>>>>> Otherwise the standard doesn't have anything to do with what
>>>>> exists already in the kernel.
>>>
>>> That's... a poor naming choice! But good, if it's entirely separate then I
>>> don't have to worry about that. Just wanted to make sure we're not going
>> to
>>> get tangled up in things like ROM tables and Coresight power domains for
>>> these things.
>>>
>>
>> OK, now that triggered another question/thought.
>>
>> 1. Do you need to do active power management for these PMUs ? Or like
>>     CPU PMUs, do you reject entering low power states if there is active
>>     session in progress. If there is active session, runtime PM won't get
>>     triggered but if there is system wide suspend, how is that dealt with ?
>>
> 
> Looking at the other uncore/system PMUs, none of the drivers support PM ops.
> NVIDIA system PMU also does not get power gated and system suspend is not
> supported. But just like other uncore PMU driver, this driver supports CPU hotplug.
> If PM is needed, the required info should have been expressed in ACPI.
> 
>> 2. Assuming you need some sort of PM, and since this is static table(which
>>     I really don't like/prefer but it is out there 🙁), how do you plan to
>>     get the power domain related information.
>>
> 
> I guess the APMT spec in section 2.2 may cover this. If a PMU implementation has
> properties beyond what is defined in the spec, these properties can be described in DSDT.
> The driver doesn’t take care of this currently, so this is a room for future improvement.

Yes, I assume it's essentially the same story as for MPAM MSCs in this 
respect. Plus it means that MSI support will be similarly fun, where 
we'll need to have a corresponding DSDT device via which we can request 
the interrupt, because that needs to further correlate to an IORT Named 
Component node describing the ITS mapping. Hopefully we can abstract 
some of that in the APMT code rather than expose it all to the PMU 
driver...

Robin.
