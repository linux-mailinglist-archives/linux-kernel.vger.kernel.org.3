Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BB64C1001
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbiBWKQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiBWKQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:16:45 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F758B6DC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:16:16 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NAFpwu004634;
        Wed, 23 Feb 2022 04:15:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645611351;
        bh=ukWLwaLL7K6cWyANGk/b8vaKKMtL9ul3qu2qxXXL59I=;
        h=From:To:CC:Subject:Date;
        b=sGzy/BXV7DubYZyheyMTS+dEOT+K9xrCGvOo7ALpSiJRjhFNUbcwrpw5KwDhaQIxK
         cZzvx4AachD1audwVWTIsCn0I1P2y6yUVPIQoTCnM5lp0IlYow5m7mMGKj2RPAq73v
         ToD5RwVkNg5BZoX4QssRnrFUFcBFX5uXFuzYurR4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NAFp7g005166
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 04:15:51 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 04:15:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 04:15:50 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NAFnxe126829;
        Wed, 23 Feb 2022 04:15:50 -0600
From:   Rahul T R <r-ravikumar@ti.com>
To:     <bjorn.andersson@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>
CC:     <biju.das.jz@bp.renesas.com>, <vkoul@kernel.org>,
        <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <nm@ti.com>,
        <r-ravikumar@ti.com>
Subject: [PATCH v2] arm64: defconfig: Enable configs for DisplayPort on J721e
Date:   Wed, 23 Feb 2022 15:45:39 +0530
Message-ID: <20220223101539.4734-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
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

Enable DRM and PHY configs required for supporting
DisplayPort on J721e

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---

Notes:
    v2:
    	Fixed the places using savedefconfig
    	Added more info in notes
    
    No change in vmlinux:
    
    	add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
    	Function                                     old     new   delta
    	Total: Before=24042991, After=24042991, chg +0.00%
    
    Diffstat of bootlogs:
    
    	after_boot.log |   46 ++++++++++++++++++++++++++--------------------
    	1 file changed, 26 insertions(+), 20 deletions(-)

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9f23d7ec1232..56d4c126f6da 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -736,6 +736,7 @@ CONFIG_DRM_THINE_THC63LVD1024=m
 CONFIG_DRM_TI_SN65DSI86=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
+CONFIG_DRM_CDNS_MHDP8546=m
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
 CONFIG_DRM_IMX_DCSS=m
@@ -750,6 +751,7 @@ CONFIG_DRM_MESON=m
 CONFIG_DRM_PL111=m
 CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
+CONFIG_DRM_TIDSS=m
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_EFI=y
@@ -1151,6 +1153,7 @@ CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_SUN4I_USB=y
+CONFIG_PHY_CADENCE_TORRENT=m
 CONFIG_PHY_MIXEL_MIPI_DPHY=m
 CONFIG_PHY_FSL_IMX8M_PCIE=y
 CONFIG_PHY_HI6220_USB=y
@@ -1175,6 +1178,7 @@ CONFIG_PHY_SAMSUNG_UFS=y
 CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_TEGRA_XUSB=y
+CONFIG_PHY_J721E_WIZ=m
 CONFIG_ARM_SMMU_V3_PMU=m
 CONFIG_FSL_IMX8_DDR_PMU=m
 CONFIG_QCOM_L2_PMU=y
-- 
2.17.1

