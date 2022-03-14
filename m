Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE34D7D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiCNIGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237722AbiCNIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:03:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FED427D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:59:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso7696559wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=MC6HDIsM6caLoZkWRofVBLBIti9B8aptOUAXfQ9m/U4=;
        b=ZSxujdAdsFj6jAc592keazUoY8tCR3tyKlPrO1d9Xr9614sPJMihXDvqBIASV0+oB1
         sAH9WjvUsnvCRaTa2wN7LthSDB4mX8Rs8SChTwlj15ueSSct7xRE4oy7v8TShpjbuDnx
         2ZwzIg4oIk1nQm2ruxX3hM/Ce7la41Axu/mLY5SXWUw2Msl5DDaRdejWucUZEoxs2wbY
         2woJbA/SqfSP+Z/KY4q0wFadO7t5YYis8ELDSIs+bSr2+S7LCMB3uExztaeQw35ijtm8
         t5owtwNuaZ62pJJ+GcF6ppoWRYQ7Oy/R4h4Tv6dvyQVOWqbfO/BHG57hQUMl61xj7VS2
         c8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=MC6HDIsM6caLoZkWRofVBLBIti9B8aptOUAXfQ9m/U4=;
        b=LPPbEwSj8JQLU2EFb4ya8/0LFaLylHRAYDZFZUSOXkk3SFuckCjWZAR/ifEZgGANbO
         5ENqJe6K7lqgYjTvi+B7EPy+tCkdSxuJHQdvQtwUJ1jZdgE/XHmjtMkx/SWKVzZKJW4+
         Ta+i4ChtvAAMGpkTFbAzmX6w0sfhFG1TX5OA9Pkosie9SfincgqGFs3VLGJkn4mv2l/7
         LyVG0l817C5Wt2G+grZZpwMm48K1Mm3A+4Mf+gOy5QsDB7z5qw+Ekfu8Dfunb58R89Bj
         QsrMs2sCVc4UA81e/NNUBwE3rrrFq0vm9z/4Uza/oU3who5lbCKPzdr3tbB5cIlNXCyW
         Argg==
X-Gm-Message-State: AOAM532QU7GxSOfWZkyzMeceZPHx6Xs5xFITCr3d87nEbGEqYuNYixA9
        mv1yY9JCiVgzYfVejoO9Jh/kuw==
X-Google-Smtp-Source: ABdhPJzEiifCc3FGV7IxyMbRZlCmOa5yD5BOm940pyHmakvmgXmE4JGdL18CH7IYG0SmsQ6mSHuzQg==
X-Received: by 2002:a7b:cc15:0:b0:381:3fb8:5f93 with SMTP id f21-20020a7bcc15000000b003813fb85f93mr24657016wmh.106.1647244753060;
        Mon, 14 Mar 2022 00:59:13 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:67f0:57f7:2185:6d18? ([2001:861:44c0:66c0:67f0:57f7:2185:6d18])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b00389f61bce7csm14307774wmq.32.2022.03.14.00.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 00:59:12 -0700 (PDT)
Message-ID: <5ad6d9bb-c0ba-4112-b015-44f992b56d00@baylibre.com>
Date:   Mon, 14 Mar 2022 08:59:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 42/64] media: platform: rename meson/ge2d/ to
 amlogic/meson-ge2d/
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <cover.1647242578.git.mchehab@kernel.org>
 <ca17efa7ff931475071461fd046e50c300575834.1647242579.git.mchehab@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <ca17efa7ff931475071461fd046e50c300575834.1647242579.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 08:55, Mauro Carvalho Chehab wrote:
