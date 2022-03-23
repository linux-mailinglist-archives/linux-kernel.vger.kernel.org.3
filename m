Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE34E4FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbiCWJtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiCWJtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:49:46 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30A35FD9;
        Wed, 23 Mar 2022 02:48:16 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id bi12so1702095ejb.3;
        Wed, 23 Mar 2022 02:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=PRqqoL9CnfGAKj9tbMC9+tkIa+u9q7uMWZ60TfiHncQ=;
        b=3/JclvJiuDbaHdmHzgW9hrBlYz3J5pqpWJBhIn7uQzOmpBTnMj7EcrLjPFzCJWkt/M
         /24VRS6j0rMUwNvgA/akcBAPjrMNGc7uHLn3taC8/Y8YGImfaRmLJqiLotwfdlfIr1+z
         F9ZeBRurZQtVkpnKKuVP+4TJhaNJSQNETWmF2fSoJaHj1EhK/bnhTQD6VIWkfrH2Iqj+
         kux5jT2yCDQpKhA6e1+jSh9zPTY+eIUUJ+i509XwYm3Gf5ZhcUBdfCEHvTqbeg+oxDTT
         lXDSyH7LAwXImG3DbfuEfFiM/W+hMG9cIIWreAo9Gg3+BnZTZTVGaglKW1Rqg4bgFehc
         IdvQ==
X-Gm-Message-State: AOAM531qVJ7UJCmIQ/xTWDTgh0PE1e3BJOxJanoyaHZt+Pq4FBbK8vpL
        frYPEoZzKVvgsa6mUceeT24=
X-Google-Smtp-Source: ABdhPJw6T/zZOwaVo7qGDuY48WS9ZdH6rtWNyliGC6aqvxDyLma2jGVbzRmKDkI302Zua7QF+t0Q7A==
X-Received: by 2002:a17:906:c111:b0:6db:cf0e:3146 with SMTP id do17-20020a170906c11100b006dbcf0e3146mr30866519ejc.280.1648028895162;
        Wed, 23 Mar 2022 02:48:15 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id ga5-20020a1709070c0500b006de43e9605asm9656907ejc.181.2022.03.23.02.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:48:14 -0700 (PDT)
Message-ID: <a730f531-4e89-da90-d100-5090a392c1a8@kernel.org>
Date:   Wed, 23 Mar 2022 10:48:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 4/4] power: supply: max17042_battery: read battery
 properties from device tree
Content-Language: en-US
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm>
 <20220318001048.20922-5-sebastian.krzyszkowiak@puri.sm>
 <354ec362-0883-ccfe-9e19-7897318e5e08@kernel.org>
 <3482664.QJadu78ljV@pliszka>
