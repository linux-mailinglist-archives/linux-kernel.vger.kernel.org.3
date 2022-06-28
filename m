Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAC555CC01
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiF1Il7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343939AbiF1Il5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:41:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC442C679
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:41:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q9so16573717wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v5dmV6m+y35m/OOgFUolVoYy95Ck77s85Hp4iBdnIEo=;
        b=F59o5KjsPbQpgausMMqrm8CVGniwLPIxLhXpdIPg9kElTHzRRtcS6rV+FaKbuAUzQL
         oam7mbVakexhVRbbFdHeg077hpaHbcaLLVqdf0tjINnn2Mn08k7UONIG8ZoYayHqk1cW
         LG5tsALv7W0EizWuYg4Ud3aiFLXf1vYFUiy/WOd6pV3qw+O8SKpOMQPw7xV15t5506mi
         oSa/dXScRlfrJRpbx3DP0BrlWUqXj2WXz4RNasGblvmzDZVoT1MXJK0XXT89FMNdJ6gA
         OV0kleLs3VQn34z57rAFaUzh3vhWavHUp0NxOTsAgXvPwKbeJHrXNnaRD+5UO8ZaA5Lf
         M15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v5dmV6m+y35m/OOgFUolVoYy95Ck77s85Hp4iBdnIEo=;
        b=LWmPqgOKGyCOgi9c1vYURbTqH0bU8QV8fyY4eoXHHA2u51vujZt0jc7TEAkKK3Ix63
         g6hBkMUNjSGQQX6qQwMYzgsoOnIHbF0fDkSGelhztXsz1v9Qnu6VWmYuprWv3gOqHAG4
         f1XBUvdZLjkfksS0HQO8UBvMdvJ/Tfk/n7ruUVpZI+bYmoy3kuBL4wnPJjWsfZhURf8x
         uC8KScamn4hg4esjltS8pvoNCDBNh7CmABDRcMQQRqPiA3BrR3I/XBrTsJE4RB0v5tYU
         6DcQ4Ac5b7ia+a8pK68JHNzeqY3RyeRfjbXwTm2zd0aqZ4TmNTpAxX92j3XIr/NahZSV
         qXgw==
X-Gm-Message-State: AJIora/Irb0lkjfnl0CZnxcC/1f6cicLFfThigFJ8dRK/Eg9UVoK/tsn
        6GwM7VP4mQUwU8RnbxBvm/t5OA==
X-Google-Smtp-Source: AGRyM1smplhxwMTCxe8Jj9olr4VhTZF3JaobTkBOwjRs6XkCBFxFYEnEhd6dCwGrqiCtb/fwuwK2fQ==
X-Received: by 2002:a5d:5887:0:b0:21b:ca70:f60d with SMTP id n7-20020a5d5887000000b0021bca70f60dmr11370211wrf.32.1656405714610;
        Tue, 28 Jun 2022 01:41:54 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z4-20020adfd0c4000000b0021bbf6687b1sm11098476wrh.81.2022.06.28.01.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:41:54 -0700 (PDT)
Message-ID: <7841a809-e180-70d2-df9b-b30b411647ce@linaro.org>
Date:   Tue, 28 Jun 2022 10:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] thermal/drivers/tegra: Remove get_trend function
Content-Language: en-US
To:     rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-2-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220616202537.303655-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thierry, Dmitry,

are fine with this patch?

Thanks

   -- Daniel

On 16/06/2022 22:25, Daniel Lezcano wrote:
> The get_trend function does already what the generic framework does.
> 
> Remove it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/tegra/soctherm.c | 32 --------------------------------
>   1 file changed, 32 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 210325f92559..825eab526619 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -633,37 +633,6 @@ static int tegra_thermctl_set_trip_temp(void *data, int trip, int temp)
>   	return 0;
>   }
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
>   static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
>   {
>   	u32 r;
> @@ -716,7 +685,6 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
>   static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
>   	.get_temp = tegra_thermctl_get_temp,
>   	.set_trip_temp = tegra_thermctl_set_trip_temp,
> -	.get_trend = tegra_thermctl_get_trend,
>   	.set_trips = tegra_thermctl_set_trips,
>   };
>   


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
