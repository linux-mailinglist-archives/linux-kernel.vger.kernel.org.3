Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58E44A7D71
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348853AbiBCBgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:36:09 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:44679 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348836AbiBCBgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:36:04 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id B5DB1580154;
        Wed,  2 Feb 2022 20:36:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 02 Feb 2022 20:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=ZN3RWo26nidccjxhuUyvxHYFylz9R9
        GDaMIgACviAFU=; b=eOQ4P0Y4PnIwHCvxbyENpxB79ITtruyY94y1gdvdWkcoyZ
        F3alW/GRWVsxQbZkxYSW2AdFAE0W8Be3tZKQHJPa+1RDnzEfsB/8yfZ/dlmLwSRt
        0qs6qMHzd8dP/KyVAM6NVxmhO14FSHKwoBrnErH9KtpHed89FByUfrP2eslVbx1e
        3T10tYH9eJIOujoN5rsE2C1YLxWJXaaqFsgxGrlHKWqcDpu0Wj3xngz9neFH1bw8
        zvo3T3kLqiwvvQR8Z0MqdsU/rfw4pAxd6BG0VFk9CIrYS0FbPBF4xsO0aYP6xO7L
        kw2oCEFTe11PT1kQF0IOWJbnGw1YoEovY9C8nAmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZN3RWo
        26nidccjxhuUyvxHYFylz9R9GDaMIgACviAFU=; b=H8OipAxXvtir40yRHjpNkO
        qK7mZXCWPW7lXYJFRN7pVDT79KkEtgEu2RKX5mJCxKStg0T0dgnZGEwLcmEjHhcJ
        O0jRBtMtzxmWg2IlneooEBsojhTNCCVBy5y6Uoeq8bFxV7TWdCLUtrJB2z6sYIPa
        jhake6loqzLMgWW748NIDaCDF3IVpkb46gVO4Ze6gONBNmggtq4i5Jv6bFShAOGr
        HSpzn/GPOXegigUVp5hP9Yf97yc/rierCJrOHcehFi1M8cBfmBVOouMSMJu3J910
        Du3iWRELekCxWqNd2qKeL8Szqq1YqnbVKCYiIe2f8gTLPUubVzOm6UGmv3rsAdDA
        ==
X-ME-Sender: <xms:gzH7YcpCzfA-06oDF0n61JimMJifdvqn8C4E8RM0kl2p2TWAZp_TdQ>
    <xme:gzH7YSoIlfdueaeAjL6VikJfjgs3tl3pvD5LsTf__baT2lwt6A9c-zatb2ntF9Ryl
    slqGoy3VEhDwkp_2A>
X-ME-Received: <xmr:gzH7YROO4jmAcGpygqx8UoZjKrjA69oHZZBxyFUWz2ZuTlHRF9vOCCvdLMQCspvN5k8E-zNqqzWBcciWvdM-HJpCxREQmxZrmyVyfHjSWZuROUA174okSi4smNRDt4pf6lVDzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:gzH7YT78gul2ovcTbqIEw1b1zdozEaX9MwPC3CSER_jhab5l2uQ8mA>
    <xmx:gzH7Yb7e0KSbxMZjSGDxqIqZJAi9FeDY6CAoQgxGBiTftvzFOe3_eA>
    <xmx:gzH7YTgnHHH2rmid7HilJ4T1eXeuVCvrvpzuCyd2f4DaVSxxjvqYrw>
    <xmx:gzH7Yfh3avS64qNuQOsmpvdvNKrkkuAindgSxw6T8cT6O6j49nmVvw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 20:36:02 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/4] phy: sun4i-usb: Rework HCI PHY (aka "pmu_unk1") handling
Date:   Wed,  2 Feb 2022 19:35:56 -0600
Message-Id: <20220203013558.11490-3-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203013558.11490-1-samuel@sholland.org>
References: <20220203013558.11490-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

As Icenowy pointed out, newer manuals (starting with H6) actually
document the register block at offset 0x800 as "HCI controller and PHY
interface", also describe the bits in our "PMU_UNK1" register.
Let's put proper names to those "unknown" variables and symbols.

