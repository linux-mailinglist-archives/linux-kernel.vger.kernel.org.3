Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84655504D2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiFRMob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 08:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiFRMoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 08:44:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAFE11801;
        Sat, 18 Jun 2022 05:44:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g12so1264988ljk.11;
        Sat, 18 Jun 2022 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=b447jOYXFdxyC5KLKr4cT1iaWa3YtDHOE19FUkUZFxI=;
        b=Y09/U+3h7GblcidI+246WuwzVXexOkGoPXfX1PNsq3sMJbAdG1fNyVgv1C17Z5SbJu
         AgVYtvcUhb9wqZumwwcTdoB+xcyopGEJRiVmwrnIClhvERJib8L17f04eUqmOuBi2BrH
         1YPOJ2iptquUetsJY79ef+SpWYxeqb5YFwqLrseDnDf/UyeY3b7CY9+r331tq0iMrBWV
         MYi59h0oWdQQWzgY75Wp13lqUnv4B83Fb2WULYMi+ybDm1qnKKZ/9aE+EKdQqQmcyKac
         EaUwlnQmmB6g4w0YnoqVU7Oa+NxAeZinL3jZEAaJbx7TX1w9bJyYvkh0RSjKI+fXe8oO
         JBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=b447jOYXFdxyC5KLKr4cT1iaWa3YtDHOE19FUkUZFxI=;
        b=uOXo2HAvbzvcH7dL/VRWtQQSjzmvKBpi6nexpXBEG3oz6PfdDBWjv10izt9lEajwkK
         RIq2uPJpSmffuCw9GE+A0n8ArsQzu2zYvBgQz+2abYcmTFzvS9fGmsdMI982j0MCCzPR
         DVMEnSXAh82+a4eZeqkZZzXDb7oZPvm5ak+j9KWSI7WC4TID/S7ul2y28Far6XvtdoM7
         qW7t0IAwLIDmIAI8VyA46/poK0VgaZk6+Mz0u4M1nh5U1VjtOGXnKXzswCNuUmWNkUvX
         sUL3YMW5qxyMcy5jl0W51ERLsRXmAxXD9o75Ewlw00FYkCKrb7pWhL9+Dumj7BYV+jhN
         N62Q==
X-Gm-Message-State: AJIora9SbgfsfBhsNLpBkXZiRh+JHE15iSboYgGQSnQrhA/jm0sEf9Qp
        NaDl87IOeXuQSoCqUTO18WC1F8LSgYM=
X-Google-Smtp-Source: AGRyM1uNGyupmSNC5LwN280DtpS+8PQAJv6zujwqVJTkDeIuZq4jJjVNUWOka2yF8oBdz8mKpDlh+g==
X-Received: by 2002:a2e:b1c8:0:b0:258:642d:98b0 with SMTP id e8-20020a2eb1c8000000b00258642d98b0mr7410361lja.447.1655556254103;
        Sat, 18 Jun 2022 05:44:14 -0700 (PDT)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru. [109.252.136.92])
        by smtp.googlemail.com with ESMTPSA id a25-20020a05651c031900b002554dde32bfsm931096ljp.47.2022.06.18.05.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 05:44:13 -0700 (PDT)
Message-ID: <6d5b2bfc-f449-668c-8c97-638eb806cb66@gmail.com>
Date:   Sat, 18 Jun 2022 15:44:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] thermal/drivers/tegra: Remove get_trend function
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-2-daniel.lezcano@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220616202537.303655-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.06.2022 23:25, Daniel Lezcano пишет:
> The get_trend function does already what the generic framework does.
> 
> Remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/tegra/soctherm.c | 32 --------------------------------
>  1 file changed, 32 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 210325f92559..825eab526619 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -633,37 +633,6 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
>  	return 0;
>  }
>  
> -static int tegra_thermctl_get_trend(void *data, int trip,
> -				    enum thermal_trend *trend)
> -{
> -	struct tegra_thermctl_zone *zone = data;
> -	struct thermal_zone_device *tz = zone->tz;
> -	int trip_temp, temp, last_temp, ret;
> -
> -	if (!tz)
> -		return -EINVAL;
> -
> -	ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
> -	if (ret)
> -		return ret;
> -
> -	temp = READ_ONCE(tz->temperature);
> -	last_temp = READ_ONCE(tz->last_temperature);
> -
> -	if (temp > trip_temp) {
> -		if (temp >= last_temp)
> -			*trend = THERMAL_TREND_RAISING;
> -		else
> -			*trend = THERMAL_TREND_STABLE;
> -	} else if (temp < trip_temp) {
> -		*trend = THERMAL_TREND_DROPPING;
> -	} else {
> -		*trend = THERMAL_TREND_STABLE;
> -	}
> -
> -	return 0;
> -}
> -
>  static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
>  {
>  	u32 r;
> @@ -716,7 +685,6 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
>  static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
>  	.get_temp = tegra_thermctl_get_temp,
>  	.set_trip_temp = tegra_thermctl_set_trip_temp,
> -	.get_trend = tegra_thermctl_get_trend,
>  	.set_trips = tegra_thermctl_set_trips,
>  };
>  

The framework doesn't use the trip temperature, is it really the same?
Previously, if temperature was above the trip and was dropping, then it
was THERMAL_TREND_STABLE instead of THERMAL_TREND_DROPPING.
