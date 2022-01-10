Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE40488E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 02:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiAJB3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 20:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiAJB31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 20:29:27 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F511C06173F;
        Sun,  9 Jan 2022 17:29:27 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id w80so17193677oie.9;
        Sun, 09 Jan 2022 17:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5NJsp6be1lDKy86aBY7oerPwqcIndNeWLcYbCjf9beU=;
        b=kEYKB6Wv10ZDy/9KoqkVIgPSDI3gSJw6BxAlKKcMNUBpHdHNb6ORXxmtT0jTzDhRRd
         xc61mbcztokyGXgeG0qfYyBFFH41NQoySZPA1tZyIi54BC8hb5YydmXrn9pRSFamPpaZ
         5XOAgxyAuw+UeVxhmmeRrMorjfvAqLDIclBagc83TlilEI3JRqv0Ey37w/IpackUI7Ov
         kvNGJfJ423+Y+FD2tqM+2r1KECN8oqQRETr9a5OVC4tBmp5k5+Cmv3NkPMVNVOsVtBrz
         qjx2mdcBRZmHObe2Vrg52+G76j5FGiwzodt5uzvUHHl76kM2OqLUM1WPJ3rqn9jczjTj
         22xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5NJsp6be1lDKy86aBY7oerPwqcIndNeWLcYbCjf9beU=;
        b=7MDFipIsEFm2E9QUQaSRECzb1cABU/XY20fy2wd3BAAhW/x7yTRmS8AIy2DTTKAL/x
         gx3N2QuXSmjCyCcgXy3nU9WpGLUKQzO1d89+aZ8cnmuFbEZvowQhra3MFyH0wCv929S7
         gMGjxfBYmpX5L102D0g2wsNuH15maeo7rEHx9/SAm+rsh0w996wac+IL2mbSxXfsafeH
         7kyvBYFC1BiyW0yzAeDXvc7EBt1cPE2gQVCvRRWhwBJqXwfctwUhO99ueQ/cv8TgS5h0
         jO4fpbBG64vTc/gzh90XJmrkO/vk35+yR+st/07p4uQb3FEy6Zx6+PAVkJAKduX5D2Hj
         spoA==
X-Gm-Message-State: AOAM5332VLf1qTixnV9K77cDQXU0FV2LHEeSHhssKAK/EOYofDXlFNPX
        zOvS3gHwxdsE2k9Jh+UAPXo=
X-Google-Smtp-Source: ABdhPJy1CubCLBAfS65bpmHdWrQ28kXWhczcd7+x3zqlJGKwgEhanhD6nCIAO6uGgpv0sP2OKdTDRQ==
X-Received: by 2002:aca:f14:: with SMTP id 20mr17178875oip.143.1641778166614;
        Sun, 09 Jan 2022 17:29:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g22sm1191209otj.0.2022.01.09.17.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:29:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 9 Jan 2022 17:29:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, list@opendingux.net,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v2 2/2] hwmon: Add "label" attribute
Message-ID: <20220110012924.GA1197630@roeck-us.net>
References: <20220105151551.20285-1-paul@crapouillou.net>
 <20220105151551.20285-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105151551.20285-3-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 03:15:51PM +0000, Paul Cercueil wrote:
> If a label is defined in the device tree for this device add that
> to the device specific attributes. This is useful for userspace to
> be able to identify an individual device when multiple identical
> chips are present in the system.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> 
> Notes:
>     v2: - Cache label into hwmon_device
>         - Rename hwmon_dev_name_is_visible() to hwmon_dev_attr_is_visible()
> 	- Add missing <linux/property.h> include
> 
>  drivers/hwmon/hwmon.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 3501a3ead4ba..22e1b47c09fc 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -18,6 +18,7 @@
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/thermal.h>
> @@ -30,6 +31,7 @@
>  
>  struct hwmon_device {
>  	const char *name;
> +	const char *label;
>  	struct device dev;
>  	const struct hwmon_chip_info *chip;
>  	struct list_head tzdata;
> @@ -71,17 +73,29 @@ name_show(struct device *dev, struct device_attribute *attr, char *buf)
>  }
>  static DEVICE_ATTR_RO(name);
>  
> +static ssize_t
> +label_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", to_hwmon_device(dev)->label);
> +}
> +static DEVICE_ATTR_RO(label);
> +
>  static struct attribute *hwmon_dev_attrs[] = {
>  	&dev_attr_name.attr,
> +	&dev_attr_label.attr,
>  	NULL
>  };
>  
> -static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,
> +static umode_t hwmon_dev_attr_is_visible(struct kobject *kobj,
>  					 struct attribute *attr, int n)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
> +	struct hwmon_device *hdev = to_hwmon_device(dev);
>  
> -	if (to_hwmon_device(dev)->name == NULL)
> +	if (attr == &dev_attr_name.attr && hdev->name == NULL)
> +		return 0;
> +
> +	if (attr == &dev_attr_label.attr && hdev->label == NULL)
>  		return 0;
>  
>  	return attr->mode;
> @@ -89,7 +103,7 @@ static umode_t hwmon_dev_name_is_visible(struct kobject *kobj,
>  
>  static const struct attribute_group hwmon_dev_attr_group = {
>  	.attrs		= hwmon_dev_attrs,
> -	.is_visible	= hwmon_dev_name_is_visible,
> +	.is_visible	= hwmon_dev_attr_is_visible,
>  };
>  
>  static const struct attribute_group *hwmon_dev_attr_groups[] = {
> @@ -117,6 +131,7 @@ static void hwmon_dev_release(struct device *dev)
>  	if (hwdev->group.attrs)
>  		hwmon_free_attrs(hwdev->group.attrs);
>  	kfree(hwdev->groups);
> +	kfree(hwdev->label);
>  	kfree(hwdev);
>  }
>  
> @@ -733,6 +748,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  			const struct attribute_group **groups)
>  {
>  	struct hwmon_device *hwdev;
> +	const char *label;
>  	struct device *hdev;
>  	int i, err, id;
>  
> @@ -752,6 +768,18 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  		goto ida_remove;
>  	}
>  
> +	if (device_property_present(dev, "label")) {
> +		err = device_property_read_string(dev, "label", &label);
> +		if (err < 0)
> +			goto free_hwmon;
> +
> +		hwdev->label = kstrdup(label, GFP_KERNEL);
> +		if (hwdev->label == NULL) {
> +			err = -ENOMEM;
> +			goto free_hwmon;

The code after free_hwmon: uses hdev, so 0-day has a point. Please fix.

Guenter

> +		}
> +	}
> +
>  	hdev = &hwdev->dev;
>  
>  	if (chip) {
