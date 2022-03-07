Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE89E4D0201
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbiCGOxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243657AbiCGOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:52:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E629026E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:51:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q14so8148953wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tLF7Vqm/MokjXYyJgUoQC6rHN9RDfGgaeSS+6MW4O9k=;
        b=if8Ns1oVLlLSj8htpo7xBHeUDQbgcDkQ4JBdR7ySBz3R0u3lRdpO6o9WOVIHQkLqoP
         60grUoSIbC4oeVFI/pmhh01pdjS1WNJKRiglOwRCVQ4yg+/jkpDZYueKeAPhfOg/2ipx
         YxepXgkTbnt9v8+5gMA/yIxLsvYsfZBxg/cio5R0e9bk4UHqS7RqJX2FTFMTb5GvV3j3
         qo9j+Xjb7aWFhS4kqiMj7udB29lNN24u8gtC9plQok4UuYBOjLKKMF4awUY+1zHTTlIX
         lm0oJasrfU/20tGHkc9M7SY7/z5xcN3YEHrUDyEiF//LccelPaL5THDdulxw9JACGv6R
         8RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tLF7Vqm/MokjXYyJgUoQC6rHN9RDfGgaeSS+6MW4O9k=;
        b=b+Q8lLqnYPIwrHAXcoQM4VLfbIKuFs3SCg/sja3N6VnbFttx031Vvl7regXpfMkgDG
         kCteva491EL/2cWDWR+lAo800+D60fFW2qVvL1//samBqoaISZcFezvi5xZISbuqad65
         YlWbZHigr9hvkU03KjLN/147ACeCO0MtS7R+oXttPa7V6fMqxFW2SKMNgimivse8G+72
         NaNYl6MdRfpCJ+x6DCOuQeovm2LRwWLx7sU9By3j3xKpPaSn9UU4+5Z8ZT3yJyn1cUSO
         8WHOmQmJYO8hAzdOY8FHZPAUCSibk470Bmz5avpRMbA9J8Ng54Vcd5Oy8sqKTThbOUdT
         BurQ==
X-Gm-Message-State: AOAM532yXgAxDhzm4szKlTxzEnur2iLcqNpRvUHE0aUYQqVJm2zkDFwk
        sc5DaZwodaHgy8MArEsJb+rDBg==
X-Google-Smtp-Source: ABdhPJyaxRnmx31qJ773otOhIpiXrXVdNl7oAU0R9US0JIEF7l9/xbvUABmD0Zb2JretgdZ+u0nZKA==
X-Received: by 2002:adf:d1cc:0:b0:1f0:4570:bf75 with SMTP id b12-20020adfd1cc000000b001f04570bf75mr8705611wrd.656.1646664698673;
        Mon, 07 Mar 2022 06:51:38 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d4891000000b001e74e998bf9sm11502846wrq.33.2022.03.07.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 06:51:38 -0800 (PST)
Date:   Mon, 7 Mar 2022 14:51:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: arizona-spi: Add Android board ACPI table
 handling
Message-ID: <YiYb+Ea7aKO99gXL@google.com>
References: <20220223134222.730886-1-hdegoede@redhat.com>
 <20220223134222.730886-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223134222.730886-2-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022, Hans de Goede wrote:

> x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
> Android as factory installed OS.
> 
> The ACPI fwnode for the codec on Android boards misses 2 things compared
> to the Windows boards (this is hardcoded in the Android board kernels):
> 
> 1. There is no CLKE ACPI method to enabe the 32 KHz clock the codec needs
>    for jack-detection.
> 
> 2. The GPIOs used by the codec are not listed in the fwnode for the codec.
> 
> The ACPI tables on x86/ACPI boards shipped with Android being incomplete
> happens a lot. The special drivers/platform/x86/x86-android-tablets.c
> module contains DMI based per model handling to compensate for this.
> 
> This module will enable the 32KHz clock through the pinctrl framework
> to fix 1. and it will also register a gpio-lookup table for all GPIOs
> needed by the codec + machine driver, including the GPIOs coming from
> the codec itself.
> 
> Add an arizona_spi_acpi_android_probe() function which waits for the
> x86-android-tablets to have set things up before continue with probing
> the arizona WM5102 codec.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/arizona-spi.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> index 238355542ab1..2c686e71db21 100644
> --- a/drivers/mfd/arizona-spi.c
> +++ b/drivers/mfd/arizona-spi.c
> @@ -81,6 +81,29 @@ static int arizona_spi_acpi_windows_probe(struct arizona *arizona)
>  	return 0;
>  }
>  
> +/* For ACPI tables from boards which ship with Android as factory OS */
> +static int arizona_spi_acpi_android_probe(struct arizona *arizona)
> +{
> +	int ret;
> +
> +	/*
> +	 * Get the reset GPIO, treating -ENOENT as -EPROBE_DEFER to wait for
> +	 * the x86-android-tablets module to register the board specific GPIO
> +	 * lookup table.
> +	 */
> +	arizona->pdata.reset = devm_gpiod_get(arizona->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(arizona->pdata.reset)) {
> +		ret = PTR_ERR(arizona->pdata.reset);
> +		if (ret == -ENOENT) {
> +			dev_info_once(arizona->dev, "Deferring probe till GPIO lookup is registered\n");

Nit: How many chars is this?

I thought we were drawing the line at 100 these days?

Does this patch pass checkpatch.pl?

> +			ret = -EPROBE_DEFER;
> +		}
> +		return dev_err_probe(arizona->dev, ret, "getting reset GPIO\n");
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * The AOSP 3.5 mm Headset: Accessory Specification gives the following values:
>   * Function A Play/Pause:           0 ohm
> @@ -102,9 +125,14 @@ static const struct arizona_micd_range arizona_micd_aosp_ranges[] = {
>  
>  static int arizona_spi_acpi_probe(struct arizona *arizona)
>  {
> +	struct acpi_device *adev = ACPI_COMPANION(arizona->dev);
>  	int ret;
>  
> -	ret = arizona_spi_acpi_windows_probe(arizona);
> +	if (acpi_dev_hid_uid_match(adev, "10WM5102", NULL))
> +		ret = arizona_spi_acpi_android_probe(arizona);
> +	else
> +		ret = arizona_spi_acpi_windows_probe(arizona);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -142,6 +170,10 @@ static const struct acpi_device_id arizona_acpi_match[] = {
>  		.id = "WM510205",
>  		.driver_data = WM5102,
>  	},
> +	{
> +		.id = "10WM5102",
> +		.driver_data = WM5102,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, arizona_acpi_match);

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
