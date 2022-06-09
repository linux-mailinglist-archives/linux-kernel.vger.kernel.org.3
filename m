Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6436554480C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbiFIJyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiFIJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:54:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E88194254
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:54:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k19so31630828wrd.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dgxIUh9kZnAhshZpAfcCNmc5NM9XP1H+pazqAWk3o4M=;
        b=sYbi7/4QmhUcDAphES1n3sjziqocBdZaVokz7jqGR4vrF3G3Qx7JFQpiauElXr2toJ
         gZCDaP679DwAhMrD7ycpRlIYOzaEABiJxvohe6lQDbOyZ046TDwXOkS0cfiY0nbpoyJn
         YCLA016qOzd+q/EJpiVMQjT/jLcQTvR3KG6oXmdYhV8Q2nNGNmausPfLhEbsQeMd/AeP
         cCNlWGGAQTCzmt6MBNFK4z7FzPN3oY6B1jDnNTP8HO6T7vXWhZeqo2tkfKjPrjmkzih1
         okOr9aVs9Hff9CcOIbUAMS5m1PFeAewjo+nOUf8xnjRWRtJM3OEVD6S68MmTywxggO4G
         esMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dgxIUh9kZnAhshZpAfcCNmc5NM9XP1H+pazqAWk3o4M=;
        b=SZHjqzuA5NEmRAFkWGvgt0e2MEMZHxIgJAoxkjCycUV63UVmGTbvjVb7UqarcKpAMF
         f2ND3gu4QTMrLiq0DBjtzNpheswdGUm7mK2U3Srg2K9nEfj6HLhKoM0N/DRoeyuZRO0a
         ruf+FzqV6QoqmHS7OzCzO+UgwfS3uOUSTtmYORV7YrrvfnxE4Pe6TjTwTC9vAM/9wcuY
         P84AzQg1wqIG0E+EuQPlVHMsWudckzNqVsfjRms4Sc6Ww2ihu3zUSJO2KMO430zD+1CI
         nqbHOzCXSGqark77Hub2CE30F8n3UTwqlB8Ukd89xRR0m53o0TlBVR0tZ3s5f8/XohNh
         Uyog==
X-Gm-Message-State: AOAM530oB9ces4PA/YT+9HZgrkTlyqtZdu2/JxE2g1JfiRCnSHENlgtL
        m/XxMYo1PDENS/zzqRuwQFa90A==
X-Google-Smtp-Source: ABdhPJwFTfJT5VBRvmZdE52zTqSkomJN72re/rRGHQq1XZGdbN0tmi270rT5tG9338WBlHEIN7CpYw==
X-Received: by 2002:a5d:64e7:0:b0:218:5626:7e7f with SMTP id g7-20020a5d64e7000000b0021856267e7fmr11844016wri.245.1654768455480;
        Thu, 09 Jun 2022 02:54:15 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d504d000000b002100e86319asm15031976wrt.78.2022.06.09.02.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:54:14 -0700 (PDT)
Date:   Thu, 9 Jun 2022 10:54:12 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: atmel_lcdfb: Rework backlight status updates
Message-ID: <20220609095412.fccofr2e2kpzhw4t@maple.lan>
References: <20220608205623.2106113-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608205623.2106113-1-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 10:56:23PM +0200, Stephen Kitt wrote:
> Instead of checking the state of various backlight_properties fields
> against the memorised state in atmel_lcdfb_info.bl_power,
> atmel_bl_update_status() should retrieve the desired state using
> backlight_get_brightness (which takes into account the power state,
> blanking etc.). This means the explicit checks using props.fb_blank
> and props.power can be dropped.
> 
> Then brightness can only be negative if the backlight is on but
> props.brightness is negative, so the test before reading the
> brightness value from the hardware can be simplified to
> (brightness < 0).

props.brightness should always be in the interval 0..max_brightness.

This is enforced by the main backlight code (and APIs to set the
brightness use unsigned values). Thus props.brightness could only be
negative is the driver explicitly sets a negative value as some kind of
placeholder (which this driver does not do).

I don't think there is any need to keep this logic.


Daniel.


> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index 1fc8de4ecbeb..06159a4da293 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -109,22 +108,10 @@ static u32 contrast_ctr = ATMEL_LCDC_PS_DIV8
>  static int atmel_bl_update_status(struct backlight_device *bl)
>  {
>  	struct atmel_lcdfb_info *sinfo = bl_get_data(bl);
> -	int			power = sinfo->bl_power;
> -	int			brightness = bl->props.brightness;
> +	int			brightness = backlight_get_brightness(bl);
>  
> -	/* REVISIT there may be a meaningful difference between
> -	 * fb_blank and power ... there seem to be some cases
> -	 * this doesn't handle correctly.
> -	 */
> -	if (bl->props.fb_blank != sinfo->bl_power)
> -		power = bl->props.fb_blank;
> -	else if (bl->props.power != sinfo->bl_power)
> -		power = bl->props.power;
> -
> -	if (brightness < 0 && power == FB_BLANK_UNBLANK)
> +	if (brightness < 0)
>  		brightness = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
> -	else if (power != FB_BLANK_UNBLANK)
> -		brightness = 0;
>  
>  	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, brightness);
>  	if (contrast_ctr & ATMEL_LCDC_POL_POSITIVE)
