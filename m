Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2789147C29A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbhLUPRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhLUPRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:17:46 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E15C061574;
        Tue, 21 Dec 2021 07:17:46 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so17024454otg.4;
        Tue, 21 Dec 2021 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tHke5PraZLo9zXLtEiDurFbl90Vg6q42JU7gVJRCp00=;
        b=lMbaJFrwg+YTl4dmVQ0fzyniXXUY0Iwi0eFGCinwLz3/I2b+MzmD/fPvwhTwWIeyli
         ACszRNHs+QnKkNyuJlITF/Vi6GagnKPne75nPxmaHgW3oEwz7hMVPpeb7J4dOE/OcH+3
         Yo0ZTwuezmL1Cd0f/hDKv8vSifAYfcKg385xf70oAAnjnPtnBDN4egVnsCENNFPpaFES
         e5lyVS7bR3YvFrWbwEfI93VmkIPbHiQda39MPlFp9u4yN4V9Hrz1vqY8XyDFOv0nace1
         3CpswTFlz+mrT1H8GuZkbomJJXkHOdTSlGaopCvYNTNc0BGSdDUpRMvPPFO/vjs2u4jl
         GbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tHke5PraZLo9zXLtEiDurFbl90Vg6q42JU7gVJRCp00=;
        b=YF0tG/51BSOqbEKhC3yZs78RO40F6sC+S9lDIVKFxQXAE85tsQXaHcgCmLzUbB5ges
         FHV/QzKN6xO2p6k4dwXk2u4bRj/fPnHnvR9KMsspppgMAuDJsuFMMtdpyET6tzA9ebUc
         BP7h6eqlgZNKHGCPws06SiCDw/w1kNsG4oGTc/P2GNw28FGJSicARfk5O5FTTQ/YHebW
         b1fCVU5ROYdXeBnxc9U67p7mIvm8Pg+Etc9CZX7HklNbtKdNkjH/laH/0wsWRt14C9tM
         V+8FCrzHQ7kUZk1YIfbe4KW+7Pj0rtOwlKngvPlKFKH4xpAU9/SFXFvToz3Dg96XrmEH
         FUeg==
X-Gm-Message-State: AOAM532BZBwTUY6vhvmDwt2kUmroho9mGzVJtf6jCLBBjyqKwielcMV5
        9Bb6Pk6mtFkXlH5CfV/Yfwl+z18EIT8=
X-Google-Smtp-Source: ABdhPJxZSwgVMZz21CwDVSI7Lu9dcnUsS6TM24ip7kPE41/cZwy3L3UhE8jgChbhcf6/8hW7SZyfYQ==
X-Received: by 2002:a9d:5549:: with SMTP id h9mr2533630oti.36.1640099865983;
        Tue, 21 Dec 2021 07:17:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ay40sm4134452oib.1.2021.12.21.07.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:17:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Dec 2021 07:17:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/10] hwmon: adt7x10: do not create name attr
Message-ID: <20211221151744.GB2753412@roeck-us.net>
References: <20211221123944.2683245-1-demonsingur@gmail.com>
 <20211221123944.2683245-2-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221123944.2683245-2-demonsingur@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 02:39:36PM +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> It will later be created automatically by hwmon.
> 
Patches have to work on their own to retain bisectability. 
The driver would be non-operational after this patch is applied
until the registration function is changed. Please merge this
patch into the with_info rework patch.

Guenter

> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  drivers/hwmon/adt7x10.c | 29 +----------------------------
>  1 file changed, 1 insertion(+), 28 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
> index 2439da9b64e6..dbe9f1ad7db0 100644
> --- a/drivers/hwmon/adt7x10.c
> +++ b/drivers/hwmon/adt7x10.c
> @@ -54,7 +54,6 @@
>  /* Each client has this additional data */
>  struct adt7x10_data {
>  	const struct adt7x10_ops *ops;
> -	const char		*name;
>  	struct device		*hwmon_dev;
>  	struct device		*bus_dev;
>  	struct mutex		update_lock;
> @@ -316,14 +315,6 @@ static ssize_t adt7x10_alarm_show(struct device *dev,
>  	return sprintf(buf, "%d\n", !!(ret & attr->index));
>  }
>  
> -static ssize_t name_show(struct device *dev, struct device_attribute *da,
> -			 char *buf)
> -{
> -	struct adt7x10_data *data = dev_get_drvdata(dev);
> -
> -	return sprintf(buf, "%s\n", data->name);
> -}
> -
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, adt7x10_temp, 0);
>  static SENSOR_DEVICE_ATTR_RW(temp1_max, adt7x10_temp, 1);
>  static SENSOR_DEVICE_ATTR_RW(temp1_min, adt7x10_temp, 2);
> @@ -337,7 +328,6 @@ static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adt7x10_alarm,
>  			     ADT7X10_STAT_T_HIGH);
>  static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, adt7x10_alarm,
>  			     ADT7X10_STAT_T_CRIT);
> -static DEVICE_ATTR_RO(name);
>  
>  static struct attribute *adt7x10_attributes[] = {
>  	&sensor_dev_attr_temp1_input.dev_attr.attr,
> @@ -368,7 +358,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>  		return -ENOMEM;
>  
>  	data->ops = ops;
> -	data->name = name;
>  	data->bus_dev = dev;
>  
>  	dev_set_drvdata(dev, data);
> @@ -406,21 +395,10 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>  	if (ret)
>  		goto exit_restore;
>  
> -	/*
> -	 * The I2C device will already have it's own 'name' attribute, but for
> -	 * the SPI device we need to register it. name will only be non NULL if
> -	 * the device doesn't register the 'name' attribute on its own.
> -	 */
> -	if (name) {
> -		ret = device_create_file(dev, &dev_attr_name);
> -		if (ret)
> -			goto exit_remove;
> -	}
> -
>  	data->hwmon_dev = hwmon_device_register(dev);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		ret = PTR_ERR(data->hwmon_dev);
> -		goto exit_remove_name;
> +		goto exit_remove;
>  	}
>  
>  	if (irq > 0) {
> @@ -435,9 +413,6 @@ int adt7x10_probe(struct device *dev, const char *name, int irq,
>  
>  exit_hwmon_device_unregister:
>  	hwmon_device_unregister(data->hwmon_dev);
> -exit_remove_name:
> -	if (name)
> -		device_remove_file(dev, &dev_attr_name);
>  exit_remove:
>  	sysfs_remove_group(&dev->kobj, &adt7x10_group);
>  exit_restore:
> @@ -454,8 +429,6 @@ void adt7x10_remove(struct device *dev, int irq)
>  		free_irq(irq, dev);
>  
>  	hwmon_device_unregister(data->hwmon_dev);
> -	if (data->name)
> -		device_remove_file(dev, &dev_attr_name);
>  	sysfs_remove_group(&dev->kobj, &adt7x10_group);
>  	if (data->oldconfig != data->config)
>  		adt7x10_write_byte(dev, ADT7X10_CONFIG, data->oldconfig);
> -- 
> 2.34.1
> 
