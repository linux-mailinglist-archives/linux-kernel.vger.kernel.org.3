Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4E591142
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbiHLNR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiHLNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:17:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F4B8051B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:17:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so539795wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=h5pNhdaJn3gZtjcw74tHikrW0IO2+nn5+5hQi02FBXI=;
        b=j7O3KEcE2eXWYLQ6fIIogKn10XMxtto9O7JBxPmSeKbY4EN1tkOQXrBr+GGO7EscUh
         HEM2IlPW2CQKtAeOnOXmnqiettzgnCdbQortN19uyll9CXz7S9NTTjJ2wxl8sFeM+DqB
         h6VFq+s9K+xe4ObW4pPDEg4npsUNACq5hshdSAP3Lmtl1BdRnvVeSiyNOHY3Vo5H/Tfw
         kdYdqu2saWJNF9pmx2fAEGl5ru1sSi7UhgwSCyj4NjyErfZSkRExF9GvxNGyNutUkcUI
         JOV7T2zvUWrWDp7JMFfxuMcfY3Wp6uiwJgKmqfLn5k5YghRfogpDdDhZtaBhO1wt9i40
         zaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=h5pNhdaJn3gZtjcw74tHikrW0IO2+nn5+5hQi02FBXI=;
        b=A8Z4QzMj0PKIdmwBBAmC6mlXzEaFMPevojaAAMEYA+q1C/Mr1RWvmokxZy3zNt+Tew
         NwnXFZbPGz3rhsKCN7t/r4KFpmmUQSJtdBAhZT7O7XGS7l6gV6lllK67xiKgr9wmzrr0
         SumOJQGIQx2wjqxTzRkHDN+0NPmhReopHzccBELpbAJwSoZpYRgV1BQuNMz3bGo+i/ZS
         PwZ7iNkWKtFTj4Y6YRMX9D8RQ4zkHZT/Ccgx/7MlXeIMPDjfUbP8RnS/39PPlZ7FDRcI
         wnZvcsLDL+XO4tL9UmKFnKWFitnCotYePa3f7Z6yvdH30KXmS/9nKPm0yC+uLst55zJQ
         xQQA==
X-Gm-Message-State: ACgBeo3TIJoMtrTrvOl7/pLtWlPpz3G+0jW6cRw7Ys8IwSTh7Ihfy3JT
        ubyDS6yRbzQi1XlExdWhoxA/nA==
X-Google-Smtp-Source: AA6agR5wrrn5Yf7D/SMH/cKc8qeHq4VVCaltJxZvq16i17bUkNqj1qGHIh7WzS+/+j1L6WJh7yczcQ==
X-Received: by 2002:a05:600c:35d6:b0:3a3:1c4f:6f46 with SMTP id r22-20020a05600c35d600b003a31c4f6f46mr2680295wmq.206.1660310253288;
        Fri, 12 Aug 2022 06:17:33 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n12-20020adfe78c000000b0021e4bc9edbfsm1911602wrm.112.2022.08.12.06.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 06:17:32 -0700 (PDT)
Message-ID: <cb827fce-197e-1f33-0127-ba5d49679d65@linaro.org>
Date:   Fri, 12 Aug 2022 15:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/5] thermal/core: Move the mutex inside the
 thermal_zone_device_update() function
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, rafael@kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
References: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
 <20220805153834.2510142-5-daniel.lezcano@linaro.org>
 <CGME20220812103956eucas1p1849443855b3537c3f5be2891fa50a50b@eucas1p1.samsung.com>
 <f1fb1d84-85de-f3c5-0212-fcf0e9c0ccd2@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <f1fb1d84-85de-f3c5-0212-fcf0e9c0ccd2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marek,

thanks for reporting.

Are you ok to check if the patch I've sent fixes the issue on your 
platform ?


