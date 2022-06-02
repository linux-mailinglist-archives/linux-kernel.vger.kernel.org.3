Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5866953BB41
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiFBO4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiFBO4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:56:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344AA231464
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:56:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id g12so5534424lja.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ex4b4TnhWybZyjVbUNL7d03f2NgaeAD4hH+6kwOL0lQ=;
        b=BiVI4J6HA0A+rErH7CN0jpx+xan3lJasSd9jH5HppAcqLcusr6GtGe5OLXhfT3rp1u
         G7XBwbSzUDh0R4GMsQlWtdNsHHxamFHuMr9NX4Zlg+3FyEuogqOUUbmQcRLWnI8ZPZjt
         ZcpfE6AyXoqZAP1oLUv4js7ytJxeQN9uVjL3+fRaceBfDtHkMtS/a8IyVVrmpJ6jXP3b
         vTR/3KME/gipO66b2H1QHmJOvPHar2YFB1guW1AcVGE7/hKzF+DrFTKuFGo2kZqDAuEq
         aXitMDOHNCVy3utE1kE347qWGmIWYaVEn7niopOpZFAKVwaaxKZXwb7E2mf2l9fsAuDX
         XFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ex4b4TnhWybZyjVbUNL7d03f2NgaeAD4hH+6kwOL0lQ=;
        b=YjlryRC7sjX9YHdck2P00rOHIc9D7vMYCUex/f8dZOm3pV4GQbZ9hYsNMhJzxsARbt
         8tuyhd9sYb2J3Nq/v5aIDYeTbj1sh2qvCxG1l8Z/8qs9Vh4aLsugK7ufYMwl26uRs+Au
         uMjgVq/LT8kPWD5zxil1isVDGKx7Zpb7vJr7sbwUVjhIK+vPwVMoemXBgooINPPt3j9Q
         2b1N0xKd8bxSBp9qBfSvjQLlTHFDZPPDKG21sVRNQJTbqLIx+kaZVRWJF5fAf2OQFVzW
         EabuWxBC3WgNhWOnzLY5xDNUJr1X8KdRsLGzdPjaFymJHH0RHV0joa91qiLdmMhZFgj9
         rDiQ==
X-Gm-Message-State: AOAM531zm/OJXzv6CkX7+Eg0FIvGcyE6ecqrSXRLmN9XTsNCCiiWGJ8c
        wgLgBH3Hg6qsH+v24OlDJIv3Iw==
X-Google-Smtp-Source: ABdhPJz8vZyGeExLYDD7aZ8JYjAIwoFwfD6FNur7hEwgtI5H9bz+uHvyGCB08TqE/f62Vs6uNfX/1Q==
X-Received: by 2002:a05:651c:179f:b0:24b:1406:5f55 with SMTP id bn31-20020a05651c179f00b0024b14065f55mr41684120ljb.361.1654181774484;
        Thu, 02 Jun 2022 07:56:14 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c15-20020a05651200cf00b00478f6f63c00sm1067749lfp.146.2022.06.02.07.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 07:56:14 -0700 (PDT)
Message-ID: <075b907c-fd12-2e91-199b-c43d27340ed2@linaro.org>
Date:   Thu, 2 Jun 2022 17:56:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 4/4] drm/bridge: parade-ps8640: Provide
 wait_hpd_asserted() in struct drm_dp_aux
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
References: <20220418171757.2282651-1-dianders@chromium.org>
 <20220418101725.v3.4.Ie827321ce263be52fdb8c1276f6f8cc00d78029f@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220418101725.v3.4.Ie827321ce263be52fdb8c1276f6f8cc00d78029f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2022 20:17, Douglas Anderson wrote:
