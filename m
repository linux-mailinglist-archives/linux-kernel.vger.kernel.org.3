Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1034B8E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiBPQyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:54:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbiBPQyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:54:37 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94391293B73;
        Wed, 16 Feb 2022 08:54:25 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so3093366oor.12;
        Wed, 16 Feb 2022 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=irVm+qBo8svStMpsZJCnZIKNaziBxfdvJdyIgNn85eY=;
        b=lYertIEN/fbrMEjIhG5ek+BaOWViioygwaC9f25ihENKM1DLKXrvX7BTVnbJPGhku4
         MVik11ta5bRu+5vvJHx8DogmmPCSPGLHE5+T+3MBMUdw/FQnr9t1xtuGRDFu+UA0zWXK
         gBqq555e/MIJFq6nzWSi/BD9oJQUd7FBUck1NG2TRHL5tBNjQCWC4o3l98IAV9e0KZfo
         gi7FEMNs8C92XIj4JW51cRtfK0Jl4jEORmxFrJVMvA+OMnoc6tmo7zxGn0tQM7gKIYPV
         ZPSSTHzFBbApWJdAu+HvwJCWZy6VmCydFEx33/WmX2799KS+y9/yalsxJNforM3KU+RL
         z+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=irVm+qBo8svStMpsZJCnZIKNaziBxfdvJdyIgNn85eY=;
        b=WhUviVLJMvlOFvVpvuuBjzGud6qD9doVJeR3g1qi74WadsK8Lx+dojxohaOnjfANX+
         lo1BLEcEFQxeroDLzycpgDes7EaXI4TVOaVaeUnimDoanxpPL5PRZSHmcpxDo2zXQefp
         5/hkchjEZZaHcr8Nsy3vz0D3vBac7GrcFf6Zo4DqmDFJbr6djGcaVMk1yCDmcK/GAF7g
         jCXqlybVv0UM+24+ATQzgUTPXrbUdZedcdStOAh8lFBiRG/HZTLB7klvSlvUkr1IOYc6
         d1i+8nIMZF5XvMMVv8bX436ks9QzYMzmA231LurKm3vBzctDzmwUW4tpTl9gomYmwLVn
         dbZA==
X-Gm-Message-State: AOAM531QUFRgaEem/bgAkGTEd1Lyoj5cS1L2B0iNGzlP9Y+udvBSr9hB
        eEOZntOzKfhUySHNV5XXTiE=
X-Google-Smtp-Source: ABdhPJw8GIVBuo8zQwdNLzBSGzyMHqEPey3zm13zg20cmv0HcQsxlo5Ok2VYndP5yJZ/iydPXOPyQA==
X-Received: by 2002:a05:6870:6492:b0:d1:4596:ee34 with SMTP id cz18-20020a056870649200b000d14596ee34mr812988oab.127.1645030464813;
        Wed, 16 Feb 2022 08:54:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f21sm15136638otq.4.2022.02.16.08.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 08:54:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <01c6bafe-4e6e-98ff-fa4c-01060f251049@roeck-us.net>
Date:   Wed, 16 Feb 2022 08:54:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220216153407.2412409-1-eugene.shalygin@gmail.com>
 <20220216160128.2418025-1-eugene.shalygin@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3] hwmon: (asus-ec-sensors) merge setup functions
In-Reply-To: <20220216160128.2418025-1-eugene.shalygin@gmail.com>
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

On 2/16/22 08:01, Eugene Shalygin wrote:
> Merge configure_sensor_setup() into probe().
> 
> Changes:
>   - v2: add local struct device *dev = &pdev->dev;
>   - v3: initialize dev at declaration
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>


Please use checkpatch and fix what it reports,, and please
do not send patches as reply to previous versions of a patch
or patch series.

> ---
>   drivers/hwmon/asus-ec-sensors.c | 38 ++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index bfac08a5dc57..b9eb9126e433 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -589,23 +589,33 @@ get_board_sensors(const struct device *dev)
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

I don't really see the point of reordering (most of) the variables
above, only to ...

>   
> -	ec_data->board_sensors = get_board_sensors(dev);
> -	if (!ec_data->board_sensors) {
> +	struct device *dev = &pdev->dev;

... add another variable at the and, after an empty line,
with no following empty line, and completely out of order with
the other variable declarations (if reverse christmas tree order
was the idea).

> +	board_sensors = get_board_sensors(dev);
> +	if (!board_sensors) {
>   		return -ENODEV;
>   	}
>   
> +	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data),
> +			     GFP_KERNEL);
> +	if (!ec_data) {
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(dev, ec_data);
> +	ec_data->board_sensors = board_sensors;
>   	ec_data->nr_sensors = board_sensors_count(ec_data->board_sensors);
>   	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
>   					sizeof(struct ec_sensor), GFP_KERNEL);
> @@ -666,22 +676,6 @@ static int __init configure_sensor_setup(struct device *dev)
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

