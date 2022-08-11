Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D485F5908F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 01:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbiHKXHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 19:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiHKXHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:07:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235F2A0621;
        Thu, 11 Aug 2022 16:07:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p18so18166452plr.8;
        Thu, 11 Aug 2022 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=PYKZX4LUyyfbbh5GPQ/dPdshp4hv00OyR27fJ3UKGT0=;
        b=eU2lIdLTIRsVTh+pxIjuSyvsiTBd/KPoYav8y0zg0W3gi7GdmZbzJBbm/wnivjoSsA
         eBenS5XufGWotsS7frdu5olJzS4Falqdl5bkH8V00KM6zgyDzmdBmdDPFL6NWWiJx1a1
         CsWPhtAR/FnWb1aTACqY0FJl/sNGP4zGToZl/2UyG4ki0gFOGLfEYKIjF87JFNgMnWfQ
         2C9KOnYWpu1pSlb7NK9m4wYfWmJqseFyeWMEwyCXxbSprNxw5GaJT7jlny7D22iip8u8
         fzRGLoCdAjxwary+ZMbGD/HWXiQH04zpcUnan59hSxWc5XywAgGN5KFAE6/6fICNtU9x
         +JIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=PYKZX4LUyyfbbh5GPQ/dPdshp4hv00OyR27fJ3UKGT0=;
        b=ejhjDmumGxwIRM6OpMFyBn3mz7r81FkvGeR7Qp4dm1RIt/es2enJktjmdD11lFzRpb
         Qol50JLu01ADCS2xcuAmSHXRSu2pZNtySHs+7/Ri+zvewK2+zt+S72D6/f9yfMh4aZj0
         eckRwKy3KCMf8BHC1PiSsW0beI3HVwVsZuUaeqE1TizQpO6CJiFLMZdD9HWuUO0cfbQ8
         dafM/NTJF/H0PdEbw0hbNBqlwRuFui66tyae7JPmDomLIvFsQmN75P0vo47iUC4HGowy
         BpoP8c9D/AXSlBz81fSJIkJtl1ddzs7zu9QQMULS4f0PcliFQzvg0BFJ/orgC0qzVbkd
         gWPQ==
X-Gm-Message-State: ACgBeo0eTtl+IczXtU+LA9ayC5JJst49Kgw8B0r7gPbZJvIop5RZ9MoH
        Q9uFafuvAyn8u6p1yPxeJKO2cuqY9sA=
X-Google-Smtp-Source: AA6agR6+9lvI92klQYKUZq5VhsqntSFPrhRXfhbjJOQ+83s6yeE988HUUjH4R/gmPcE07XeBPYh6YA==
X-Received: by 2002:a17:902:e750:b0:170:8891:83be with SMTP id p16-20020a170902e75000b00170889183bemr1372306plf.12.1660259269411;
        Thu, 11 Aug 2022 16:07:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c348:229d:7b9:f9dd])
        by smtp.gmail.com with ESMTPSA id g15-20020a65594f000000b0041d7ab5865dsm250168pgu.49.2022.08.11.16.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 16:07:48 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:07:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Benjamin Rood <benjaminjrood@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan MacDonald <dmacdonald@curbellmedical.com>
Subject: Re: 0001-Input-pixcir_i2c_ts-lengthen-reset-pulse-to-touchscr
Message-ID: <YvWLwpQemH1Rm95r@google.com>
References: <Mailbird-54ba6c13-8fd5-42db-9ad8-fc347c3039f4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Mailbird-54ba6c13-8fd5-42db-9ad8-fc347c3039f4@gmail.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, Aug 11, 2022 at 02:33:13PM -0400, Benjamin Rood wrote:
> From bd53d80e1966320f8d6f2775337043cbac2d1b6e Mon Sep 17 00:00:00 2001
> From: Benjamin Rood <benjaminjrood@gmail.com>
> Date: Thu, 11 Aug 2022 14:18:16 -0400
> Subject: [PATCH] Input: pixcir_i2c_ts - lengthen reset pulse to touchscreen
>  controller
> 
> This patch adjust the reset pulse in the pixcir_i2c_ts driver to address
> the following issues:
> 
> 1. Not driving the reset signal HIGH for a long enough period, resulting
> in a "shark fin" reset signal.
> 2. Not waiting long enough after assering the reset signal to issue the
> first I2C transaction, which results in a NACK because the touchscreen
> controller was not ready to communicate.  This typically results in the
> touchscreen controller not enumerating as an input device.
> 
> The changes included in this patch address the above two issues by:
> 
> 1. Configuring the delay after driving the reset signal HIGH to use
> usleep_range(500, 1000) to allow the reset signal to reach a full logic
> HIGH voltage for a maximum period of 1ms.  This is overkill as the
> datasheet specs 80ns as the minimum duration of the reset pulse, so by
> overshooting the timing by quite a lot, it gives the driving chip enough
> time to drive a logic HIGH to assert the reset.

I guess 1 msec is not that bad...

> 2. Configuring the delay after de-asserting the reset signal to be a
> duration of 1s before issuing the first I2C transaction.  This allows
> the touchscreen controller to fully boot which avoids a NACK an a
> missing input device.

but 1 sec is insanely long, especially for driver that is not marked for
async probe. I wonder, since (I assume) the time to get out of reset
state is not specified in the datasheet, if we could not retry I2C xfers
with a small delays between them instead of waiting for whole second.

How long does it actually take for the controller to exit the reset
state on your system?

> 
> Kudos also should be given to my colleage Dan MacDonald
> <dmacdonald@curbellmedical.com> for helping to discover and fix these
> issues.
> 
> Signed-off-by: Benjamin Rood <benjaminjrood@gmail.com>
> ---
>  drivers/input/touchscreen/pixcir_i2c_ts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index dc148b4bed74..324e41886dea 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -222,10 +222,10 @@ static void pixcir_reset(struct pixcir_i2c_ts_data *tsdata)
>  {
>   if (!IS_ERR_OR_NULL(tsdata->gpio_reset)) {
>   gpiod_set_value_cansleep(tsdata->gpio_reset, 1);
> - ndelay(100); /* datasheet section 1.2.3 says 80ns min. */
> + usleep_range(500, 1000); /* datasheet section 1.2.3 says 80ns min. */
>   gpiod_set_value_cansleep(tsdata->gpio_reset, 0);
>   /* wait for controller ready. 100ms guess. */
> - msleep(100);
> + msleep(1000);

Please note that the patch is whitespace-damaged. Did you paste it into
gmail UI?

>   }
>  }
>  
> -- 
> 2.25.1

Thanks.

-- 
Dmitry
