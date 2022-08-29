Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6AC5A4EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiH2N6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiH2N6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:58:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616F380F49;
        Mon, 29 Aug 2022 06:58:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l3so8060516plb.10;
        Mon, 29 Aug 2022 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=uyREE3fVUfVLXJ9trWcxM2jpkfj4wawfjqxKtCQdtxA=;
        b=K3orChyEl1A6UE9Ly+Y03qPb6XOUUe2qzgKr5pkBRS7CFcpc9FR/pvhxIU/aGBN16c
         +kyygQgxUaxZTp+iQg0x3lhZM33wG5SMyJRh0es4VL9r4YwOAokMDxCs79ANmtF8i1nV
         c84bo1fXAJFE8Egir1R1/kSDfEpGd9cLOGV1LbQ6nNX1Dp9/PZnBHHnH05zbabvp+UxI
         lXBL8JfU6UvAYQLHSfyvNdVT8gRPQCTQC1DGXlg/raAnerBoNTgRfVr68F6wMs2X/6mV
         J0wOTl/PK7kfWLBlLEkZA7xLlGr3tDHiSPB6cMmvN3eRKqXdras4zkYTR2mODqWElY0L
         Jgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=uyREE3fVUfVLXJ9trWcxM2jpkfj4wawfjqxKtCQdtxA=;
        b=2Setj6vFXkmR3zuZkG901GUtRUMCmOBh031TTTULHEeGn/YjEpregE5YRUBz5vOBQW
         m75lQabZzPXj+UABfLjp2HQIL51kNa/F5MyBlRmNznzpPTJOaPdH+NqFJWgz1KspnS2T
         QOdDFzZmLSmamClhqpfYC2TLlKLkSgiOsApWUgOWvMy4HjiWptpBLMi6DGMhdcfuyj3B
         LM1/gFe1sscjG6YPS5APFP1COPom2DXfiUbvxTnMJsaIDZRWOJcDDSLzl0IFh7zXIGHT
         RrGSZYGpL5KHvLNSQ2spYgte8b7p6w8Cwi0Mkl/b4DSoRysslQG+34CSi2WBrnfFzaKu
         7s5g==
X-Gm-Message-State: ACgBeo1molrpGh4DKcEjUQR+rmuLOe48rAOs1EIT9NIyS5fkpc8I2arz
        78j6Zqvb8hGA/o+byqADdZ0=
X-Google-Smtp-Source: AA6agR6Q6YpWQ51FcZTGOpVW7g4gq/cMS0zb6rHM4EA4LQpOVbKe9Cxnq3Onm2eCPPb2IREyOn8H2w==
X-Received: by 2002:a17:90b:3003:b0:1fd:f876:72f4 with SMTP id hg3-20020a17090b300300b001fdf87672f4mr717140pjb.145.1661781479939;
        Mon, 29 Aug 2022 06:57:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b202-20020a621bd3000000b005377c854b50sm7252719pfb.1.2022.08.29.06.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:57:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 29 Aug 2022 06:57:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v2 1/3] hwmon: (pwm-fan) Replace OF specific call to PWM
 by plain one
Message-ID: <20220829135758.GA306130@roeck-us.net>
References: <20220826172642.16404-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826172642.16404-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 08:26:40PM +0300, Andy Shevchenko wrote:
> There is no need to call OF specific devm_of_pwm_get() since
> the device node parameter duplicates in the device parameter.
> Hence we may safely replace it by plain devm_pwm_get() call.
> 
> This allows to drop devm_of_pwm_get() as no more users will be.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I am going to apply the series to hwmon-next.
Uwe, please holler if that is not ok.

Thanks,
Guenter

> ---
> v2: added tag (Uwe), left only one-liner change (Uwe, Guenter)
>  drivers/hwmon/pwm-fan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 6c08551d8d14..06fd1d75101d 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -302,7 +302,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	mutex_init(&ctx->lock);
>  
> -	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
> +	ctx->pwm = devm_pwm_get(dev, NULL);
>  	if (IS_ERR(ctx->pwm))
>  		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
>  
