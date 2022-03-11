Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C514D5DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiCKIt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbiCKItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:49:55 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E311C574BC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:48:48 -0800 (PST)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E5862488;
        Fri, 11 Mar 2022 09:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646988526;
        bh=619hxS5eRALXNbTGrMeDNhkIZN+yytyMrHKVVWIcuf4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BRw6g9pPuq+rnp3tD1xTLWXQoIMiJPf9cpirhuw0kZX6t3hCROcydjDBbYKyF0et8
         82Ld1M0sJYaPVRHATdk5DKr7h4FT5TlGeOz8yI0fOlVpLI24307wdwxoRYMd4L/zfV
         eho/5S/Xi94Mm0ki+p3Z28bTNNorgPc62LX/d/4Q=
Message-ID: <632b3099-36ff-6141-a27b-95d920588a80@ideasonboard.com>
Date:   Fri, 11 Mar 2022 10:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] arm64: defconfig: Enable configs for DisplayPort on
 J721e
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, bjorn.andersson@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        krzk@kernel.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com
Cc:     biju.das.jz@bp.renesas.com, vkoul@kernel.org,
        enric.balletbo@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        nm@ti.com
References: <20220223101539.4734-1-r-ravikumar@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220223101539.4734-1-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2022 12:15, Rahul T R wrote:
> Enable DRM and PHY configs required for supporting
> DisplayPort on J721e
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
> 
> Notes:
>      v2:
>      	Fixed the places using savedefconfig
>      	Added more info in notes
>      
>      No change in vmlinux:
>      
>      	add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
>      	Function                                     old     new   delta
>      	Total: Before=24042991, After=24042991, chg +0.00%
>      
>      Diffstat of bootlogs:
>      
>      	after_boot.log |   46 ++++++++++++++++++++++++++--------------------
>      	1 file changed, 26 insertions(+), 20 deletions(-)
> 
>   arch/arm64/configs/defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 9f23d7ec1232..56d4c126f6da 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -736,6 +736,7 @@ CONFIG_DRM_THINE_THC63LVD1024=m
>   CONFIG_DRM_TI_SN65DSI86=m
>   CONFIG_DRM_I2C_ADV7511=m
>   CONFIG_DRM_I2C_ADV7511_AUDIO=y
> +CONFIG_DRM_CDNS_MHDP8546=m
>   CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
>   CONFIG_DRM_DW_HDMI_CEC=m
>   CONFIG_DRM_IMX_DCSS=m
> @@ -750,6 +751,7 @@ CONFIG_DRM_MESON=m
>   CONFIG_DRM_PL111=m
>   CONFIG_DRM_LIMA=m
>   CONFIG_DRM_PANFROST=m
> +CONFIG_DRM_TIDSS=m
>   CONFIG_FB=y
>   CONFIG_FB_MODE_HELPERS=y
>   CONFIG_FB_EFI=y
> @@ -1151,6 +1153,7 @@ CONFIG_RESET_RZG2L_USBPHY_CTRL=y
>   CONFIG_RESET_TI_SCI=y
>   CONFIG_PHY_XGENE=y
>   CONFIG_PHY_SUN4I_USB=y
> +CONFIG_PHY_CADENCE_TORRENT=m
>   CONFIG_PHY_MIXEL_MIPI_DPHY=m
>   CONFIG_PHY_FSL_IMX8M_PCIE=y
>   CONFIG_PHY_HI6220_USB=y
> @@ -1175,6 +1178,7 @@ CONFIG_PHY_SAMSUNG_UFS=y
>   CONFIG_PHY_UNIPHIER_USB2=y
>   CONFIG_PHY_UNIPHIER_USB3=y
>   CONFIG_PHY_TEGRA_XUSB=y
> +CONFIG_PHY_J721E_WIZ=m
>   CONFIG_ARM_SMMU_V3_PMU=m
>   CONFIG_FSL_IMX8_DDR_PMU=m
>   CONFIG_QCOM_L2_PMU=y

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Not directly related to this patch, but this is slightly annoying:

cdns-mhdp8546 a000000.dp-bridge: invalid resource
cdns-mhdp8546 a000000.dp-bridge: Failed to get SAPB memory resource, 
HDCP not supported

The first one is an error print and the second is a warning. I think a 
dev_info about HDCP not supported would be enough.

  Tomi
