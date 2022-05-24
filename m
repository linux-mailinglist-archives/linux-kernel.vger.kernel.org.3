Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0A253322E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbiEXUII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiEXUIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:08:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621B55AA4E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:08:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso3200660pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=95joObH0DwG1ZqidG+ckHPbt1l+SEtovBpUjPuTMARQ=;
        b=Ns2bJ3hmUXS3Ha59g4WB/YCeIS3bfiBK+VHy4aBbe1YPC4MZF9l2OOdJcfOk7ryF5w
         6+QZoe4GUkVROZYVFDPXQo3YvvAUN0P/BXYCBXe3apQDv2ob3+HIZvbme0DxJ2idLlNq
         w4opPNJNfYvRVge96SoQ75Palo0WcphPukuZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=95joObH0DwG1ZqidG+ckHPbt1l+SEtovBpUjPuTMARQ=;
        b=KwtXOp0geOVQgBJCykyJwaWQ86bddqM6a/OZMVuzc862lo6EdCm2ixmgbKuAw1tzc4
         cRXrPo9IJpNTCHQjSjmDextqa4cDSMsXLS4WH/aRAFZP6XPJkLDSIu7oHyxHXnMIRI0c
         rxhaV+pdSx1Iug+5WwQLYCXMFeSuyhn9tN+enTZLmqOU+KcqLK8Ymf4kveoLL+/c4p5F
         JcszzoNQuZLhc1kT6s1RXSysHMJ5ZtKDbu9hezvHng/M/m5l3b/nX2f9x8ZHQEy/ysdj
         eZPOhRqpTGAvTvBuikoVJKaKAy+fKi1apb9Ez848BsywWNU4q8IHIZCbqVfx0taBSkOT
         F+qA==
X-Gm-Message-State: AOAM531gbvkaQ/xq1l0iuRQqjWIIcaRryqKR2IS4fP3A8PZOnqCF9aHm
        Csuvj8nGq3GUP86saW8gPzxYvA==
X-Google-Smtp-Source: ABdhPJyGffqe7c8R22Fe2/Z2lTu2ZUsTSmkFgyj/pojZItiJcQ0fRKHH4swVtz/YkeOzaTI4Qz7zWg==
X-Received: by 2002:a17:90a:1911:b0:1df:b08a:e252 with SMTP id 17-20020a17090a191100b001dfb08ae252mr6241484pjg.215.1653422881823;
        Tue, 24 May 2022 13:08:01 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:d9e2:8472:9ac:8532])
        by smtp.gmail.com with UTF8SMTPSA id d5-20020a170902b70500b0015ed003552fsm7632910pls.293.2022.05.24.13.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 13:08:01 -0700 (PDT)
Date:   Tue, 24 May 2022 13:08:00 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 4/5] platform/chrome: cros_kbd_led_backlight: support
 OF match
Message-ID: <Yo07IDqYuQUzeL+N@google.com>
References: <20220523090822.3035189-1-tzungbi@kernel.org>
 <20220523090822.3035189-5-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Mon, May 23, 2022 at 05:08:21PM +0800, Tzung-Bi Shih wrote:
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

You need to put this assignment inside an '#ifdef CONFIG_OF' block,
otherwise the compiler won't find 'keyboard_led_of_match' when
CONFIG_OF isn't set.
