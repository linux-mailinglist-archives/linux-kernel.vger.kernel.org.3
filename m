Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9A598DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346037AbiHRUY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345975AbiHRUYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:24:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB16327;
        Thu, 18 Aug 2022 13:23:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w14so2422809plp.9;
        Thu, 18 Aug 2022 13:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=+f47M8bnKeVgHl+2cxbnmIQoyHB0xTlkNOuBRH0IAOI=;
        b=dYMcmCDSqwoLtSPeWiNd1pOUBeGeToMXODzJd8fsEPqRDRCehxILZFkbBjNRJNG7Dj
         gD+ERA/jgbUDXMBFAkPtp8g0HkD8MLmnXaU4XxWVggeALlkRuhrl8ePC4DGaDKApusKo
         0nOr0lGQ1BzrKGuM+LZOSPIA3PRcRSElxIJjovrHH7Xh+KOBdhcMITw/gCEy7CCUcaqo
         x5mGljJsyR2o02N/R3JmF5NuL9jaZzv3/gFDMKjvuO79rkvZRRXl1CnJIJKv3L1OKZKX
         ARnEYIhU/qf3isf2QfxFnRv7OBiawDLbgIZBDU2HUP7vumSWfaec4cUC9mVthWSJLXdg
         LOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=+f47M8bnKeVgHl+2cxbnmIQoyHB0xTlkNOuBRH0IAOI=;
        b=qBp2DHb/bHtjLqEYaBcBcy7wTitaBPaZY1VXi933AJyvl6brjTdE7d0WkM5mvVeyVk
         SZMG/6S/aPaZm+lrGhzGnajvYWRs9OTZ1c3TQFOXA3jP5R135O+URhFXjgmYGJEykaRG
         nrMl4srKf9b6GMESf3Bbhv08dz9qJkMnZJC4BPqQzQQkKtvDT2fRO5Vndkxzm5zL0L6F
         YnWaX/Dpi2lp9VVlqxUb3V60vvbvgJGUQjbDT7w7V7nF38YhH+ch/ZoNltICtPyAntmC
         asqR6YlsVwGNnwKv49UiP6TPnluM5Nh3BM5fq7sGjKV/MuLd23fl4TsounPuQambq9d8
         nEpA==
X-Gm-Message-State: ACgBeo3nigKJ2I9rnK3RrOBbgMnF5eMgloAugZBa4fMfyghuf22n69t6
        USm0D2JB8e4XgLgVs18o2gJdzxLtzBA=
X-Google-Smtp-Source: AA6agR7vwLxurJjdjYVWP1aemep6T2jAyD2CszOcLQztYe+Wt4GScjqJqbCaATwjA1tbIzTuNQCTLg==
X-Received: by 2002:a17:90a:c782:b0:1f7:a6cf:2f41 with SMTP id gn2-20020a17090ac78200b001f7a6cf2f41mr10344892pjb.128.1660854207313;
        Thu, 18 Aug 2022 13:23:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2-20020a632002000000b0042988a04bfdsm1674346pgg.9.2022.08.18.13.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 13:23:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 13:23:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eliav Farber <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 12/16] hwmon: (mr75203) modify the temperature equation
Message-ID: <20220818202324.GA3431316@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-13-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817054321.6519-13-farbere@amazon.com>
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

On Wed, Aug 17, 2022 at 05:43:17AM +0000, Eliav Farber wrote:
> Modify the equation and coefficients to convert the digital output to
> temperature according to series 5 of the Moortec Embedded Temperature
> Sensor (METS) datasheet:
> T = G + H * (n / cal5 - 0.5) + J * F
> 
> The G, H and J coefficients are multiplied by 1000 to get the temperature
> in milli-Celsius.
> 

This is, at the very least, confusing. It doesn't explain the discrepancy
to the old code nor the change in constant values. I have no idea if this
change would result in erroneous readings on some other system where
the existing calculation may be the correct one.

On top of that, it seems overflow-prune in 32 bit systems.

Guenter

> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/hwmon/mr75203.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
> index e3191f590167..e500897585e4 100644
> --- a/drivers/hwmon/mr75203.c
> +++ b/drivers/hwmon/mr75203.c
> @@ -102,9 +102,10 @@
>  
>  #define PVT_POLL_DELAY_US	20
>  #define PVT_POLL_TIMEOUT_US	20000
> -#define PVT_H_CONST		100000
> -#define PVT_CAL5_CONST		2047
> -#define PVT_G_CONST		40000
> +#define PVT_H_CONST		60000
> +#define PVT_G_CONST		200000
> +#define PVT_J_CONST		-100
> +#define PVT_CAL5_CONST		4094
>  #define PVT_CONV_BITS		10
>  #define PVT_N_CONST		90
>  #define PVT_R_CONST		245805
> @@ -158,7 +159,6 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
>  	struct regmap *t_map = pvt->t_map;
>  	u32 stat, nbs;
>  	int ret;
> -	u64 tmp;
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
> @@ -176,12 +176,13 @@ static int pvt_read_temp(struct device *dev, u32 attr, int channel, long *val)
>  		nbs &= SAMPLE_DATA_MSK;
>  
>  		/*
> -		 * Convert the register value to
> -		 * degrees centigrade temperature
> +		 * Convert the register value to degrees centigrade temperature:
> +		 * T = G + H * (n / cal5 - 0.5) + J * F
>  		 */
> -		tmp = nbs * PVT_H_CONST;
> -		do_div(tmp, PVT_CAL5_CONST);
> -		*val = tmp - PVT_G_CONST - pvt->ip_freq;
> +		*val = PVT_G_CONST;
> +		*val += PVT_H_CONST * nbs / PVT_CAL5_CONST;
> +		*val -= PVT_H_CONST / 2;
> +		*val += PVT_J_CONST * pvt->ip_freq / HZ_PER_MHZ;
>  
>  		return 0;
>  	default:
> @@ -313,7 +314,7 @@ static int pvt_init(struct pvt_device *pvt)
>  		    (key >> 1) << CLK_SYNTH_HI_SFT |
>  		    (key >> 1) << CLK_SYNTH_HOLD_SFT | CLK_SYNTH_EN;
>  
> -	pvt->ip_freq = sys_freq * 100 / (key + 2);
> +	pvt->ip_freq = clk_get_rate(pvt->clk) / (key + 2);
>  
>  	if (t_num) {
>  		ret = regmap_write(t_map, SDIF_SMPL_CTRL, 0x0);
