Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B319D4CBA5E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiCCJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiCCJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:35:20 -0500
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FBF403C2;
        Thu,  3 Mar 2022 01:34:35 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id qx21so9258426ejb.13;
        Thu, 03 Mar 2022 01:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HCoJ2YMwz0q/SwgLBzV0H3UA+rYOKmWN8IjDCigSeO8=;
        b=QeWlJjedoR2qFQBUOh4pkhzui5u5PKxnKQUs5zyRaF5mTqLJkKjx2lJcSdTp4D4V/d
         NweQl12MrRSaJTviT4Nmzvr5hRPl6ZIoyJ5SWf1ZE/BVbnVyp5EY9W/FYSxw+W67ms0x
         3Tc/EJHGU2v4Cfz954oAjvXSxchWOfWf70Yc/3EA91lFIKkXZeZMphk4JY7MjyCXDKRL
         0GwdW3UkK7fcWvnmMBXR1iEnbhtTe7j210IQtL0LlpIL6x8qJNT8N10IoPqGkT4aFbYF
         DSOqePZ20AIdQZiziy1VaHD9bE3lPjaauePg+l2qGeZG6SbHfAPvq71EfaPt2CslijLi
         bodA==
X-Gm-Message-State: AOAM5339lsRSqgv6ri2nmuqHXf6oMYGuzKCYahmDQa6va9QSG0FcJTmU
        7HWgYiyml/fTml07yJ6lJqY1biMyFVU=
X-Google-Smtp-Source: ABdhPJyj7IPoYYr6U2OkzEEq2Jm0KvkKkWEb0ABY+xk3BFll3PIddVhRcde7e62zhWwEa+oWwrxWsA==
X-Received: by 2002:a17:906:402:b0:6d5:c6bc:3150 with SMTP id d2-20020a170906040200b006d5c6bc3150mr26995549eja.403.1646300073839;
        Thu, 03 Mar 2022 01:34:33 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id f6-20020a50fc86000000b0040f614e0906sm615639edq.46.2022.03.03.01.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 01:34:32 -0800 (PST)
Message-ID: <fd39f73e-8317-38c4-6002-8defd784caec@kernel.org>
Date:   Thu, 3 Mar 2022 10:34:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Content-Language: en-US
To:     =?UTF-8?B?RWR3aW4gQ2hpdSDpgrHlnoLls7A=?= <edwin.chiu@sunplus.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
 <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
 <394261d1-f1df-e80d-3591-10f2d649e731@kernel.org>
 <bcc7a0b58aad4f0989d7d86eaee2c746@sphcmbx02.sunplus.com.tw>
 <748eb0e1-684c-a772-bccd-64b80780192f@kernel.org>
 <fda1e55e576b4cdf9ab412529a3dfc7b@sphcmbx02.sunplus.com.tw>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <fda1e55e576b4cdf9ab412529a3dfc7b@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 10:01, Edwin Chiu 邱垂峰 wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Tuesday, March 1, 2022 7:34 PM
