Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7817458CA0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbiHHOBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243257AbiHHOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:00:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D332BC8F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:00:37 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278DkCCd007927;
        Mon, 8 Aug 2022 09:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=BPqucitPbiJgZkyr8KSKxpuC4Rbx+/uKoOV9owYN5OY=;
 b=coN/fmQ8jmUK4p4o98xJwVTy6mNQ/QwYWfoSs79Uff2KgW71Ofl176bQBhAQTrXid1Zi
 OGJGsp2OuB3TFjSZhmZYAN0Zu+JeuYGf9FGxDJ6tCJADzEMeL0ssh02sqHEdprZRzaY2
 NdEbeD69XhFDqk/dg12mV13VCXSRV+qW4Rsj315rKd/Hdb3Ma7hENAkM6AdoxBMXXkR9
 yeXPmXwAfEbAIh2LfljBZOY0EdcvMZXwjYVARUleT+xQbb97BCnCqB7z5UvpERhM1oKq
 rcOaw0mUambAp7VcsY/UuwzglFJ0wzH6UU/MpFODoy5HWsOCVQSRLFZY3iTzSf4ZL+9Q ow== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hsnq1t2qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:00:25 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 8 Aug 2022
 09:00:23 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Mon, 8 Aug 2022 09:00:23 -0500
Received: from [198.90.251.95] (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 58FAB476;
        Mon,  8 Aug 2022 14:00:23 +0000 (UTC)
Message-ID: <a27df713-31e6-a0d5-7004-80f3f7d952e6@opensource.cirrus.com>
Date:   Mon, 8 Aug 2022 15:00:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 20/28] mfd: arizona: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-21-paul@crapouillou.net>
 <94394206-a018-27b0-5a21-97976fc4a3bc@opensource.cirrus.com>
 <T2KAGR.KY35O6CZFRQ83@crapouillou.net>
 <2c5c063b-da58-1f6f-5422-1ada3dabb90a@opensource.cirrus.com>
 <ANMAGR.U803VAFDNZVL@crapouillou.net>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <ANMAGR.U803VAFDNZVL@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -WbGJoeJFvGJsFuxoZuvvUdJ8Ym1Ktli
X-Proofpoint-GUID: -WbGJoeJFvGJsFuxoZuvvUdJ8Ym1Ktli
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 12:01, Paul Cercueil wrote:
> 
> 
> Le lun., août 8 2022 at 11:43:31 +0100, Richard Fitzgerald 
> <rf@opensource.cirrus.com> a écrit :
>> On 08/08/2022 11:06, Paul Cercueil wrote:
>>> Hi Richard,
>>>
>>> Le lun., août 8 2022 at 10:53:54 +0100, Richard Fitzgerald 
>>> <rf@opensource.cirrus.com> a écrit :
>>>> On 07/08/2022 15:52, Paul Cercueil wrote:
>>>>> Only export the arizona_pm_ops if CONFIG_PM is set, but leave the
>>>>> suspend/resume functions (and related code) outside #ifdef guards.
>>>>>
>>>>> If CONFIG_PM is not set, the arizona_pm_ops will be defined as
>>>>> "static __maybe_unused", and the structure plus all the callbacks will
>>>>> be automatically dropped by the compiler.
>>>>>
>>>>> The advantage is then that these functions are now always compiled
>>>>> independently of any Kconfig option, and thanks to that bugs and
>>>>> regressions are easier to catch.
>>>>>
>>>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>>> Cc: patches@opensource.cirrus.com
>>>>> ---
>>>>>   drivers/mfd/arizona-core.c | 21 +++++++++++----------
>>>>>   drivers/mfd/arizona-i2c.c  |  2 +-
>>>>>   drivers/mfd/arizona-spi.c  |  2 +-
>>>>>   3 files changed, 13 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
>>>>> index cbf1dd90b70d..c1acc9521f83 100644
>>>>> --- a/drivers/mfd/arizona-core.c
>>>>> +++ b/drivers/mfd/arizona-core.c
>>>>> @@ -480,7 +480,6 @@ static int 
>>>>> wm5102_clear_write_sequencer(struct arizona *arizona)
>>>>>       return 0;
>>>>>   }
>>>>>   -#ifdef CONFIG_PM
>>>>>   static int arizona_isolate_dcvdd(struct arizona *arizona)
>>>>
>>>> __maybe_unused?
>>>
>>> No need. The symbols are always referenced.
>>>
>>>>>   {
>>>>>       int ret;
>>>>> @@ -742,9 +741,7 @@ static int arizona_runtime_suspend(struct 
>>>>> device *dev)
>>>>
>>>> __maybe_unused?
>>>>
>>>>>         return 0;
>>>>>   }
>>>>> -#endif
>>>>>   -#ifdef CONFIG_PM_SLEEP
>>>>>   static int arizona_suspend(struct device *dev)
>>>>
>>>> __maybe_unused?
>>>>
>>>>>   {
>>>>>       struct arizona *arizona = dev_get_drvdata(dev);
>>>>> @@ -784,17 +781,21 @@ static int arizona_resume(struct device *dev)
>>>>
>>>> __maybe_unused?
>>>>
>>>>>         return 0;
>>>>>   }
>>>>> -#endif
>>>>>   +#ifndef CONFIG_PM
>>>>> +static __maybe_unused
>>>>> +#endif
>>>>
>>>> No need to ifdef a __maybe_unused.
>>>
>>> Yes, it is needed, because the symbol is conditionally exported. If
>>
>> Why conditionally export it?
>>
>>> !CONFIG_PM, we want the compiler to discard the dev_pm_ops
>>  and all the
>>> callbacks, hence the "static __maybe_unused". That's the same trick 
>>> used > in _EXPORT_DEV_PM_OPS().
>>>
>>> (note that this patch is broken as it does not change the struct 
>>> name, in the !PM case, which causes conflicts with the .h. I'll fix 
>>> in v2)
>>>
>>>>>   const struct dev_pm_ops arizona_pm_ops = {
>>>>> -    SET_RUNTIME_PM_OPS(arizona_runtime_suspend,
>>>>> -               arizona_runtime_resume,
>>>>> -               NULL)
>>>>> -    SET_SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
>>>>> -    SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
>>>>> -                      arizona_resume_noirq)
>>>>> +    RUNTIME_PM_OPS(arizona_runtime_suspend,
>>>>> +               arizona_runtime_resume,
>>>>> +               NULL)
>>>>> +    SYSTEM_SLEEP_PM_OPS(arizona_suspend, arizona_resume)
>>>>> +    NOIRQ_SYSTEM_SLEEP_PM_OPS(arizona_suspend_noirq,
>>>>> +                  arizona_resume_noirq)
>>>>>   };
>>>>> +#ifdef CONFIG_PM
>>>>>   EXPORT_SYMBOL_GPL(arizona_pm_ops);
>>>>> +#endif
>>>>
>>>> This ifdeffing is ugly. Why must the structure only be exported if
>>>> CONFIG_PM is set?
>>>
>>> So that all the PM code is garbage-collected by the compiler if 
>>> !CONFIG_PM.
>>
>> The functions will be dropped if they are not referenced. That doesn't
>> answer why the struct must not be exported.
>>
>> What is the aim of omitting the struct export?
> 
> The functions are always referenced by the dev_pm_ops structure. 
> Omitting the struct export means that the struct can now be a "static 
> __maybe_unused" symbol in the !CONFIG_PM case, and everything related to 
> PM will be automatically removed by the compiler.
> 
> Otherwise, the symbol is exported as usual. The symbol being 
> conditionally exported is not a problem - the struct is always 
> referenced (as it should be) using the pm_sleep_ptr() or pm_ptr() macros.
> 
> This is basically what EXPORT_SIMPLE_DEV_PM_OPS() does by the way.
> 
> Cheers,
> -Paul
> 
Ok,
Well ultimately it's up to Lee as the maintainer of the MFD subsystem.

