Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9AA4C021D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbiBVTkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbiBVTkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:40:22 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6313BA6A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:39:56 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21MJdUlD104308;
        Tue, 22 Feb 2022 13:39:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645558770;
        bh=6uwqgwJ7QdIst1Tx3LsNcMJWBVkHFMIOtlyS+eDUVns=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=FZRIwZZz5cTm7b/fXqODkSyakwJoIzqjda3MDjR2NIkYm5exAt9iQp/GlLgSG7E6S
         Bwtqe0nZTqlXHaF1w9f10fF32jSRpx7g86ziwDA9Au6LvgDluHgoZcPBZtN27ylbKY
         IrVW2nWl9S5x8Xd2+7NrCpKWigip9wYzOA2iclco=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21MJdUYh055213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 13:39:30 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 13:39:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 13:39:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21MJdUcJ093871;
        Tue, 22 Feb 2022 13:39:30 -0600
Date:   Tue, 22 Feb 2022 13:39:30 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Rahul T R <r-ravikumar@ti.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <bjorn.andersson@linaro.org>,
        <krzk@kernel.org>, <geert+renesas@glider.be>,
        <marcel.ziswiler@toradex.com>, <biju.das.jz@bp.renesas.com>,
        <vkoul@kernel.org>, <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] arm64: defconfig: Enable configs for DisplayPort on J721e
Message-ID: <20220222193930.sbc5xlsofhg3amgk@overrun>
References: <20220222180703.30401-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220222180703.30401-1-r-ravikumar@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:37-20220222, Rahul T R wrote:
> Enable DRM and PHY configs required for supporting
> DisplayPort on J721e
> 
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> ---
>  arch/arm64/configs/defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 9f23d7ec1232..b0cb894a392e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -702,6 +702,9 @@ CONFIG_DRM_EXYNOS_DSI=y
>  CONFIG_DRM_EXYNOS_HDMI=y
>  CONFIG_DRM_EXYNOS_MIC=y
>  CONFIG_DRM_ROCKCHIP=m
> +CONFIG_DRM_TIDSS=m
> +CONFIG_DRM_DISPLAY_CONNECTOR=m
> +CONFIG_DRM_CDNS_MHDP8546=m

Please use savedefconfig to place the changes in the correct location

Also indicate changes if any in vmlinux in commit message.

A bootlog indicating functionality in diffstat is also additional good
thing to do.

>  CONFIG_ROCKCHIP_ANALOGIX_DP=y
>  CONFIG_ROCKCHIP_CDN_DP=y
>  CONFIG_ROCKCHIP_DW_HDMI=y
> @@ -1175,6 +1178,8 @@ CONFIG_PHY_SAMSUNG_UFS=y
>  CONFIG_PHY_UNIPHIER_USB2=y
>  CONFIG_PHY_UNIPHIER_USB3=y
>  CONFIG_PHY_TEGRA_XUSB=y
> +CONFIG_PHY_J721E_WIZ=m
> +CONFIG_PHY_CADENCE_TORRENT=m
>  CONFIG_ARM_SMMU_V3_PMU=m
>  CONFIG_FSL_IMX8_DDR_PMU=m
>  CONFIG_QCOM_L2_PMU=y
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