> This implements the callback added by the patch ("drm/dp: Add
> wait_hpd_asserted() callback to struct drm_dp_aux").
> 
> With this change and all the two "DP AUX Endpoint" drivers changed to
> use wait_hpd_asserted(), we no longer need to have an long delay in
> the AUX transfer function. It's up to the panel code to make sure that
> the panel is powered now. If someone tried to call the aux transfer
> function without making sure the panel is powered we'll just get a
> normal transfer failure.
> 
> We'll still keep the wait for HPD in the pre_enable() function. Though
> it's probably not actually needed there, this driver is used in the
> old mode (pre-DP AUX Endpoints) and it may be important for those
> cases. If nothing else, it shouldn't cause any big problems.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor nit below

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Change is_hpd_asserted() to wait_hpd_asserted()
> 
>   drivers/gpu/drm/bridge/parade-ps8640.c | 34 ++++++++++++++++----------
>   1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 9766cbbd62ad..2f19a8c89880 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -168,23 +168,30 @@ static bool ps8640_of_panel_on_aux_bus(struct device *dev)
>   	return true;
>   }
>   
> -static int ps8640_ensure_hpd(struct ps8640 *ps_bridge)
> +static int _ps8640_wait_hpd_asserted(struct ps8640 *ps_bridge, unsigned long wait_us)
>   {
>   	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
> -	struct device *dev = &ps_bridge->page[PAGE2_TOP_CNTL]->dev;
>   	int status;
> -	int ret;
>   
>   	/*
>   	 * Apparently something about the firmware in the chip signals that
>   	 * HPD goes high by reporting GPIO9 as high (even though HPD isn't
>   	 * actually connected to GPIO9).
>   	 */
> -	ret = regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
> -				       status & PS_GPIO9, 20 * 1000, 200 * 1000);
> +	return regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
> +					status & PS_GPIO9, wait_us / 10, wait_us);
> +}
>   
> -	if (ret < 0)
> -		dev_warn(dev, "HPD didn't go high: %d\n", ret);
> +static int ps8640_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned long wait_us)
> +{
> +	struct ps8640 *ps_bridge = aux_to_ps8640(aux);
> +	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
> +	int ret;
> +
> +	pm_runtime_get_sync(dev);
> +	ret = _ps8640_wait_hpd_asserted(ps_bridge, wait_us);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);

I'd add a note here, that the called should have already woken up the 
device.

>   
>   	return ret;
>   }
> @@ -323,9 +330,7 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
>   	int ret;
>   
>   	pm_runtime_get_sync(dev);
> -	ret = ps8640_ensure_hpd(ps_bridge);
> -	if (!ret)
> -		ret = ps8640_aux_transfer_msg(aux, msg);
> +	ret = ps8640_aux_transfer_msg(aux, msg);
>   	pm_runtime_mark_last_busy(dev);
>   	pm_runtime_put_autosuspend(dev);
>   
> @@ -369,8 +374,8 @@ static int __maybe_unused ps8640_resume(struct device *dev)
>   	 * Mystery 200 ms delay for the "MCU to be ready". It's unclear if
>   	 * this is truly necessary since the MCU will already signal that
>   	 * things are "good to go" by signaling HPD on "gpio 9". See
> -	 * ps8640_ensure_hpd(). For now we'll keep this mystery delay just in
> -	 * case.
> +	 * _ps8640_wait_hpd_asserted(). For now we'll keep this mystery delay
> +	 * just in case.
>   	 */
>   	msleep(200);
>   
> @@ -406,7 +411,9 @@ static void ps8640_pre_enable(struct drm_bridge *bridge)
>   	int ret;
>   
>   	pm_runtime_get_sync(dev);
> -	ps8640_ensure_hpd(ps_bridge);
> +	ret = _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
> +	if (ret < 0)
> +		dev_warn(dev, "HPD didn't go high: %d\n", ret);
>   
>   	/*
>   	 * The Manufacturer Command Set (MCS) is a device dependent interface
> @@ -652,6 +659,7 @@ static int ps8640_probe(struct i2c_client *client)
>   	ps_bridge->aux.name = "parade-ps8640-aux";
>   	ps_bridge->aux.dev = dev;
>   	ps_bridge->aux.transfer = ps8640_aux_transfer;
> +	ps_bridge->aux.wait_hpd_asserted = ps8640_wait_hpd_asserted;
>   	drm_dp_aux_init(&ps_bridge->aux);
>   
>   	pm_runtime_enable(dev);


-- 
With best wishes
Dmitry
