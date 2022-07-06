Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039C1568123
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiGFIWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiGFIWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:22:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE41323BF9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:22:19 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id i17so12721732ljj.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r1nRSrhgVEGC+tujKgOIQQSnhnEjEybxPP/bQgL+NR4=;
        b=vZGa8D1Zb+8Wrjfg6pTFI6T47TTh34O7Toga9RzNOgecjJ38bW1eL6EFFrOcpOOEAw
         Fc0UHsTnvQKn7J+JGweh1tHQ6+wtJdEsBxCmT2bqBL6bsofW0dSOLOaOx081e/c3kxYN
         8h+EiV/Tf2S4YlNtm7GudlsXZCzsH44CywidkiVqYnBu5naEbtCcMSg67yj6D/nmMj81
         4tgO9G/6KhMijKt+2w/Y8XRRfMSq6GRZ+FRHUCnDZ5tCcu/0S/LMCGGIxAbeRzUfFS1H
         GWHXrCZHJUIuGyv4YOPb31U+bPE1v8LTO07r/CFqD1AEYD76jEFE4RPU6C15SlMevO5c
         yCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r1nRSrhgVEGC+tujKgOIQQSnhnEjEybxPP/bQgL+NR4=;
        b=1QBmS+7ZZzi1qP9vh2ECJdw3/y/y8ruTJpQlh92H5ywvpgaJ14vHshUQuAOF5pQTE7
         FYkVGVfzLFzx+7ZXOJsx7svePqi+atxNvyE0Pxpgl+Act9MNjP9W6MtXRueIoLA+qcn/
         Cbjtiz0l1neniAdl0d8ktROCZo42m6udQ/QTeR/vhUlD1pzKrrgK3+so3aYdScjalVCa
         30DwkrhxCcdIl+GrhILqlZChEtiXSAJ69Hoqe4fw6fhreUEOc1jYEaIIfbOZZH+/wm2H
         QW46fGXu1VirwfKCG2NPiXo38LIMRuYhfjs/szILL19ADvpGwlqofOqDk9F3VlrRms41
         GkQQ==
X-Gm-Message-State: AJIora+nZ+JVE/e5GAJMZ4fmMOuxK8Kr8xvZgciXin9q6LHYENhKCVaq
        jTQgEbnng9HbI/3UzF2hbSyI8g==
X-Google-Smtp-Source: AGRyM1t1ai97XBNL8Q6CGrzJXHVah3UzeipWuCyDo3L7D5lDdNewkmhITE93meiF6f+D/ylvLoYrEg==
X-Received: by 2002:a2e:a36a:0:b0:25a:8d16:9ea7 with SMTP id i10-20020a2ea36a000000b0025a8d169ea7mr23175524ljn.293.1657095738155;
        Wed, 06 Jul 2022 01:22:18 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id o18-20020ac24bd2000000b004811dae391fsm4683138lfq.48.2022.07.06.01.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:22:17 -0700 (PDT)
Message-ID: <c51383ba-1266-b006-201f-562d836e2a5d@linaro.org>
Date:   Wed, 6 Jul 2022 10:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/5] drm/bridge: cdns-dsi: Move to drm/bridge/cadence
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        tomi.valkeinen@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        sjakhade@cadence.com, mparab@cadence.com, a-bhatia1@ti.com,
        devicetree@vger.kernel.org, vigneshr@ti.com, lee.jones@linaro.org
References: <20220705121116.24121-1-r-ravikumar@ti.com>
 <20220705121116.24121-4-r-ravikumar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705121116.24121-4-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 14:11, Rahul T R wrote:
> Move the cadence dsi bridge under drm/bridge/cadence
> directory, to prepare for adding j721e wrapper
> support
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig                       | 11 -----------
>  drivers/gpu/drm/bridge/Makefile                      |  1 -
>  drivers/gpu/drm/bridge/cadence/Kconfig               | 12 ++++++++++++
>  drivers/gpu/drm/bridge/cadence/Makefile              |  2 ++
>  .../bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c}   |  0
>  5 files changed, 14 insertions(+), 12 deletions(-)
>  rename drivers/gpu/drm/bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c} (100%)
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 57946d80b02d..8b2226f72b24 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -15,17 +15,6 @@ config DRM_PANEL_BRIDGE
>  menu "Display Interface Bridges"
>  	depends on DRM && DRM_BRIDGE
>  
> -config DRM_CDNS_DSI
> -	tristate "Cadence DPI/DSI bridge"
> -	select DRM_KMS_HELPER
> -	select DRM_MIPI_DSI
> -	select DRM_PANEL_BRIDGE
> -	select GENERIC_PHY_MIPI_DPHY
> -	depends on OF
> -	help
> -	  Support Cadence DPI to DSI bridge. This is an internal
> -	  bridge and is meant to be directly embedded in a SoC.
> -
>  config DRM_CHIPONE_ICN6211
>  	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 1884803c6860..52f6e8b4a821 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
>  obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
>  obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
>  obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
> diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
> index 1d06182bea71..e4d3415df2a0 100644
> --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> @@ -25,3 +25,15 @@ config DRM_CDNS_MHDP8546_J721E
>  	  initializes the J721E Display Port and sets up the
>  	  clock and data muxes.
>  endif
> +
> +config DRM_CDNS_DSI
> +	tristate "Cadence DPI/DSI bridge"
> +	select DRM_KMS_HELPER
> +	select DRM_MIPI_DSI
> +	select DRM_PANEL_BRIDGE
> +	select GENERIC_PHY_MIPI_DPHY
> +	depends on OF
> +	help
> +	  Support Cadence DPI to DSI bridge. This is an internal
> +	  bridge and is meant to be directly embedded in a SoC.
> +

You have a white-space error here.


Best regards,
Krzysztof
