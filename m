Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E3958C60D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbiHHKGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiHHKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:06:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB646E009
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:06:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v2so3300165lfi.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i5CM5vTANkWYiuVPrpKGDAGTjskrOOxTqLINLMvEnvA=;
        b=rdaElLrzlrMWj+6z961QZ8ntxB1VAFEOT1sqi1SAUGM7d/Rj6+ZZIxHnwJSre89KFJ
         V++TGVkK21IFVtZsY5XVRj3FYol8ZAEaTLf9MQsCFIpZl5K9TlsvSIfB281G40wDtP9S
         4hE+JGGQbXlfhyepOGG7DS/zBZg8eTdVOJGVhqqKygx6oRydVhviVCRksPt4q+ry+nz0
         nNDnjXMb+QfeeUq33jeCshr0L0+ftD8SLtCs8tM4wIeJAgcFksLp1fVi7dJu6KWgtv1j
         nTRA0L6r4cso7sTGT1yDu3/0sNJ/ZYYMild6C+oaSrEhM2DwdJJLahQUw/wI3iOt24aJ
         qNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i5CM5vTANkWYiuVPrpKGDAGTjskrOOxTqLINLMvEnvA=;
        b=uCVT8S4WvQRaJXbUfkIyeAHym2m8KiSDkDXfX0QViAPhfc+NzBEOpCjI46S5qcJ8zv
         JRyEMvvLPn8i20C1mDQ8CRVQ2gJPJ0GKN8s5cJo/jIhhrfAkhVD1anyCLEbXOWBeh0kC
         /n5BbiXZY6rFPmuSndVuvvhexxLtqs2Pjswot4L7gP1yqtMmxg0Hvco8CRVoW+ZrGpBh
         cgh8/8amBvf1/3cpUQKX9FpZX7D0/EVZsJGbxn/GbDkHjnWEE+rRDM3Zg4FlFihEgB1R
         g5VeIm1k52oBiDXyJWudCT3gdAn3T2LuUtCdiy6S6bzSHD7+uGQ6MByop57QOmXzU3/A
         hDLQ==
X-Gm-Message-State: ACgBeo3AZym9OwDQxVovP12svTvJZvDHljbWh1WDJJrdnE+g8LHPFhBj
        jvKq57+uig59rL9SFP38Dk5QOd0i3mKGXTyp
X-Google-Smtp-Source: AA6agR42D/nJAamUWrc//5iNXrvklhtjoybNhJP/Kuae4VXN7r5KYphyAYBc5JByHCsxg2oxRYWgyQ==
X-Received: by 2002:ac2:4209:0:b0:48a:7386:978f with SMTP id y9-20020ac24209000000b0048a7386978fmr6095048lfh.521.1659953172001;
        Mon, 08 Aug 2022 03:06:12 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id 5-20020a2e1645000000b0025d47a29734sm1303877ljw.47.2022.08.08.03.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 03:06:11 -0700 (PDT)
Message-ID: <e4dbc605-e998-dbca-b9bc-322783578564@linaro.org>
Date:   Mon, 8 Aug 2022 13:06:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 13/28] mfd: sec: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
References: <20220807145247.46107-1-paul@crapouillou.net>
 <20220807145247.46107-14-paul@crapouillou.net>
 <a625a1b4-6ecd-79d9-3d13-f42fd5b8275c@linaro.org>
 <ACIAGR.7NVZ6UO1UX632@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ACIAGR.7NVZ6UO1UX632@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 12:28, Paul Cercueil wrote:
> Hi Krzysztof,
> 
> Le lun., août 8 2022 at 12:11:02 +0300, Krzysztof Kozlowski 
> <krzysztof.kozlowski@linaro.org> a écrit :
>> On 07/08/2022 17:52, Paul Cercueil wrote:
>>>  Use the new DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() macros
>>>  to handle the .suspend/.resume callbacks.
>>>
>>>  These macros allow the suspend and resume functions to be 
>>> automatically
>>>  dropped by the compiler when CONFIG_SUSPEND is disabled, without 
>>> having
>>>  to use #ifdef guards.
>>>
>>>  The advantage is then that these functions are now always compiled
>>>  independently of any Kconfig option, and thanks to that bugs and
>>>  regressions are easier to catch.
>>>
>>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>>  Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>  Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>
>> The address does not work. Please don't add it to commit log.
> 
> That's what get-maintainers gave me, and I didn't get any error sending 
> at that address. 

I know, I was bugging Bartlomiej and other Samsung folks to fix it and
we reached some kind of conclusion but it never resulted in a patch.

> But I'll take your word.
> 
>>>  Cc: linux-samsung-soc@vger.kernel.org
>>
>> This is also not really needed in commit log... it's just a mailing 
>> list...
>>
>> I actually never understood why people want to add to commit log, so 
>> to
>> something which will last 10 years, Cc-ing other folks, instead of
>> adding such tags after '---'. Imagine 10 years from now:
>>
>> 1. What's the point to be cced on this patch after 10 years instead of
>> using maintainers file (the one in 10 years)? Why Cc-ing me in 10 
>> years?
>> If I am a maintainer of this driver in that time, I will be C-ced 
>> based
>> on maintainers file. If I am not a maintainer in 10 years, why the 
>> heck
>> cc-ing me based on some 10-year old commit? Just because I was a
>> maintainer once, like 10 years ago?
>>
>> 2. Or why cc-ing such people when backporting to stable?
>>
>> It's quite a lot of unnecessary emails which many of us won't actually
>> handle later...
>>
>> I sincerely admit I was once also adding such Cc-tags. But that time 
>> my
>> employer was counting lines-of-patch (including commit log)... crazy, 
>> right?
> 
> Yeah, well, I can add these tags after the '---' line. Nobody ever told 
> me that I was doing it wrong, and I see Cc: tags quite often in commit 
> messages, so I thought it was common practice.

It indeed is a practice, which I do not understand. :) My complaining
about it was just complaining, not as a feedback required to change.

> 
>>>  ---
>>>   drivers/mfd/sec-core.c | 7 +++----
>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>>
>>>  diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
>>>  index 1fb29c45f5cf..a467de2b2fea 100644
>>>  --- a/drivers/mfd/sec-core.c
>>>  +++ b/drivers/mfd/sec-core.c
>>>  @@ -455,7 +455,6 @@ static void sec_pmic_shutdown(struct i2c_client 
>>> *i2c)
>>>   	regmap_update_bits(sec_pmic->regmap_pmic, reg, mask, 0);
>>>   }
>>>
>>>  -#ifdef CONFIG_PM_SLEEP
>>>   static int sec_pmic_suspend(struct device *dev)
>>
>> Did you test W=1 with !CONFIG_PM_SLEEP? No warnings?
> 
> I tested the PR with !CONFIG_PM_SLEEP, correct. sec-core.o compiles 
> fine. No warnings with W=1.

Ah, I see now. _DEFINE_DEV_PM_OPS uses __maybe_unused for such case.

Looks fine then. With dropped Bartlomiej Cc:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
