Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2CE557C17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiFWM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiFWMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:55:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1449CA9;
        Thu, 23 Jun 2022 05:55:57 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25NCtmdR104662;
        Thu, 23 Jun 2022 07:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655988948;
        bh=4XwwzbOSUen5F3tnuKla9UlebDbQMg9n3BkwPwYF3UE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Oi9wAfYXi5D4Q/VZrNny9eyKD8kKp90Y67HTRJ9Nuq/AKY+npdXm9u2gO356pqFK9
         ot2WpYm1yyxx8rZ4uza1hIzLq969VBwccpbaBNgsHpK6ZrtgyjK/cBWruxRtOCoxLU
         D5lPCtGtIZi7Jtq+LUg8nEKHhcu7W0wShPxz54X8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25NCtm5G091482
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jun 2022 07:55:48 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Jun 2022 07:55:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Jun 2022 07:55:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25NCtak2079630;
        Thu, 23 Jun 2022 07:55:36 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <linux-phy@lists.infradead.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.yadav@ti.com>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v4 2/3] phy: cdns-dphy: Add band config for dphy tx
Date:   Thu, 23 Jun 2022 18:24:32 +0530
Message-ID: <20220623125433.18467-3-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623125433.18467-1-r-ravikumar@ti.com>
References: <20220623125433.18467-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for band ctrl config for dphy tx.

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/phy/cadence/cdns-dphy.c | 40 ++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index ba042e39cfaf..14f951013b4f 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -3,6 +3,7 @@
  * Copyright: 2017-2018 Cadence Design Systems, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -45,6 +46,10 @@
 #define DPHY_CMN_OPDIV_FROM_REG		BIT(6)
 #define DPHY_CMN_OPDIV(x)		((x) << 7)
 
+#define DPHY_BAND_CFG			DPHY_PCS(0x0)
+#define DPHY_BAND_CFG_LEFT_BAND		GENMASK(4, 0)
+#define DPHY_BAND_CFG_RIGHT_BAND	GENMASK(9, 5)
+
 #define DPHY_PSM_CFG			DPHY_PCS(0x4)
 #define DPHY_PSM_CFG_FROM_REG		BIT(0)
 #define DPHY_PSM_CLK_DIV(x)		((x) << 1)
@@ -92,6 +97,12 @@ struct cdns_dphy {
 	struct phy *phy;
 };
 
+/* Order of bands is important since the index is the band number. */
+static const unsigned int tx_bands[] = {
+	80, 100, 120, 160, 200, 240, 320, 390, 450, 510, 560, 640, 690, 770,
+	870, 950, 1000, 1200, 1400, 1600, 1800, 2000, 2200, 2500
+};
+
 static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 				     struct cdns_dphy_cfg *cfg,
 				     struct phy_configure_opts_mipi_dphy *opts,
@@ -232,6 +243,24 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 	return 0;
 }
 
+static int cdns_dphy_tx_get_band_ctrl(unsigned long hs_clk_rate)
+{
+	unsigned int rate;
+	int i;
+
+	rate = hs_clk_rate / 1000000UL;
+
+	if (rate < tx_bands[0])
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < ARRAY_SIZE(tx_bands) - 1; i++) {
+		if (rate >= tx_bands[i] && rate < tx_bands[i + 1])
+			return i;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 			      union phy_configure_opts *opts)
 {
@@ -247,7 +276,8 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
 	struct cdns_dphy_cfg cfg = { 0 };
-	int ret;
+	int ret, band_ctrl;
+	unsigned int reg;
 
 	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
 	if (ret)
@@ -276,6 +306,14 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	 */
 	cdns_dphy_set_pll_cfg(dphy, &cfg);
 
+	band_ctrl = cdns_dphy_tx_get_band_ctrl(opts->mipi_dphy.hs_clk_rate);
+	if (band_ctrl < 0)
+		return band_ctrl;
+
+	reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
+	      FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
+	writel(reg, dphy->regs + DPHY_BAND_CFG);
+
 	return 0;
 }
 
-- 
2.36.1

