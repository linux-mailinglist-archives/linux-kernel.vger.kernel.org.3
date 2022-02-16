Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69C24B8C40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiBPPSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:18:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiBPPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:18:02 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9387BE38AF;
        Wed, 16 Feb 2022 07:17:49 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id o192-20020a4a2cc9000000b00300af40d795so2796554ooo.13;
        Wed, 16 Feb 2022 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LZUBzMlbYHA3s2eTK5GN4Due0r2pYlR1eEia/95E5GQ=;
        b=oztqwJWE4vWoFq9v6sNpYViA9/nQfzcHN0dqDZhtc1rQIZ0kshsUbjfJKK7CdQ752b
         CEly7MWfx6nbRmUf6G11XsKT8C0V4mFSPQTVjjSKQ3HBnVeW5iW4Q1O7gt/34F2ncu32
         lSKrdGbRXIBcOB7KzivfaQ4iB5P1I8qWQsXme8K4q6Z2hopA7476l3eiFBpt3R6BysIg
         NCZ0rJxcJj7GiN7odHx61RUMxsyeo/JGiuUuet0TxWjEV/6OJ+FL/kNsrdiidzRVU32N
         tC/NruDvpCIl8AAuw0wuV0mnMoh8ipyhP9wmoPXLKWT8zjtfbNCuKRyDhBTJNWlxsm3b
         E9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LZUBzMlbYHA3s2eTK5GN4Due0r2pYlR1eEia/95E5GQ=;
        b=ixBVlAs8gu1sx9yjOVSD0os+zdWqsxAhkpoBTZgXv7Xf/MFtqCuKy2YXU+J5s0AA5S
         yqQpOlqOdwWyyRU2FHqDloVpZgPlg/nsuK5iSBYAiClz2OJtd0qXiyWtzESmzbaeFwKI
         go3vg5m0snEpBlD28kLdy5srrTYHl4hSgnpD8csocIMUaKpEinZ+MQ2l0lSOzcP5KvYL
         Ar/ZfN0z0XBqwGof27Nfyuy3gd+uqLTji4Ak4UY2XxRkQiUmGuRAr6gym/tSOr1FYQ5J
         T+gH9iy4PVFwM0bNh2k+tqaSOeF7E8arEHzwGEydngaLMIQapaYK/3YYvxr/ZklAkVWu
         5JSw==
X-Gm-Message-State: AOAM533/R2c8QvujoJnNM+fQfz2am6PS6ENZcjwdZ5qZrxqhzBNUA+Aq
        XyC9Qv3EuC+MLo/5km0EZWG2YbDFB/mbRA==
X-Google-Smtp-Source: ABdhPJx2mICbj/HwJWEoYyd8mFTkNNGNhAq5HxeNVsU6HF94JynQVqT/2i673guEM6jJ5KxpGRPiVg==
X-Received: by 2002:a05:6870:e612:b0:ce:c0c9:6e1 with SMTP id q18-20020a056870e61200b000cec0c906e1mr645703oag.307.1645024668919;
        Wed, 16 Feb 2022 07:17:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e16sm15267855otr.11.2022.02.16.07.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 07:17:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d720b4a6-e318-8738-d9f4-5017acd558e6@roeck-us.net>
