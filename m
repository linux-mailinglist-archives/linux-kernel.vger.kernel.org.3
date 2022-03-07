Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFBD4D0294
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiCGPUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiCGPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:20:13 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756116A005
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:19:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t11so23867223wrm.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 07:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hwFEIH70dUCNWsMAW/01lRUmkLpF7WH9uESSqO/Vh4E=;
        b=gNQ4y/7L6UPyjmXf3QKUUJIOP5Ac3nf+awzAPjkEinHdvhodtP8r0taWcNQiZ2WWeO
         715jwikmoXM+xsApAT0MulT0IK72aUCZsh1f/AVT6GD8oY+IX4hWXJqVv12TUi0b716z
         CPyG0SK7fNlYuUIeNv5uoZa5Tu7EK15lL28gOnNwyUoW/CGDxZiXvDRnCa5JoZSYnJhS
         7hq84agf5oeOb7DyU01A5XRn0gu0vfqyhFdDVH6ifBFCElGLoVZrUFzRhYXWbui0Zllz
         Bdz1/FVReCRP1tNrfPqO0gyj4g3fwISKSdMahUhnRaRNBJd6dQFQVMv+HyVHM0Nj0B4b
         mViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hwFEIH70dUCNWsMAW/01lRUmkLpF7WH9uESSqO/Vh4E=;
        b=nQBNJrh+GDcsk+3mubSG/6aBO27y2jLQfRtXyIBKT0VUv49AoYGR0ZI7hcoLEOY1qt
         ENnmplDHpt2YyhqKqF2RjxTNg94tkk7cjbujUr0gekcaMR15U1hZWynVqwi6LYL3e2xT
         4wBQTfzYXVW/FoMM8g6h1LKoeROltiqwdZN9YyFiQhTq3LcAqmYrUNWUFwcg+OcJ6ZUF
         ytpqhnMf0IsrTRx6UyC5qAzpRhoq79xrdszXXnLekj0i7NnUlVV6HoTDfC9MC6WJQ3t/
         H1EuQqehBH9a9upp95Ax5NR6q2340W9s6ZTqibffd2vRJRXGHce0E98OmVYxP5ouEvN4
         cUMg==
X-Gm-Message-State: AOAM530KAhs+nAoGYu1smvl0FXNTrojLx8/9mwp3aZbMsurtR5l2nVHT
        1zBIBT26ipG5p7DFea5raU3Iibh5lw21TA==
X-Google-Smtp-Source: ABdhPJwg1tjWFd8p55cRJwQY7y0036QM6t6SCyUMINH3J0Zdl0S+BFuAycGsjwGHlCgB4IOwEKCiCA==
X-Received: by 2002:adf:8067:0:b0:1ea:9c01:d8f3 with SMTP id 94-20020adf8067000000b001ea9c01d8f3mr8796517wrk.556.1646666356970;
        Mon, 07 Mar 2022 07:19:16 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm17055006wmq.35.2022.03.07.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:19:16 -0800 (PST)
Date:   Mon, 7 Mar 2022 15:19:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: arizona-spi: Add Android board ACPI table
 handling
Message-ID: <YiYicoaSc7KYTbvj@google.com>
References: <20220223134222.730886-1-hdegoede@redhat.com>
 <20220223134222.730886-2-hdegoede@redhat.com>
 <YiYb+Ea7aKO99gXL@google.com>
 <ac21f173-2cba-0ddc-67db-27e06950c2d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac21f173-2cba-0ddc-67db-27e06950c2d4@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2022, Hans de Goede wrote:

> Hi,
> 
> On 3/7/22 15:51, Lee Jones wrote:
> > On Wed, 23 Feb 2022, Hans de Goede wrote:
> > 
> >> x86/ACPI boards with an arizona WM5102 codec ship with either Windows or
> >> Android as factory installed OS.
> >>
> >> The ACPI fwnode for the codec on Android boards misses 2 things compared
> >> to the Windows boards (this is hardcoded in the Android board kernels):
> >>
> >> 1. There is no CLKE ACPI method to enabe the 32 KHz clock the codec needs
> >>    for jack-detection.
> >>
> >> 2. The GPIOs used by the codec are not listed in the fwnode for the codec.
> >>
> >> The ACPI tables on x86/ACPI boards shipped with Android being incomplete
> >> happens a lot. The special drivers/platform/x86/x86-android-tablets.c
> >> module contains DMI based per model handling to compensate for this.
> >>
> >> This module will enable the 32KHz clock through the pinctrl framework
> >> to fix 1. and it will also register a gpio-lookup table for all GPIOs
> >> needed by the codec + machine driver, including the GPIOs coming from
> >> the codec itself.
> >>
> >> Add an arizona_spi_acpi_android_probe() function which waits for the
> >> x86-android-tablets to have set things up before continue with probing
> >> the arizona WM5102 codec.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  drivers/mfd/arizona-spi.c | 34 +++++++++++++++++++++++++++++++++-
> >>  1 file changed, 33 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> >> index 238355542ab1..2c686e71db21 100644
> >> --- a/drivers/mfd/arizona-spi.c
> >> +++ b/drivers/mfd/arizona-spi.c
> >> @@ -81,6 +81,29 @@ static int arizona_spi_acpi_windows_probe(struct arizona *arizona)
> >>  	return 0;
> >>  }
> >>  
> >> +/* For ACPI tables from boards which ship with Android as factory OS */
> >> +static int arizona_spi_acpi_android_probe(struct arizona *arizona)
> >> +{
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * Get the reset GPIO, treating -ENOENT as -EPROBE_DEFER to wait for
> >> +	 * the x86-android-tablets module to register the board specific GPIO
> >> +	 * lookup table.
> >> +	 */
> >> +	arizona->pdata.reset = devm_gpiod_get(arizona->dev, "reset", GPIOD_OUT_LOW);
> >> +	if (IS_ERR(arizona->pdata.reset)) {
> >> +		ret = PTR_ERR(arizona->pdata.reset);
> >> +		if (ret == -ENOENT) {
> >> +			dev_info_once(arizona->dev, "Deferring probe till GPIO lookup is registered\n");
> > 
> > Nit: How many chars is this?
> 
> 105.
> 
> > I thought we were drawing the line at 100 these days?
> 
> We have an exception for log lines, since we don't want to break them
> up because that makes grepping for them impossible.
> 
> > Does this patch pass checkpatch.pl?
> 
> Yes because of the exception for log lines:
> 
> [hans@x1 linux]$ scripts/checkpatch.pl 0001-mfd-arizona-spi-Add-Android-board-ACPI-table-handlin.patch 
> total: 0 errors, 0 warnings, 54 lines checked
> 
> 0001-mfd-arizona-spi-Add-Android-board-ACPI-table-handlin.patch has no obvious style problems and is ready for submission.

What do you mean by long lines?

I'm aware of the exception for long strings.

Not sure why anyone would grep for "dev_info_once(arizona->dev, ".

I would break this after the first comma.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
