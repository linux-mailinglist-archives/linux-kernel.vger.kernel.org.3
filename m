Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFD4D7D17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiCNIGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbiCNIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:02:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C304339B90
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:58:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h15so22432793wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/5Zssy/qjVUOmPsZXKpDZoEyYQBzcz5Dm2scyxNbSsA=;
        b=n3RGtDc2CCcmEaO+ZmuOAdVGFk3zitR0zNUbdXbyUn0BHStT95/PKeqMMtVymaSvd/
         yiaogIAhl+c4P1WkXsTL0UFhQXZhr7EGQR8HgOI3jDXe3ZXTMHIXUxUXkgP5tAk0Mbkj
         kebtY+mS33Xud1OYXhlHhn6kUyGAp2PVynNhGneppc4CMlXftscaILOlvFoJE+ecG9Cz
         k5YC0UF/2ev7YNvGPDoZgOhMWOAmIpb/Pz/sCPechPg52p5uLq6cmUY1CDgenn7daE/L
         082zn8NLzg2Pacm5UPD0AB3m/uEiG09/YASrX4XcSjw7TzBCCuPkXwFpx+tsofMluZqe
         vECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/5Zssy/qjVUOmPsZXKpDZoEyYQBzcz5Dm2scyxNbSsA=;
        b=hkOjnpsSGwgE5RYCRAWjNDKjvaClTRG7civ0EsIDNdx0OD63ZRlsd2UWp4nilnwCX3
         dHPRT5x/0VIrdXeEm5V3egOq51J94/s9qjtoh9CvspH4as7RxsRhP9P9pxnvY2phF5ij
         GKur9waOWtT454ZkgyIg6bPMk14bKU6b34Xo4VkhAropZjOmfAn3H8vdhU5MpE54WcZE
         1XGPqwaAtsyTwA97YxnQOgRWAI5Y/RJak1INQC+iqAMdCrmdBXgIWqFEFbZHgJd/pVLq
         m86bVwOiOGa5d9hckeJn1dinYKObK0eNy3wkFhtaerle6WxUhwbL2n0NymmLoAr+zdVv
         RI2A==
X-Gm-Message-State: AOAM531j3ESnapLLDsSyKNss3WjDwsmMdDQxh1Xi9H66FVJiVGb/HVIF
        aRLVH7dePDAb5oxOGw3VFVki1Q==
X-Google-Smtp-Source: ABdhPJw1z7cYzXUMIL5+a9eG7REnc743MAoQ09qp8cu1JHEUssDSrlUz7mcW02Gv4wBksBmSahqjeA==
X-Received: by 2002:a5d:64e5:0:b0:1f1:fa31:e7d3 with SMTP id g5-20020a5d64e5000000b001f1fa31e7d3mr16190255wri.573.1647244720101;
        Mon, 14 Mar 2022 00:58:40 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:67f0:57f7:2185:6d18? ([2001:861:44c0:66c0:67f0:57f7:2185:6d18])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm12670304wrv.79.2022.03.14.00.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 00:58:39 -0700 (PDT)
Message-ID: <01247ed7-16ef-e4bc-8745-a8fc5bfa1818@baylibre.com>
Date:   Mon, 14 Mar 2022 08:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 15/64] media: platform: ge2d: move config to its own file
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <cover.1647242578.git.mchehab@kernel.org>
 <fe12b0fc0692a8d31b7461d57ca8874eeeb7e45a.1647242579.git.mchehab@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <fe12b0fc0692a8d31b7461d57ca8874eeeb7e45a.1647242579.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 08:55, Mauro Carvalho Chehab wrote:
> In order to better organize the platform/Kconfig, place
> ge2d-specific config stuff on a separate Kconfig file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/
> 
>   drivers/media/platform/Kconfig            | 15 +--------------
>   drivers/media/platform/meson/ge2d/Kconfig | 14 ++++++++++++++
>   2 files changed, 15 insertions(+), 14 deletions(-)
>   create mode 100644 drivers/media/platform/meson/ge2d/Kconfig
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 57ca2426a83b..d3b7bef19237 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -47,6 +47,7 @@ source "drivers/media/platform/coda/Kconfig"
>   source "drivers/media/platform/davinci/Kconfig"
>   
>   source "drivers/media/platform/exynos-gsc/Kconfig"
> +source "drivers/media/platform/meson/ge2d/Kconfig"
>   source "drivers/media/platform/omap/Kconfig"
>   
>   source "drivers/media/platform/aspeed/Kconfig"
> @@ -273,20 +274,6 @@ config VIDEO_MEM2MEM_DEINTERLACE
>   	help
>   	    Generic deinterlacing V4L2 driver.
>   
> -config VIDEO_MESON_GE2D
> -	tristate "Amlogic 2D Graphic Acceleration Unit"
> -	depends on V4L_MEM2MEM_DRIVERS
> -	depends on VIDEO_DEV && VIDEO_V4L2
> -	depends on ARCH_MESON || COMPILE_TEST
> -	select VIDEOBUF2_DMA_CONTIG
> -	select V4L2_MEM2MEM_DEV
> -	help
> -	  This is a v4l2 driver for Amlogic GE2D 2D graphics accelerator.
> -	  GE2D is a standalone 2D graphic acceleration unit, with color converter,
> -	  image scaling, BitBLT & alpha blending operations.
> -
> -	  To compile this driver as a module choose m here.
> -
>   config VIDEO_SAMSUNG_S5P_G2D
>   	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
>   	depends on V4L_MEM2MEM_DRIVERS
> diff --git a/drivers/media/platform/meson/ge2d/Kconfig b/drivers/media/platform/meson/ge2d/Kconfig
> new file mode 100644
> index 000000000000..8c3f3b1b6b05
> --- /dev/null
> +++ b/drivers/media/platform/meson/ge2d/Kconfig
> @@ -0,0 +1,14 @@
> +config VIDEO_MESON_GE2D
> +	tristate "Amlogic 2D Graphic Acceleration Unit"
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV && VIDEO_V4L2
> +	depends on ARCH_MESON || COMPILE_TEST
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	help
> +	  This is a v4l2 driver for Amlogic GE2D 2D graphics accelerator.
> +	  GE2D is a standalone 2D graphic acceleration unit, with color converter,
> +	  image scaling, BitBLT & alpha blending operations.
> +
> +	  To compile this driver as a module choose m here.
> +

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
