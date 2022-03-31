Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865234EDB80
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiCaONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiCaONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:13:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD9F214043
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:11:52 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VEBVBK020022;
        Thu, 31 Mar 2022 09:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648735891;
        bh=ZDdSKsPCwWPCWqcIz0i8RFY6FrZTU5tHLq0iTroiyhg=;
        h=From:To:CC:Subject:Date;
        b=bGqElQVSJtbwIzkzitM96B3StQlVSVMx2R+YBnvUzw2Wy2qwzXQGiaWF4oCeKHxIt
         cz1VTA659gAR3+mns/hIs7xBYkGsFtNftmrRjCdSAAb3g85SGgS/+i2L5w22oWvIRA
         afmcDPyKeoYRjc38fuXwfkLufnARhVrSoT1MU1WI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VEBV61004507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 09:11:31 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 09:11:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 09:11:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VEBTru097691;
        Thu, 31 Mar 2022 09:11:30 -0500
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
Subject: [PATCH v3] arm64: defconfig: Enable configs for DisplayPort on J721e
Date:   Thu, 31 Mar 2022 19:41:13 +0530
Message-ID: <20220331141113.15747-1-r-ravikumar@ti.com>
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
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---

Notes:
    v2:
        Fixed the places using savedefconfig
        Added more info in notes

    v3:
        rebased to next-20220330

    No change in vmlinux:

        add/remove: 0/0 grow/shrink: 0/0 up/down: 0/0 (0)
        Function                                     old     new   delta
        Total: Before=24042991, After=24042991, chg +0.00%

    boot logs:
        https://gist.githubusercontent.com/ravi-rahul/1bdbc3f77ab381e486c8394650c2e85d/raw/f04584c30181821c4ee83aee7781a9ba143cd3f3/j7_DP_upstream.log

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 813e644b6af1..b5f9fbb054fa 100644
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
@@ -1162,6 +1164,7 @@ CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_SUN4I_USB=y
+CONFIG_PHY_CADENCE_TORRENT=m
 CONFIG_PHY_CADENCE_SIERRA=m
 CONFIG_PHY_MIXEL_MIPI_DPHY=m
 CONFIG_PHY_FSL_IMX8M_PCIE=y
-- 
2.17.1

