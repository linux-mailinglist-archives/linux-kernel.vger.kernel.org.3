Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175CC595887
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiHPKhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbiHPKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:36:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFF815735
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:00:50 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c28so9893730lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=043hWz8b615XDyOIXdxEzBsstB56mnVvGPAwgZ+APrg=;
        b=ZNsA5ND0kulqzso1yZe07rJLhJJrheK1Y1tL145gnSD8myu6YkhRoukYh42/mX4caY
         JNL9L3JXWjTSWqPruD/4kGN/FObUaDuDPSIS+N/rX1wD0ZvfNjprVGqltcPjenh8ki+T
         naMWYCRU2R5+3SdswZnTZCCkH0+Aw3EEp3cEM/Lq198dXdqInZWFYDTixh0rLOmvuGSu
         nBzu1YPEO8+M5I+gCKvyW9wqOHj9O2X/o7zlbhx7rRAFiATN/aOQVT0/D2Y/U8R+94Hp
         BMIOcASdRwo510/5QPpbVqbaQjnLVa3dzXY45dthe2kbbA2JI0GQshdby8vJlyNZoSPu
         k5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=043hWz8b615XDyOIXdxEzBsstB56mnVvGPAwgZ+APrg=;
        b=szDXRc1AOlZYtpEo+7HLecvkjypu1edFZXFqtE1lhfv8AewUYgebQzTSaPOiusegLJ
         V0hllBuhBcwwsvUniqcQZGbEWYK5KHffnmU9QH7roz0Vk1ZZdVvMGokiB8aJKvTq6P1+
         /MVUTL+sWE5XvKTAF8VAkzv815urjnxDuyaSPcAC7ey+F9oyFIF630KmQbeiLtEK5T3d
         viaFAHRkLiYdFJaMZSIOLjKf2ygKZ7ixA75JLGOnGelju54riycqCbVdeV7DgQYkrOZJ
         Cg73euoXBVlP25DCEsH/YOBW5LPCzlWJtrToXv3Yd+hrR0AOJdoHYylIY8Ug/qVv2jP1
         yiJA==
X-Gm-Message-State: ACgBeo1NIDRG1Dl2tTUbQZTK3aeIL9mg9UrdTiOXpV3aCmrZ3HEQLGvE
        DooJz1aq3z6E1paSkx74PZ/vmQ==
X-Google-Smtp-Source: AA6agR58GGqmd5KxhxWS4m9evkdUo6IfYO5ez03h86oGM7Y+w5L89kpSjzRxzfI/XeBoSG0VVyhsbA==
X-Received: by 2002:ac2:4562:0:b0:48b:2a91:e59 with SMTP id k2-20020ac24562000000b0048b2a910e59mr6621305lfm.91.1660640448810;
        Tue, 16 Aug 2022 02:00:48 -0700 (PDT)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id d2-20020a056512368200b0048afbe9d0fasm1329817lfs.45.2022.08.16.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 02:00:48 -0700 (PDT)
Date:   Tue, 16 Aug 2022 11:00:47 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 08/26] thermal/drivers/rcar: Use generic
 thermal_zone_get_trip() function
Message-ID: <YvtcvzhQwJdtGXYP@oden.dyn.berto.se>
References: <20220809220436.711020-1-daniel.lezcano@linaro.org>
 <20220809220436.711020-9-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220809220436.711020-9-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thanks for your work.

On 2022-08-10 00:04:18 +0200, Daniel Lezcano wrote:
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
> 
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/thermal/rcar_thermal.c | 49 +++++-----------------------------
>  1 file changed, 6 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index 4df42d70d867..003457810072 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -278,52 +278,16 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
>  	return rcar_thermal_get_current_temp(priv, temp);
>  }
>  
> -static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
> -				      int trip, enum thermal_trip_type *type)
> -{
> -	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> -	struct device *dev = rcar_priv_to_dev(priv);
> -
> -	/* see rcar_thermal_get_temp() */
> -	switch (trip) {
> -	case 0: /* +90 <= temp */
> -		*type = THERMAL_TRIP_CRITICAL;
> -		break;
> -	default:
> -		dev_err(dev, "rcar driver trip error\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
> -				      int trip, int *temp)
> -{
> -	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
> -	struct device *dev = rcar_priv_to_dev(priv);
> -
> -	/* see rcar_thermal_get_temp() */
> -	switch (trip) {
> -	case 0: /* +90 <= temp */
> -		*temp = MCELSIUS(90);
> -		break;
> -	default:
> -		dev_err(dev, "rcar driver trip error\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
>  	.get_temp	= rcar_thermal_get_temp,
>  };
>  
>  static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
>  	.get_temp	= rcar_thermal_get_temp,
> -	.get_trip_type	= rcar_thermal_get_trip_type,
> -	.get_trip_temp	= rcar_thermal_get_trip_temp,
> +};
> +
> +static struct thermal_trip trips[] = {
> +	{ .type = THERMAL_TRIP_CRITICAL, .temperature = 90000 }
>  };
>  
>  /*
> @@ -531,9 +495,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>  						dev, i, priv,
>  						&rcar_thermal_zone_of_ops);
>  		} else {
> -			priv->zone = thermal_zone_device_register(
> -						"rcar_thermal",
> -						1, 0, priv,
> +			priv->zone = thermal_zone_device_register_with_trips(
> +				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
>  						&rcar_thermal_zone_ops, NULL, 0,
>  						idle);
>  
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