But the open-coded #ifdef around "static __maybe_unused" is ugly, so if
this is going to be a common pattern a new macro would be nice.

>>>
>>> Ideally I would use something like EXPORT_SIMPLE_DEV_PM_OPS() which 
>>> would make the patch much cleaner, but it doesn't support noirq 
>>> callbacks - and that's why I suggested in the cover letter that 
>>> maybe a new PM macro can be added if this patch is deemed too messy.
>>>
>>> Cheers,
>>> -Paul
>>>
>>>>>     #ifdef CONFIG_OF
>>>>>   static int arizona_of_get_core_pdata(struct arizona *arizona)
>>>>> diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
>>>>> index 6d83e6b9a692..8799d9183bee 100644
>>>>> --- a/drivers/mfd/arizona-i2c.c
>>>>> +++ b/drivers/mfd/arizona-i2c.c
>>>>> @@ -119,7 +119,7 @@ static const struct of_device_id 
>>>>> arizona_i2c_of_match[] = {
>>>>>   static struct i2c_driver arizona_i2c_driver = {
>>>>>       .driver = {
>>>>>           .name    = "arizona",
>>>>> -        .pm    = &arizona_pm_ops,
>>>>> +        .pm    = pm_ptr(&arizona_pm_ops),
>>>>>           .of_match_table    = of_match_ptr(arizona_i2c_of_match),
>>>>>       },
>>>>>       .probe        = arizona_i2c_probe,
>>>>> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
>>>>> index 941b0267d09d..da05b966d48c 100644
>>>>> --- a/drivers/mfd/arizona-spi.c
>>>>> +++ b/drivers/mfd/arizona-spi.c
>>>>> @@ -282,7 +282,7 @@ static const struct of_device_id 
>>>>> arizona_spi_of_match[] = {
>>>>>   static struct spi_driver arizona_spi_driver = {
>>>>>       .driver = {
>>>>>           .name    = "arizona",
>>>>> -        .pm    = &arizona_pm_ops,
>>>>> +        .pm    = pm_ptr(&arizona_pm_ops),
>>>>>           .of_match_table    = of_match_ptr(arizona_spi_of_match),
>>>>>           .acpi_match_table = ACPI_PTR(arizona_acpi_match),
>>>>>       },
>>>
>>>
> 
> 