While we are at it, generalise the existing code by allowing a bitmap
of bits to clear and set, to cover newer SoCs: The A100 and H616 use a
different bit for the SIDDQ control.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/allwinner/phy-sun4i-usb.c | 30 ++++++++++++---------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 624950fd48ba..6675dad17415 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -43,7 +43,7 @@
 #define REG_PHYCTL_A33			0x10
 #define REG_PHY_OTGCTL			0x20
 
-#define REG_PMU_UNK1			0x10
+#define REG_HCI_PHY_CTL			0x10
 
 #define PHYCTL_DATA			BIT(7)
 
@@ -82,6 +82,7 @@
 /* A83T specific control bits for PHY0 */
 #define PHY_CTL_VBUSVLDEXT		BIT(5)
 #define PHY_CTL_SIDDQ			BIT(3)
+#define PHY_CTL_H3_SIDDQ		BIT(1)
 
 /* A83T specific control bits for PHY2 HSIC */
 #define SUNXI_EHCI_HS_FORCE		BIT(20)
@@ -115,9 +116,9 @@ struct sun4i_usb_phy_cfg {
 	int hsic_index;
 	enum sun4i_usb_phy_type type;
 	u32 disc_thresh;
+	u32 hci_phy_ctl_clear;
 	u8 phyctl_offset;
 	bool dedicated_clocks;
-	bool enable_pmu_unk1;
 	bool phy0_dual_route;
 	int missing_phys;
 };
@@ -288,6 +289,12 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		return ret;
 	}
 
+	if (phy->pmu && data->cfg->hci_phy_ctl_clear) {
+		val = readl(phy->pmu + REG_HCI_PHY_CTL);
+		val &= ~data->cfg->hci_phy_ctl_clear;
+		writel(val, phy->pmu + REG_HCI_PHY_CTL);
+	}
+
 	if (data->cfg->type == sun8i_a83t_phy ||
 	    data->cfg->type == sun50i_h6_phy) {
 		if (phy->index == 0) {
@@ -297,11 +304,6 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 			writel(val, data->base + data->cfg->phyctl_offset);
 		}
 	} else {
-		if (phy->pmu && data->cfg->enable_pmu_unk1) {
-			val = readl(phy->pmu + REG_PMU_UNK1);
-			writel(val & ~2, phy->pmu + REG_PMU_UNK1);
-		}
-
 		/* Enable USB 45 Ohm resistor calibration */
 		if (phy->index == 0)
 			sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
@@ -863,7 +865,6 @@ static const struct sun4i_usb_phy_cfg sun4i_a10_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
@@ -872,7 +873,6 @@ static const struct sun4i_usb_phy_cfg sun5i_a13_cfg = {
 	.disc_thresh = 2,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
@@ -881,7 +881,6 @@ static const struct sun4i_usb_phy_cfg sun6i_a31_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
@@ -890,7 +889,6 @@ static const struct sun4i_usb_phy_cfg sun7i_a20_cfg = {
 	.disc_thresh = 2,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = false,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
@@ -899,7 +897,6 @@ static const struct sun4i_usb_phy_cfg sun8i_a23_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A10,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
@@ -908,7 +905,6 @@ static const struct sun4i_usb_phy_cfg sun8i_a33_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = false,
 };
 
 static const struct sun4i_usb_phy_cfg sun8i_a83t_cfg = {
@@ -925,7 +921,7 @@ static const struct sun4i_usb_phy_cfg sun8i_h3_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = true,
+	.hci_phy_ctl_clear = PHY_CTL_H3_SIDDQ,
 	.phy0_dual_route = true,
 };
 
@@ -935,7 +931,7 @@ static const struct sun4i_usb_phy_cfg sun8i_r40_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = true,
+	.hci_phy_ctl_clear = PHY_CTL_H3_SIDDQ,
 	.phy0_dual_route = true,
 };
 
@@ -945,7 +941,7 @@ static const struct sun4i_usb_phy_cfg sun8i_v3s_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = true,
+	.hci_phy_ctl_clear = PHY_CTL_H3_SIDDQ,
 	.phy0_dual_route = true,
 };
 
@@ -955,7 +951,7 @@ static const struct sun4i_usb_phy_cfg sun50i_a64_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = true,
+	.hci_phy_ctl_clear = PHY_CTL_H3_SIDDQ,
 	.phy0_dual_route = true,
 };
 
-- 
2.33.1

