Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3212451F9F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiEIKe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiEIKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:34:34 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1D22A5EB9;
        Mon,  9 May 2022 03:29:44 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g184so9168652pgc.1;
        Mon, 09 May 2022 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TwS3BLFTGGCldPOj2qtqx13iW7It+EgR/QGQVKU6mFs=;
        b=QDHOSjP6pRdjfSA6MR7m2GA9AC4ZqHBbRc5Crqq/8fBnZjt2tSu/vSHF/c321IayGu
         RafA+2BryZWv8Gxuz1ixzW6f0cSYQANaSPQqhvX2lejQgcqrKVSsuB4FMi1D3buY54T9
         aDhh8/XVr287qxtLH2YsQR7vMVIGjDxjpIpA3H0FFC9LI/26szY+hKlX4tA9LUEwOdDR
         qK6sPqMsKHxgUT40ke+se8DmdlTmBLd+sRh0/f0oHF6K2JBSpd8AfH9Bl7imXe0rstDY
         1DHyQL8CfG7sGQSDuHE5V9M9Xh6mc8eU3IybnSn0gZ5O4JRnYfSDq+6vS/mTJ+NfXwaC
         Cf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TwS3BLFTGGCldPOj2qtqx13iW7It+EgR/QGQVKU6mFs=;
        b=uZeC3xQuwHwcFI83xie/UlLNnXzX+/D9pwN+JBqa/t+kIYX0+DUyKSgWbElN+VwmPU
         M6SF8gBlGmvnPaSF7rIEiNWnUTSmEgIt1upQGwt4No5hzcOAbQr+VWHdNngsMD2GJ94U
         7ol4YhH6AI1z74kVrljYmUPsoQiQOX9qZqGg+Ttmwdv5pb3yL6uryg6Kdy2bBMdsv8BQ
         uKDwYNaBBCA7/yeQOA1Gm+3Wdtfo6P/iDVkKiam/Mu8KKZU4duJLGxNKgT3H+M/D0RAv
         sdmedBVe+P7+FvCylrIL7F8xnQLlBZlPvf71hBmiPlo2G7Qu+/ZXnQbkSTSHL1GJftqp
         cIyA==
X-Gm-Message-State: AOAM5303fyw/NDVqhrtDLvciJUWuRH0WCzqQ7r9C6NXjC+opfYI3QZGy
        CtKyGEMot9pGGDA7EZRRZWo=
X-Google-Smtp-Source: ABdhPJwIep48Sp0SysTbaidcp0H14dyixs70fYKkIaiQY3J/GMhK0+xCO7vWSJ0oGiSCq3RACW1qpQ==
X-Received: by 2002:a63:ff0b:0:b0:3c6:b0b:dfee with SMTP id k11-20020a63ff0b000000b003c60b0bdfeemr13094365pgi.346.1652092180848;
        Mon, 09 May 2022 03:29:40 -0700 (PDT)
Received: from [172.30.1.41] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a001a0f00b0050dc76281f1sm8335203pfv.203.2022.05.09.03.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:29:40 -0700 (PDT)
Message-ID: <ad5aa4cb-485f-abf5-87b1-e78b3305a562@gmail.com>
Date:   Mon, 9 May 2022 19:29:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 5/5] PM / devfreq: passive: Update frequency when start
 governor
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, johnson.wang@mediatek.com,
        mka@chromium.org, jia-wei.chang@mediatek.com,
        andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com
References: <20220507150145.531864-1-cw00.choi@samsung.com>
 <20220507150145.531864-6-cw00.choi@samsung.com> <YniX1w+oI1eOCmCx@google.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <YniX1w+oI1eOCmCx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22. 5. 9. 13:25, Chen-Yu Tsai wrote:
> Hi,
> 
> On Sun, May 08, 2022 at 12:01:45AM +0900, Chanwoo Choi wrote:
>> If the parent device changes the their frequency before registering
>> the passive device, the passive device cannot receive the notification
>> from parent device and then the passive device cannot be able to
>> set the proper frequency according to the frequency of parent device.
>>
>> So, when start the passive governor, update the frequency
>> according to the frequency of parent device.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Link: https://lore.kernel.org/r/20220507150145.531864-6-cw00.choi@samsung.com
>> ---
>>   drivers/devfreq/governor_passive.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>> index b34dbe750c0a..74d26c193fdb 100644
>> --- a/drivers/devfreq/governor_passive.c
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -412,6 +412,23 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>>   		if (!p_data->this)
>>   			p_data->this = devfreq;
>>   
>> +		/*
>> +		 * If the parent device changes the their frequency before
>> +		 * registering the passive device, the passive device cannot
>> +		 * receive the notification from parent device and then the
>> +		 * passive device cannot be able to set the proper frequency
>> +		 * according to the frequency of parent device.
>> +		 *
>> +		 * When start the passive governor, update the frequency
>> +		 * according to the frequency of parent device.
>> +		 */
>> +		mutex_lock(&devfreq->lock);
>> +		ret = devfreq_update_target(devfreq, parent->previous_freq);
> 
> This crashes when parent is NULL, in the case where parent is cpufreq.
> This is the case with the MTK ccifreq driver, which produces the panic
> and backtrace below [1].
> 
> I made a fix for a previous version of this patch:
> 
>      https://github.com/wens/linux/commit/f85c1834dd07388abb57a00200c80f7440823a03
> 
> BTW, could you CC me on future revisions? I'm not subscribed to the
> linux-pm mailing list.

