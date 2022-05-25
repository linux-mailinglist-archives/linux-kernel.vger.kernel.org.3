Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3F534333
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbiEYSk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiEYSkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:40:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D317EB2266
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:40:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q4so19302782plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kcKV1w2nPlwaIbCWnEveE9hseS5PyiFCk/LlY1siP3E=;
        b=gF4mzOT2oM4CfPgmn1UlSGGEbwf+gvzsFyifnYVIbjNO0iu8sUlx7k25anA+q/KaOi
         373snxdX0rBgwl3v9kDUgarArIHyNVdS6o43qZlRlc4EcZFit/EVrtVCsh1VFdW6f3hV
         35T/ena+zbKsnIdkZeM9Mbe6e3JwSsSvQtZO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kcKV1w2nPlwaIbCWnEveE9hseS5PyiFCk/LlY1siP3E=;
        b=kuPCL+yOBjxqOCRk4RrKlQ4EajBmQUsDAEeBzIoXY5SHjH7W4qKcmdGWRTu4QTNQ1z
         Zw90J2tOrpgjQdzWI8kScJI7mrs3I15Ncz0aT0nbC3CrbPJgmz9F9gQbXg/KH7YLviDO
         jIQU1h1VM5y2jzpGnFzB7YKY9vW5Run/fxTo0QsS4Egaf6XPA2ligA+Ubk5kPsbbP7/C
         mY5LtJ8ZW5+92EI9aptbOmAgi/PdxX6fl4H6BRKci8br0YRyIan3WSS9yDmnJFFpGCCh
         FSvLHmMuzwXO5XdxMo/P//nuh//COl6IW2WytkceaSS3GVsq517k7TFbDrEX0CAsL6cO
         dvsg==
X-Gm-Message-State: AOAM5334ZjCtUrY3aO9ShyraSi+nGdBJwnFCDIEXAJku+qCTxnKiBklk
        ee/++M+7gsl6TzEV7T2dwgzNhg==
X-Google-Smtp-Source: ABdhPJytsR6CP9N4WKNHzCbzIrM1a3ij8m7Yn9JRjYK1/hXrfhC81XsY53KcEwNKFeCSuEw5eHFn4g==
X-Received: by 2002:a17:903:2445:b0:161:d47e:88cf with SMTP id l5-20020a170903244500b00161d47e88cfmr33393332pls.67.1653504054374;
        Wed, 25 May 2022 11:40:54 -0700 (PDT)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a8d8100b001df93c8e737sm2133845pjo.39.2022.05.25.11.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 11:40:53 -0700 (PDT)
Date:   Wed, 25 May 2022 18:40:52 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        mka@chromium.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 4/5] platform/chrome: cros_kbd_led_backlight: support
 OF match
Message-ID: <Yo54NGcb45oNBfUY@chromium.org>
References: <20220523090822.3035189-1-tzungbi@kernel.org>
 <20220523090822.3035189-5-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523090822.3035189-5-tzungbi@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi,

On May 23 17:08, Tzung-Bi Shih wrote:
> For letting device tree based machines to use the driver, support OF match.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> No changes from v3.
> 
> Changes from v2:
> - Add commit message.
> - Add R-b tag.
> 
> Changes from v1:
> (https://patchwork.kernel.org/project/chrome-platform/patch/20220214053646.3088298-5-tzungbi@google.com/)
> - Update email address accordingly.
> - Use device_get_match_data() per review comment in v1.
> 
>  drivers/platform/chrome/cros_kbd_led_backlight.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
> index a86d664854ae..4bca880d7721 100644
> --- a/drivers/platform/chrome/cros_kbd_led_backlight.c
> +++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
> @@ -10,7 +10,9 @@
>  #include <linux/kernel.h>
>  #include <linux/leds.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>

linux/of.h includes linux/property.h [1]

[1] https://elixir.bootlin.com/linux/v5.18/source/include/linux/of.h#L22

>  #include <linux/slab.h>
>  
>  /**
> @@ -116,7 +118,7 @@ static int keyboard_led_probe(struct platform_device *pdev)
>  	const struct keyboard_led_drvdata *drvdata;
>  	int error;
>  
> -	drvdata = acpi_device_get_match_data(&pdev->dev);
> +	drvdata = device_get_match_data(&pdev->dev);
>  	if (!drvdata)
>  		return -EINVAL;
>  
> @@ -152,10 +154,21 @@ static const struct acpi_device_id keyboard_led_acpi_match[] = {
>  MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
>  #endif
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id keyboard_led_of_match[] = {
> +	{
> +		.compatible = "google,cros-kbd-led-backlight",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, keyboard_led_of_match);
> +#endif
> +
>  static struct platform_driver keyboard_led_driver = {
>  	.driver		= {
>  		.name	= "chromeos-keyboard-leds",
>  		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
> +		.of_match_table = of_match_ptr(keyboard_led_of_match),
>  	},
>  	.probe		= keyboard_led_probe,
>  };
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 
> 
