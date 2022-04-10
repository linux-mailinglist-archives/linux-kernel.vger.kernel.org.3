Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382704FAE16
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbiDJNpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiDJNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 09:45:38 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2676554B4;
        Sun, 10 Apr 2022 06:43:27 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v75so13490279oie.1;
        Sun, 10 Apr 2022 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2xjr+BwHg3OPjxs2PXuxRIEEOcJNydn7OhHvKUplCGw=;
        b=YnfTi2xS7n0zuDGOu3pTS14vifratV9h7iF8nZusqB8siuCr/6XEhGHGXC/E8ny3JQ
         PS8sicbCauFCho1/r9D6gnTAaiUou2eRZ9cTd+OSFyLgWHjB9gPVR23vh5E/1C6NNjkZ
         SEjn5zBzj5bRDYEunY+tUJPKQhHeBrhfT7jHAzptBVwKW+V8yh/gbUTKVmL11BYZN4p2
         22aBAtzzBBANyNRXXBntvOVGIsRX7rHGl3icxL96LsU1wDez3MQUfGu3Vy3VzP+26Rsw
         KnFFuMzIPcDIyp4JYhb04JROHhYy4O9qrox4II1DMoyq7wgwoIBUoD15sDPh2v6Bby+T
         meOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2xjr+BwHg3OPjxs2PXuxRIEEOcJNydn7OhHvKUplCGw=;
        b=1YZLMZleICs9/eTXQV3sNnoYxuTCMY6oh5eFEdRet9r29qUTpDdXogJBY0McmAQwhH
         zInd7yOTRc5cG1aBwwaoCp3myvOzNNW1yr727m2w5VJ2g6WU0bcHz3MSlJjFOSiG2AZJ
         zl/J4EvxjaXIJA2HENo3EQmoKSLqVlkkCV47CvbZ6HvvYdvAAqgoHs5mN5hXGN0c+Ip8
         y2aUjAHRdc6RccRUSmtcXGAwAknSz6k9xrZcuelbN/YsLt0HvfOvDn+LOaIVuwlByA8e
         jSHMbUlEcEfSXH4yWjQeg1uxDxLCJi9nHgSAV19DN9kxvbNNAqHS/tp/Qe49iwoxpG7U
         TCqw==
X-Gm-Message-State: AOAM531rd4lKEk4RdfeD6EBB38N3PBCg/7v+quZoZKZ2fiXbe8SSCh5p
        m/L8J0jmuwnlNqBixcPqw0Fp2ZTntw8=
X-Google-Smtp-Source: ABdhPJzqubpShfyGGGiZHT8JpHl5QUuwV6DdX8lt8aHwNONehwm7H/CogCao/jWRuuiwEr5M5LcO1Q==
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id e6-20020a056808148600b002f9e82151d9mr3382080oiw.253.1649598207050;
        Sun, 10 Apr 2022 06:43:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 123-20020a4a0181000000b00324a1217e96sm10648929oor.35.2022.04.10.06.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 06:43:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <57e155e6-6ccc-f5b0-3f8e-efcd8ba18bb0@roeck-us.net>
Date:   Sun, 10 Apr 2022 06:43:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] hwmon: (dell-smm) Add cooling device support
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220330163324.572437-1-W_Armin@gmx.de>
 <757b30ef-e250-063f-7523-030f56b1d0b8@gmx.de>
 <20220410100845.2isvctcw643yfp7n@pali>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220410100845.2isvctcw643yfp7n@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/22 03:08, Pali Rohár wrote:
