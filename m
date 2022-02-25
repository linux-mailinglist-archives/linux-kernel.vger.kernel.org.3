Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD48F4C470B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbiBYODL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiBYODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:03:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F9C3C1E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:02:31 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y5so1736489wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qk5zAx/v4pV2NZHwekGx/zCPF5BYYqJTYfuyv4JLKnY=;
        b=qSqHaAhVw1FQbAxP/QAKts4bG5uOwjXiLlvlpqNoykQNaeeBXx32Edu43dPFStbZCG
         cnQTUAezVOLG2KcozYpdObnmmiXEODrRfjE3sgIO4puFvZRT7+VS21wqJ0ZA2wY+Gmie
         q4OMiLbz4SyMAB+tqwh9ilNBqpa8fyiAkMWeuXzAlAdESXgegz2460ZT7qY9jn215v+v
         fFkTJxtJT5oB6R3OaoW7TwhajdFxuXkE77nR3r5OB7lbU1dHY2s/K9xrZjilvGNH8x5m
         7MSD0/mhJ8tj8BYvyIVdzEon2/I5Hjt4/zFb6EWNseBMC8roVJ3usS25uz22iiIOt6BF
         fLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qk5zAx/v4pV2NZHwekGx/zCPF5BYYqJTYfuyv4JLKnY=;
        b=0Y7+fcncCByIljUEJnHgnvGWFUAepPhhDGm4VDyITARtLDBWFy8RfqwS/ytM13NLi9
         sgiuW89sB2vhJR9yr3rJGCSZzIJ3Egpmg9Gd4nD018BG/LbPCa1KfIrEJYoGWldoYtMV
         c9kHji24CY4yIOxUCdBVKNFhPCmCFYceFun8N5ZS/dqqJjSFMwt4CaDapAtZlXsAde4K
         SY02ccwrHILxa9TwJVoepxTNdgvUDxtc+QOxjGlseVWUF0f11zUB0aJXwhxGBWjnVbz+
         RLAFjz/m2htCF//7c+sz9LHfLxiOIaJUGd6Dug7g+WSRQFijXecVeiK++LKZMYN3modR
         8Ing==
X-Gm-Message-State: AOAM530mnWc0TVKcVFC0EIAxT7MtoEhaEu9UDjrzG1JCjU870dOyLmX/
        nppbPwi2j5ZZ/tHJuFLpza94HQ==
X-Google-Smtp-Source: ABdhPJzNfT6n5Kc9L2VQ5D1j+nBD0b/pLVfgouVRVGcRtPNPueTZJNk9DqZCS70uXP1DUkfwvKJuoQ==
X-Received: by 2002:a05:600c:508:b0:380:fd39:2c42 with SMTP id i8-20020a05600c050800b00380fd392c42mr2814366wmc.178.1645797750075;
        Fri, 25 Feb 2022 06:02:30 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:25a:d4d2:9383:c638? ([2a01:e34:ed2f:f020:25a:d4d2:9383:c638])
        by smtp.googlemail.com with ESMTPSA id f21-20020a7bcd15000000b0034efd01ee16sm2462450wmj.42.2022.02.25.06.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 06:02:29 -0800 (PST)
Message-ID: <422bd780-354d-d4ac-7b7a-8060325fc13e@linaro.org>
Date:   Fri, 25 Feb 2022 15:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] drivers: thermal: tsens: respect thermal_device_mode
 in threshold irq reporting
