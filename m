Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD86449FC88
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiA1PNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiA1PNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:13:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE326C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:13:15 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a13so11464251wrh.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AUwJFbkTUdnlBk2iiUiCsMF/VYfJTKSHUYAJSm9ePFA=;
        b=m/G2yCpBhl3MgvFX0eCqxTH2UX/2jTTlzDb9a9d99JkomGhjqBJCg2rFda7/6wywEu
         kbUESx3fj8prq771TTeIbSjXjKBRhuKJYt8kKGZSBwT0xJ81NcxpBQ19kpXgDNNoR7qK
         hUhNE66MeEuQLOvTxeuGaXksymzOMjAZ9XKxDSybd8ZdkXSBeCEavf13SUnbrMEB2dlB
         Td3bDENJ0Cl//PHpNAJlb8GS3+1uyYDH3UFAZkGHVUQcCsTrgJqYKIRMoDV9hr2g2dTf
         9FjgJHgRtfblCYDx7YEPcHgrDc84bq2aSxOADkaxfiMq0l5kjvSj7GANDwapEcThRP8F
         UGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AUwJFbkTUdnlBk2iiUiCsMF/VYfJTKSHUYAJSm9ePFA=;
        b=3IZ5A9+MuD1S3ZFv6QU+xoGLGqCiXf/ZRWh7AKZUkGprM2WlkkAE2Yuv4hnKmTfLXC
         lgtTbC1BallW62SOC6A5Pl1z5hCW1+p8xUyQIAYM/S4ZXCfnLTAWRBknwgIfMaITz5mJ
         fpBwZWxNK5rjvFcs8rSnOtOD/2vNybN6LPYDvVYP3HFVPq4piZiKKJaYSGCNZIzhhc+l
         SKuvFM1ql5KCIl2mKgNeKTbkOQclT0UtqNh0yxWiOOE3QtSqfFLzfJWFqMrvEgZiWvWt
         HJ90uyR6vf0PmrMNXFQYPNhG2BiptGFCezvl+jVzGTR0azk4gV9pwpt51p/Wu/8Z482j
         5Fvw==
X-Gm-Message-State: AOAM531yEwzeSWgmO9zcyrPrpp5B2oyt/bwX4NjkZDtD2ZbT6wuo6GjK
        CW70DceoGsYtjD2lRIo+86hdYg==
X-Google-Smtp-Source: ABdhPJyYERh4YgS4Bbw9OaouOmH93frvS5/RF382UnIWRRnGqAeIjfNe8mDbXZOwE2Th4HzRUqZVMA==
X-Received: by 2002:a05:6000:16c2:: with SMTP id h2mr7667083wrf.614.1643382794348;
        Fri, 28 Jan 2022 07:13:14 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:f39:b962:8b8e:9851? ([2a01:e34:ed2f:f020:f39:b962:8b8e:9851])
        by smtp.googlemail.com with ESMTPSA id d4sm6066910wri.39.2022.01.28.07.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 07:13:13 -0800 (PST)
Message-ID: <55780cda-f963-9168-f439-5a51da3b4907@linaro.org>
Date:   Fri, 28 Jan 2022 16:13:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 5/5] rockchip/soc/drivers: Add DTPM description for
 rk3399
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, rjw@rjwysocki.net
Cc:     robh@kernel.org, lukasz.luba@arm.com, arnd@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20220125171809.1273269-1-daniel.lezcano@linaro.org>
 <20220125171809.1273269-6-daniel.lezcano@linaro.org>
 <48865702.Mx8J7aE1p6@diego>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <48865702.Mx8J7aE1p6@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Heiko,

thanks for your comments

On 28/01/2022 11:19, Heiko Stübner wrote:
> Am Dienstag, 25. Januar 2022, 18:18:09 CET schrieb Daniel Lezcano:
>> The DTPM framework does support now the hierarchy description.
>>
>> The platform specific code can call the hierarchy creation function
>> with an array of struct dtpm_node pointing to their parent.
>>
>> This patch provides a description of the big / Little CPUs and the
>> GPU and tie them together under a virtual 'package' name. Only rk3399 is
>> described now.
>>
>> The description could be extended in the future with the memory
>> controller with devfreq.
>>
>> The description is always a module and it describes the soft
>> dependencies. The userspace has to load the softdeps module in the
>> right order.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

>> +static struct dtpm_node __initdata rk3399_hierarchy[] = {
> 
> The driver is tristate so buildable as module but uses __initdata.
> As it depends on panfrost (which also can be a module) you
> probably want a "__initdata_or_module" here .

Well, actually the dependency is wrong.

It should be:

	depends on DTPM && m

It will be compiled always as a module.

Referring to the Documentation/kernel-hacking/hacking.rst

"After boot, the kernel frees up a special section; functions marked with
``__init`` and data structures marked with ``__initdata`` are dropped
after boot is complete: similarly modules discard this memory after
initialization."

So after the module is loaded and the hierarchy is created, nothing will 
stay in memory (except the future module exit function)


>> +	[0]{ .name = "rk3399",
>> +	     .type = DTPM_NODE_VIRTUAL },
>> +	[1]{ .name = "package",
>> +	     .type = DTPM_NODE_VIRTUAL,
>> +	     .parent = &rk3399_hierarchy[0] },
>> +	[2]{ .name = "/cpus/cpu@0",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &rk3399_hierarchy[1] },
>> +	[3]{ .name = "/cpus/cpu@1",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &rk3399_hierarchy[1] },
>> +	[4]{ .name = "/cpus/cpu@2",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &rk3399_hierarchy[1] },
>> +	[5]{ .name = "/cpus/cpu@3",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &rk3399_hierarchy[1] },
>> +	[6]{ .name = "/cpus/cpu@100",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &rk3399_hierarchy[1] },
>> +	[7]{ .name = "/cpus/cpu@101",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &rk3399_hierarchy[1] },
>> +	[8]{ .name = "/gpu@ff9a0000",
>> +	     .type = DTPM_NODE_DT,
>> +	     .parent = &rk3399_hierarchy[1] },
>> +	[9]{ },
> 
> hmm, do we want a "/* sentinel */" inside the empty last entry?
> I think that is pretty common to denote the "this one is the last entry"
> of a dynamic list ;-)

Sure

>> +};
>> +
>> +static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
>> +        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
>> +        {},
>> +};
>> +
>> +static int __init rockchip_dtpm_init(void)
>> +{
>> +	return dtpm_create_hierarchy(rockchip_dtpm_match_table);
>> +}
>> +module_init(rockchip_dtpm_init);
> 
> Just for my understanding what happens on driver unload?

ATM it is not possible to unload it.

A second series with the hierarchy destruction will follow once this 
series is merged. The module unloading will be added here.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
