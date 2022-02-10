Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE74B05A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 06:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiBJFm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 00:42:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiBJFmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 00:42:21 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FD510CB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:41:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i30so8293666pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 21:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MycArphAL+eI4CNWC2fJtlo4v2VAv4DVPnEgYiAFfhI=;
        b=cRwFHOxsA1rFfoKgkohYYCK97jWpVFIeQpUt6nrxyxweM1gnUGKZQPcEa9umeVYlQ3
         z9DV4xaqGUJSSSmMTiXptrxBO6ZKAqlDt7juJN/fBtWx7e4hHYdy3zobDbjnUa54wUgk
         FuF5fRExGky/ELqIoVQitM75YWGXBSdGUU1J2vNWQHi81QYe/u38h/MCzcRT5MExwIWG
         bjZIHV3ulQX9Dff6nHO0uuh0UyOXiXtudECJJBM9+txAMSyMLQbhwepC+WqVN7ZOaL4f
         76fOnnjH/RCqt9sReilEmvGhic9wW0flWj5ilkhA0BL99em+7UmBDfdWY7pdbhj0E1CO
         SxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MycArphAL+eI4CNWC2fJtlo4v2VAv4DVPnEgYiAFfhI=;
        b=B5vWCzmCI5tkxXIDKBV7SywTEwENbUixHGLM4rfhcZvXVy/VYCE0XppRd5T76AZhRd
         uWhKk5b4etKiluQv6aUv25iB9+/B7STH6i5D3VQUwGRqJyE8wKGhBSKBnJ87X2HMD+fE
         9zDSrbeO2azhthKVofBKEIxHds1LiZAuaTRDz9dFi7GG42omq3ue+YVL600NaovOiOiP
         t6tK6MCzCfhbrlyJ7YU2kIDBeShyWa9JhVZJay7qkroqlhvJSNlgQcr6UUgIVxD1btuz
         GiZh4OfcsvUx/+qPm/+ONbqCnsdSW7allIwm9pL7iwiO7i9tzvweDmICJZsKmbI7g4SF
         s6lw==
X-Gm-Message-State: AOAM532uqcWoW4q940JDayscWYHysZy4ydaLGXJsFtSHuCQnWs4GhBK4
        SKYZwZtPHSIJV9Ld7VnjCJ0PNQ==
X-Google-Smtp-Source: ABdhPJylbaVJIaI4S2Eo448QHk8Qz7yTaz2a4vWBQpy5qfMnKkwM/5SAToovyB7ORqe/SbpsRrPqaQ==
X-Received: by 2002:a05:6a00:16d4:: with SMTP id l20mr5973435pfc.5.1644471694237;
        Wed, 09 Feb 2022 21:41:34 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:c189:30c:e45a:d116])
        by smtp.gmail.com with ESMTPSA id a17sm663383pju.15.2022.02.09.21.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 21:41:33 -0800 (PST)
Date:   Thu, 10 Feb 2022 13:41:31 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Sami =?iso-8859-1?Q?Ky=F6stil=E4?= <skyostil@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bleung@chromium.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, evanbenn@chromium.org
Subject: Re: [PATCH v3 1/1] platform/chrome: add a driver for HPS
Message-ID: <YgSli/6HuZ+i+2gb@google.com>
References: <20220207013613.1150783-1-skyostil@chromium.org>
 <20220207013613.1150783-2-skyostil@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207013613.1150783-2-skyostil@chromium.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 12:36:13PM +1100, Sami Kyöstilä wrote:
> This patch introduces a driver for the ChromeOS screen privacy
> sensor (aka. HPS). The driver supports a sensor connected to the I2C bus
> and identified as "GOOG0020" in the ACPI tables.

The patch uses HPS instead of SPS everywhere.  Would you consider to use
"human presence sensor" when referring it?

> When loaded, the driver exports the sensor to userspace through a
> character device. This device only supports power management, i.e.,
> communication with the sensor must be done through regular I2C
> transmissions from userspace.
> 
> Power management is implemented by enabling the respective power GPIO
> while at least one userspace process holds an open fd on the character
> device. By default, the device is powered down if there are no active
> clients.
> 
> Note that the driver makes no effort to preserve the state of the sensor
> between power down and power up events. Userspace is responsible for
> reinitializing any needed state once power has been restored.

