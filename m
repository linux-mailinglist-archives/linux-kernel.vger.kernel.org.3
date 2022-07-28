Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760D9583C15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiG1Kcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiG1Kcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:32:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2CE402DD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:32:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t17so2266450lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LssnVf2Hx3DAf9PFq4l/W6b4KFQJSD35yxvcRp6Iqig=;
        b=L1wzYJ3VtFtmqmprQoCkFtJHxKqV5ETHdihJCs6JucOE71bPODd67tfOotuDJ17e5z
         UuwikMYsZ0uLzzShKVSUsQiXpUZMfzZw8RsNQ8L3EhIHY2QdfOOKIgtH3Oc0r95HTLqt
         WpXNfiFKUnt7u0lV09fTNU/MEFXBObJGC9cPnrbXmVfDeDM5l98ol/8kR3uUYjvBP4b6
         QBN9m/Kwmwe10UiKW8hOFglJJmf/0uMo4hAanVzEDlS7l3IitkuMmiDctle3ZG4LRVNc
         ANsC+ifC8Lsr6WeS62MQgJuTmLD91B/QZ4fMANufLo+2D4Zk3G/smibIdZGHl41ie88O
         xEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LssnVf2Hx3DAf9PFq4l/W6b4KFQJSD35yxvcRp6Iqig=;
        b=HiNRbNkzAWjFEHK9oNLsGv4bfFPdHpAgCWdNrhfjs0a2UsP7kjlKcbWTTY94HGX1CB
         7Y9SgvyUQHypPZIhBkCVMV67nBaseM5THEGpkGOQpO+Vgtsl5N9eTDi3YlXZXV1/wlrX
         w3xSj3foSXDsxWm54/KbkuDYSUxrwOa8+u1qnSADG2gzO8QOeYyM9+uPqwei+rWkmK3x
         iAnzk39oaYfFY2TJo08TO/V5l/GW+fLS0PMBcYu7CMU7qd99bDDVwxjXeH7YVdmyI8IP
         coHQ6u3ZL2aOG3nZ7ouOAavZ79Ax5ysJDoOpy7AsOFhrNj7/fdVTpD+veCypRIPq7/u+
         OG3Q==
X-Gm-Message-State: AJIora/Y/WMx3smryVJDJCKmNmv3/EuIJvcOpcoAbsiVaeu4HHaBWxFJ
        tnNQViLz4cVCkONVG0WumGEnOQ==
X-Google-Smtp-Source: AGRyM1sbVrvpYj2bzSCOVYeKPMbcT4xI0frfcsQ8FalT/oMMzdB8EilkHrRhoVqlZhu4BZtF0oieiw==
X-Received: by 2002:a05:6512:3186:b0:48a:c33e:f5e with SMTP id i6-20020a056512318600b0048ac33e0f5emr1316081lfe.531.1659004356108;
        Thu, 28 Jul 2022 03:32:36 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id m5-20020a056512114500b004793b9c2c12sm138611lfg.124.2022.07.28.03.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 03:32:35 -0700 (PDT)
Message-ID: <eec86221-8dfc-4a98-396d-208d8b82ac19@linaro.org>
Date:   Thu, 28 Jul 2022 12:32:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH RFC v1 1/2] bus: add Wiegand write-only GPIO driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mani@kernel.org,
        hemantk@codeaurora.org, elder@linaro.org, f.fainelli@gmail.com,
        linus.walleij@linaro.org, Michael.Srba@seznam.cz,
        jeffrey.l.hugo@gmail.com, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, saravanak@google.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
