Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7647A20D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 21:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhLSU1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 15:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhLSU1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 15:27:36 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9398BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:27:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id c4so15938170wrd.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 12:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ImKwKAtJTa2JOr2xuzluWDkdVVqyTel0wJZ07wbIYbA=;
        b=HpVK6ENa73MHlEhJDRYLhTQmKwqnG3mgMc8ghhRxMDUn4dCNuEGcuJFcsHQOdU0xX/
         ke8z3qwKaMWAw84z0iXUJOS/mrhRGdU1X/WfHQ0kFg+l4E4JyqjN0BIDrC5XoFXiyJG4
         k5+BLwh3qxJuHlzw2lQwUPxcVWi9pO/8pQ4QZTM035VyrsN1G3L81KnTMo9DASs0/GFw
         zgpOyNU5KvUSJEwpXBNiUKnFBaYzD1kTRtKdi19oMU7YIb+JGZ3hj7C8mBLYMLyZpRQ6
         8jbXi4SDNZV51z9YBeZD4xbbMXikk7dwl7agRRDqa+bpTjybXjwkIkv6/jwoOZ4z96vz
         0BQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ImKwKAtJTa2JOr2xuzluWDkdVVqyTel0wJZ07wbIYbA=;
        b=5xvMGfE2LtQA28jUJI/NC1KVCTgx3tVdJkaQvjbBac84rEX9ngxbH7+LYeBwnn5UbC
         qD3lQpTONbGs5JlxjqZ+8ENCLpDAgqAzmwAhNUPzKEVnM0X7Jub8c8EZztv49MoYXkUr
         2Ko0M1Xi/B871bzDIAxTZjGixSpfXxpAidp4DBboGQS8WYTGilPogcTkErYTl6HYkoT9
         +pI+Ad1wQ6zQhvQ9KMxW7gIBToNbl15CHfmACZhQJPrJTPwI5F9HySB6TF9E8wjdkldD
         DCUOx8rcTmTTPB3V/7APLJMV9BhlApqWYQJb/0EOrDzy4ey68hDzaqKF4OhorAbIgNVA
         G2/w==
X-Gm-Message-State: AOAM533f8PdoeZSf3ZGCRD7OZQ1SIbITVX+GCCXr7PoZxEePXS8QDR32
        0+1o3LqcROm7VPTwcfjaAMr0vw==
X-Google-Smtp-Source: ABdhPJwxpVXU+Y/j2S++Pov+VyZ1FliIpqI9/hEEJ8es8f76ghu33oeN9seadNCO8EYWJLopEEq2MQ==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr10467273wrv.73.1639945653692;
        Sun, 19 Dec 2021 12:27:33 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:fa36:a1cd:f64:7a6? ([2a01:e34:ed2f:f020:fa36:a1cd:f64:7a6])
        by smtp.googlemail.com with ESMTPSA id g11sm8662064wri.73.2021.12.19.12.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 12:27:33 -0800 (PST)
Subject: Re: [PATCH v5 6/6] qcom/soc/drivers: Add DTPM description for sdm845
To:     Steev Klimaszewski <steev@kali.org>, rjw@rjwysocki.net
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
 <818ed2a3-47d4-46d6-4bd3-ff2c7ff0192c@kali.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <56905f98-d8a1-0631-8f1e-ccd403c6add2@linaro.org>
