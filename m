Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49E75301E1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 10:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242037AbiEVIhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 04:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbiEVIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 04:37:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F43B3614C
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:37:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f21so9307518ejh.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XsyKoH6LpiATp9ZAhLZkNq7NYsEkUYnS/BXvVMGV97s=;
        b=DHyfeM0n6/4AUuRDrpljFlQiHJe89GVpKBXu1F/YuNkXjtX0Tph8oTgAsXn0Hey+Lz
         4sOLibIqVwrVFHAqoQB1Em3Y3WuQrEUrooA76cowDapb4LDuPuCVF8TkVwjYce2vjWvx
         fZiJ41OfgBJdNPwqQItsQOSfLySkv/2pyC8YNosDTHuH76H1p7P8uwS+wCvDspkkofPS
         QsNojRCjHc4wQCOLvX0nECtJodmkOBeoYaCuceLox5ChxkIwjyrHC1d2qnT/EM3JT8LT
         XbwQQHwF6yKEV/Q68B6rXTWuT3s+HoGpfXear4L98Wl4r0cAEBJ4yQIxvl8TtAc7rcgp
         h/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XsyKoH6LpiATp9ZAhLZkNq7NYsEkUYnS/BXvVMGV97s=;
        b=oSfUDm2yIZBUm0Z9QmoWKVfvo3Xv6WC+6LryRyRYPV34osdR/RsN0YbDbeqVmryt6o
         mS1+5ejjVaWpnZF0VnmazN3qC/K3UPgxmQSE1cwvYkHohW+mkNsOpXhUteIKnEXtOgKa
         98ZO65TjjxbRSjHqfXIFwHVjQM3Hs36QO68Nmk48LzfAD/wIFd8YC5XorSOIJ/SM7Q40
         a82CL1Xfl5u3d+pn0N0+EBprjeuGJv3cjgIfrLxGx1wXD3+RDV1BsgB9zWhJ8Fmq7RyD
         PJE0BiGf41lR8LIAqvkI2tDmcxNju3Ke9F5JYSx7jid3Fq+5Aea32WcaHRZkHcszKTeZ
         mpEw==
X-Gm-Message-State: AOAM5308f9K9i5Uiw1SSGdmeBSvDmglh8b1ocQI6ch4pwEW0d9EYexD2
        7s2Szf6UMDCIY1iYdPijZ9U=
X-Google-Smtp-Source: ABdhPJz3CV8JYQCceCSBFGfodUqj22X+yRGu7v0vIulurX3hct86iUuziZZ3MaglfgkfvwnoDuuySw==
X-Received: by 2002:a17:907:908b:b0:6fe:8c1f:3e47 with SMTP id ge11-20020a170907908b00b006fe8c1f3e47mr15474294ejb.594.1653208618613;
        Sun, 22 May 2022 01:36:58 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id mm24-20020a170906cc5800b006fe9ba21333sm3517525ejb.113.2022.05.22.01.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 01:36:58 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org, Genfu Pan <benlypan@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, samuel@sholland.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Genfu Pan <benlypan@gmail.com>
Subject: Re: [PATCH] drm/sun4i: mixer: fix scanline for V3s and D1
Date:   Sun, 22 May 2022 10:36:57 +0200
Message-ID: <3173956.44csPzL39Z@jernej-laptop>
In-Reply-To: <20220521133443.1114749-1-benlypan@gmail.com>
References: <20220521133443.1114749-1-benlypan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne sobota, 21. maj 2022 ob 15:34:43 CEST je Genfu Pan napisal(a):
> Accrording the SDK from Allwinner, the scanline value of yuv and rgb for
> V3s are both 1024.

s/scanline value/scanline length/

Which SDK? All SDKs that I have or found on internet don't mention YUV nor RGB 
scanline limit. That doesn't mean there is none, I'm just unable to verify 
your claim. Did you test this by yourself? Also, please make YUV scanline 
change separate patch with fixes tag.

> The is also the same for mixer 1 of D1. Currently the
> scanline value of rgb is hardcoded to 2048 for all SOCs.
> 
> Change the scanline_yuv property of V3s to 1024. > Add the scanline_rgb
> property to the mixer config and replace the hardcoded value with it before
> scaling.

I guess RGB scanline patch would also need fixes tag, since it fixes existing 
bug.