> As the end goal is to have platform drivers split by vendor,
> rename meson/ge2d/ to amlogic/meson-ge2d/.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/
> 
>   MAINTAINERS                                                     | 2 +-
>   drivers/media/platform/Kconfig                                  | 2 +-
>   drivers/media/platform/Makefile                                 | 2 +-
>   .../media/platform/{meson/ge2d => amlogic/meson-ge2d}/Kconfig   | 0
>   .../media/platform/{meson/ge2d => amlogic/meson-ge2d}/Makefile  | 0
>   .../platform/{meson/ge2d => amlogic/meson-ge2d}/ge2d-regs.h     | 0
>   .../media/platform/{meson/ge2d => amlogic/meson-ge2d}/ge2d.c    | 0
>   7 files changed, 3 insertions(+), 3 deletions(-)
>   rename drivers/media/platform/{meson/ge2d => amlogic/meson-ge2d}/Kconfig (100%)
>   rename drivers/media/platform/{meson/ge2d => amlogic/meson-ge2d}/Makefile (100%)
>   rename drivers/media/platform/{meson/ge2d => amlogic/meson-ge2d}/ge2d-regs.h (100%)
>   rename drivers/media/platform/{meson/ge2d => amlogic/meson-ge2d}/ge2d.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b83cf0eb99ce..09b0e60da4e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12523,7 +12523,7 @@ L:	linux-amlogic@lists.infradead.org
>   S:	Supported
>   T:	git git://linuxtv.org/media_tree.git
>   F:	Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
> -F:	drivers/media/platform/meson/ge2d/
> +F:	drivers/media/platform/amlogic/meson-ge2d/
>   
>   MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
>   M:	Liang Yang <liang.yang@amlogic.com>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 0a4260627a00..b4faee0a1b63 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -67,6 +67,7 @@ config VIDEO_MUX
>   
>   source "drivers/media/platform/allegro-dvt/Kconfig"
>   source "drivers/media/platform/am437x/Kconfig"
> +source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
>   source "drivers/media/platform/amphion/Kconfig"
>   source "drivers/media/platform/aspeed/Kconfig"
>   source "drivers/media/platform/atmel/Kconfig"
> @@ -77,7 +78,6 @@ source "drivers/media/platform/exynos-gsc/Kconfig"
>   source "drivers/media/platform/exynos4-is/Kconfig"
>   source "drivers/media/platform/intel/Kconfig"
>   source "drivers/media/platform/marvell/Kconfig"
> -source "drivers/media/platform/meson/ge2d/Kconfig"
>   source "drivers/media/platform/mtk-jpeg/Kconfig"
>   source "drivers/media/platform/mtk-mdp/Kconfig"
>   source "drivers/media/platform/mtk-vcodec/Kconfig"
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index 8b2deba4b62c..48531f93d92f 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -7,6 +7,7 @@
>   # (e. g. LC_ALL=C sort Makefile)
>   obj-y += allegro-dvt/
>   obj-y += am437x/
> +obj-y += amlogic/meson-ge2d/
>   obj-y += amphion/
>   obj-y += aspeed/
>   obj-y += atmel/
> @@ -17,7 +18,6 @@ obj-y += exynos-gsc/
>   obj-y += exynos4-is/
>   obj-y += intel/
>   obj-y += marvell/
> -obj-y += meson/ge2d/
>   obj-y += mtk-jpeg/
>   obj-y += mtk-mdp/
>   obj-y += mtk-vcodec/
> diff --git a/drivers/media/platform/meson/ge2d/Kconfig b/drivers/media/platform/amlogic/meson-ge2d/Kconfig
> similarity index 100%
> rename from drivers/media/platform/meson/ge2d/Kconfig
> rename to drivers/media/platform/amlogic/meson-ge2d/Kconfig
> diff --git a/drivers/media/platform/meson/ge2d/Makefile b/drivers/media/platform/amlogic/meson-ge2d/Makefile
> similarity index 100%
> rename from drivers/media/platform/meson/ge2d/Makefile
> rename to drivers/media/platform/amlogic/meson-ge2d/Makefile
> diff --git a/drivers/media/platform/meson/ge2d/ge2d-regs.h b/drivers/media/platform/amlogic/meson-ge2d/ge2d-regs.h
> similarity index 100%
> rename from drivers/media/platform/meson/ge2d/ge2d-regs.h
> rename to drivers/media/platform/amlogic/meson-ge2d/ge2d-regs.h
> diff --git a/drivers/media/platform/meson/ge2d/ge2d.c b/drivers/media/platform/amlogic/meson-ge2d/ge2d.c
> similarity index 100%
> rename from drivers/media/platform/meson/ge2d/ge2d.c
> rename to drivers/media/platform/amlogic/meson-ge2d/ge2d.c

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