References: <20220728091712.13395-1-m.zatovic1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728091712.13395-1-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 11:17, Martin Zaťovič wrote:
> Wiegand is a communication protocol that is still widely used
> especially for access control applications. It utilizes two wires to
> transmit data - D0 and D1, the generic names of which are data-lo and
> data-hi.
> 
> Both data lines are initially pulled up. To send a bit of value 1, the
> D1 line is set low. Similarly to send a bit of value 0, the D0 line is
> set low. Standard Wiegand formats include 26, 36 and 37 bit and they
> reserve the first and last bits for parity. The first(MSB) parity bit
> is set to 1 if the parity of the first half of the payload is odd. The
> last(LSB) parity bit is set to 1 if the parity of the second half of
> the payload even.
> 
> The driver currently supports the 3 standard formats - 26, 36 and 37
> bits. When one of these formats is used, it automatically calculates
> the values of parity bits and appends them to the messages. It also
> offers to set a custom format. Using a custom format, the user is
> responsible for setting the parity bits. The driver offers setting of
> the following sysfs attributes:
> 
> 	pulse_len - length of the low pulse in usec; defaults to 50us
> 	interval_len - length of a whole bit(pulse_len + high phase)
> 	in usec; defaults to 50us
> 	frame_gap - length of the last bit of a frame(pulse_len +
> 	high phase); defaults to interval_len
> 	format - valid values are 0 for custom, 26, 36, 37
> 	custom_payload_len - can be set when using a custom format(0);
> 	0 means all bits of a message will be sent
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
> The driver was tested on NXP Verdin iMX8MP Plus.
> 
> I would like to kindly ask a few questions:
> 1. Is debug printing of the data being transmitted a valid thing to do?
> Wiegand could potentially be used to transmit sensitive data which
> might get exposed by the debug mode.
> 2. The part of the code, where sysfs files are being created does not
> currently contain freeing of the ones already created on an error. Is
> it better to use goto jumps to free them and exit, or let the driver
> run without some of the attribute files?
> 
> If you have any suggestions to make this patch better, please let me
> know, I am eager to learn. I am very much new to this field, so any
> feedback will be aprreciated.
> ---
>  MAINTAINERS                |   6 +
>  drivers/bus/Kconfig        |  10 +
>  drivers/bus/Makefile       |   1 +
>  drivers/bus/wiegand-gpio.c | 661 +++++++++++++++++++++++++++++++++++++
>  drivers/bus/wiegand-gpio.h |  54 +++
>  5 files changed, 732 insertions(+)
>  create mode 100644 drivers/bus/wiegand-gpio.c
>  create mode 100644 drivers/bus/wiegand-gpio.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64379c699903..9a519530e44e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21586,6 +21586,12 @@ L:	linux-rtc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/rtc/rtc-sd3078.c
>  
> +WIEGAND WRITE-ONLY GPIO DRIVER
> +M:	Martin Zaťovič <m.zatovic1@gmail.com>
> +S:	Maintained
> +F:	drivers/bus/wiegand-gpio.c
> +F:	drivers/bus/wiegand-gpio.h
> +
>  WIIMOTE HID DRIVER
>  M:	David Rheinsberg <david.rheinsberg@gmail.com>
>  L:	linux-input@vger.kernel.org
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 7bfe998f3514..f7c7d3b24710 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -231,6 +231,16 @@ config UNIPHIER_SYSTEM_BUS
>  	  Support for UniPhier System Bus, a simple external bus.  This is
>  	  needed to use on-board devices connected to UniPhier SoCs.
>  
> +config WIEGAND_GPIO
> +    tristate "GPIO-based wiegand master (write only)"
> +    depends on OF_GPIO
> +    help
> +      Say y here to enable a driver which uses GPIO pins to send
> +      Wiegand data. Say m to build it as module. Say n to disable
> +      building. The driver utilizes two data lines that need to be
> +      defined as outputs in the device tree - wiegand-data-hi and
> +      wiegand-data-lo.
> +
>  config VEXPRESS_CONFIG
>  	tristate "Versatile Express configuration bus"
>  	default y if ARCH_VEXPRESS
> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> index d90eed189a65..cc21530a441f 100644
> --- a/drivers/bus/Makefile
> +++ b/drivers/bus/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_TI_SYSC)		+= ti-sysc.o
>  obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
>  obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
>  obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
> +obj-$(CONFIG_WIEGAND_GPIO)	+= wiegand-gpio.o
>  

This is confusing. You put it in bus, but you just added a single
driver, not a bus driver, right?

If it is not a bus driver, it goes to respective subsystem.

> +DEVICE_ATTR_RW(pulse_len);
> +DEVICE_ATTR_RW(interval_len);
> +DEVICE_ATTR_RW(frame_gap);
> +DEVICE_ATTR_RW(format);
> +DEVICE_ATTR_RW(payload_len);
> +
> +static int wiegand_gpio_dev_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct wiegand_gpio_device *wiegand_gpio;
> +	struct wiegand_gpio_platform_data *pdata = pdev->dev.platform_data;
> +
> +	if (!pdata) {
> +		if (IS_ERR(pdata))
> +			return PTR_ERR(pdata);

Why? How is this going to bind? Who provides pdata? Who provides error
pdata?!?

> +	}
> +
> +	wiegand_gpio = kzalloc(sizeof(struct wiegand_gpio_device), GFP_KERNEL);

