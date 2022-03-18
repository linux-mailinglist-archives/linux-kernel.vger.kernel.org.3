Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D564DD656
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiCRImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiCRImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:42:01 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AC517C412;
        Fri, 18 Mar 2022 01:40:41 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id p6so5797139lfh.1;
        Fri, 18 Mar 2022 01:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x+aZsSUA8MQf/8QzgnABXBDq4WnY5Owhm5CoPJ80F7g=;
        b=rJ3HldNqM/0pOtfNWGam+zcNph+gB7N5l0i0tz8VZhwjl8TREYRCFctMjV83GG8Yfz
         s/CZMua9xIeL3/7IUNS/zvrJHQ5fxMiSfKaDCda8ww1Ib5nm+FL/zriNLjePM5usgfjJ
         TRY6vO/MXUwPdcZTcy+UoEWy6QbjU2fgqXZBN6c13RIWfLQTwqVru0RT4PfGs/F7MmRI
         xldA0FoGSF3hul37rfOHRkqIR0hqm8CyL6q6qPalT7cVPdj39eRB5yQwtwIm8uLsSLxo
         5wo4CdX42R3Sd2hIIuId4BjU/x2RSTuJBKBxF//UkpM+0n9K5mQMocaDLGA4/YPiu7wi
         TvLw==
X-Gm-Message-State: AOAM531CJWrV8G+DUUfaGd5p6MytEO47v48S4FxElMKbk3I2YBqRS5Z3
        5W50BjId6AdPwWPayu93wt0=
X-Google-Smtp-Source: ABdhPJx7het/ER7SMI1T3LzCDB2G6vbr12KVLeWnqK0CSFgjlBYzApaS2EZB1CbIacc4hryCrLsDWg==
X-Received: by 2002:a05:6512:3192:b0:448:6ef9:12f2 with SMTP id i18-20020a056512319200b004486ef912f2mr5280424lfe.483.1647592839934;
        Fri, 18 Mar 2022 01:40:39 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id i24-20020a2e8658000000b0024806af7079sm840430ljj.43.2022.03.18.01.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 01:40:39 -0700 (PDT)
Message-ID: <354ec362-0883-ccfe-9e19-7897318e5e08@kernel.org>
Date:   Fri, 18 Mar 2022 09:40:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220318001048.20922-5-sebastian.krzyszkowiak@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
> So far configuring the gauge was only possible using platform data,
> with no way to provide the configuration on device tree-based platforms.
> 
> Change that by looking up the configuration values from monitored-battery
> property. This is especially useful on models implementing ModelGauge m5 EZ
> algorithm, such as MAX17055, as all the required configuration can be
> derived from a "simple-battery" DT node there.
> 
> In order to be able to access power supply framework in get_of_pdata,
> move devm_power_supply_register earlier in max17042_probe.
> 
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---
>  drivers/power/supply/max17042_battery.c | 50 +++++++++++++++++++------
>  include/linux/power/max17042_battery.h  |  1 +
>  2 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index c39250349a1d..4c33565802d5 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -937,7 +937,9 @@ max17042_get_of_pdata(struct max17042_chip *chip)
>  	struct device *dev = &chip->client->dev;
>  	struct device_node *np = dev->of_node;
>  	u32 prop;
> +	u64 data64;
>  	struct max17042_platform_data *pdata;
> +	struct power_supply_battery_info *info;
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
> @@ -961,6 +963,32 @@ max17042_get_of_pdata(struct max17042_chip *chip)
>  	if (of_property_read_s32(np, "maxim,over-volt", &pdata->vmax))
>  		pdata->vmax = INT_MAX;
>  
> +	if (pdata->enable_current_sense &&
> +	    power_supply_get_battery_info(chip->battery, &info) == 0) {
> +		pdata->config_data = devm_kzalloc(dev, sizeof(*pdata->config_data), GFP_KERNEL);
> +		if (!pdata->config_data)
> +			return NULL;
> +
> +		if (info->charge_full_design_uah != -EINVAL) {
> +			data64 = (u64)info->charge_full_design_uah * pdata->r_sns;
> +			do_div(data64, MAX17042_CAPACITY_LSB);
> +			pdata->config_data->design_cap = (u16)data64;
> +			pdata->enable_por_init = true;
> +		}
> +		if (info->charge_term_current_ua != -EINVAL) {
> +			data64 = (u64)info->charge_term_current_ua * pdata->r_sns;
> +			do_div(data64, MAX17042_CURRENT_LSB);
> +			pdata->config_data->ichgt_term = (u16)data64;
> +			pdata->enable_por_init = true;
> +		}
> +		if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
> +			if (info->voltage_max_design_uv > 4250000) {
> +				pdata->config_data->model_cfg = MAX17055_MODELCFG_VCHG_BIT;
> +				pdata->enable_por_init = true;
> +			}
> +		}
> +	}
> +
>  	return pdata;
>  }
>  #endif
> @@ -1092,16 +1120,23 @@ static int max17042_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> +	i2c_set_clientdata(client, chip);
> +	psy_cfg.drv_data = chip;
> +	psy_cfg.of_node = dev->of_node;
> +
> +	chip->battery = devm_power_supply_register(&client->dev, max17042_desc,
> +						   &psy_cfg);
> +	if (IS_ERR(chip->battery)) {
> +		dev_err(&client->dev, "failed: power supply register\n");
> +		return PTR_ERR(chip->battery);
> +	}

I don't think it is correct. You register power supply, thus making it
available for system, before configuring most of the data. For short
time the chip might report to the system bogus results and events.

Instead I think you should split it into two parts - init which happens
before registering power supply and after.


Best regards,
Krzysztof