In-Reply-To: <3482664.QJadu78ljV@pliszka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2022 22:24, Sebastian Krzyszkowiak wrote:
> On piątek, 18 marca 2022 09:40:36 CET Krzysztof Kozlowski wrote:
>> On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
>>> So far configuring the gauge was only possible using platform data,
>>> with no way to provide the configuration on device tree-based platforms.
>>>
>>> Change that by looking up the configuration values from monitored-battery
>>> property. This is especially useful on models implementing ModelGauge m5
>>> EZ
>>> algorithm, such as MAX17055, as all the required configuration can be
>>> derived from a "simple-battery" DT node there.
>>>
>>> In order to be able to access power supply framework in get_of_pdata,
>>> move devm_power_supply_register earlier in max17042_probe.
>>>
>>> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
>>> ---
>>>
>>>  drivers/power/supply/max17042_battery.c | 50 +++++++++++++++++++------
>>>  include/linux/power/max17042_battery.h  |  1 +
>>>  2 files changed, 40 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/power/supply/max17042_battery.c
>>> b/drivers/power/supply/max17042_battery.c index
>>> c39250349a1d..4c33565802d5 100644
>>> --- a/drivers/power/supply/max17042_battery.c
>>> +++ b/drivers/power/supply/max17042_battery.c
>>> @@ -937,7 +937,9 @@ max17042_get_of_pdata(struct max17042_chip *chip)
>>>
>>>  	struct device *dev = &chip->client->dev;
>>>  	struct device_node *np = dev->of_node;
>>>  	u32 prop;
>>>
>>> +	u64 data64;
>>>
>>>  	struct max17042_platform_data *pdata;
>>>
>>> +	struct power_supply_battery_info *info;
>>>
>>>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>>  	if (!pdata)
>>>
>>> @@ -961,6 +963,32 @@ max17042_get_of_pdata(struct max17042_chip *chip)
>>>
>>>  	if (of_property_read_s32(np, "maxim,over-volt", &pdata->vmax))
>>>  	
>>>  		pdata->vmax = INT_MAX;
>>>
>>> +	if (pdata->enable_current_sense &&
>>> +	    power_supply_get_battery_info(chip->battery, &info) == 0) {
>>> +		pdata->config_data = devm_kzalloc(dev, sizeof(*pdata-
>> config_data),
>>> GFP_KERNEL); +		if (!pdata->config_data)
>>> +			return NULL;
>>> +
>>> +		if (info->charge_full_design_uah != -EINVAL) {
>>> +			data64 = (u64)info->charge_full_design_uah * 
> pdata->r_sns;
>>> +			do_div(data64, MAX17042_CAPACITY_LSB);
>>> +			pdata->config_data->design_cap = (u16)data64;
>>> +			pdata->enable_por_init = true;
>>> +		}
>>> +		if (info->charge_term_current_ua != -EINVAL) {
>>> +			data64 = (u64)info->charge_term_current_ua * 
> pdata->r_sns;
>>> +			do_div(data64, MAX17042_CURRENT_LSB);
>>> +			pdata->config_data->ichgt_term = (u16)data64;
>>> +			pdata->enable_por_init = true;
>>> +		}
>>> +		if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
>>> +			if (info->voltage_max_design_uv > 4250000) {
>>> +				pdata->config_data->model_cfg = 
> MAX17055_MODELCFG_VCHG_BIT;
>>> +				pdata->enable_por_init = true;
>>> +			}
>>> +		}
>>> +	}
>>> +
>>>
>>>  	return pdata;
>>>  
>>>  }
>>>  #endif
>>>
>>> @@ -1092,16 +1120,23 @@ static int max17042_probe(struct i2c_client
>>> *client,> 
>>>  		return -EINVAL;
>>>  	
>>>  	}
>>>
>>> +	i2c_set_clientdata(client, chip);
>>> +	psy_cfg.drv_data = chip;
>>> +	psy_cfg.of_node = dev->of_node;
>>> +
>>> +	chip->battery = devm_power_supply_register(&client->dev, 
> max17042_desc,
>>> +						   
> &psy_cfg);
>>> +	if (IS_ERR(chip->battery)) {
>>> +		dev_err(&client->dev, "failed: power supply 
> register\n");
>>> +		return PTR_ERR(chip->battery);
>>> +	}
>>
>> I don't think it is correct. You register power supply, thus making it
>> available for system, before configuring most of the data. For short
>> time the chip might report to the system bogus results and events.
>>
>> Instead I think you should split it into two parts - init which happens
>> before registering power supply and after.
> 
> Simply splitting initialization into two parts won't really help. If you set 
> capacity, current, Vchg and refresh the model after registering power supply, 
> you will still end up having a short time window with bogus results. Looking 
> at other drivers, they seem to deal with it in the same way - they register 
> the power supply early, before the driver can fully configure the device.
> 
> To actually fix the problem with bogus data on init, it seems like we would 
> either need some support from the power supply framework to notify it when can 
> it actually start expecting correct data, or have a way to access the battery 
> information without having to register power supply beforehand.

Indeed I spotted similar pattern in other drivers, so this might be a
common issue.

> 
> Since power_supply_get_battery_info doesn't actually seem to depend on 
> power_supply device at all - it uses psy->dev for devm functions and psy-
> of_node to read the data from - I wonder if it could be split into a function 
> that only takes an of_node?

That might be the best approach.


Best regards,
Krzysztof