> On Saturday 09 April 2022 17:33:48 Armin Wolf wrote:
>> Am 30.03.22 um 18:33 schrieb Armin Wolf:
>>
>>> Until now, only the temperature sensors where exported thru
>>> the thermal subsystem. Export the fans as "dell-smm-fan[1-3]" too
>>> to make them available as cooling devices.
>>> Also update Documentation.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>    Documentation/hwmon/dell-smm-hwmon.rst |  7 ++
>>>    drivers/hwmon/Kconfig                  |  1 +
>>>    drivers/hwmon/dell-smm-hwmon.c         | 94 +++++++++++++++++++++++++-
>>>    3 files changed, 99 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
>>> index d3323a96665d..41839b7de2c1 100644
>>> --- a/Documentation/hwmon/dell-smm-hwmon.rst
>>> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
>>> @@ -86,6 +86,13 @@ probe the BIOS on your machine and discover the appropriate codes.
>>>
>>>    Again, when you find new codes, we'd be happy to have your patches!
>>>
>>> +``thermal`` interface
>>> +---------------------------
>>> +
>>> +The driver also exports the fans as thermal cooling devices with
>>> +``type`` set to ``dell-smm-fan[1-3]``. This allows for easy fan control
>>> +using one of the thermal governors.
>>> +
>>>    Module parameters
>>>    -----------------
>>>
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index 9ab4e9b3d27b..1175b8e38c45 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -498,6 +498,7 @@ config SENSORS_DS1621
>>>    config SENSORS_DELL_SMM
>>>    	tristate "Dell laptop SMM BIOS hwmon driver"
>>>    	depends on X86
>>> +	imply THERMAL
>>>    	help
>>>    	  This hwmon driver adds support for reporting temperature of different
>>>    	  sensors and controls the fans on Dell laptops via System Management
>>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
>>> index 84cb1ede7bc0..0c29386f4bd3 100644
>>> --- a/drivers/hwmon/dell-smm-hwmon.c
>>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>>> @@ -21,6 +21,7 @@
>>>    #include <linux/errno.h>
>>>    #include <linux/hwmon.h>
>>>    #include <linux/init.h>
>>> +#include <linux/kconfig.h>
>>>    #include <linux/kernel.h>
>>>    #include <linux/module.h>
>>>    #include <linux/mutex.h>
>>> @@ -29,6 +30,7 @@
>>>    #include <linux/seq_file.h>
>>>    #include <linux/string.h>
>>>    #include <linux/smp.h>
>>> +#include <linux/thermal.h>
>>>    #include <linux/types.h>
>>>    #include <linux/uaccess.h>
>>>
>>> @@ -80,6 +82,11 @@ struct dell_smm_data {
>>>    	int *fan_nominal_speed[DELL_SMM_NO_FANS];
>>>    };
>>>
>>> +struct dell_smm_cooling_data {
>>> +	u8 fan_num;
>>> +	struct dell_smm_data *data;
>>> +};
>>> +
>>>    MODULE_AUTHOR("Massimo Dal Zotto (dz@debian.org)");
>>>    MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
>>>    MODULE_DESCRIPTION("Dell laptop SMM BIOS hwmon driver");
>>> @@ -638,9 +645,50 @@ static void __init i8k_init_procfs(struct device *dev)
>>>
>>>    #endif
>>>
>>> -/*
>>> - * Hwmon interface
>>> - */
>>> +static int dell_smm_get_max_state(struct thermal_cooling_device *dev, unsigned long *state)
>>> +{
>>> +	struct dell_smm_cooling_data *cdata = dev->devdata;
>>> +
>>> +	*state = cdata->data->i8k_fan_max;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int dell_smm_get_cur_state(struct thermal_cooling_device *dev, unsigned long *state)
>>> +{
>>> +	struct dell_smm_cooling_data *cdata = dev->devdata;
>>> +	int ret;
>>> +
>>> +	ret = i8k_get_fan_status(cdata->data, cdata->fan_num);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	*state = ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int dell_smm_set_cur_state(struct thermal_cooling_device *dev, unsigned long state)
>>> +{
>>> +	struct dell_smm_cooling_data *cdata = dev->devdata;
>>> +	struct dell_smm_data *data = cdata->data;
>>> +	int ret;
>>> +
>>> +	if (state > data->i8k_fan_max)
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&data->i8k_mutex);
>>> +	ret = i8k_set_fan(data, cdata->fan_num, (int)state);
>>> +	mutex_unlock(&data->i8k_mutex);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct thermal_cooling_device_ops dell_smm_cooling_ops = {
>>> +	.get_max_state = dell_smm_get_max_state,
>>> +	.get_cur_state = dell_smm_get_cur_state,
>>> +	.set_cur_state = dell_smm_set_cur_state,
>>> +};
>>>
>>>    static umode_t dell_smm_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
>>>    				   int channel)
>>> @@ -941,6 +989,37 @@ static const struct hwmon_chip_info dell_smm_chip_info = {
>>>    	.info = dell_smm_info,
>>>    };
>>>
>>> +static int __init dell_smm_init_cdev(struct device *dev, u8 fan_num)
>>> +{
>>> +	struct dell_smm_data *data = dev_get_drvdata(dev);
>>> +	struct thermal_cooling_device *cdev;
>>> +	struct dell_smm_cooling_data *cdata;
>>> +	int ret = 0;
>>> +	char *name;
>>> +
>>> +	name = kasprintf(GFP_KERNEL, "dell-smm-fan%u", fan_num + 1);
>>> +	if (!name)
>>> +		return -ENOMEM;
>>> +
>>> +	cdata = devm_kmalloc(dev, sizeof(*cdata), GFP_KERNEL);
>>> +	if (cdata) {
>>> +		cdata->fan_num = fan_num;
>>> +		cdata->data = data;
>>> +		cdev = devm_thermal_of_cooling_device_register(dev, NULL, name, cdata,
>>> +							       &dell_smm_cooling_ops);
>>> +		if (IS_ERR(cdev)) {
>>> +			devm_kfree(dev, cdata);
>>> +			ret = PTR_ERR(cdev);
>>> +		}
>>> +	} else {
>>> +		ret = -ENOMEM;
>>> +	}
>>> +
>>> +	kfree(name);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>    static int __init dell_smm_init_hwmon(struct device *dev)
>>>    {
>>>    	struct dell_smm_data *data = dev_get_drvdata(dev);
>>> @@ -967,6 +1046,15 @@ static int __init dell_smm_init_hwmon(struct device *dev)
>>>    			continue;
>>>
>>>    		data->fan[i] = true;
>>> +
>>> +		/* the cooling device it not critical, ignore failures */
>>> +		if (IS_REACHABLE(CONFIG_THERMAL)) {
>>> +			err = dell_smm_init_cdev(dev, i);
>>> +			if (err < 0)
>>> +				dev_err(dev, "Failed to register cooling device for fan %u\n",
>>> +					i + 1);
>>> +		}
>>> +
>>>    		data->fan_nominal_speed[i] = devm_kmalloc_array(dev, data->i8k_fan_max + 1,
>>>    								sizeof(*data->fan_nominal_speed[i]),
>>>    								GFP_KERNEL);
>>> --
>>> 2.30.2
>>>
>> Any thoughts on this? I tested it on a Dell Inspiron 3505, so i can prove it works.
> 
> Hello! If hwmon maintainers are happy with this approach and this new
> API then I'm fine with it. Maybe one thing to discuss, should not be
> dell_smm_init_cdev() fatal on error?

"the cooling device it not critical, ignore failures"

Besides the misspelling - if it is not fatal, the code should not use
dev_err() but dev_warning(). Other than that I am ok as well.

Guenter