Date:   Sun, 19 Dec 2021 21:27:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <818ed2a3-47d4-46d6-4bd3-ff2c7ff0192c@kali.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2021 19:44, Steev Klimaszewski wrote:
> Hi Daniel,
> 
> On 12/18/21 2:11 PM, Daniel Lezcano wrote:
>> Hi Steev,
>>
>> thanks for taking the time to test the series.
> 
> My C630 is my daily driver and main computer, so I don't mind testing
> things to improve its usage at all.
> 
> 
>> <snip>
>> Yes, the module is designed to be loaded only. I did not wanted to add
>> more complexity in the driver as unloading it is not the priority ATM.
>> We need this to be a module in order to load it after the other devices.
> Makes sense, I just wasn't entirely sure if it was on purpose or not.
>>>> +    depends on DTPM
>>>> +    help
>>>> +     Describe the hierarchy for the Dynamic Thermal Power
>>>> +     Management tree on this platform. That will create all the
>>>> +     power capping capable devices.
>>>> +
>>>>    endmenu
>>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>>> index 70d5de69fd7b..cf38496c3f61 100644
>>>> --- a/drivers/soc/qcom/Makefile
>>>> +++ b/drivers/soc/qcom/Makefile
>>>> @@ -28,3 +28,4 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>>>>    obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>>>>    obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>>>>    obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=    kryo-l2-accessors.o
>>>> +obj-$(CONFIG_QCOM_DTPM) += dtpm.o
>> [ ... ]
> I noticed this as well, and was going to ask if it shouldn't be named
> qcom_dtpm, but I don't think it matters since it would be in
> /lib/modules/$kver/kernel/drivers/soc/qcom ?

Right

>>>> +static struct of_device_id __initdata sdm845_dtpm_match_table[] = {
>>>> +        { .compatible = "qcom,sdm845", .data = sdm845_hierarchy },
>>>> +        {},
>>>> +};
>>>> +
>>>> +static int __init sdm845_dtpm_init(void)
>>>> +{
>>>> +    return dtpm_create_hierarchy(sdm845_dtpm_match_table);
>>>> +}
>>>> +late_initcall(sdm845_dtpm_init);
>>>> +
>>>> +MODULE_DESCRIPTION("Qualcomm DTPM driver");
>>>> +MODULE_LICENSE("GPL");
>>>> +MODULE_ALIAS("platform:dtpm");
>>>> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
>>>> +
>>> It does seem to work aside from not being able to modprobe -r the
>>> module. Although I do see
>>>
>>> [   35.849622] dtpm: Registered dtpm node 'sdm845' / 0-0 uW,
>>> [   35.849652] dtpm: Registered dtpm node 'package' / 0-0 uW,
>>> [   35.849676] dtpm: Registered dtpm node 'cpu0-cpufreq' /
>>> 40000-436000 uW,
>>> [   35.849702] dtpm: Registered dtpm node 'cpu4-cpufreq' /
>>> 520000-5828000 uW,
>>> [   35.849734] dtpm_devfreq: No energy model available for '5000000.gpu'
>>> [   35.849738] dtpm: Failed to setup '/soc@0/gpu@5000000': -22
>>>
>>> If the devfreq issue with the gpu isn't expected, are we missing
>>> something for the c630?
>> Yes, the energy model is missing for the GPU, very likely the
>> 'dynamic-power-coefficient' property is missing in the gpu section.
>>
>> A quick test could be to add a value like 800. The resulting power
>> numbers will be wrong but it should be possible to act on the
>> performance by using these wrong power numbers.
>>
>>    -- Daniel
>>
> So, I'm definitely not the greatest of kernel hackers, just enough
> knowledge to be dangerous and I know how to apply patches properly....
> I'm not able to actually get this working.  I've tried adding it with a
> few different numbers, and any time i try to add the d-p-c, I get
> 
> Dec 18 15:00:49 limitless kernel: [   57.394503] adreno 5000000.gpu: EM:
> invalid perf. state: -22
> Dec 18 15:00:49 limitless kernel: [   57.394515] dtpm_devfreq: No energy
> model available for '5000000.gpu'
> Dec 18 15:00:49 limitless kernel: [   57.394519] dtpm: Failed to setup
> '/soc@0/gpu@5000000': -22

I've been through the code and I suspect something is missing in the
mainline kernel for devfreq vs energy model. Not related to DTPM actually.

I'll double check if that could be added beside this series


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
