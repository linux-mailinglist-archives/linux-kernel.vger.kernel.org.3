Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5DD5543F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354777AbiFVHyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354154AbiFVHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:54:00 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761302E9DE;
        Wed, 22 Jun 2022 00:53:56 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25M7rna4127217;
        Wed, 22 Jun 2022 02:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655884429;
        bh=4mPwJ22Tk+ewkjlniyDSgNEwXTPWe2vaG6Vt0ZFpcvg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g7siXyT9K4hUCjsgjLDXvW8CFmCo8Ed7gU4JaEGnf3dBBJjmDvEEMSYld/agEtY95
         PtJwzAYvEwSlRlZPyXpM6lr8zg+LzJv8HoYvwyhZ3CSw36wLk7ZAXjqBMhY6LtAvJy
         Sd9Snr9USmMCJWu5CsVxXgjog0diBXziekj4ePNI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25M7rnb3117743
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jun 2022 02:53:49 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Jun 2022 02:53:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Jun 2022 02:53:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25M7rlwi022313;
        Wed, 22 Jun 2022 02:53:48 -0500
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
Subject: [PATCH v2 2/3] phy: cdns-dphy: Add band config for dphy tx
Date:   Wed, 22 Jun 2022 13:23:39 +0530
Message-ID: <20220622075340.16915-3-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622075340.16915-1-r-ravikumar@ti.com>
References: <20220622075340.16915-1-r-ravikumar@ti.com>
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
---
 drivers/phy/cadence/cdns-dphy.c | 52 ++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index ba042e39cfaf..ddfa524d8ce7 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/module.h>
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
@@ -92,6 +97,22 @@ struct cdns_dphy {
 	struct phy *phy;
 };
 
+struct cdns_dphy_band {
+	unsigned int min_rate;
+	unsigned int max_rate;
+};
+
+/* Order of bands is important since the index is the band number. */
+static struct cdns_dphy_band tx_bands[] = {
+	{80, 100}, {100, 120}, {120, 160}, {160, 200}, {200, 240},
+	{240, 320}, {320, 390}, {390, 450}, {450, 510}, {510, 560},
+	{560, 640}, {640, 690}, {690, 770}, {770, 870}, {870, 950},
+	{950, 1000}, {1000, 1200}, {1200, 1400}, {1400, 1600}, {1600, 1800},
+	{1800, 2000}, {2000, 2200}, {2200, 2500}
+};
+
+static int num_tx_bands = ARRAY_SIZE(tx_bands);
+
 static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 				     struct cdns_dphy_cfg *cfg,
 				     struct phy_configure_opts_mipi_dphy *opts,
@@ -232,6 +253,26 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 	return 0;
 }
 
+static int cdns_dphy_tx_get_band_ctrl(unsigned long hs_clk_rate)
+{
+	unsigned int rate;
+	int i;
+
+	rate = hs_clk_rate / 1000000UL;
+
+	if (rate < tx_bands[0].min_rate || rate >= tx_bands[num_tx_bands - 1].max_rate)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < num_tx_bands; i++) {
+		if (rate >= tx_bands[i].min_rate && rate < tx_bands[i].max_rate)
+			return i;
+	}
+
+	/* Unreachable. */
+	WARN(1, "Reached unreachable code.");
+	return -EINVAL;
+}
+
 static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 			      union phy_configure_opts *opts)
 {
@@ -247,7 +288,8 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
 	struct cdns_dphy_cfg cfg = { 0 };
-	int ret;
+	int ret, band_ctrl;
+	unsigned int reg;
 
 	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
 	if (ret)
@@ -276,6 +318,14 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
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

