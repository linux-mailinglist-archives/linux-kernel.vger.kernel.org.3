Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C6147A1D5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 19:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhLSSof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 13:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhLSSod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 13:44:33 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB4C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:44:32 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t19so12550976oij.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lhJNH4R0qDRclkW5BecSZ0DLx+YYqdS6FwDGEaIzbNo=;
        b=DSr0WZNuF6T1ISgtA9ZbBfhpkvupssp+i8YvkuckLD4EWtchMugLkk3oeMOdkruBCN
         T+lbKE2g76wO5X/VVUM7/Oifc+MlD9IZJu/KA+R1ChMH68Yx+yB36hs9HwFBhMtDgBl9
         wk69xTAylhkY0A9PKV2kfSbuyhYqPDrERyYTZ16cnzFemFyMVGXoY/A5r53Vd7qXf+Nm
         bPVz0YbkfEvoNSwc1Oh9QlS43GQCqdlM4fV4SerSAaqBxSjw+bzbaFqn/oIRD6jleC4t
         YkocgtNkGiM/UyBBM34YTa/NiSxE+gpuzm5M2X9ePt20/pa9Ts2Hvq0+xFWaGD32wbsb
         MWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lhJNH4R0qDRclkW5BecSZ0DLx+YYqdS6FwDGEaIzbNo=;
        b=7D3/GR6VaFVwKKK9F542parlUWJkLAyUNzbO+UkDsWdM2GQH1yzhe+Sdm+oIxvOhhy
         oJk6UiW8QVfv8wwXWsznNrrSvm+NvEpntdqg+GuSl8SZFpSHzFv01r5KlMaezaWGLukl
         nbfTl9O7ZJELZ9Z8iOVYpBE0bku6E93yxCdxbztAXU/5LHDCQBd0eQMlMT7/gQeGd+fL
         CSPAv68oDYiGbG9zF6XyLraKymuUlCrX2i/qMbJdILCRHwBNwwGWtFrbdAgDEan3hEPx
         uX47fzQwH0ThpeGTQGQ1hib0qR12nAYmHYtD49Z53Gl65cqbp+RlNlzTobMZRuXBwwUt
         jdzw==
X-Gm-Message-State: AOAM530/hmOPDgJeTAw49TaJuMzktxWVTFpItsFsPeXUZwnAw/4WDOlX
        D9d5U2fgIUzvOvfvcdI+YlMTgA==
X-Google-Smtp-Source: ABdhPJyyEnB0DyheB0df+wNEuDGhRlDZpyO2lJVezRZ0m78iaysJloOhGMui5MiVMBKbWVI8T01IwQ==
X-Received: by 2002:a05:6808:120a:: with SMTP id a10mr1617585oil.160.1639939471877;
        Sun, 19 Dec 2021 10:44:31 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id a5sm2811545otd.74.2021.12.19.10.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 10:44:31 -0800 (PST)
Message-ID: <818ed2a3-47d4-46d6-4bd3-ff2c7ff0192c@kali.org>
Date:   Sun, 19 Dec 2021 12:44:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v5 6/6] qcom/soc/drivers: Add DTPM description for sdm845
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, robh@kernel.org, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-7-daniel.lezcano@linaro.org>
 <aae49bcb-078f-f414-aede-0906c44c030b@kali.org>
 <79f91bbd-aa65-16d9-0fde-1f04c0690477@linaro.org>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <79f91bbd-aa65-16d9-0fde-1f04c0690477@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 12/18/21 2:11 PM, Daniel Lezcano wrote:
> Hi Steev,
>
> thanks for taking the time to test the series.

My C630 is my daily driver and main computer, so I don't mind testing 
things to improve its usage at all.


> <snip>
> Yes, the module is designed to be loaded only. I did not wanted to add
> more complexity in the driver as unloading it is not the priority ATM.
> We need this to be a module in order to load it after the other devices.
Makes sense, I just wasn't entirely sure if it was on purpose or not.
>>> +    depends on DTPM
>>> +    help
>>> +     Describe the hierarchy for the Dynamic Thermal Power
>>> +     Management tree on this platform. That will create all the
>>> +     power capping capable devices.
>>> +
>>>    endmenu
>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>> index 70d5de69fd7b..cf38496c3f61 100644
>>> --- a/drivers/soc/qcom/Makefile
>>> +++ b/drivers/soc/qcom/Makefile
>>> @@ -28,3 +28,4 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>>>    obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>>>    obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>>>    obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=    kryo-l2-accessors.o
>>> +obj-$(CONFIG_QCOM_DTPM) += dtpm.o
> [ ... ]
I noticed this as well, and was going to ask if it shouldn't be named 
qcom_dtpm, but I don't think it matters since it would be in 
/lib/modules/$kver/kernel/drivers/soc/qcom ?
>>> +static struct of_device_id __initdata sdm845_dtpm_match_table[] = {
>>> +        { .compatible = "qcom,sdm845", .data = sdm845_hierarchy },
>>> +        {},
>>> +};
>>> +
>>> +static int __init sdm845_dtpm_init(void)
>>> +{
>>> +    return dtpm_create_hierarchy(sdm845_dtpm_match_table);
>>> +}
>>> +late_initcall(sdm845_dtpm_init);
>>> +
>>> +MODULE_DESCRIPTION("Qualcomm DTPM driver");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_ALIAS("platform:dtpm");
>>> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
>>> +
>> It does seem to work aside from not being able to modprobe -r the
>> module. Although I do see
>>
>> [   35.849622] dtpm: Registered dtpm node 'sdm845' / 0-0 uW,
>> [   35.849652] dtpm: Registered dtpm node 'package' / 0-0 uW,
>> [   35.849676] dtpm: Registered dtpm node 'cpu0-cpufreq' / 40000-436000 uW,
>> [   35.849702] dtpm: Registered dtpm node 'cpu4-cpufreq' /
>> 520000-5828000 uW,
>> [   35.849734] dtpm_devfreq: No energy model available for '5000000.gpu'
>> [   35.849738] dtpm: Failed to setup '/soc@0/gpu@5000000': -22
>>
>> If the devfreq issue with the gpu isn't expected, are we missing
>> something for the c630?
> Yes, the energy model is missing for the GPU, very likely the
> 'dynamic-power-coefficient' property is missing in the gpu section.
>
> A quick test could be to add a value like 800. The resulting power
> numbers will be wrong but it should be possible to act on the
> performance by using these wrong power numbers.
>
>    -- Daniel
>
So, I'm definitely not the greatest of kernel hackers, just enough 
knowledge to be dangerous and I know how to apply patches properly.... 
I'm not able to actually get this working.  I've tried adding it with a 
few different numbers, and any time i try to add the d-p-c, I get

Dec 18 15:00:49 limitless kernel: [   57.394503] adreno 5000000.gpu: EM: 
invalid perf. state: -22
Dec 18 15:00:49 limitless kernel: [   57.394515] dtpm_devfreq: No energy 
model available for '5000000.gpu'
Dec 18 15:00:49 limitless kernel: [   57.394519] dtpm: Failed to setup 
'/soc@0/gpu@5000000': -22

-- steev

