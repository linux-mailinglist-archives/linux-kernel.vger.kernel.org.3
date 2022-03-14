Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE7F4D7DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiCNIz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiCNIz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:55:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8AC2180A;
        Mon, 14 Mar 2022 01:54:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s29so4417542lfb.13;
        Mon, 14 Mar 2022 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NG8o060Tka0L3sIFkp3uolm5d8/wc9yzHfKOZpMlr6U=;
        b=MtVa3tYQXYf6RuRhg1nJdlMpiyhdH6usMXSTG9Ck2EZN6WaGb0CYgjQVb+UrqSEVpG
         Layl0e8k6AtU4DUtaTBTNUUpdvcVBahgxkXPRurjeoW00OmY5boGQ58RQ8drB8XDalR6
         VwgaWR94taGLDSqIM80jMfdSJ2VY9Mz8XPyMPQEjuNV6Psf2x6d4MWICM+W6rfSZlpxn
         +ire/8QFIn1zt5Xwxba81c6IenogkY4D03U4BLLhwZQRKbVCKma2eGUwxN4y0atVbb09
         KWQLtWJciH5jdZ6k8OxLBBzaP9DFfz6+VaQem/lMhSkLotRCDasZJF1HBRHGvrDNIsO2
         oyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NG8o060Tka0L3sIFkp3uolm5d8/wc9yzHfKOZpMlr6U=;
        b=HA+M0wxd8ocby5CbnpxqlKS0EHiMiA5Bz+yeWAhpT1uQEQiMG6M2xsb6eXDnj6W0pV
         VjVeZAxUOMFjFrmL85bzZvixTrIySdkKTpfj7WTJL2s7qiskRYhL4ZOMXYHj3qeb//0A
         YY1wgGl456XMi5Cus7Ktz141KeK1hYREaf/rVUjnbwe+J8QKvVbdZzBZx5XTcYZK47/p
         BsHtqoxUmil7dyrO59C1oujNUokaYJ5ApC6fivMHsE7Nc6DZznnAV02qXuLoQheaNyWt
         /qj2oB9WOMytl9Bog/tKPD/HTaaO6t735cx0QVQpCgLoLFUsD2pzZj+4GtybKewzGwYh
         MVEA==
X-Gm-Message-State: AOAM530HmEKiiRPk1PGPoZkLd21ECoflYNI2mf6litpte34FSjLwHXrz
        ih3yUKw3BsB+LWsDAjH+5pA=
X-Google-Smtp-Source: ABdhPJwL5+FzxL3+pOy50Oa5xyzBYMKk+RLCzYWZVTIm2eYjorck162HwIriR5jBgx1gP2Y0zGf5eg==
X-Received: by 2002:a05:6512:2304:b0:448:46a9:7263 with SMTP id o4-20020a056512230400b0044846a97263mr12854556lfu.309.1647248083097;
        Mon, 14 Mar 2022 01:54:43 -0700 (PDT)
Received: from [192.168.0.192] ([194.146.248.76])
        by smtp.gmail.com with ESMTPSA id bq5-20020a056512150500b004433c791651sm3155349lfb.69.2022.03.14.01.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 01:54:42 -0700 (PDT)
Message-ID: <174d7d1f-2483-04de-81be-8f63c569851a@gmail.com>
Date:   Mon, 14 Mar 2022 09:54:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 15/24] media: platform: rename s5p-jpeg/ to
 samsung/s5p-jpeg/
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
        Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <cover.1647167750.git.mchehab@kernel.org>
 <4be1962723cfc2ad1c1031c3885ea53023fae642.1647167750.git.mchehab@kernel.org>
From:   Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
In-Reply-To: <4be1962723cfc2ad1c1031c3885ea53023fae642.1647167750.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Thanks,

W dniu 13.03.2022 o 11:51, Mauro Carvalho Chehab pisze:
> As the end goal is to have platform drivers split by vendor,
> rename s5p-jpeg/ to samsung/s5p-jpeg/.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>

> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/
> 
>   MAINTAINERS                                                     | 2 +-
>   drivers/media/platform/Kconfig                                  | 2 +-
>   drivers/media/platform/Makefile                                 | 2 +-
>   drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                  | 2 +-
>   drivers/media/platform/renesas/rcar_jpu.c                       | 2 +-
>   drivers/media/platform/{ => samsung}/s5p-jpeg/Kconfig           | 0
>   drivers/media/platform/{ => samsung}/s5p-jpeg/Makefile          | 0
>   drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-core.c       | 2 +-
>   drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-core.h       | 2 +-
>   .../media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos3250.c  | 0
>   .../media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos3250.h  | 2 +-
>   drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos4.c | 0
>   drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos4.h | 0
>   drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-s5p.c     | 2 +-
>   drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-s5p.h     | 2 +-
>   drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-regs.h       | 2 +-
>   16 files changed, 11 insertions(+), 11 deletions(-)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/Kconfig (100%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/Makefile (100%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-core.c (99%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-core.h (99%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos3250.c (100%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos3250.h (97%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos4.c (100%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-exynos4.h (100%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-s5p.c (99%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-hw-s5p.h (97%)
>   rename drivers/media/platform/{ => samsung}/s5p-jpeg/jpeg-regs.h (99%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4c4be0d7ec14..dfd490369d48 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2633,7 +2633,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:	linux-media@vger.kernel.org
>   S:	Maintained
> -F:	drivers/media/platform/s5p-jpeg/
> +F:	drivers/media/platform/samsung/s5p-jpeg/
>   
>   ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
>   M:	Marek Szyprowski <m.szyprowski@samsung.com>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index f70fc95e4195..0af01626c008 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -88,12 +88,12 @@ source "drivers/media/platform/omap3isp/Kconfig"
>   source "drivers/media/platform/qcom/Kconfig"
>   source "drivers/media/platform/renesas/Kconfig"
>   source "drivers/media/platform/rockchip/Kconfig"
> -source "drivers/media/platform/s5p-jpeg/Kconfig"
>   source "drivers/media/platform/s5p-mfc/Kconfig"
>   source "drivers/media/platform/samsung/exynos-gsc/Kconfig"
>   source "drivers/media/platform/samsung/exynos4-is/Kconfig"
>   source "drivers/media/platform/samsung/s3c-camif/Kconfig"
>   source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
> +source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
>   source "drivers/media/platform/sti/Kconfig"
>   source "drivers/media/platform/stm32/Kconfig"
>   source "drivers/media/platform/ti-vpe/Kconfig"
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index a5a068e18492..94bdd5d94bb2 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -30,12 +30,12 @@ obj-y += qcom/venus/
>   obj-y += renesas/
>   obj-y += rockchip/rga/
>   obj-y += rockchip/rkisp1/
> -obj-y += s5p-jpeg/
>   obj-y += s5p-mfc/
>   obj-y += samsung/exynos-gsc/
>   obj-y += samsung/exynos4-is/
>   obj-y += samsung/s3c-camif/
>   obj-y += samsung/s5p-g2d/
> +obj-y += samsung/s5p-jpeg/
>   obj-y += sti/bdisp/
>   obj-y += sti/c8sectpfe/
>   obj-y += sti/delta/
> diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> index 3b892c5792b4..d1ec1f4b506b 100644
> --- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> +++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
> @@ -35,7 +35,7 @@
>    * it, enable dynamic debug for this module and:
>    * echo 1 > /sys/module/mxc_jpeg_encdec/parameters/jpeg_tracing
>    *
> - * This is inspired by the drivers/media/platform/s5p-jpeg driver
> + * This is inspired by the drivers/media/platform/samsung/s5p-jpeg driver
>    *
>    * Copyright 2018-2019 NXP
>    */
> diff --git a/drivers/media/platform/renesas/rcar_jpu.c b/drivers/media/platform/renesas/rcar_jpu.c
> index 56bb464629ed..293beba131e2 100644
> --- a/drivers/media/platform/renesas/rcar_jpu.c
> +++ b/drivers/media/platform/renesas/rcar_jpu.c
> @@ -4,7 +4,7 @@
>    * Copyright (C) 2014-2015 Cogent Embedded, Inc.  <source@cogentembedded.com>
>    * Copyright (C) 2014-2015 Renesas Electronics Corporation
>    *
> - * This is based on the drivers/media/platform/s5p-jpeg driver by
> + * This is based on the drivers/media/platform/samsung/s5p-jpeg driver by
>    * Andrzej Pietrasiewicz and Jacek Anaszewski.
>    * Some portions of code inspired by VSP1 driver by Laurent Pinchart.
>    *
> diff --git a/drivers/media/platform/s5p-jpeg/Kconfig b/drivers/media/platform/samsung/s5p-jpeg/Kconfig
> similarity index 100%
> rename from drivers/media/platform/s5p-jpeg/Kconfig
> rename to drivers/media/platform/samsung/s5p-jpeg/Kconfig
> diff --git a/drivers/media/platform/s5p-jpeg/Makefile b/drivers/media/platform/samsung/s5p-jpeg/Makefile
> similarity index 100%
> rename from drivers/media/platform/s5p-jpeg/Makefile
> rename to drivers/media/platform/samsung/s5p-jpeg/Makefile
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> similarity index 99%
> rename from drivers/media/platform/s5p-jpeg/jpeg-core.c
> rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> index a8d9159d5ed8..5479bc8d474d 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
> +++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> @@ -1,5 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> -/* linux/drivers/media/platform/s5p-jpeg/jpeg-core.c
> +/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
>    *
>    * Copyright (c) 2011-2014 Samsung Electronics Co., Ltd.
>    *		http://www.samsung.com
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
> similarity index 99%
> rename from drivers/media/platform/s5p-jpeg/jpeg-core.h
> rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
> index 4a5fb1b15455..5570c79f122f 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-core.h
> +++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
> @@ -1,5 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
> -/* linux/drivers/media/platform/s5p-jpeg/jpeg-core.h
> +/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.h
>    *
>    * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>    *		http://www.samsung.com
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.c
> similarity index 100%
> rename from drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.c
> rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.c
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.h
> similarity index 97%
> rename from drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.h
> rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.h
> index 68160befce39..15af928fad76 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.h
> +++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.h
> @@ -1,5 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
> -/* linux/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos3250.h
> +/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos3250.h
>    *
>    * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>    *		http://www.samsung.com
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos4.c
> similarity index 100%
> rename from drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c
> rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos4.c
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos4.h
> similarity index 100%
> rename from drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.h
> rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-exynos4.h
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.c b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c
> similarity index 99%
> rename from drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.c
> rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c
> index 491e9248286c..01b47b3df1e7 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.c
> +++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.c
> @@ -1,5 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-only
> -/* linux/drivers/media/platform/s5p-jpeg/jpeg-hw.h
> +/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw.h
>    *
>    * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>    *		http://www.samsung.com
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.h
> similarity index 97%
> rename from drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.h
> rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.h
> index 98ddf7097562..f068d52c66b7 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-hw-s5p.h
> +++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw-s5p.h
> @@ -1,5 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
> -/* linux/drivers/media/platform/s5p-jpeg/jpeg-hw.h
> +/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-hw.h
>    *
>    * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>    *		http://www.samsung.com
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-regs.h b/drivers/media/platform/samsung/s5p-jpeg/jpeg-regs.h
> similarity index 99%
> rename from drivers/media/platform/s5p-jpeg/jpeg-regs.h
> rename to drivers/media/platform/samsung/s5p-jpeg/jpeg-regs.h
> index 86f376b50581..c2298b680022 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-regs.h
> +++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-regs.h
> @@ -1,5 +1,5 @@
>   /* SPDX-License-Identifier: GPL-2.0-only */
> -/* linux/drivers/media/platform/s5p-jpeg/jpeg-regs.h
> +/* linux/drivers/media/platform/samsung/s5p-jpeg/jpeg-regs.h
>    *
>    * Register definition file for Samsung JPEG codec driver
>    *
