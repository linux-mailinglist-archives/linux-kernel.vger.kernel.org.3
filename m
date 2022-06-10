Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC15462D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347871AbiFJJxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiFJJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:53:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0FAAF1F7;
        Fri, 10 Jun 2022 02:53:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y29so29007842ljd.7;
        Fri, 10 Jun 2022 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ytoGZR3SKueDIWMp5RM2UctQDbYqSwipVeXgdfbfnM=;
        b=UbCSAyXCa6b1vFT0idjjlhl84Pixh7H7H7P4Ph34Ts3wqqAVoSVGXdf4ZEAGGNPtPY
         uOwwP/XSabYf38M9Tq/1IC2bBCVVj8MVTXy+a/N74pWbonAYIbbId4gus60T1k96o2dc
         Vo8PXw0GNGJeFAGwbSY1ZmROZM9I5peIDwmROHeDtm0uTfen4NolFjjKHPd3whSue2zL
         kKXRg6AUj34FVZYooCG2pTURs4ksLrMgd8h/g8XoZGPbcb9sOaQyiCBWs0LNyLhKjA5v
         TQwUGbFWpAenIHAhpfbjIfXyyz1zIC/ypb0H5x+Q4yOSCZRdru2cP0jyJMfDRzYO8Gfb
         VZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ytoGZR3SKueDIWMp5RM2UctQDbYqSwipVeXgdfbfnM=;
        b=3InFXqympDs9rGyLDo9hUE+2aYuv0qaKcgEHQou8aFhcsO0ZHdUoCQAUIDWUXtlpkf
         aD8MHz56yjFQjZxFTgOr+lIyJj4k7+G2QjzxEqphPdY5yrJ+omkev+EZgAqD6hJuKu/O
         kQ11bm7eIKjK19RXp2iEIdOtylXiC87sZKPWXi+mpjFcCKVLIhv/3XlZ0Qjxl155CmBH
         +oTBJHPNIIdTSF/QoH/b5BR2FQxEnmHxR3ShCGe/CX1WSH8UZf8Sqh8Cy8VehiNX5riX
         E4dOr6vzXq2MxPyPhJneQvl4UEF2l7ZRGTKyiiX46qS8aV3qK/7WCG2alXK2Rcuecb2M
         8seQ==
X-Gm-Message-State: AOAM530owxVuoKfwyfKeM05TlxoAWzuc3dVVFTxNdJkdvfqoymOis0Uf
        s4P/EVi27z67A6KsuXNwgEzcOs6jIHiT/P/D
X-Google-Smtp-Source: ABdhPJyWwHvE39IjYiR2lr+IB/8Q3z/V2k0vrJIXIQdhmp18zRsHZPHOwdsE+vCx68xUXX3hMoCpnw==
X-Received: by 2002:a2e:3c12:0:b0:255:7b24:6fe5 with SMTP id j18-20020a2e3c12000000b002557b246fe5mr21743530lja.117.1654854795364;
        Fri, 10 Jun 2022 02:53:15 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id b8-20020a0565120b8800b0047255d2115fsm4650117lfv.142.2022.06.10.02.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 02:53:14 -0700 (PDT)
Date:   Fri, 10 Jun 2022 12:53:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: dwapb: Don't print error on -EPROBE_DEFER
Message-ID: <20220610095312.kjr3hgpm7cfi53i7@mobilestation>
References: <20220610075152.10214-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610075152.10214-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 10:51:52AM +0300, Serge Semin wrote:
> Currently if the APB or Debounce clocks aren't yet ready to be requested
> the DW GPIO driver will correctly handle that by deferring the probe
> procedure, but the error is still printed to the system log. It needlessly
> pollutes the log since there was no real error but a request to postpone
> the clock request procedure since the clocks subsystem hasn't been fully
> initialized yet. Let's fix that by using the dev_err_probe method to print
> the APB/clock request error status. It will correctly handle the deferred
> probe situation and print the error if it actually happens.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/gpio/gpio-dwapb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index b0f3aca61974..a51458be34a9 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -653,7 +653,7 @@ static int dwapb_get_clks(struct dwapb_gpio *gpio)
>  	err = devm_clk_bulk_get_optional(gpio->dev, DWAPB_NR_CLOCKS,
>  					 gpio->clks);
>  	if (err) {

> -		dev_err(gpio->dev, "Cannot get APB/Debounce clocks\n");
> +		dev_err_probe(gpio->dev, err, "Cannot get APB/Debounce clocks\n");

As Philipp correctly pointed out here:
https://lore.kernel.org/lkml/20220610080103.10689-1-Sergey.Semin@baikalelectronics.ru/
This can be shortened out by directly returning a value returned by
the dev_err_probe() method. I'll fix that in v2.

-Sergey

>  		return err;
>  	}
>  
> -- 
> 2.35.1
> 
