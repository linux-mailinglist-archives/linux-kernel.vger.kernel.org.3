Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF449560B62
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiF2VGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiF2VGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:06:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF0E3FBF0;
        Wed, 29 Jun 2022 14:06:51 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so700682pjb.2;
        Wed, 29 Jun 2022 14:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8p+JOQ19xWokrdD2iUophisiJ9mD6MuQuzslw5aPPt8=;
        b=pBDhbsa65pfboiBYSIPpuk5KeIXyy0CQwKFEJmWAxZi2DC419WqJc0EL/OQYVNSaQl
         yKjLEf/pFzk45D9E7KNeB4dnQXjiBvD8UxBN31ZoFpf9/lH/Jgq1r4YxOoN6tncKFzYI
         NzxYHA0UCTUAIW2ULluh+3s2lqPBpt8hB84OacsdqUXwz8XphTIzOeCUYrR4fiqXEbUA
         zfTtNFhGVEy3TXntUEu6Xrfab9eP65FLmP15nS6c8uNuioDmDv3AtIyHz8Zs4KWrmdC2
         M0CwsJh2UfSEOs7LBhI1eOYvFiAhwHnF2UQWktnMsjKgDpOc2Folx0VSewBYKJHOFcvD
         MnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8p+JOQ19xWokrdD2iUophisiJ9mD6MuQuzslw5aPPt8=;
        b=Gro5dPtQZuwVI0VmD2xbxN663JhcEjnfBPmXTzrBRxSsZ+aYUA8cjzeXIahufbDt4P
         OELqP8pBPvuoWvRex+e8PeA6JVrqlGwpIMaNrNldGWP/DO2Emg4m9wdQSkoaNoMTFy8R
         nSNXC9rhMXE43msXCNqVkOMqdJq/OegrQ2Kyqk1vEZmzDcJaqmLeVPNabrgCsdK6uZN0
         3YyRbl3vPHwrZ46Peqv5I31mO+ajtnLYAwQMsTErU94STXXSDyO6upgo31cQpUxYlJg/
         Mh+dVuhMrHxM6g4iM9UTLWbQLOWgF33SOQ3yw3UwsdcwL4wBky8F6C25QI1nMj4RZ1XV
         OXtA==
X-Gm-Message-State: AJIora/e73RwLM4As/lhqzkpoYGcOrz/T3l5I+YHifcIAxa/IlAaufLG
        ocZJ3FcS4TxL+tnFr0yL6VG5YvvJ0R0=
X-Google-Smtp-Source: AGRyM1s+IVwYUeIRlFUjDSpO5yq9/VlA/lFPZa6AvW0otsJCgzZyLyBPKOeccAiaY/j4LdhIZUmESQ==
X-Received: by 2002:a17:90a:31c1:b0:1ec:729f:36b7 with SMTP id j1-20020a17090a31c100b001ec729f36b7mr7669431pjf.123.1656536811190;
        Wed, 29 Jun 2022 14:06:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s37-20020a056a0017a500b0052513b5d078sm11984154pfg.31.2022.06.29.14.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:06:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 29 Jun 2022 14:06:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add support for Maximus XI Hero
Message-ID: <20220629210649.GA3936933@roeck-us.net>
References: <20220627225437.87462-1-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627225437.87462-1-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:54:36AM +0200, Eugene Shalygin wrote:
> From: Michael Carns <mike@carns.com>
> 
> Add definitions for ROG MAXIMUS XI HERO and ROG MAXIMUS XI HERO (WI-FI)
> boards.
> 
> Signed-off-by: Michael Carns <mike@carns.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/asus_ec_sensors.rst |  2 ++
>  drivers/hwmon/asus-ec-sensors.c         | 36 +++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index 00d8c46ef9e0..1e40c123db77 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -13,6 +13,8 @@ Supported boards:
>   * ROG CROSSHAIR VIII FORMULA
>   * ROG CROSSHAIR VIII HERO
>   * ROG CROSSHAIR VIII IMPACT
> + * ROG MAXIMUS XI HERO
> + * ROG MAXIMUS XI HERO (WI-FI)
>   * ROG STRIX B550-E GAMING
>   * ROG STRIX B550-I GAMING
>   * ROG STRIX X570-E GAMING
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 19d3ca71b360..625c2baa35ec 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -141,6 +141,7 @@ enum board_family {
>  	family_unknown,
>  	family_amd_400_series,
>  	family_amd_500_series,
> +	family_intel_300_series,
>  	family_intel_600_series
>  };
>  
> @@ -200,6 +201,26 @@ static const struct ec_sensor_info sensors_family_amd_500[] = {
>  		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
>  };
>  
> +static const struct ec_sensor_info sensors_family_intel_300[] = {
> +	[ec_sensor_temp_chipset] =
> +		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
> +	[ec_sensor_temp_cpu] = EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x3b),
> +	[ec_sensor_temp_mb] =
> +		EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x3c),
> +	[ec_sensor_temp_t_sensor] =
> +		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
> +	[ec_sensor_temp_vrm] = EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x3e),
> +	[ec_sensor_fan_cpu_opt] =
> +		EC_SENSOR("CPU_Opt", hwmon_fan, 2, 0x00, 0xb0),
> +	[ec_sensor_fan_vrm_hs] = EC_SENSOR("VRM HS", hwmon_fan, 2, 0x00, 0xb2),
> +	[ec_sensor_fan_water_flow] =
> +		EC_SENSOR("Water_Flow", hwmon_fan, 2, 0x00, 0xbc),
> +	[ec_sensor_temp_water_in] =
> +		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
> +	[ec_sensor_temp_water_out] =
> +		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
> +};
> +
>  static const struct ec_sensor_info sensors_family_intel_600[] = {
>  	[ec_sensor_temp_t_sensor] =
>  		EC_SENSOR("T_Sensor", hwmon_temp, 1, 0x00, 0x3d),
> @@ -281,6 +302,18 @@ static const struct ec_board_info board_info[] = {
>  		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
>  		.family = family_amd_500_series,
>  	},
> +	{
> +		.board_names = {
> +			"ROG MAXIMUS XI HERO",
> +			"ROG MAXIMUS XI HERO (WI-FI)",
> +		},
> +		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> +			SENSOR_TEMP_T_SENSOR |
> +			SENSOR_TEMP_VRM | SENSOR_SET_TEMP_WATER |
> +			SENSOR_FAN_CPU_OPT | SENSOR_FAN_WATER_FLOW,
> +		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
> +		.family = family_intel_300_series,
> +	},
>  	{
>  		.board_names = {"ROG CROSSHAIR VIII IMPACT"},
>  		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
> @@ -814,6 +847,9 @@ static int __init asus_ec_probe(struct platform_device *pdev)
>  	case family_amd_500_series:
>  		ec_data->sensors_info = sensors_family_amd_500;
>  		break;
> +	case family_intel_300_series:
> +		ec_data->sensors_info = sensors_family_intel_300;
> +		break;
>  	case family_intel_600_series:
>  		ec_data->sensors_info = sensors_family_intel_600;
>  		break;