On 12/08/2022 12:39, Marek Szyprowski wrote:
> Hi Daniel,
> 
> On 05.08.2022 17:38, Daniel Lezcano wrote:
>> All the different calls inside the thermal_zone_device_update()
>> function take the mutex.
>>
>> The previous changes move the mutex out of the different functions,
>> like the throttling ops. Now that the mutexes are all at the same
>> level in the call stack for the thermal_zone_device_update() function,
>> they can be moved inside this one.
>>
>> That has the benefit of:
>>
>> 1. Simplify the code by not having a plethora of places where the lock is taken
>>
>> 2. Probably closes more race windows because releasing the lock from
>> one line to another can give the opportunity to the thermal zone to change
>> its state in the meantime. For example, the thermal zone can be
>> enabled right after checking it is disabled.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> This patch landed recently in linux next-20220811 as commit ca48ad71717d
> ("thermal/core: Move the mutex inside the thermal_zone_device_update()
> function"). Unfortunately it triggers a warning on Samsung ARM/ARM64
> Exynos-based systems during the system suspend/resume cycle:
> 
> Restarting tasks ... done.
> random: crng reseeded on system resumption
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1374 at drivers/thermal/thermal_core.c:452
> thermal_zone_device_is_enabled+0x58/0x5c
> Modules linked in: cmac bnep hci_uart btbcm btintel bluetooth s5p_csis
> s5p_fimc exynos4_is_common v4l2_fwnode v4l2_async ecdh_generic ecc
> s5p_mfc brcmfmac cfg80211 s5p_jpeg videobuf2_dma_contig videobuf2_memops
> brcmutil v4l2_mem2mem videobuf2_v4l2 videobuf2_common videodev mc
> CPU: 1 PID: 1374 Comm: rtcwake Not tainted 5.18.0-02136-gca48ad71717d #12560
> Hardware name: Samsung Exynos (Flattened Device Tree)
>    unwind_backtrace from show_stack+0x10/0x14
>    show_stack from dump_stack_lvl+0x58/0x70
>    dump_stack_lvl from __warn+0x230/0x234
>    __warn from warn_slowpath_fmt+0xac/0xb4
>    warn_slowpath_fmt from thermal_zone_device_is_enabled+0x58/0x5c
>    thermal_zone_device_is_enabled from thermal_pm_notify+0x84/0xe8
>    thermal_pm_notify from blocking_notifier_call_chain+0x6c/0x94
>    blocking_notifier_call_chain from pm_suspend+0x2e8/0x428
>    pm_suspend from state_store+0x68/0xc8
>    state_store from kernfs_fop_write_iter+0x108/0x1b0
>    kernfs_fop_write_iter from vfs_write+0x268/0x50c
>    vfs_write from ksys_write+0x54/0xc8
>    ksys_write from ret_fast_syscall+0x0/0x1c
> Exception stack(0xf0fa9fa8 to 0xf0fa9ff0)
> ...
> irq event stamp: 49341
> hardirqs last  enabled at (49349): [<c019d3f0>] __up_console_sem+0x50/0x60
> hardirqs last disabled at (49358): [<c019d3dc>] __up_console_sem+0x3c/0x60
> softirqs last  enabled at (49336): [<c0101808>] __do_softirq+0x4c8/0x5e8
> softirqs last disabled at (49331): [<c01305b8>] irq_exit+0x1cc/0x200
> ---[ end trace 0000000000000000 ]---
> PM: suspend exit
> 
> 
> It looks that either the exynos_thermal driver or the framework has to
> be somehow adjusted to avoid the above issue, but I didn't check the
> details in the code yet.
> 
> 
>> ---
>>    drivers/thermal/thermal_core.c    | 32 +++++--------
>>    drivers/thermal/thermal_core.h    |  2 +
>>    drivers/thermal/thermal_helpers.c | 75 ++++++++++++++++++-------------
>>    drivers/thermal/thermal_sysfs.c   |  6 ++-
>>    4 files changed, 62 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 9d554f97e081..60110ac53e23 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -297,24 +297,18 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
>>    
>>    static void monitor_thermal_zone(struct thermal_zone_device *tz)
>>    {
>> -	mutex_lock(&tz->lock);
>> -
>>    	if (tz->mode != THERMAL_DEVICE_ENABLED)
>>    		thermal_zone_device_set_polling(tz, 0);
>>    	else if (tz->passive)
>>    		thermal_zone_device_set_polling(tz, tz->passive_delay_jiffies);
>>    	else if (tz->polling_delay_jiffies)
>>    		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
>> -
>> -	mutex_unlock(&tz->lock);
>>    }
>>    
>>    static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
>>    {
>> -	mutex_lock(&tz->lock);
>>    	tz->governor ? tz->governor->throttle(tz, trip) :
>>    		       def_governor->throttle(tz, trip);
>> -	mutex_unlock(&tz->lock);
>>    }
>>    
>>    void thermal_zone_device_critical(struct thermal_zone_device *tz)
>> @@ -382,7 +376,7 @@ static void update_temperature(struct thermal_zone_device *tz)
>>    {
>>    	int temp, ret;
>>    
>> -	ret = thermal_zone_get_temp(tz, &temp);
>> +	ret = __thermal_zone_get_temp(tz, &temp);
>>    	if (ret) {
>>    		if (ret != -EAGAIN)
>>    			dev_warn(&tz->device,
>> @@ -391,10 +385,8 @@ static void update_temperature(struct thermal_zone_device *tz)
>>    		return;
>>    	}
>>    
>> -	mutex_lock(&tz->lock);
>>    	tz->last_temperature = tz->temperature;
>>    	tz->temperature = temp;
>> -	mutex_unlock(&tz->lock);
>>    
>>    	trace_thermal_temperature(tz);
>>    
>> @@ -457,15 +449,9 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_disable);
>>    
>>    int thermal_zone_device_is_enabled(struct thermal_zone_device *tz)
>>    {
>> -	enum thermal_device_mode mode;
>> -
>> -	mutex_lock(&tz->lock);
>> -
>> -	mode = tz->mode;
>> +	lockdep_assert_held(&tz->lock);
>>    
>> -	mutex_unlock(&tz->lock);
>> -
>> -	return mode == THERMAL_DEVICE_ENABLED;
>> +	return tz->mode == THERMAL_DEVICE_ENABLED;
>>    }
>>    
>>    void thermal_zone_device_update(struct thermal_zone_device *tz,
>> @@ -473,9 +459,6 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>>    {
>>    	int count;
>>    
>> -	if (!thermal_zone_device_is_enabled(tz))
>> -		return;
>> -
>>    	if (atomic_read(&in_suspend))
>>    		return;
>>    
>> @@ -483,9 +466,14 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>>    		      "'get_temp' ops set\n", __func__))
>>    		return;
>>    
>> +	mutex_lock(&tz->lock);
>> +
>> +	if (!thermal_zone_device_is_enabled(tz))
>> +		goto out;
>> +
>>    	update_temperature(tz);
>>    
>> -	thermal_zone_set_trips(tz);
>> +	__thermal_zone_set_trips(tz);
>>    
>>    	tz->notify_event = event;
>>    
>> @@ -493,6 +481,8 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>>    		handle_thermal_trip(tz, count);
>>    
>>    	monitor_thermal_zone(tz);
>> +out:
>> +	mutex_unlock(&tz->lock);
>>    }
>>    EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>>    
>> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
>> index 2241d2dce017..1571917bd3c8 100644
>> --- a/drivers/thermal/thermal_core.h
>> +++ b/drivers/thermal/thermal_core.h
>> @@ -112,6 +112,8 @@ int thermal_build_list_of_policies(char *buf);
>>    
>>    /* Helpers */
>>    void thermal_zone_set_trips(struct thermal_zone_device *tz);
>> +void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>> +int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>>    
>>    /* sysfs I/F */
>>    int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
>> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
>> index 690890f054a3..702c70bdca48 100644
>> --- a/drivers/thermal/thermal_helpers.c
>> +++ b/drivers/thermal/thermal_helpers.c
>> @@ -64,27 +64,17 @@ get_thermal_instance(struct thermal_zone_device *tz,
>>    }
>>    EXPORT_SYMBOL(get_thermal_instance);
>>    
>> -/**
>> - * thermal_zone_get_temp() - returns the temperature of a thermal zone
>> - * @tz: a valid pointer to a struct thermal_zone_device
>> - * @temp: a valid pointer to where to store the resulting temperature.
>> - *
>> - * When a valid thermal zone reference is passed, it will fetch its
>> - * temperature and fill @temp.
>> - *
>> - * Return: On success returns 0, an error code otherwise
>> - */
>> -int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>> +int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>>    {
>>    	int ret = -EINVAL;
>>    	int count;
>>    	int crit_temp = INT_MAX;
>>    	enum thermal_trip_type type;
>>    
>> +	lockdep_assert_held(&tz->lock);
>> +	
>>    	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
>> -		goto exit;
>> -
>> -	mutex_lock(&tz->lock);
>> +		return -EINVAL;
>>    
>>    	ret = tz->ops->get_temp(tz, temp);
>>    
>> @@ -107,35 +97,42 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>>    			*temp = tz->emul_temperature;
>>    	}
>>    
>> -	mutex_unlock(&tz->lock);
>> -exit:
>>    	return ret;
>>    }
>> -EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>>    
>>    /**
>> - * thermal_zone_set_trips - Computes the next trip points for the driver
>> - * @tz: a pointer to a thermal zone device structure
>> + * thermal_zone_get_temp() - returns the temperature of a thermal zone
>> + * @tz: a valid pointer to a struct thermal_zone_device
>> + * @temp: a valid pointer to where to store the resulting temperature.
>>     *
>> - * The function computes the next temperature boundaries by browsing
>> - * the trip points. The result is the closer low and high trip points
>> - * to the current temperature. These values are passed to the backend
>> - * driver to let it set its own notification mechanism (usually an
>> - * interrupt).
>> + * When a valid thermal zone reference is passed, it will fetch its
>> + * temperature and fill @temp.
>>     *
>> - * It does not return a value
>> + * Return: On success returns 0, an error code otherwise
>>     */
>> -void thermal_zone_set_trips(struct thermal_zone_device *tz)
>> +int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&tz->lock);
>> +	ret = __thermal_zone_get_temp(tz, temp);
>> +	mutex_unlock(&tz->lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>> +
>> +void __thermal_zone_set_trips(struct thermal_zone_device *tz)
>>    {
>>    	int low = -INT_MAX;
>>    	int high = INT_MAX;
>>    	int trip_temp, hysteresis;
>>    	int i, ret;
>>    
>> -	mutex_lock(&tz->lock);
>> -
>> +	lockdep_assert_held(&tz->lock);
>> +	
>>    	if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
>> -		goto exit;
>> +		return;
>>    
>>    	for (i = 0; i < tz->num_trips; i++) {
>>    		int trip_low;
>> @@ -154,7 +151,7 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>>    
>>    	/* No need to change trip points */
>>    	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
>> -		goto exit;
>> +		return;
>>    
>>    	tz->prev_low_trip = low;
>>    	tz->prev_high_trip = high;
>> @@ -169,8 +166,24 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>>    	ret = tz->ops->set_trips(tz, low, high);
>>    	if (ret)
>>    		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
>> +}
>>    
>> -exit:
>> +/**
>> + * thermal_zone_set_trips - Computes the next trip points for the driver
>> + * @tz: a pointer to a thermal zone device structure
>> + *
>> + * The function computes the next temperature boundaries by browsing
>> + * the trip points. The result is the closer low and high trip points
>> + * to the current temperature. These values are passed to the backend
>> + * driver to let it set its own notification mechanism (usually an
>> + * interrupt).
>> + *
>> + * It does not return a value
>> + */
>> +void thermal_zone_set_trips(struct thermal_zone_device *tz)
>> +{
>> +	mutex_lock(&tz->lock);
>> +	__thermal_zone_set_trips(tz);
>>    	mutex_unlock(&tz->lock);
>>    }
>>    
>> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
>> index 3c513561d346..f094f7cbc455 100644
>> --- a/drivers/thermal/thermal_sysfs.c
>> +++ b/drivers/thermal/thermal_sysfs.c
>> @@ -49,7 +49,11 @@ static ssize_t
>>    mode_show(struct device *dev, struct device_attribute *attr, char *buf)
>>    {
>>    	struct thermal_zone_device *tz = to_thermal_zone(dev);
>> -	int enabled = thermal_zone_device_is_enabled(tz);
>> +	int enabled;
>> +
>> +	mutex_lock(&tz->lock);
>> +	enabled = thermal_zone_device_is_enabled(tz);
>> +	mutex_unlock(&tz->lock);
>>    
>>    	return sprintf(buf, "%s\n", enabled ? "enabled" : "disabled");
>>    }
> 
> Best regards


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