> 
> Signed-off-by: Genfu Pan <benlypan@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 13 ++++++++++++-
>  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  1 +
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  3 +--
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> b/drivers/gpu/drm/sun4i/sun8i_mixer.c index 875a1156c..e64e08207 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -567,6 +567,7 @@ static const struct sun8i_mixer_cfg
> sun8i_a83t_mixer0_cfg = { .ccsc		= CCSC_MIXER0_LAYOUT,
>  	.scaler_mask	= 0xf,
>  	.scanline_yuv	= 2048,
> +	.scanline_rgb	= 2048,
>  	.ui_num		= 3,
>  	.vi_num		= 1,
>  };
> @@ -575,6 +576,7 @@ static const struct sun8i_mixer_cfg
> sun8i_a83t_mixer1_cfg = { .ccsc		= CCSC_MIXER1_LAYOUT,
>  	.scaler_mask	= 0x3,
>  	.scanline_yuv	= 2048,
> +	.scanline_rgb	= 2048,
>  	.ui_num		= 1,
>  	.vi_num		= 1,
>  };
> @@ -584,6 +586,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg
> = { .mod_rate	= 432000000,
>  	.scaler_mask	= 0xf,
>  	.scanline_yuv	= 2048,
> +	.scanline_rgb	= 2048,
>  	.ui_num		= 3,
>  	.vi_num		= 1,
>  };
> @@ -593,6 +596,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg
> = { .mod_rate	= 297000000,
>  	.scaler_mask	= 0xf,
>  	.scanline_yuv	= 2048,
> +	.scanline_rgb	= 2048,
>  	.ui_num		= 3,
>  	.vi_num		= 1,
>  };
> @@ -602,6 +606,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg
> = { .mod_rate	= 297000000,
>  	.scaler_mask	= 0x3,
>  	.scanline_yuv	= 2048,
> +	.scanline_rgb	= 2048,
>  	.ui_num		= 1,
>  	.vi_num		= 1,
>  };
> @@ -610,7 +615,8 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg
> = { .vi_num = 2,
>  	.ui_num = 1,
>  	.scaler_mask = 0x3,
> -	.scanline_yuv = 2048,
> +	.scanline_yuv = 1024,
> +	.scanline_rgb = 1024,
>  	.ccsc = CCSC_MIXER0_LAYOUT,
>  	.mod_rate = 150000000,
>  };
> @@ -620,6 +626,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg
> = { .mod_rate	= 297000000,
>  	.scaler_mask	= 0x3,
>  	.scanline_yuv	= 2048,
> +	.scanline_rgb	= 2048,
>  	.ui_num		= 1,
>  	.vi_num		= 1,
>  };
> @@ -629,6 +636,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg
> = { .mod_rate	= 297000000,
>  	.scaler_mask	= 0x1,
>  	.scanline_yuv	= 1024,
> +	.scanline_rgb	= 1024,
>  	.ui_num		= 0,
>  	.vi_num		= 1,
>  };
> @@ -638,6 +646,7 @@ static const struct sun8i_mixer_cfg
> sun50i_a64_mixer0_cfg = { .mod_rate	= 297000000,
>  	.scaler_mask	= 0xf,
>  	.scanline_yuv	= 4096,
> +	.scanline_rgb	= 2048,
>  	.ui_num		= 3,
>  	.vi_num		= 1,
>  };
> @@ -647,6 +656,7 @@ static const struct sun8i_mixer_cfg
> sun50i_a64_mixer1_cfg = { .mod_rate	= 297000000,
>  	.scaler_mask	= 0x3,
>  	.scanline_yuv	= 2048,
> +	.scanline_rgb	= 2048,
>  	.ui_num		= 1,
>  	.vi_num		= 1,
>  };
> @@ -657,6 +667,7 @@ static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg
> = { .mod_rate	= 600000000,
>  	.scaler_mask	= 0xf,
>  	.scanline_yuv	= 4096,
> +	.scanline_rgb	= 2048,
>  	.ui_num		= 3,
>  	.vi_num		= 1,
>  };
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> b/drivers/gpu/drm/sun4i/sun8i_mixer.h index 85c94884f..c01b3e9d6 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -172,6 +172,7 @@ struct sun8i_mixer_cfg {
>  	unsigned long	mod_rate;
>  	unsigned int	is_de3 : 1;
>  	unsigned int	scanline_yuv;
> +	unsigned int	scanline_rgb;

This quirk needs to be documented above in the comment.

Best regards,
Jernej

>  };
> 
>  struct sun8i_mixer {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index f7d0b082d..30e6bde92 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -188,8 +188,7 @@ static int sun8i_vi_layer_update_coord(struct
> sun8i_mixer *mixer, int channel, src_h = vn;
>  		}
> 
> -		/* it seems that every RGB scaler has buffer for 2048 
pixels */
> -		scanline = subsampled ? mixer->cfg->scanline_yuv : 
2048;
> +		scanline = subsampled ? mixer->cfg->scanline_yuv :
> mixer->cfg->scanline_rgb;
> 
>  		if (src_w > scanline) {
>  			DRM_DEBUG_DRIVER("Using horizontal coarse 
scaling\n");