Date:   Wed, 16 Feb 2022 07:17:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) merge setup functions
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220216081920.2334468-1-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220216081920.2334468-1-eugene.shalygin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/16/22 00:19, Eugene Shalygin wrote:
> Merge configure_sensor_setup() into probe().
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
> ---
>   drivers/hwmon/asus-ec-sensors.c | 55 ++++++++++++++-------------------
>   1 file changed, 24 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index bfac08a5dc57..45de8d34a588 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -589,31 +589,40 @@ get_board_sensors(const struct device *dev)
>   	return (unsigned long)dmi_entry->driver_data;
>   }
>   
> -static int __init configure_sensor_setup(struct device *dev)
> +static int __init asus_ec_probe(struct platform_device *pdev)
>   {
> -	struct ec_sensors_data *ec_data = dev_get_drvdata(dev);
> +	const struct hwmon_channel_info **ptr_asus_ec_ci;
>   	int nr_count[hwmon_max] = { 0 }, nr_types = 0;
> -	struct device *hwdev;
>   	struct hwmon_channel_info *asus_ec_hwmon_chan;
> -	const struct hwmon_channel_info **ptr_asus_ec_ci;
>   	const struct hwmon_chip_info *chip_info;
>   	const struct ec_sensor_info *si;
> +	struct ec_sensors_data *ec_data;
>   	enum hwmon_sensor_types type;
> +	unsigned long board_sensors;
> +	struct device *hwdev;
>   	unsigned int i;
>   
> -	ec_data->board_sensors = get_board_sensors(dev);
> -	if (!ec_data->board_sensors) {
> +	board_sensors = get_board_sensors(&pdev->dev);
> +	if (!board_sensors) {
>   		return -ENODEV;
>   	}
>   
> +	ec_data = devm_kzalloc(&pdev->dev, sizeof(struct ec_sensors_data),
> +			     GFP_KERNEL);
> +	if (!ec_data) {
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, ec_data);
> +	ec_data->board_sensors = board_sensors;
>   	ec_data->nr_sensors = board_sensors_count(ec_data->board_sensors);
> -	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
> +	ec_data->sensors = devm_kcalloc(&pdev->dev, ec_data->nr_sensors,
>   					sizeof(struct ec_sensor), GFP_KERNEL);

Almost the entire change consists of replacing "dev" with "&pdev->dev".
Please add
	struct device *dev = &pdev->dev;
at the beginning of this function to avoid this.

Guenter

>   
>   	setup_sensor_data(ec_data);
> -	ec_data->registers = devm_kcalloc(dev, ec_data->nr_registers,
> +	ec_data->registers = devm_kcalloc(&pdev->dev, ec_data->nr_registers,
>   					  sizeof(u16), GFP_KERNEL);
> -	ec_data->read_buffer = devm_kcalloc(dev, ec_data->nr_registers,
> +	ec_data->read_buffer = devm_kcalloc(&pdev->dev, ec_data->nr_registers,
>   					    sizeof(u8), GFP_KERNEL);
>   
>   	if (!ec_data->registers || !ec_data->read_buffer) {
> @@ -622,7 +631,7 @@ static int __init configure_sensor_setup(struct device *dev)
>   
>   	fill_ec_registers(ec_data);
>   
> -	ec_data->aml_mutex = asus_hw_access_mutex(dev);
> +	ec_data->aml_mutex = asus_hw_access_mutex(&pdev->dev);
>   
>   	for (i = 0; i < ec_data->nr_sensors; ++i) {
>   		si = get_sensor_info(ec_data, i);
> @@ -635,11 +644,11 @@ static int __init configure_sensor_setup(struct device *dev)
>   		nr_count[hwmon_chip]++, nr_types++;
>   
>   	asus_ec_hwmon_chan = devm_kcalloc(
> -		dev, nr_types, sizeof(*asus_ec_hwmon_chan), GFP_KERNEL);
> +		&pdev->dev, nr_types, sizeof(*asus_ec_hwmon_chan), GFP_KERNEL);
>   	if (!asus_ec_hwmon_chan)
>   		return -ENOMEM;
>   
> -	ptr_asus_ec_ci = devm_kcalloc(dev, nr_types + 1,
> +	ptr_asus_ec_ci = devm_kcalloc(&pdev->dev, nr_types + 1,
>   				       sizeof(*ptr_asus_ec_ci), GFP_KERNEL);
>   	if (!ptr_asus_ec_ci)
>   		return -ENOMEM;
> @@ -651,37 +660,21 @@ static int __init configure_sensor_setup(struct device *dev)
>   		if (!nr_count[type])
>   			continue;
>   
> -		asus_ec_hwmon_add_chan_info(asus_ec_hwmon_chan, dev,
> +		asus_ec_hwmon_add_chan_info(asus_ec_hwmon_chan, &pdev->dev,
>   					     nr_count[type], type,
>   					     hwmon_attributes[type]);
>   		*ptr_asus_ec_ci++ = asus_ec_hwmon_chan++;
>   	}
>   
> -	dev_info(dev, "board has %d EC sensors that span %d registers",
> +	dev_info(&pdev->dev, "board has %d EC sensors that span %d registers",
>   		 ec_data->nr_sensors, ec_data->nr_registers);
>   
> -	hwdev = devm_hwmon_device_register_with_info(dev, "asusec",
> +	hwdev = devm_hwmon_device_register_with_info(&pdev->dev, "asusec",
>   						     ec_data, chip_info, NULL);
>   
>   	return PTR_ERR_OR_ZERO(hwdev);
>   }
>   
> -static int __init asus_ec_probe(struct platform_device *pdev)
> -{
> -	struct ec_sensors_data *state;
> -	int status = 0;
> -
> -	state = devm_kzalloc(&pdev->dev, sizeof(struct ec_sensors_data),
> -			     GFP_KERNEL);
> -
> -	if (!state) {
> -		return -ENOMEM;
> -	}
> -
> -	dev_set_drvdata(&pdev->dev, state);
> -	status = configure_sensor_setup(&pdev->dev);
> -	return status;
> -}
>   
>   static const struct acpi_device_id acpi_ec_ids[] = {
>   	/* Embedded Controller Device */