>> To: Edwin Chiu 邱垂峰 <edwin.chiu@sunplus.com>; Edwin Chiu <edwinchiu0505tw@gmail.com>;
>> robh+dt@kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel.org;
>> daniel.lezcano@linaro.org; linux-pm@vger.kernel.org
>> Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus sp7021
>>
>> On 01/03/2022 10:30, Edwin Chiu 邱垂峰 wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Sent: Tuesday, February 22, 2022 12:48 AM
>>>> To: Edwin Chiu <edwinchiu0505tw@gmail.com>; Edwin Chiu 邱垂峰
>>>> <edwin.chiu@sunplus.com>;
>>>> robh+dt@kernel.org; devicetree@vger.kernel.org;
>>>> robh+linux-kernel@vger.kernel.org; rafael@kernel.org;
>>>> daniel.lezcano@linaro.org; linux-pm@vger.kernel.org
>>>> Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for
>>>> sunplus sp7021
>>>>
>>>> On 21/02/2022 08:26, Edwin Chiu wrote:
>>>>> Create cpuidle driver for sunplus sp7021 chip
>>>>>
>>>>> Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
>>>>> ---
>>>>> Changes in v3
>>>>>  - Rearrangement #include sequence
>>>>>  - Change remark style to /*~*/
>>>>>  - Align author email address to same as sob
>>>>>  - Optimal code
>>>>> Changes in v4
>>>>>  - According Rob Herringrobh's comment
>>>>>    There is no need for this binding.
>>>>>    Just wanting a different driver is not a reason
>>>>>    for a duplicate schema.
>>>>>    So remove yaml file and submit driver again.
>>>>> Changes in v5
>>>>>  - According Krzysztof's comment
>>>>>    You either use appropriate compatible in DT
>>>>>    or add your compatible to cpuidle-arm.
>>>>>    Even if this did not work, then the solution is to
>>>>>    use common parts, not to duplicate entire driver.
>>>>>    According Sudeep's comment
>>>>>    In short NACK for any dedicated driver for this platform,
>>>>>    use the generic cpuidle-arm driver with appropriate platform hooks
>>>>>    Create cpuidle-sunplus.c in arch/arm/mach-sunplus/
>>>>>    for hook generic cpuidle-arm driver
>>>>>
>>>>>  MAINTAINERS                                   |  6 ++
>>>>>  arch/arm/mach-sunplus/cpuidle-sunplus.c       | 88 +++++++++++++++++
>>>>>  include/linux/platform_data/cpuidle-sunplus.h | 12 ++++
>>>>>  3 files changed, 106 insertions(+)
>>>>>  create mode 100644 arch/arm/mach-sunplus/cpuidle-sunplus.c
>>>>>  create mode 100644 include/linux/platform_data/cpuidle-sunplus.h
>>>>>
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS index e0dca8f..5c96428 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -18252,6 +18252,12 @@ L:	netdev@vger.kernel.org
>>>>>  S:	Maintained
>>>>>  F:	drivers/net/ethernet/dlink/sundance.c
>>>>>
>>>>> +SUNPLUS CPUIDLE DRIVER
>>>>> +M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
>>>>> +S:	Maintained
>>>>> +F:	arch/arm/mach-sunplus/cpuidle-sunplus.c
>>>>> +F:	include/linux/platform_data/cpuidle-sunplus.h
>>>>> +
>>>>>  SUPERH
>>>>>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>>>>>  M:	Rich Felker <dalias@libc.org>
>>>>> diff --git a/arch/arm/mach-sunplus/cpuidle-sunplus.c
>>>>> b/arch/arm/mach-sunplus/cpuidle-sunplus.c
>>>>> new file mode 100644
>>>>> index 0000000..e9d9738
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/mach-sunplus/cpuidle-sunplus.c
>>>>> @@ -0,0 +1,88 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>> +/*
>>>>> + * SP7021 cpu idle Driver.
>>>>> + * Copyright (C) Sunplus Tech / Tibbo Tech.
>>>>> + */
>>>>> +#define pr_fmt(fmt) "CPUidle arm: " fmt
>>>>> +
>>>>> +#include <linux/cpuidle.h>
>>>>> +#include <linux/of_device.h>
>>>>> +#include <linux/platform_data/cpuidle-sunplus.h>
>>>>> +
>>>>> +#include <asm/cpuidle.h>
>>>>> +
>>>>> +typedef int (*idle_fn)(void);
>>>>> +
>>>>> +static DEFINE_PER_CPU(idle_fn*, sp7021_idle_ops);
>>>>> +
>>>>> +static int sp7021_cpuidle_enter(unsigned long index) {
>>>>> +	return __this_cpu_read(sp7021_idle_ops)[index]();
>>>>> +}
>>>>> +static int sp7021_cpu_spc(void)
>>>>> +{
>>>>> +	cpu_v7_do_idle();   /* idle to WFI */
>>>>> +	return 0;
>>>>> +}
>>>>> +static const struct of_device_id sp7021_idle_state_match[] = {
>>>>> +	{ .compatible = "arm,idle-state", .data = sp7021_cpu_spc },
>>>>> +	{ },
>>>>> +};
>>>>
>>>> This is confusing. You want to have two drivers to bind to the same
>>>> compatible? As I wrote in the previous messages, you should simply use arm,idle-state just like few
>> other architectures.
>>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>>
>>> The patch v5 implemented according your comment.
>>> Used common part of arm,idle-state.
>>> Create new enable-method for cpuidle.ops function.
>>> It only have arm cpuidle driver exist now, no two drivers to bind to the same compatible.
>>>
>>> What do you mean " simply use arm,idle-state just like few other architectures "?
>>>
>>
>> I mean, do it similarly (by using arm,idle-state and other related
>> properties) to for example ti,am4372/ti,am3352.
>>
>> Best regards,
>> Krzysztof
> 
> 
> The am3352 cpuidle code structure is very similar to ours.				
> Used enable-method = "ti,am3352" and compatible = "arm,idle-state" in am33xx.dtsi				
> Used CPUIDLE_METHOD_OF_DECLARE(pm33xx_idle, "ti,am3352", &amx3_cpuidle_ops) in pm33xx-core.c				
> 				
> The difference are				
> am3352				
> amx3_idle_init(~) assign idle_states[i].wfi_flags = states[i].wfi_flags;				
> amx3_idle_enter(~) call idle_fn(idle_state->wfi_flags)				
> 				
> sunplus-sp7021				
> sp7021_cpuidle_init(~) assign fns[i] = idle_fns[i];				
> sp7021_cpuidle_enter(~) call __this_cpu_read(sp7021_idle_ops)[index]();				
> 
> I don't think am3352 cpuidle code architecture simpler than ours.
> The idle_fn function need more complex method to be assign.
> How do you think?

You duplicated a driver, entire pieces of code. This is not acceptable.
Therefore it does not really make sense to discuss whether duplicated
solution seems simpler or not... We won't accept duplicated code.
Especially for WFI-only driver.

Best regards,
Krzysztof
