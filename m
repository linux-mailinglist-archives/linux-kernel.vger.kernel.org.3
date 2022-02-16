Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32554B8FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiBPSIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:08:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiBPSIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:08:38 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0CB2A4A04;
        Wed, 16 Feb 2022 10:08:25 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q5so1973785oij.6;
        Wed, 16 Feb 2022 10:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ynGAPs6vewqkUM+uFjFuuBNNaKXpBR9qE62w23OOkpQ=;
        b=MFIB/pTbkxtdy+E48fWpYvRcwoXzLYx5CSk/pVrhc5klo71wVI3Ci3cWHfMJ0J9iCP
         yNlvMC0ixq8vrPztVqYZw4gUlkJnpDm81EOBL+Vq75cVn2NJV+efIwTehzXf/VSIz07s
         W3LwXxc7hohSkqjntqkXY72k9nJVrHZIRBih49mT+YJDT0wLzn9G8FR0MTt43oOBJi9m
         7Nq/Ab/VCpsjQ+1Fl2+x/PESySBuG1ThNwzY1NrBUJkzrTc+ocHLi+ygt03NxEWY6Vkz
         fbStwmVPHC+XLLvfWB1MLaSFMm4XHO4qCzYdgmpM/StmPx+pmqLkp7aOZlwBv2qP89ZJ
         5t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=ynGAPs6vewqkUM+uFjFuuBNNaKXpBR9qE62w23OOkpQ=;
        b=NHrpBGHpS1L70CL5Ln+AWNECZoVwD0SUP76hty0XQbkOlA5muDsPGWhckoBTFrSng+
         /QDBoDVXNeIiY3GiUgX7LHGHNFSHU6Nxao/O0qKGlFhLAqqjMl7SvyuFSHxw+5n9+Ach
         3Mxph9fUQLORDHoG5eCMNDIXEuKNhB3LfBpOLwhgIf9gqRbAq6ltiK0xLff3T81taDTa
         U/aoNDlwG0ZSmGkTNW0NQDMFfbl6juuNeK5RrGpf5MH1B5Z35tKUhhQYLGztZh+5p3I7
         O2cNCqbNQvyRWq4wqHgzH9uopBl1JBhc9B8fveFCYiyS7HhK7A8GrifAYrjIDzibKIy4
         tPag==
X-Gm-Message-State: AOAM5329w51gDk0wHwgDaimjQv5v+klpxHbdx1KbWZgfTmTDFJcIrLYy
        Qm8U/lqAigKWnjIu8kUQ8tXXrq0FsFlZ3w==
X-Google-Smtp-Source: ABdhPJyTvp8Xff06BppHZI0rsKZaIqitugshaW9L52ilAinPQf64JMnMe5Sz1HxGq1lLj3XF6RV3lw==
X-Received: by 2002:aca:5f42:0:b0:2ce:6ee7:2cb1 with SMTP id t63-20020aca5f42000000b002ce6ee72cb1mr1269764oib.223.1645034904906;
        Wed, 16 Feb 2022 10:08:24 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w13sm460356ooj.5.2022.02.16.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 10:08:23 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 16 Feb 2022 10:08:22 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] hwmon: (asus-ec-sensors) merge setup functions
Message-ID: <20220216180822.GA3300192@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Wed, Feb 16, 2022 at 06:15:32PM +0100, Eugene Shalygin wrote:
> Merge configure_sensor_setup() into probe().
> 
> Changes:
>  - v2: add local struct device *dev = &pdev->dev;
>  - v3: initialize dev at declaration
>  - v4: fix checkpatch warning
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

$ scripts/checkpatch.pl --strict asus-ec
WARNING: braces {} are not necessary for single statement blocks
#55: FILE: drivers/hwmon/asus-ec-sensors.c:607:
+	if (!board_sensors) {
 		return -ENODEV;
 	}

CHECK: Alignment should match open parenthesis
#60: FILE: drivers/hwmon/asus-ec-sensors.c:612:
+	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data),
+			     GFP_KERNEL);

WARNING: braces {} are not necessary for single statement blocks
#61: FILE: drivers/hwmon/asus-ec-sensors.c:613:
+	if (!ec_data) {
+		return -ENOMEM;
+	}

total: 0 errors, 2 warnings, 1 checks, 61 lines checked

> ---
>  drivers/hwmon/asus-ec-sensors.c | 38 ++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index bfac08a5dc57..ef887168df20 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -589,23 +589,33 @@ get_board_sensors(const struct device *dev)
>  	return (unsigned long)dmi_entry->driver_data;
>  }
>  
> -static int __init configure_sensor_setup(struct device *dev)
> +static int __init asus_ec_probe(struct platform_device *pdev)
>  {
> -	struct ec_sensors_data *ec_data = dev_get_drvdata(dev);
> +	const struct hwmon_channel_info **ptr_asus_ec_ci;
>  	int nr_count[hwmon_max] = { 0 }, nr_types = 0;
> -	struct device *hwdev;
>  	struct hwmon_channel_info *asus_ec_hwmon_chan;
> -	const struct hwmon_channel_info **ptr_asus_ec_ci;
>  	const struct hwmon_chip_info *chip_info;
> +	struct device *dev = &pdev->dev;
> +	struct ec_sensors_data *ec_data;
>  	const struct ec_sensor_info *si;
>  	enum hwmon_sensor_types type;
> +	unsigned long board_sensors;
> +	struct device *hwdev;
>  	unsigned int i;
>  
> -	ec_data->board_sensors = get_board_sensors(dev);
> -	if (!ec_data->board_sensors) {
> +	board_sensors = get_board_sensors(dev);
> +	if (!board_sensors) {
>  		return -ENODEV;
>  	}
>  
> +	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data),
> +			     GFP_KERNEL);
> +	if (!ec_data) {
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(dev, ec_data);
> +	ec_data->board_sensors = board_sensors;
>  	ec_data->nr_sensors = board_sensors_count(ec_data->board_sensors);
>  	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
>  					sizeof(struct ec_sensor), GFP_KERNEL);
> @@ -666,22 +676,6 @@ static int __init configure_sensor_setup(struct device *dev)
>  	return PTR_ERR_OR_ZERO(hwdev);
>  }
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
>  static const struct acpi_device_id acpi_ec_ids[] = {
>  	/* Embedded Controller Device */
> -- 
> 2.35.1
> 
