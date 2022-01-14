Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0D848EE90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiANQl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243544AbiANQlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:41:25 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B984C061748;
        Fri, 14 Jan 2022 08:41:21 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id t6-20020a9d7746000000b005917e6b96ffso10667095otl.7;
        Fri, 14 Jan 2022 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kIYbOTqfhE3s5dj9CQrixsP9xxxyMkLxQ3bTsGzPWco=;
        b=XngQux0jEARQeItclkgpycWj7/FxI63twTQliwS1sro4aWPfKCYTovUlXUy5tduieS
         IOUVNIYeo9dwHPrpi7Ki/c2X2xvIpKsxjWwv03SywjjCT62AG6hM7KOW+RmdFdR+GPoo
         5p15L/BV9vyCXQJejoOWKHaTsiUDCG91xsrynS/ihJ92T27pQVntnCIoN+jbh9pdqnkv
         Nox3w0Z0MUzUMpEFtsvx+PvzBvbqvVjGrSCY321WTgm4quk6FLhuY7rRk1HDMQj7JzML
         mlmxF4yTpp0em+NBnu10ojDLFn9CLxj3LtL9UfW4YWceZizwtsYrLuzUcGK0U0S9NbkC
         EEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kIYbOTqfhE3s5dj9CQrixsP9xxxyMkLxQ3bTsGzPWco=;
        b=AV9VUXAR57AbYvVT55mizqEaP0oeV606kJbNpkGPTyGs4n4L/MvjTf/IkBQDtXB2+8
         /w2KnMVFUYz/T1jMbi52sLYj4W5WF/dRrFUuuHp25i1243g6xuYcnK1t15vsw7UlVv5n
         BQuxsfqfDTDWD1Peqc/uZmIFpU3kerIFvB3MQtY3exuSJRg5GT2P4Et8Lo5iuh/XlnfH
         azMhC6h1AP4QQ0YZTUe9YZrpqrdwJbMcKNmH5/Ok7VAmHLM6J7SjArIbAI0PFqR39ZLV
         +thQYBALUjAoZtmk3b30iiMBEkqxi4yWJncPNYzpVoRYPAaRO39JlNRV5j9CDHmhf+PD
         GymA==
X-Gm-Message-State: AOAM532XWc5eeM3JKJrKIyMW7gSYdOhgQndTvP0Y9RiamtS4Qot200+M
        JsQSak1hM/3jo8Bz+Hybm7U=
X-Google-Smtp-Source: ABdhPJzC1lpThwxX7jDR4yoNPJt9opKFbObXCMi6+aC6s23PdbWdK+3jrcS2+dwSesukYT8g8bLRoQ==
X-Received: by 2002:a9d:6011:: with SMTP id h17mr1801414otj.103.1642178480751;
        Fri, 14 Jan 2022 08:41:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j13sm2206417oil.42.2022.01.14.08.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:41:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Jan 2022 08:41:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, list@opendingux.net,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v3 2/2] hwmon: Add "label" attribute
Message-ID: <20220114164119.GA1278956@roeck-us.net>
References: <20220110182256.30763-1-paul@crapouillou.net>
 <20220110182256.30763-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110182256.30763-3-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 06:22:56PM +0000, Paul Cercueil wrote:
> If a label is defined in the device tree for this device add that
> to the device specific attributes. This is useful for userspace to
> be able to identify an individual device when multiple identical
> chips are present in the system.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Notes:
>     v2: - Cache label into hwmon_device
>         - Rename hwmon_dev_name_is_visible() to hwmon_dev_attr_is_visible()
>     v3: Move the code setting the label around in the probe function to fix
>         error handling issue.
> 
>  drivers/hwmon/hwmon.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 3501a3ead4ba..8d787dba3e38 100644
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
> @@ -788,6 +804,18 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  		hdev->groups = groups;
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
> +		}
> +	}
> +
>  	hwdev->name = name;
>  	hdev->class = &hwmon_class;
>  	hdev->parent = dev;
