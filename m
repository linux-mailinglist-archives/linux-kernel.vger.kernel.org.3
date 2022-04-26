Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C35101ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352330AbiDZPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352336AbiDZPdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:33:13 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC341105
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:30:01 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23QFTUSp126025;
        Tue, 26 Apr 2022 10:29:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650986970;
        bh=dJ6NxkWukewDN74R+Z5GQH5zfuUg1xk50F5FGiyQ3v8=;
        h=From:To:CC:Subject:Date;
        b=m+iyUMt2/SebOOlfEb1HWWPM0XGkqe6OWPrTaXdSIGVpFe00gLz/mEFrGbaP6IPpF
         gbZTB2RriZPvzBT+wj1tbn6G1S5JhVLhkvqw51XJ5q+uElJ+KzhxMBe9QUV1LRgK0l
         fBhGOhcfID2qw/lHVUQvn1cJR7lipYemint4Pg8I=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23QFTUYR028449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Apr 2022 10:29:30 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 26
 Apr 2022 10:29:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 26 Apr 2022 10:29:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23QFTSA9074180;
        Tue, 26 Apr 2022 10:29:29 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <bjorn.andersson@linaro.org>, <arnd@arndb.de>,
        <shawnguo@kernel.org>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>
CC:     <biju.das.jz@bp.renesas.com>, <vkoul@kernel.org>,
        <enric.balletbo@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <nm@ti.com>, <vigneshr@ti.com>
Subject: [PATCH v4] arm64: defconfig: Enable configs for DisplayPort on J721e
Date:   Tue, 26 Apr 2022 20:59:26 +0530
Message-ID: <20220426152926.20953-1-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DRM and PHY configs required for supporting
DisplayPort on J721e

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---

Notes:
    v2:
        Fixed the places using savedefconfig
        Added more info in notes

    v3:
        rebased to next-20220330

    v4:
        rebased to next-20220422

    No change in vmlinux:

        add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
        Function                                     old     new   delta
        Total: Before=24042991, After=24042991, chg +0.00%

    boot logs:
        https://gist.githubusercontent.com/ravi-rahul/1bdbc3f77ab381e486c8394650c2e85d/raw/2327c9894c3236950a00f4511ae668ac4399b71e/j7_DP_upstream.log

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6906b83f5e45..4ebbab95cd61 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -742,6 +742,7 @@ CONFIG_DRM_THINE_THC63LVD1024=m
 CONFIG_DRM_TI_SN65DSI86=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_I2C_ADV7511_AUDIO=y
+CONFIG_DRM_CDNS_MHDP8546=m
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
 CONFIG_DRM_IMX_DCSS=m
@@ -756,6 +757,7 @@ CONFIG_DRM_MESON=m
 CONFIG_DRM_PL111=m
 CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
+CONFIG_DRM_TIDSS=m
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_EFI=y
@@ -1169,6 +1171,7 @@ CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_SUN4I_USB=y
+CONFIG_PHY_CADENCE_TORRENT=m
 CONFIG_PHY_CADENCE_SIERRA=m
 CONFIG_PHY_MIXEL_MIPI_DPHY=m
 CONFIG_PHY_FSL_IMX8M_PCIE=y
-- 
2.17.1

