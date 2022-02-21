Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF14BE693
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347815AbiBUQnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:43:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiBUQnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:43:10 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6611EC69;
        Mon, 21 Feb 2022 08:42:46 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id a19so33404189qvm.4;
        Mon, 21 Feb 2022 08:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1WzDOpNHJ0rfPRdSj3JhKU3VK3POJ7SwpnBhQLRPXi4=;
        b=BNUsuQpfaVVWRiN3MmnX5/RAfoD/FMkh0rCYpi4N3w2IehBd/DlNWbByxFTOkGYbR/
         g5/vcWrlnA/+6kJ9NvFp0+kV5E2LaDPboyUMt0SfASv+fTzb/pbumnl9i+K+4Bxc3jzz
         VCABIFvazPQKgBd8HyE9elKLQJS2PKKUbwYQH6nI0fbMWJgWr6xC6h41oX9cjwGUMoIf
         kVhe5IGIc1dZ0neEh/9nO11AJ/PXPSzvAtYfqOTDDa1/nqYFDs02sCDkyzt8NTFaSkXk
         f0wA7ewfGq3BtS6ulNfGYvtd4UlEqGk8jteuxvHSAImnkRypAdd84TvoNswXtECWAARA
         cPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1WzDOpNHJ0rfPRdSj3JhKU3VK3POJ7SwpnBhQLRPXi4=;
        b=eZz0PyP8qRybv9YVXIERDf5yUPwJoVrg8gtyE+PTAbNAsbYY6DH6MStpvk+ZogbfFa
         rSby1mZfYpB2nchRfMpN5kIT4u1xqBjm6j4flpwxWjjzfPNZ66KkcToDiyYxEzXQtgX9
         9/ysY/UNw0BXzpZhlM9x2xcm4NvTxka8jDFdwRNQa/Q0offwm6r2HVg/49ReBna7saLF
         uP302+Q3UKex5Yr0FQaB7LQoBcXCVU8wBEZwHHHtHJBcnqVwHdRb/kPo1N92mda5jAQh
         xKj4U+7pQa8dUG8z2ouIVom4x6aQyVXL/6JRd6M1tz0iPgUhJxv+ZBX1uldkzFDXPFC2
         o2mQ==
X-Gm-Message-State: AOAM533LrOJag5WlL7ZeFHS2qCr32lTUq3icSeudfn4awz0efOA5JhVk
        jAEhSgHjiSR9leJA+iBD5RPm/K6zLEeDMA==
X-Google-Smtp-Source: ABdhPJwvtOwmpHQRsXYrpamk7gY5aD2VO5msr6JHKK4vgj1Xj1Ko/V0eKL/jo9jF9UOKTbb0sHqjgQ==
X-Received: by 2002:a05:622a:c9:b0:2de:15a4:6256 with SMTP id p9-20020a05622a00c900b002de15a46256mr5761940qtw.679.1645461765862;
        Mon, 21 Feb 2022 08:42:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s7sm27078557qki.20.2022.02.21.08.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:42:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ad8f0011-3444-d5df-c0b3-88d95766308d@roeck-us.net>
Date:   Mon, 21 Feb 2022 08:42:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
 <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
 <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
 <20da6f55-682f-4b30-7be7-f425f8efa995@nvidia.com>
 <437c7c3c-66d4-2665-c8fa-781979366bc3@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <437c7c3c-66d4-2665-c8fa-781979366bc3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 08:20, Dmitry Osipenko wrote:
> 21.02.2022 19:16, Jon Hunter пишет:
>>
>> On 21/02/2022 16:02, Guenter Roeck wrote:
>>
>> ...
>>
>>>> The platform I see this on does use device-tree and it does have a
>>>> node for the ti,tmp451 device which uses the lm90 device. This
>>>> platform uses the device-tree source
>>>> arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts and the tmp451
>>>> node is in arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi.
>>>>
>>>
>>> Interesting. It appears that the call to
>>> devm_thermal_zone_of_sensor_register()
>>> in the hwmon core nevertheless returns -ENODEV which is not handled
>>> properly
>>> in the hwmon core. I can see a number of reasons for this to happen:
>>> - there is no devicetree node for the lm90 device
>>> - there is no thermal-zones devicetree node
>>> - there is no thermal zone entry in the thermal-zones node which matches
>>>     the sensor
>>
>>
>> So we definitely have the node for the lm90 device and a thermal-zones
>> node, but I do not see a thermal-sensor node. Maybe this is what we are
>> missing?
> 
> Could you please try this:
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 5915fedee69b..48f80bc99fe6 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -233,8 +233,12 @@ static int hwmon_thermal_add_sensor(struct device
> *dev, int index)
>   	 * If CONFIG_THERMAL_OF is disabled, this returns -ENODEV,
>   	 * so ignore that error but forward any other error.
>   	 */
> -	if (IS_ERR(tzd) && (PTR_ERR(tzd) != -ENODEV))
> -		return PTR_ERR(tzd);
> +	if (IS_ERR(tzd)) {
> +		if (PTR_ERR(tzd) != -ENODEV)
> +			return PTR_ERR(tzd);
> +
> +		tzd = NULL;

That should just bail out. I'll send a patch in a minute.

Guenter

> +	}
> 
>   	err = devm_add_action(dev, hwmon_thermal_remove_sensor, &tdata->node);
>   	if (err)
> @@ -283,7 +287,7 @@ static void hwmon_thermal_notify(struct device *dev,
> int index)
>   	struct hwmon_thermal_data *tzdata;
> 
>   	list_for_each_entry(tzdata, &hwdev->tzdata, node) {
> -		if (tzdata->index == index) {
> +		if (tzdata->index == index && tzdata->tzd) {
>   			thermal_zone_device_update(tzdata->tzd,
>   						   THERMAL_EVENT_UNSPECIFIED);
>   		}
> 

