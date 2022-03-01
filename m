Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414334C8ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiCALen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCALel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:34:41 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00365621C;
        Tue,  1 Mar 2022 03:34:00 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id i11so21548185eda.9;
        Tue, 01 Mar 2022 03:34:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bN9HlQf/NwTO54rjjqUiLXYpe71Rz0PB5yoR/LiS8uw=;
        b=PF5vghQESz1Y37qnrL4LJr4Ss0Cw44MRbLn7ObpGwwLMSNDnFfAPvmFGls5WpJPNGT
         Sfe0emQpg9y2lMDIYTQNMLV2C+GFTGk67/yIPS2LZIFVlrBrXFFrt6ZAD6CyLeFbxp/V
         xFbpMoXfpzZVd2S+9W+mSY2XrqkyddzN5iyX9+HP6mgvKuVG0ElseZFEgyCfeNYIA72A
         oCbR6WZhQwi6JOIz2jwbACLCh+1kGeAHuAjps2Z7WOTu2dS7OhdTLdpk9kyfKu0p5lIS
         FWD0B2hx6Z4izrdAP6SMnsLSC+S74PFeN2Wo7g/EbD3Eog3d5jQIHBLgffFtjuC+HM7r
         Vrhg==
X-Gm-Message-State: AOAM533lkizEuYaaq7Ju+xIUV2i/HIiadoCGr8BX98OR5Hn3lcSbdnjM
        /Jo7pBcz8oGaDdG/X/awbd96aRpU8mo=
X-Google-Smtp-Source: ABdhPJyYkxVmcu5KkuZaTR8i62dfcTWKqlkpeUwLdp4ggobBYY1EzxO9vryMZ/bXpn484fVk1aBwIg==
X-Received: by 2002:a05:6402:354c:b0:412:b2f2:f8e4 with SMTP id f12-20020a056402354c00b00412b2f2f8e4mr24202197edd.269.1646134439052;
        Tue, 01 Mar 2022 03:33:59 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.googlemail.com with ESMTPSA id s6-20020a170906354600b006d6e53cd014sm524344eja.94.2022.03.01.03.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:33:57 -0800 (PST)
Message-ID: <748eb0e1-684c-a772-bccd-64b80780192f@kernel.org>
Date:   Tue, 1 Mar 2022 12:33:56 +0100
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <bcc7a0b58aad4f0989d7d86eaee2c746@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2022 10:30, Edwin Chiu 邱垂峰 wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: Tuesday, February 22, 2022 12:48 AM
>> To: Edwin Chiu <edwinchiu0505tw@gmail.com>; Edwin Chiu 邱垂峰 <edwin.chiu@sunplus.com>;
>> robh+dt@kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; rafael@kernel.org;
>> daniel.lezcano@linaro.org; linux-pm@vger.kernel.org
>> Subject: Re: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus sp7021
>>
>> On 21/02/2022 08:26, Edwin Chiu wrote:
>>> Create cpuidle driver for sunplus sp7021 chip
>>>
>>> Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
>>> ---
>>> Changes in v3
>>>  - Rearrangement #include sequence
>>>  - Change remark style to /*~*/
>>>  - Align author email address to same as sob
>>>  - Optimal code
>>> Changes in v4
>>>  - According Rob Herringrobh's comment
>>>    There is no need for this binding.
>>>    Just wanting a different driver is not a reason
>>>    for a duplicate schema.
>>>    So remove yaml file and submit driver again.
>>> Changes in v5
>>>  - According Krzysztof's comment
>>>    You either use appropriate compatible in DT
>>>    or add your compatible to cpuidle-arm.
>>>    Even if this did not work, then the solution is to
>>>    use common parts, not to duplicate entire driver.
>>>    According Sudeep's comment
>>>    In short NACK for any dedicated driver for this platform,
>>>    use the generic cpuidle-arm driver with appropriate platform hooks
>>>    Create cpuidle-sunplus.c in arch/arm/mach-sunplus/
>>>    for hook generic cpuidle-arm driver
>>>
>>>  MAINTAINERS                                   |  6 ++
>>>  arch/arm/mach-sunplus/cpuidle-sunplus.c       | 88 +++++++++++++++++
>>>  include/linux/platform_data/cpuidle-sunplus.h | 12 ++++
>>>  3 files changed, 106 insertions(+)
>>>  create mode 100644 arch/arm/mach-sunplus/cpuidle-sunplus.c
>>>  create mode 100644 include/linux/platform_data/cpuidle-sunplus.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS index e0dca8f..5c96428 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -18252,6 +18252,12 @@ L:	netdev@vger.kernel.org
>>>  S:	Maintained
>>>  F:	drivers/net/ethernet/dlink/sundance.c
>>>
>>> +SUNPLUS CPUIDLE DRIVER
>>> +M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
>>> +S:	Maintained
>>> +F:	arch/arm/mach-sunplus/cpuidle-sunplus.c
>>> +F:	include/linux/platform_data/cpuidle-sunplus.h
>>> +
>>>  SUPERH
>>>  M:	Yoshinori Sato <ysato@users.sourceforge.jp>
>>>  M:	Rich Felker <dalias@libc.org>
>>> diff --git a/arch/arm/mach-sunplus/cpuidle-sunplus.c
>>> b/arch/arm/mach-sunplus/cpuidle-sunplus.c
>>> new file mode 100644
>>> index 0000000..e9d9738
>>> --- /dev/null
>>> +++ b/arch/arm/mach-sunplus/cpuidle-sunplus.c
>>> @@ -0,0 +1,88 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * SP7021 cpu idle Driver.
>>> + * Copyright (C) Sunplus Tech / Tibbo Tech.
>>> + */
>>> +#define pr_fmt(fmt) "CPUidle arm: " fmt
>>> +
>>> +#include <linux/cpuidle.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_data/cpuidle-sunplus.h>
>>> +
>>> +#include <asm/cpuidle.h>
>>> +
>>> +typedef int (*idle_fn)(void);
>>> +
>>> +static DEFINE_PER_CPU(idle_fn*, sp7021_idle_ops);
>>> +
>>> +static int sp7021_cpuidle_enter(unsigned long index) {
>>> +	return __this_cpu_read(sp7021_idle_ops)[index]();
>>> +}
>>> +static int sp7021_cpu_spc(void)
>>> +{
>>> +	cpu_v7_do_idle();   /* idle to WFI */
>>> +	return 0;
>>> +}
>>> +static const struct of_device_id sp7021_idle_state_match[] = {
>>> +	{ .compatible = "arm,idle-state", .data = sp7021_cpu_spc },
>>> +	{ },
>>> +};
>>
>> This is confusing. You want to have two drivers to bind to the same compatible? As I wrote in the
>> previous messages, you should simply use arm,idle-state just like few other architectures.
>>
>>
>> Best regards,
>> Krzysztof
> 
> 
> The patch v5 implemented according your comment.
> Used common part of arm,idle-state.
> Create new enable-method for cpuidle.ops function.
> It only have arm cpuidle driver exist now, no two drivers to bind to the same compatible.
> 
> What do you mean " simply use arm,idle-state just like few other architectures "?
>

I mean, do it similarly (by using arm,idle-state and other related
properties) to for example ti,am4372/ti,am3352.

Best regards,
Krzysztof
