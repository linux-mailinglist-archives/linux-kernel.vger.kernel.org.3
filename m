Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8405854F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiG2SMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238211AbiG2SMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:12:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC875FAFA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:12:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w15so8418072lft.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=YRtWVtjASRhasg4zc8teXz0/znN+y1S+ZkqIbY7XKTA=;
        b=nKEbCpTn4ES338fo/oL+ZxbpzekkKK2V0nZCrR8D9coR5pJNycc5h9KHT3bd8XeneQ
         vPSuxtMcHwyAfCbOMCvpReAOZt0imu43u+fzDy1KqhXerbTrgMa2PFQ/1EM3YFWwnm20
         n+Pay0YAcn5etX+RhQMrfN2166BiRYs1f6LlxnUIgqQA17G+U4KzPhZlOZpPSwW9yDJc
         VqmOVvoVheAn8/IAIy+SueUv7yI1jmne/GlQE11VSytvv8R0SJvtANTgFeVKRxqOoG8P
         pbs6XpbiFip7/U/Ms8xoVcdMPVTz11kQDSLw9cyGEAoUlwClryZRDsAT/7eUJXB0Enty
         p/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=YRtWVtjASRhasg4zc8teXz0/znN+y1S+ZkqIbY7XKTA=;
        b=TiYvaJuShBQ1NZY8aaYDxFEcXlkYUerkQHWeCW0+i6l0SYXATYh53+AwtKCiIF6tRj
         yIlL5GwS0YqMaXpOLIQlp0UvValQd7wMZcGFwTbDXYs01n5lh1UYmwZ3fBwOa9LJsW4W
         8R6/LjnPyH3rnBlWtNTPAn5fvsxJ5oYR/kphpnstPBt1XMB3YyUwyPLwNMO5iBP+lW0y
         JHyUd7zoeS9VgM9X5pYnV9Fdl1yqt9fSr2EGbYeu7m/sxhM6GopZwTKJRBlj0XJ1L/3F
         JYBbu/MMfvW1VC5XfarMqq6hYop0vTKEdLgyBgWGRK9PjjI3g79knhdiZZZLYAvyrW6W
         D3Hg==
X-Gm-Message-State: AJIora9iq86hRDZmpAfN/CCKb0U5TuVNN/WkYcoBdQF+qq4U+2Oogsbk
        xH5GJroyowontOPkdXNxE4I=
X-Google-Smtp-Source: AGRyM1tGTdtn7I/aNBel79an2DZRtTumSuY2b+SFhmNnAAQda14q5JmpFf7rHUQ5FfW3XCUPU7bjZw==
X-Received: by 2002:a05:6512:1521:b0:48a:3c5d:5d17 with SMTP id bq33-20020a056512152100b0048a3c5d5d17mr1600643lfb.587.1659118331035;
        Fri, 29 Jul 2022 11:12:11 -0700 (PDT)
Received: from [192.168.177.6] (public-gprs370360.centertel.pl. [37.47.77.249])
        by smtp.googlemail.com with ESMTPSA id p3-20020a2e7403000000b0025e0b9ea91csm731173ljc.84.2022.07.29.11.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 11:12:10 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <0e285cf5-6ef2-3484-9fb7-5eb55c0ca269@gmail.com>
Date:   Fri, 29 Jul 2022 20:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH v1 20/35] drm/vc4: vec: Switch for common modes
Content-Language: pl
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-20-3d53ae722097@cerno.tech>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-20-3d53ae722097@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

I'm just noting that the modelines you defined in drm_modes.c are 
different to the ones you're removing here.

The horizontal sync differences probably doesn't matter too much, VC4 
uses those only as a hint anyway and generates sync autonomously, so the 
slight differences will only cause the image to slightly shift horizontally.

But you're also changing the 480i vertical sync (vsync_start is now 488 
instead of 487, etc.). Are you sure that this won't break anything? This 
will probably shift the image by 1 line (which for the 480i might 
actually mean going out of spec), and I _think_ it might control the odd 
vs. even field first modes on some drivers. I won't be able to test this 
before Monday, but I'm just pointing out the potential issue.

BTW, I've seen a similar thing in the sun4i driver changes (patch 32/35) 
and the differences in vertical sync are even more dramatic. It's 
entirely possible that the current timings in sun4i are broken and the 
new ones are correct (the new ones certainly look saner to me), but I'd 
double-check if that driver does not have any quirks that would 
_require_ such weird settings.

Best regards,
Mateusz Kwiatkowski

W dniu 29.07.2022 o 18:35, Maxime Ripard pisze:
> Now that the core has a definition for the 525 and 625 lines analog TV
> modes, let's switch to it for vc4.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>
> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> index 8f30a530b2d5..255bba563fce 100644
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> @@ -224,38 +224,24 @@ static const struct debugfs_reg32 vec_regs[] = {
>   	VC4_REG32(VEC_DAC_MISC),
>   };
>   
> -static const struct drm_display_mode ntsc_mode = {
> -	DRM_MODE("720x480", DRM_MODE_TYPE_DRIVER, 13500,
> -		 720, 720 + 14, 720 + 14 + 64, 720 + 14 + 64 + 60, 0,
> -		 480, 480 + 7, 480 + 7 + 6, 525, 0,
> -		 DRM_MODE_FLAG_INTERLACE)
> -};
> -
> -static const struct drm_display_mode pal_mode = {
> -	DRM_MODE("720x576", DRM_MODE_TYPE_DRIVER, 13500,
> -		 720, 720 + 20, 720 + 20 + 64, 720 + 20 + 64 + 60, 0,
> -		 576, 576 + 4, 576 + 4 + 6, 625, 0,
> -		 DRM_MODE_FLAG_INTERLACE)
> -};
> -
>   static const struct vc4_vec_tv_mode vc4_vec_tv_modes[] = {
>   	[VC4_VEC_TV_MODE_NTSC] = {
> -		.mode = &ntsc_mode,
> +		.mode = &drm_mode_480i,
>   		.config0 = VEC_CONFIG0_NTSC_STD | VEC_CONFIG0_PDEN,
>   		.config1 = VEC_CONFIG1_C_CVBS_CVBS,
>   	},
>   	[VC4_VEC_TV_MODE_NTSC_J] = {
> -		.mode = &ntsc_mode,
> +		.mode = &drm_mode_480i,
>   		.config0 = VEC_CONFIG0_NTSC_STD,
>   		.config1 = VEC_CONFIG1_C_CVBS_CVBS,
>   	},
>   	[VC4_VEC_TV_MODE_PAL] = {
> -		.mode = &pal_mode,
> +		.mode = &drm_mode_576i,
>   		.config0 = VEC_CONFIG0_PAL_BDGHI_STD,
>   		.config1 = VEC_CONFIG1_C_CVBS_CVBS,
>   	},
>   	[VC4_VEC_TV_MODE_PAL_M] = {
> -		.mode = &pal_mode,
> +		.mode = &drm_mode_576i,
>   		.config0 = VEC_CONFIG0_PAL_BDGHI_STD,
>   		.config1 = VEC_CONFIG1_C_CVBS_CVBS | VEC_CONFIG1_CUSTOM_FREQ,
>   		.custom_freq = 0x223b61d1,
>

