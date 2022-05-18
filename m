Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC35D52B2D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiERHKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiERHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:10:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F50E64FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:10:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t6so1300447wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZCNKI5woerPUrmPCB0wU/T9brPPBMRmt8DMnLhy8VFA=;
        b=3ZiEMpESJJSEUhffXP/IpwU9L2ho0mVvu018crv9SbiP4Y91EhmpwbxBkut6kmW1uv
         bSEKpuWdEwxM4fOwpWwLa+ybzQ6DPAj15+PJQtxz1og9wv16KN7EX41jzdDipCfRiAfE
         m97bekTjXB9iaz45+9UF8ZyqSm3JWC1Gnoz2RY9fb1AlsbWUtLXVsrrbV93IpKJlleVb
         f18fBUCx5xabxRATX6cxrdH0wMsUzwTgi6gS9Rp+poGVHR4ba/RPti6wCFBtgJRdMQDC
         3yjk4jRLsWEewxBy/ZCKewsTZ7kzOLG6TVMXyjkBHA0LY9YwDI5igpSRV4tILoOJ258e
         p+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZCNKI5woerPUrmPCB0wU/T9brPPBMRmt8DMnLhy8VFA=;
        b=FqRuLZMIT8G/kesYtbm/x7WlFzA84V6UDM97+NlhJ/XTrPOkI1VWDdpS4xDbGmXuhP
         bKlt99y599RtnOOHXg79Omotre55MaeYMSFnpiZ1pVUL4q0PjA+bBkx7zD36AbEztXZi
         Fkfke7r3zpmkz+fzn+BZgGajpAANBeOQIID9lJOJDy+RljFtjsMyyYv0/Fx71ezEfzv3
         4VEs9lMi2vhBvSHIRYkBaI5UDAaWbxzSY8Cyjo5pSkNmFOPXn7flYsNoGAlCr5TQjaZh
         Djs/V2+txyH4yEMcY4ERHP4uBbnAGDuhVf+0YMquC95MOKiApb9hWKGN0L8LSvPH9FX+
         4tPA==
X-Gm-Message-State: AOAM531EQE+yQ0foZO5aKZ+pYeHpNx6PNwAUv6OkdhdcwOdITS9IBAgt
        OZGRQz2oNe/MnzQmaFHg/m35AhN3uHKj3KEQ
X-Google-Smtp-Source: ABdhPJyOF3VINKLZf/L/OcxPy0tS8BWcAs3AlYPYrG5qnl7HqufB62jEn9h9Q2demM7n5Qsnkh6J/w==
X-Received: by 2002:a5d:584b:0:b0:20c:6317:1f77 with SMTP id i11-20020a5d584b000000b0020c63171f77mr21948376wrf.355.1652857803413;
        Wed, 18 May 2022 00:10:03 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:dea9:338d:d500:c574? ([2001:861:44c0:66c0:dea9:338d:d500:c574])
        by smtp.gmail.com with ESMTPSA id bg26-20020a05600c3c9a00b003942a244ee0sm962397wmb.37.2022.05.18.00.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:10:02 -0700 (PDT)
Message-ID: <bb8e1955-b82f-bb6d-69ce-bd0845aa2ec1@baylibre.com>
Date:   Wed, 18 May 2022 09:10:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/meson: add YUV422 output support
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Dongjin Kim <tobetter@gmail.com>,
        Furkan Kardame <f.kardame@manjaro.org>
References: <20220516072245.10745-1-christianshewitt@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220516072245.10745-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 09:22, Christian Hewitt wrote:
> From: Dongjin Kim <tobetter@gmail.com>
> 
> Support YUV422 output from the Amlogic Meson SoC VPU to the HDMI
> controller. Without this YUV422 format out of the HDMI encoder
> leads to using the dw-hdmi YUV444 to YUV422 color conversion which
> gives wrong colors and a green line on the left edge of the screen.
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Furkan Kardame <f.kardame@manjaro.org>
> ---
> I've had this patch in my sources for some time now; originally picked
> from Dongjin's mainline branches for Hardkernel boards and tweaked for
> some minor renaming after DRM bridge changes were merged. Furkhan has
> reminded me this is still needed a couple of days ago and now the same
> issue is reported on the mailing list [0] so best to submit it. If a
> fixes tag is required? please advise the commit and i'll resend.
> 
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 5e306de6f485..08529efb4405 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -218,7 +218,8 @@ static void meson_encoder_hdmi_atomic_enable(struct drm_bridge *bridge,
>   	if (encoder_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYYVYY8_0_5X24) {
>   		ycrcb_map = VPU_HDMI_OUTPUT_CRYCB;
>   		yuv420_mode = true;
> -	}
> +	} else if (encoder_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYVY8_1X16)
> +		ycrcb_map = VPU_HDMI_OUTPUT_CRYCB;
>   
>   	/* VENC + VENC-DVI Mode setup */
>   	meson_venc_hdmi_mode_set(priv, vic, ycrcb_map, yuv420_mode, mode);
> @@ -230,6 +231,10 @@ static void meson_encoder_hdmi_atomic_enable(struct drm_bridge *bridge,
>   		/* Setup YUV420 to HDMI-TX, no 10bit diphering */
>   		writel_relaxed(2 | (2 << 2),
>   			       priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
> +	else if (encoder_hdmi->output_bus_fmt == MEDIA_BUS_FMT_UYVY8_1X16)
> +		/* Setup YUV422 to HDMI-TX, no 10bit diphering */
> +		writel_relaxed(1 | (2 << 2),
> +				priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
>   	else
>   		/* Setup YUV444 to HDMI-TX, no 10bit diphering */
>   		writel_relaxed(0, priv->io_base + _REG(VPU_HDMI_FMT_CTRL));
> @@ -257,6 +262,7 @@ static void meson_encoder_hdmi_atomic_disable(struct drm_bridge *bridge,
>   
>   static const u32 meson_encoder_hdmi_out_bus_fmts[] = {
>   	MEDIA_BUS_FMT_YUV8_1X24,
> +	MEDIA_BUS_FMT_UYVY8_1X16,
>   	MEDIA_BUS_FMT_UYYVYY8_0_5X24,
>   };
>   

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