It's weird.  If most of the thing is done by userspace programs, couldn't it
set the power GPIO via userspace interface (e.g. [1]) too?

[1]: https://embeddedbits.org/new-linux-kernel-gpio-user-space-interface/

> diff --git a/MAINTAINERS b/MAINTAINERS
[...]
> +HPS (ChromeOS screen privacy sensor) DRIVER

Does it make more sense to use "CHROMEOS HPS DRIVER" title?

> diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/chrome/cros_hps_i2c.c
[...]
> +static void hps_set_power(struct hps_drvdata *hps, bool state)
> +{
> +	if (!IS_ERR_OR_NULL(hps->enable_gpio))

Could it get rid of the check?  Does the function get called if device probe
fails?

> +static void hps_unload(void *drv_data)
> +{
> +	struct hps_drvdata *hps = drv_data;
> +
> +	hps_set_power(hps, true);

Why does it need to set to true when device removing?

> +static int hps_open(struct inode *inode, struct file *file)
> +{
> +	struct hps_drvdata *hps = container_of(file->private_data,
> +					       struct hps_drvdata, misc_device);
> +	struct device *dev = &hps->client->dev;
> +	int ret;
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		goto pm_get_fail;
> +	return 0;
> +
> +pm_get_fail:
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);

The two functions are not effectively symmetric if pm_runtime_get_sync()
fails.
- It doesn't need to call pm_runtime_put() if pm_runtime_get_sync() fails.
- I guess it wouldn't want to pm_runtime_disable() here.  The capability is
  controlled when the device probing and removing.

> +static int hps_release(struct inode *inode, struct file *file)
> +{
> +	struct hps_drvdata *hps = container_of(file->private_data,
> +					       struct hps_drvdata, misc_device);
> +	struct device *dev = &hps->client->dev;
> +	int ret;
> +
> +	ret = pm_runtime_put(dev);
> +	if (ret < 0)
> +		goto pm_put_fail;
> +	return 0;
> +
> +pm_put_fail:
> +	pm_runtime_disable(dev);

Same here.

> +const struct file_operations hps_fops = {
> +	.owner = THIS_MODULE,
> +	.open = hps_open,
> +	.release = hps_release,
> +};

The struct can be static.

> +static int hps_i2c_probe(struct i2c_client *client)
> +{
> +	struct hps_drvdata *hps;
> +	int ret = 0;

It doesn't need to be initialized.  It's going to be overridden soon.

> +	memset(&hps->misc_device, 0, sizeof(hps->misc_device));
> +	hps->misc_device.parent = &client->dev;
> +	hps->misc_device.minor = MISC_DYNAMIC_MINOR;
> +	hps->misc_device.name = "hps";

Does "cros_hps_i2c" or "cros_hps" make more sense?

> +	ret = devm_add_action(&client->dev, &hps_unload, hps);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"failed to install unload action: %d\n", ret);
> +		return ret;
> +	}

Why does it need to call hps_unload() when device removing?  Couldn't it put
the code in hps_i2c_remove()?

> +	hps_set_power(hps, false);
> +	pm_runtime_enable(&client->dev);
> +	return ret;

Using `return 0;` makes it clear.

> +static int hps_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct hps_drvdata *hps = i2c_get_clientdata(client);
> +
> +	hps_set_power(hps, false);
> +	return 0;
> +}
> +
> +static int hps_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct hps_drvdata *hps = i2c_get_clientdata(client);
> +
> +	hps_set_power(hps, true);
> +	return 0;
> +}

Does it need to save the old state before suspending?  Instead of turning on
the power after every resumes.

> +static const struct i2c_device_id hps_i2c_id[] = {
> +	{ "hps", 0 },

Does "cros_hps_i2c" or "cros_hps" make more sense?

> +static struct i2c_driver hps_i2c_driver = {
> +	.probe_new = hps_i2c_probe,
> +	.remove = hps_i2c_remove,
> +	.id_table = hps_i2c_id,
> +	.driver = {
> +		.name = "hps",

Does "cros_hps_i2c" or "cros_hps" make more sense?

> +#ifdef CONFIG_ACPI
> +		.acpi_match_table = ACPI_PTR(hps_acpi_id),
> +#endif

It doesn't need the guard as ACPI_PTR() already does.
