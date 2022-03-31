Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16EE4EDB58
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiCaOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiCaOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:09:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FAC17FD32
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:07:23 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VE6xjq017986;
        Thu, 31 Mar 2022 09:06:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648735619;
        bh=dqvLp+9cqEcaO39ZGp5ziRMLXPWl68+X+jcE34qALT8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lOo5HfLTNxI6k3WyLjczPwDKditJH0XZ358IaEBTrbJivMMHVYCMJO3Z3zey2NWAn
         RtQCl2aknJE6Z2RChdaHnZ/u8em2/tLnShcGTKP/YehVbmlf1zXrBKr7N3SSE6cH4g
         V3jldpkekN2CKpZaLEc/abKytWIpYZXux4iT2d8k=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VE6xlB024106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 09:06:59 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 09:06:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 09:06:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VE6vGU089013;
        Thu, 31 Mar 2022 09:06:58 -0500
Date:   Thu, 31 Mar 2022 19:36:57 +0530
From:   Rahul T R <r-ravikumar@ti.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <bjorn.andersson@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <biju.das.jz@bp.renesas.com>, <vkoul@kernel.org>,
        <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <laurent.pinchart@ideasonboard.com>, <nm@ti.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable configs for DisplayPort on
 J721e
Message-ID: <20220331140656.whyyz2czowzx2cvd@uda0490373>
References: <20220223101539.4734-1-r-ravikumar@ti.com>
 <632b3099-36ff-6141-a27b-95d920588a80@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <632b3099-36ff-6141-a27b-95d920588a80@ideasonboard.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:48-20220311, Tomi Valkeinen wrote:
> On 23/02/2022 12:15, Rahul T R wrote:
> > Enable DRM and PHY configs required for supporting
> > DisplayPort on J721e
> > 
> > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > ---
> > 
> > Notes:
> >      v2:
> >      	Fixed the places using savedefconfig
> >      	Added more info in notes
> >      No change in vmlinux:
> >      	add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
> >      	Function                                     old     new   delta
> >      	Total: Before=24042991, After=24042991, chg +0.00%
> >      Diffstat of bootlogs:
> >      	after_boot.log |   46 ++++++++++++++++++++++++++--------------------
> >      	1 file changed, 26 insertions(+), 20 deletions(-)
> > 
> >   arch/arm64/configs/defconfig | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 9f23d7ec1232..56d4c126f6da 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -736,6 +736,7 @@ CONFIG_DRM_THINE_THC63LVD1024=m
> >   CONFIG_DRM_TI_SN65DSI86=m
> >   CONFIG_DRM_I2C_ADV7511=m
> >   CONFIG_DRM_I2C_ADV7511_AUDIO=y
> > +CONFIG_DRM_CDNS_MHDP8546=m
> >   CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
> >   CONFIG_DRM_DW_HDMI_CEC=m
> >   CONFIG_DRM_IMX_DCSS=m
> > @@ -750,6 +751,7 @@ CONFIG_DRM_MESON=m
> >   CONFIG_DRM_PL111=m
> >   CONFIG_DRM_LIMA=m
> >   CONFIG_DRM_PANFROST=m
> > +CONFIG_DRM_TIDSS=m
> >   CONFIG_FB=y
> >   CONFIG_FB_MODE_HELPERS=y
> >   CONFIG_FB_EFI=y
> > @@ -1151,6 +1153,7 @@ CONFIG_RESET_RZG2L_USBPHY_CTRL=y
> >   CONFIG_RESET_TI_SCI=y
> >   CONFIG_PHY_XGENE=y
> >   CONFIG_PHY_SUN4I_USB=y
> > +CONFIG_PHY_CADENCE_TORRENT=m
> >   CONFIG_PHY_MIXEL_MIPI_DPHY=m
> >   CONFIG_PHY_FSL_IMX8M_PCIE=y
> >   CONFIG_PHY_HI6220_USB=y
> > @@ -1175,6 +1178,7 @@ CONFIG_PHY_SAMSUNG_UFS=y
> >   CONFIG_PHY_UNIPHIER_USB2=y
> >   CONFIG_PHY_UNIPHIER_USB3=y
> >   CONFIG_PHY_TEGRA_XUSB=y
> > +CONFIG_PHY_J721E_WIZ=m
> >   CONFIG_ARM_SMMU_V3_PMU=m
> >   CONFIG_FSL_IMX8_DDR_PMU=m
> >   CONFIG_QCOM_L2_PMU=y
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> Not directly related to this patch, but this is slightly annoying:
> 
> cdns-mhdp8546 a000000.dp-bridge: invalid resource
> cdns-mhdp8546 a000000.dp-bridge: Failed to get SAPB memory resource, HDCP
> not supported
> 
> The first one is an error print and the second is a warning. I think a
> dev_info about HDCP not supported would be enough.
> 
>  Tomi

Thanks Tomi,

Will discuss with cdns-mhdp driver maintainer and send a patch for this issue
Also will rebase and send a respin for this patch

Regards
Rahul T R