devm, sizeof(*wiegand_gpio)

> +	if (!wiegand_gpio)
> +		return -ENOMEM;
> +
> +	wiegand_gpio->dev = &pdev->dev;
> +
> +	/* Initialize character device */
> +	cdev_init(&wiegand_gpio->cdev, &wiegand_gpio_fops);
> +	wiegand_gpio->cdev.owner = THIS_MODULE;
> +
> +	rc = cdev_add(&wiegand_gpio->cdev, MKDEV(MAJOR(base_devno),
> +				pdev->id == -1 ? 0 : pdev->id), 1);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "Failed to allocate cdev: %d\n", rc);
> +		kfree(wiegand_gpio);
> +		return rc;
> +	}
> +
> +	wiegand_gpio->dev->devt = wiegand_gpio->cdev.dev;
> +	mutex_init(&wiegand_gpio->mutex);
> +
> +	/* Get GPIO lines using device tree bindings. */
> +	wiegand_gpio->gpio_data_lo = devm_gpiod_get(wiegand_gpio->dev,
> +			"wiegand-data-lo", GPIOD_OUT_HIGH);
> +	if (IS_ERR(wiegand_gpio->gpio_data_lo)) {
> +		dev_info(wiegand_gpio->dev,
> +			"Failed to get wiegand-data-lo pin.\n");
> +		return PTR_ERR(wiegand_gpio->gpio_data_lo);

No, return dev_err_probe().

> +	}
> +	wiegand_gpio->gpio_data_hi = devm_gpiod_get(wiegand_gpio->dev,
> +			"wiegand-data-hi", GPIOD_OUT_HIGH);
> +	if (IS_ERR(wiegand_gpio->gpio_data_hi)) {
> +		dev_info(wiegand_gpio->dev,
> +			"Failed to get wiegand-data-hi pin.\n");
> +		return PTR_ERR(wiegand_gpio->gpio_data_hi);

return dev_err_probe()

> +	}
> +
> +	memcpy(&wiegand_gpio->setup, &WIEGAND_SETUP,
> +			sizeof(struct wiegand_setup));
> +
> +	platform_set_drvdata(pdev, wiegand_gpio);
> +
> +	dev_info(&pdev->dev, "devno=%d:%d\n",
> +		 MAJOR(wiegand_gpio->dev->devt),
> +		 MINOR(wiegand_gpio->dev->devt));
> +
> +	rc = device_create_file(wiegand_gpio->dev, &dev_attr_pulse_len);
> +	rc |= device_create_file(wiegand_gpio->dev, &dev_attr_interval_len);
> +	rc |= device_create_file(wiegand_gpio->dev, &dev_attr_frame_gap);
> +	rc |= device_create_file(wiegand_gpio->dev, &dev_attr_format);
> +	rc |= device_create_file(wiegand_gpio->dev,
> +				&dev_attr_payload_len);
> +	if (rc != 0)
> +		dev_warn(&pdev->dev,
> +				"Failed to register attribute files(%d)\n", rc);
> +
> +	return 0;
> +}
> +
> +static int wiegand_gpio_dev_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct wiegand_gpio_device *wiegand_gpio = platform_get_drvdata(pdev);
> +
> +	device_remove_file(dev, &dev_attr_pulse_len);
> +	device_remove_file(dev, &dev_attr_interval_len);
> +	device_remove_file(dev, &dev_attr_frame_gap);
> +	device_remove_file(dev, &dev_attr_format);
> +	device_remove_file(dev, &dev_attr_payload_len);
> +	cdev_del(&wiegand_gpio->cdev);
> +	kfree(wiegand_gpio);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id wiegand_gpio_dt_idtable[] = {
> +	{ .compatible = "wiegand-gpio" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, wiegand_gpio_dt_idtable);
> +#endif
> +
> +static struct platform_driver wiegand_gpio_driver = {
> +	.probe		= wiegand_gpio_dev_probe,
> +	.remove		= wiegand_gpio_dev_remove,
> +	.driver		= {
> +		.owner	= THIS_MODULE,

This is not needed. Do you see it in any driver?

> +		.name	= "wiegand-gpio",
> +		.of_match_table = of_match_ptr(wiegand_gpio_dt_idtable),
> +	}
> +};
> +MODULE_ALIAS("platform:wiegand-gpio");
> +

Best regards,
Krzysztof
