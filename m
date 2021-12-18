Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE13A479C81
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 21:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbhLRULd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 15:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhLRULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 15:11:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89308C06173F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 12:11:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j9so11127115wrc.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 12:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jQn3VgompRNFuhU8fi2ilFWaC4sX+wD/C0nf/KumjpE=;
        b=rNwrU1KH7raJ5cCl1qwuTI2tpZFxDHGH++NGtC8bzib+endShYZi5vcJgC6GA1BMG4
         3QAISj4KGdx5arBXCwO5tnWc6Zl+YMeQoftTRQytorlnQEEH9xvX/Fm0V9mB0nZJ4iSV
         tqSE6+rKLQdc3k/HofB4fLWY3W6/tDYPUrSnLaKUO6y3i1xY1Qp6ZQk2cZ1J2WXOUL12
         hFLg29mQwYSl7akMjk+yBlxScag0Ph1VcAVLV24/gLBSlG/Xy1+QiuS5Q1K3z+NTBbTU
         g1Z9kkOtw0FIEXwfKJ9jtY05nC7Ndxp3IPVaYBsNYQDB5gMktlisiUE19S433huR48ZX
         cPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jQn3VgompRNFuhU8fi2ilFWaC4sX+wD/C0nf/KumjpE=;
        b=VMydweTwP9rDu2NoCxkfqkIcvMya1QY/VQIo/+2lvw1lmF5wc4roQFG5+MD6dQBj9v
         nY1loFjwZoDHmmyh/vKZCD13Gah6IwoIk9AgqaETijU97m+umzxSgwhN/Uv/1b/nJbA3
         z2zBvCcDxvzvIZpRzqiOJUSiogPJnIPBnd6h2Gqs3bk0ck23sN09S8VED+HrLpGPC7VT
         2P5mq+RMICQGTKeesBWMHpgK4HcWgEHIe1TFRisLo6CG3QQaqw+fsAZ6Z4KCB6AmggVz
         Zood17JxjPz3VQv6ZXTYtWJ7V92GnInZYBaAhmAKD0S8+aEc6sgq8ySA7u1F/oQsKcSy
         7qmQ==
X-Gm-Message-State: AOAM532vb07FjmVk1uGs4kDR7lsfM4V0oYhsloK+FnX/8cT7nXQEAgqk
        Bs5kgpW8pcjwRYdYqDY6b8nW0A==
X-Google-Smtp-Source: ABdhPJz6vq/ECTtvOXI5NaaUEKKDNvDUaiWY9zhEwWpo6zAOBVKweTRepL02Fay18G/Q/yXGwRchiQ==
X-Received: by 2002:a05:6000:38b:: with SMTP id u11mr2058170wrf.408.1639858289499;
        Sat, 18 Dec 2021 12:11:29 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1f0f:c9b8:ee5c:5c2f? ([2a01:e34:ed2f:f020:1f0f:c9b8:ee5c:5c2f])
        by smtp.googlemail.com with ESMTPSA id m20sm15248046wmq.11.2021.12.18.12.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 12:11:29 -0800 (PST)
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <79f91bbd-aa65-16d9-0fde-1f04c0690477@linaro.org>
Date:   Sat, 18 Dec 2021 21:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <aae49bcb-078f-f414-aede-0906c44c030b@kali.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steev,

thanks for taking the time to test the series.

On 18/12/2021 20:47, Steev Klimaszewski wrote:
> Hi Daniel,
> 
> On 12/18/21 7:00 AM, Daniel Lezcano wrote:
>> The DTPM framework does support now the hierarchy description.
>>
>> The platform specific code can call the hierarchy creation function
>> with an array of struct dtpm_node pointing to their parents.
>>
>> This patch provides a description of the big and Little CPUs and the
>> GPU and tie them together under a virtual package name. Only sdm845 is
>> described.
>>
>> The description could be extended in the future with the memory
>> controller with devfreq if it has the energy information.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/soc/qcom/Kconfig  |  9 ++++++
>>   drivers/soc/qcom/Makefile |  1 +
>>   drivers/soc/qcom/dtpm.c   | 65 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 75 insertions(+)
>>   create mode 100644 drivers/soc/qcom/dtpm.c
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index e718b8735444..f21c1df2f2f9 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -228,4 +228,13 @@ config QCOM_APR
>>         application processor and QDSP6. APR is
>>         used by audio driver to configure QDSP6
>>         ASM, ADM and AFE modules.
>> +
>> +config QCOM_DTPM
>> +    tristate "Qualcomm DTPM hierarchy"
> 
> Testing this on a Lenovo Yoga C630 here and...
> 
> 
> Should this be tristate?  Is it actually possible to unload the module
> once it's loaded?
> 
> Here I have DTPM=y, DTPM_CPU=y, DTPM_DEVFREQ=y, QCOM_DTPM=m
> 
> But if I attempt to modprobe -r dtpm,
> 
> modprobe: ERROR: ../libkmod/libkmod-module.c:799
> kmod_module_remove_module() could not remove 'dtpm': Device or resource
> busy

Yes, the module is designed to be loaded only. I did not wanted to add
more complexity in the driver as unloading it is not the priority ATM.
We need this to be a module in order to load it after the other devices.

>> +    depends on DTPM
>> +    help
>> +     Describe the hierarchy for the Dynamic Thermal Power
>> +     Management tree on this platform. That will create all the
>> +     power capping capable devices.
>> +
>>   endmenu
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 70d5de69fd7b..cf38496c3f61 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -28,3 +28,4 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>>   obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>>   obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>>   obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=    kryo-l2-accessors.o
>> +obj-$(CONFIG_QCOM_DTPM) += dtpm.o

[ ... ]

>> +static struct of_device_id __initdata sdm845_dtpm_match_table[] = {
>> +        { .compatible = "qcom,sdm845", .data = sdm845_hierarchy },
>> +        {},
>> +};
>> +
>> +static int __init sdm845_dtpm_init(void)
>> +{
>> +    return dtpm_create_hierarchy(sdm845_dtpm_match_table);
>> +}
>> +late_initcall(sdm845_dtpm_init);
>> +
>> +MODULE_DESCRIPTION("Qualcomm DTPM driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:dtpm");
>> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
>> +
> 
> It does seem to work aside from not being able to modprobe -r the
> module. Although I do see
> 
> [   35.849622] dtpm: Registered dtpm node 'sdm845' / 0-0 uW,
> [   35.849652] dtpm: Registered dtpm node 'package' / 0-0 uW,
> [   35.849676] dtpm: Registered dtpm node 'cpu0-cpufreq' / 40000-436000 uW,
> [   35.849702] dtpm: Registered dtpm node 'cpu4-cpufreq' /
> 520000-5828000 uW,
> [   35.849734] dtpm_devfreq: No energy model available for '5000000.gpu'
> [   35.849738] dtpm: Failed to setup '/soc@0/gpu@5000000': -22
> 
> If the devfreq issue with the gpu isn't expected, are we missing
> something for the c630?

Yes, the energy model is missing for the GPU, very likely the
'dynamic-power-coefficient' property is missing in the gpu section.

A quick test could be to add a value like 800. The resulting power
numbers will be wrong but it should be possible to act on the
performance by using these wrong power numbers.

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