OK. I'll.

> 
> 
> Regards
> ChenYu
> 
> [1]
> 
> Unable to handle kernel read from unreadable memory at virtual address 0000000000000420
> Mem abort info:
> ESR = 0x0000000096000005
> EC = 0x25: DABT (current EL), IL = 32 bits
> SET = 0, FnV = 0
> EA = 0, S1PTW = 0
> FSC = 0x05: level 1 translation fault
> Data abort info:
> ISV = 0, ISS = 0x00000005
> CM = 0, WnR = 0
> [0000000000000420] user address but active_mm is swapper
> Internal error: Oops: 96000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc5-next-20220505-09393-g38dc825c1d73 #155 b348fdb8d61a403eef7a9c5857bc02a261fcb213
> Hardware name: Google juniper sku16 board (DT)
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : devfreq_passive_event_handler (drivers/devfreq/governor_passive.c:426)
> lr : devfreq_passive_event_handler (drivers/devfreq/governor_passive.c:426)
> sp : ffffffc00808ba80
> x29: ffffffc00808ba80 x28: 0000000000000000 x27: ffffffe99bb90458
> x26: 0000000000000010 x25: ffffff80c1843848 x24: ffffff80c1843810
> x23: ffffffe99babf3f5 x22: ffffffe99c278190 x21: ffffff80c0924d80
> x20: ffffff80c1843800 x19: 0000000000000000 x18: 0000000000000000
> x17: 0000000065516d0e x16: 00000000fc90660b x15: 0000000000000018
> x14: 0000000000000000 x13: ffffffffff000000 x12: 0000000000000038
> x11: 0101010101010101 x10: 8000000000000000 x9 : ffffffe99acb8458
> x8 : 0065766973000000 x7 : 0000000000000080 x6 : 0000000000000000
> x5 : 8000000000000000 x4 : 0000000000000000 x3 : ffffff80c1843810
> x2 : ffffff80c0228000 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
> devfreq_passive_event_handler (drivers/devfreq/governor_passive.c:426)
> devfreq_add_device (drivers/devfreq/devfreq.c:932)
> devm_devfreq_add_device (drivers/devfreq/devfreq.c:1028)
> mtk_ccifreq_probe (drivers/devfreq/mtk-cci-devfreq.c:366)
> platform_probe (drivers/base/platform.c:1398)
> really_probe (drivers/base/dd.c:542 drivers/base/dd.c:621 drivers/base/dd.c:566)
> __driver_probe_device (drivers/base/dd.c:752)
> driver_probe_device (drivers/base/dd.c:782)
> __driver_attach (drivers/base/dd.c:1143 drivers/base/dd.c:1094)
> bus_for_each_dev (drivers/base/bus.c:301)
> driver_attach (drivers/base/dd.c:1160)
> bus_add_driver (drivers/base/bus.c:619)
> driver_register (drivers/base/driver.c:240)
> __platform_driver_register (drivers/base/platform.c:866)
> mtk_ccifreq_platdrv_init (drivers/devfreq/mtk-cci-devfreq.c:468)
> do_one_initcall (init/main.c:1301)
> kernel_init_freeable (init/main.c:1375 init/main.c:1392 init/main.c:1411 init/main.c:1618)
> kernel_init (init/main.c:1511)
> ret_from_fork (arch/arm64/kernel/entry.S:868)
> Code: f9000eb4 91004298 aa1803e0 940979d4 (f9421261)
> All code
> ========
>     0:	f9000eb4 	str	x20, [x21, #24]
>     4:	91004298 	add	x24, x20, #0x10
>     8:	aa1803e0 	mov	x0, x24
>     c:	940979d4 	bl	0x25e75c
>    10:*	f9421261 	ldr	x1, [x19, #1056]		<-- trapping instruction
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	f9421261 	ldr	x1, [x19, #1056]
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> SMP: stopping secondary CPUs
> Kernel Offset: 0x2992c00000 from 0xffffffc008000000
> PHYS_OFFSET: 0x40000000
> CPU features: 0x000,00324811,00001086
> Memory Limit: none
> PANIC in EL3.
> 
>> +		if (ret < 0)
>> +			dev_warn(&devfreq->dev,
>> +			"failed to update devfreq using passive governor\n");
>> +		mutex_unlock(&devfreq->lock);
>> +
>>   		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
>>   			ret = devfreq_passive_register_notifier(devfreq);
>>   		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
>>
>> -- 
>> 2.25.1
>>

Thanks for the testing. I'll drop the last patch
and then send next version.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