Content-Language: en-US
To:     Benjamin Li <benl@squareup.com>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zac Crosby <zac@squareup.com>, Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220120200153.1214-1-benl@squareup.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220120200153.1214-1-benl@squareup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 21:01, Benjamin Li wrote:
> 'echo disabled > .../thermal_zoneX/mode' will disable the thermal core's
> polling mechanism to check for threshold trips. This is used sometimes to
> run performance test cases.
> 
> However, tsens supports an interrupt mechanism to receive notification of
> trips, implemented in commit 634e11d5b450 ("drivers: thermal: tsens: Add
> interrupt support").
> 
> Currently the thermal zone mode that's set by userspace is not checked
> before propagating threshold trip events from IRQs. Let's fix this to
> restore the abilty to disable thermal throttling at runtime.
> 
> ====================
> 
> Tested on MSM8939 running 5.16.0. This platform has 8 cores; the first
> four thermal zones control cpu0-3 and the last zone is for the other four
> CPUs together.
> 
>    for f in /sys/class/thermal/thermal_zone*; do
>      echo "disabled" > $f/mode
>      echo $f | paste - $f/type $f/mode
>    done
> 
> /sys/class/thermal/thermal_zone0	cpu0-thermal	disabled
> /sys/class/thermal/thermal_zone1	cpu1-thermal	disabled
> /sys/class/thermal/thermal_zone2	cpu2-thermal	disabled
> /sys/class/thermal/thermal_zone3	cpu3-thermal	disabled
> /sys/class/thermal/thermal_zone4	cpu4567-thermal	disabled
> 
> With mitigation thresholds at 75 degC and load running, we can now cruise
> past temp=75000 without CPU throttling kicking in.
> 
>    watch -n 1 "grep '' /sys/class/thermal/*/temp
>        /sys/class/thermal/*/cur_state
>        /sys/bus/cpu/devices/cpu*/cpufreq/cpuinfo_cur_freq"
> 
> /sys/class/thermal/thermal_zone0/temp:82000
> /sys/class/thermal/thermal_zone1/temp:84000
> /sys/class/thermal/thermal_zone2/temp:87000
> /sys/class/thermal/thermal_zone3/temp:84000
> /sys/class/thermal/thermal_zone4/temp:84000
> /sys/class/thermal/cooling_device0/cur_state:0
> /sys/class/thermal/cooling_device1/cur_state:0
> /sys/bus/cpu/devices/cpu0/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu1/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu2/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu3/cpufreq/cpuinfo_cur_freq:1113600
> /sys/bus/cpu/devices/cpu4/cpufreq/cpuinfo_cur_freq:800000
> /sys/bus/cpu/devices/cpu5/cpufreq/cpuinfo_cur_freq:800000
> /sys/bus/cpu/devices/cpu6/cpufreq/cpuinfo_cur_freq:800000
> /sys/bus/cpu/devices/cpu7/cpufreq/cpuinfo_cur_freq:800000
> 
> Reported-by: Zac Crosby <zac@squareup.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> ---
> Changes in v3:
> - Upgraded logging to dev_info_ratelimited and revised log message.
> - Remove unrelated hunk.
> 
> Some drivers that support thermal zone disabling implement a set_mode
> operation and simply disable the sensor or the relevant IRQ(s), so they
> actually don't log anything when zones are disabled. These drivers are
> imx_thermal.c, intel_quark_dts_thermal.c, and int3400_thermal.c.
> 
> For tsens.c, implementing a change_mode would require migrating the driver
> from devm_thermal_zone_of_sensor_register to thermal_zone_device_register
> (or updating thermal_of.c to add a change_mode operation in thermal_zone_
> of_device_ops).
> 
> stm_thermal.c seems to use this patch's model of not disabling IRQs when
> the zone is disabled (they still perform the thermal_zone_device_update
> upon IRQ, but return -EAGAIN from their get_temp).

What is the concern by changing the core code to have a correct handling 
of the disabled / enabled state in this driver ? (and by this way give 
the opportunity to other drivers to fix their code)


> Changes in v2:
> - Reordered sentences in first part of commit message to make sense.
> 
>   drivers/thermal/qcom/tsens.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 99a8d9f3e03c..dd0002829536 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -509,10 +509,14 @@ static irqreturn_t tsens_irq_thread(int irq, void *data)
>   		spin_unlock_irqrestore(&priv->ul_lock, flags);
>   
>   		if (trigger) {
> -			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> -				hw_id, __func__, temp);
> -			thermal_zone_device_update(s->tzd,
> -						   THERMAL_EVENT_UNSPECIFIED);
> +			if (s->tzd->mode == THERMAL_DEVICE_ENABLED) {
> +				dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
> +					hw_id, __func__, temp);
> +				thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
> +			} else {
> +				dev_info_ratelimited(priv->dev, "[%u] %s: TZ update trigger (%d mC) skipped - zone disabled, operating outside of safety limits!\n",
> +					hw_id, __func__, temp);
> +			}
>   		} else {
>   			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
>   				hw_id, __func__, temp);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
