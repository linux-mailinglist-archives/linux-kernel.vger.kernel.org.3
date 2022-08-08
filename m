Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD15E58C665
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbiHHK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHHK3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:29:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49695273D;
        Mon,  8 Aug 2022 03:29:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso14071764pjq.4;
        Mon, 08 Aug 2022 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=7sLJU4FguPl7so68C/rRxu5FseehgIH6MH51qVnSXUE=;
        b=P/NWX6dxl3TJqkTMylsVm1Mdv3QGoXz14KS+vYLuvKMpB8dArK5DDhf3mLh964vy8N
         NVtvO20HjvD0h306jLl42FSMXLwsmZq8N5+R4NyxyYpKiPllBtqBucuikoqRkO/WlmgE
         sdeDLwA0U2wWuAHPrVwANRJjV+dcthfcXP7heXbd/dztPvppD6ORj4EYo8ydC3BLlzoB
         tekVx+vBNuLqitLQXJUR6BSO9fbfC5O2cHQhgAFDNuE6+yGss2rD8sv7cEYaylXtZ+B+
         lsVclH8QY3uIjKq/RbOZqvk8I4FmZSuRJVSlPGLqQNdzgO99rp67fmLm3ZXlK6RO/2dK
         m51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=7sLJU4FguPl7so68C/rRxu5FseehgIH6MH51qVnSXUE=;
        b=XOsykpaaW/0tvmlxVIrp0pf3jlTEwCdlCygAMFHzBHOYKUAcJEoFTWVmkJLYjAIhiT
         hsxa3JYdIn0zc6u84jtCUYl8T+X/uQcrzcij0SxGXB9YesvW/Xc/YA3Kv7sy7+yv2ePo
         v2zsFAyDPiW23UvSNnlABSBlFqAUoR/ZVUrV+Nr6p1oxAjSHi8VpJzi11QBT/GTLrrxc
         8elM+G5Iu6BtBxw+ZmCVv1EEDeeBEW0bBnzGQOPQqYBMWxAbMLPFK8mHY5oGC15hnUog
         ffLmQ1zUsL8JzgnOWjWIc11mSIXneaiXVnhTaYxJUf47HZ5SRbLS8u3NT2XXTJ6JpjEr
         gp+w==
X-Gm-Message-State: ACgBeo3jV8YXa4b9YHPNzqMOVEinGl7PJfMcGyXSfhtKRWn1yPoAZdgm
        5zpsoXqQHZ4+B7TKK/rsUxc=
X-Google-Smtp-Source: AA6agR7rAqZDjC1bWIsFIS0LlvTSmZ8wIDjccyreDG+sBmANFjonFe20Wpf/sLtDmjyHI2IivSjnUA==
X-Received: by 2002:a17:903:292:b0:16d:5e43:bd9e with SMTP id j18-20020a170903029200b0016d5e43bd9emr18612707plr.116.1659954591793;
        Mon, 08 Aug 2022 03:29:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k4-20020a17090a62c400b001f2fc3828e4sm7793385pjs.24.2022.08.08.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:29:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 8 Aug 2022 03:29:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Jean Delvare <jdelvare@suse.com>,
        "open list:PMBUS HARDWARE MONITORING DRIVERS" 
        <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v5 26/33] hwmon/drivers/pm_bus: Switch to new of thermal
 API
Message-ID: <20220808102949.GC1969424@roeck-us.net>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-27-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804224349.1926752-27-daniel.lezcano@linexp.org>
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

On Fri, Aug 05, 2022 at 12:43:42AM +0200, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

Subject tag should be something like "hwmon: (pmbus) ...".

Also, from other patches it appears that this would or might result
in a registration failure if a thermal zone for the sensor does not
exist. This will need to be resolved before the patch is can be applied.

Guenter

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 02912022853d..3b9bb2123a1a 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1109,9 +1109,9 @@ struct pmbus_thermal_data {
>  	struct pmbus_sensor *sensor;
>  };
>  
> -static int pmbus_thermal_get_temp(void *data, int *temp)
> +static int pmbus_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
> -	struct pmbus_thermal_data *tdata = data;
> +	struct pmbus_thermal_data *tdata = tz->devdata;
>  	struct pmbus_sensor *sensor = tdata->sensor;
>  	struct pmbus_data *pmbus_data = tdata->pmbus_data;
>  	struct i2c_client *client = to_i2c_client(pmbus_data->dev);
> @@ -1135,7 +1135,7 @@ static int pmbus_thermal_get_temp(void *data, int *temp)
>  	return ret;
>  }
>  
> -static const struct thermal_zone_of_device_ops pmbus_thermal_ops = {
> +static const struct thermal_zone_device_ops pmbus_thermal_ops = {
>  	.get_temp = pmbus_thermal_get_temp,
>  };
>  
> @@ -1153,8 +1153,8 @@ static int pmbus_thermal_add_sensor(struct pmbus_data *pmbus_data,
>  	tdata->sensor = sensor;
>  	tdata->pmbus_data = pmbus_data;
>  
> -	tzd = devm_thermal_zone_of_sensor_register(dev, index, tdata,
> -						   &pmbus_thermal_ops);
> +	tzd = devm_thermal_of_zone_register(dev, index, tdata,
> +					    &pmbus_thermal_ops);
>  	/*
>  	 * If CONFIG_THERMAL_OF is disabled, this returns -ENODEV,
>  	 * so ignore that error but forward any other error.
> -- 
> 2.25.1
> 
