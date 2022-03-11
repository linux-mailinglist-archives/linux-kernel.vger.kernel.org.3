Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325824D6333
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiCKOOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350010AbiCKON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:13:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A74B3E;
        Fri, 11 Mar 2022 06:12:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id e6so8639201lfc.1;
        Fri, 11 Mar 2022 06:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5BeQ8REpGKhUc/KyzlD/mNmy0fZUF9zT7g+58W2w+hM=;
        b=QOWuWjeDbcl2Ha9xCgMLgPiwJDtreX3I31dka+yyLNiRBslYanYOEYm7w/AQoRUH60
         qEi8J2HRblvQblBDA+C9NS04sQ2V/0ZDVSAXg8z9novOiQ3e5lnPeZpPDC3p1xpKurTr
         C4nlfVNSRrk7Ml97QzfaCbOpN+GuG2+aga12i8crLUFWWo1kE1txRoXCVuawtqqxfyoU
         FAsWTGyECEqJWMtV/qU1XAlNhntEWi7gt+guuXQ/k00LePCNRrfJ+rRU8MQjmkAYQnmT
         7L2f6+SPv8avk7muKfZJgIr3vkzQDz//6M04x8s0f03hjYuNrA7PNfkhtFXqX2K/he88
         JvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5BeQ8REpGKhUc/KyzlD/mNmy0fZUF9zT7g+58W2w+hM=;
        b=N6j2JXaBGM3C+M+REY6wA0RhIakf/KxW1jYDRbzo3Nlb8WAvOykzIfGOj254RBQRjD
         bUc8qOidNDFq6Xo14yepWUsTxr2ipJqRliMvQdZXIC4KaVZECCSLPS+eTWxOH2nT0bDt
         LQ9RCgKqBrD1nHpQS7HQg7CBH9PbLiw3VMA13gTuWC9PNkQZ5iq6a5skn9Un4vnmfxsF
         8ek65RJEyraB2MRlFZwggsNYkCk8MdOFOo4n07ol/f8jsRg4i4DmPZlDRnjHuSvAu2S/
         dxpKHD6xc1It0lT/tIsb7TdvMuMCuLqnpqxwGkyLBzOsbY3ApFK4ZByCSE8thPcf9oX6
         R+vQ==
X-Gm-Message-State: AOAM530ApXnHvZ093I8edmky9hHAlO/E3nzoJJ6umjA0txOyFU92tR43
        gwHoSKWdazsBCxscMhoq70U=
X-Google-Smtp-Source: ABdhPJzLyHfd8RRv6o0zsJarbbvnHKj53wFQM2xPNrBt0yU3uBraXRffUaMC/y1e1l7fljVylmvzXA==
X-Received: by 2002:a05:6512:2347:b0:448:309d:2b19 with SMTP id p7-20020a056512234700b00448309d2b19mr6117881lfu.222.1647007969098;
        Fri, 11 Mar 2022 06:12:49 -0800 (PST)
Received: from [192.168.0.192] ([194.146.248.76])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05651c168500b00244b8f727dfsm1754603ljb.95.2022.03.11.06.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 06:12:48 -0800 (PST)
Message-ID: <de761fb4-3fe0-2e80-2444-0862a8864429@gmail.com>
Date:   Fri, 11 Mar 2022 15:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 36/38] media: platform: s5p-jpeg: move config to its
 own file
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <cover.1647006877.git.mchehab@kernel.org>
 <b6258d7a7522dc421837403c0904850575cc3d2e.1647006877.git.mchehab@kernel.org>
From:   Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
In-Reply-To: <b6258d7a7522dc421837403c0904850575cc3d2e.1647006877.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Thanks for taking care of that!


W dniu 11.03.2022 o 15:07, Mauro Carvalho Chehab pisze:
> In order to better organize the platform/Kconfig, place
> s5p-jpeg-specific config stuff on a separate Kconfig file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>


> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/
> 
>   drivers/media/platform/Kconfig          | 13 +------------
>   drivers/media/platform/s5p-jpeg/Kconfig | 12 ++++++++++++
>   2 files changed, 13 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/media/platform/s5p-jpeg/Kconfig
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 447fe5681307..913b48994e15 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -69,6 +69,7 @@ source "drivers/media/platform/rockchip/rkisp1/Kconfig"
>   source "drivers/media/platform/rockchip/rga/Kconfig"
>   source "drivers/media/platform/s3c-camif/Kconfig"
>   source "drivers/media/platform/s5p-g2d/Kconfig"
> +source "drivers/media/platform/s5p-jpeg/Kconfig"
>   source "drivers/media/platform/sti/hva/Kconfig"
>   source "drivers/media/platform/stm32/Kconfig"
>   source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
> @@ -111,18 +112,6 @@ config VIDEO_MEM2MEM_DEINTERLACE
>   	help
>   	    Generic deinterlacing V4L2 driver.
>   
> -
> -config VIDEO_SAMSUNG_S5P_JPEG
> -	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
> -	depends on V4L_MEM2MEM_DRIVERS
> -	depends on VIDEO_DEV && VIDEO_V4L2
> -	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> -	select VIDEOBUF2_DMA_CONTIG
> -	select V4L2_MEM2MEM_DEV
> -	help
> -	  This is a v4l2 driver for Samsung S5P, EXYNOS3250
> -	  and EXYNOS4 JPEG codec
> -
>   source "drivers/media/platform/s5p-mfc/Kconfig"
>   
>   source "drivers/media/platform/sti/bdisp/Kconfig"
> diff --git a/drivers/media/platform/s5p-jpeg/Kconfig b/drivers/media/platform/s5p-jpeg/Kconfig
> new file mode 100644
> index 000000000000..e522860d2b15
> --- /dev/null
> +++ b/drivers/media/platform/s5p-jpeg/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config VIDEO_SAMSUNG_S5P_JPEG
> +	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV && VIDEO_V4L2
> +	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	help
> +	  This is a v4l2 driver for Samsung S5P, EXYNOS3250
> +	  and EXYNOS4 JPEG codec
