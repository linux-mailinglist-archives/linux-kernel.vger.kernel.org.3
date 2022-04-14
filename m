Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7535004A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiDND0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbiDNDZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:25:33 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9265E51300
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:23:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 03AA25C059F;
        Wed, 13 Apr 2022 23:23:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 13 Apr 2022 23:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649906588; x=1649992988; bh=oy
        Y0y0iDKvCprqGB7cUA56JPXS9meVq9Antz5/VLmEw=; b=PRhsrHf/KKEKGfwAht
        KhgQ62OpuPa9RENHhU+1ijtCcXsxDczA1T9Y7AYDuYJkUlmB7U4pe2u4ZZV67/CJ
        mr1yJAX+ufJHsQz5PIffjK5TA8YTe3cFrhoVKvZ3AePeVMQg43YKZ5UAePXZ28HL
        l78iVcz9pgKTLfi7157z3qYvqcKgrQrnsiYK3seJ2gb1UhaQVV6pIulLT5Um+QPA
        MD9KLET5FVsuFX5n9k9cIJ72gYCrpXmsM1747/jd9sII9X/zLMpWnoxPCqpCb/0Y
        RsbZH5li0tZXot6hOOkn/w5qZz94qsGh02lPxHSK5J6FTOH+WO2boFEUi5sy1fWV
        NWPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649906588; x=1649992988; bh=oyY0y0iDKvCprqGB7cUA56JPXS9meVq9Ant
        z5/VLmEw=; b=VsMYKYmnJF7QxbhfMPpV73nRpY0JNdWHQuM5dOm9hb1KcG30o5G
        ixXIpEs8qvHj0GHfUfFHNg3ImPSBeYW8i7TZB8fqw+lbpITjl23rmPPEG1z+yLt8
        YEn8W7bAtznCxHUN4o7lCebH78anbIwsoRGNl0rX1Lyss4VHgnZpb97g1ZlmUa9U
        3giTMXsZ2S8CjX9zZB1BrqfakqiziEYgDc69ziQ5QWdE2YSnyg9gAIxkKjCzczMv
        Abnq+JyTrvxoYjPdOsPCLagLtGCKLGlI48VaZoOy2CCbOxY808HFViZjbmFDwxsH
        bFauG+fY/6gab7Nm50gXTVhDdSHkbZ2WNow==
X-ME-Sender: <xms:nJNXYl8m9cUrclXwsEPpP5U2to0lBJODMhxzoZBZXK-4JdqHcGwCuA>
    <xme:nJNXYpvMZJPKiVaV19rF0f0TAPtt-bJlAUB6AKLD2AbOeK76xQHfKmYRo5qQts8DF
    TOfbqPvs1aiPOMz3Q>
X-ME-Received: <xmr:nJNXYjC4AlLKaPmSCJ8D6U1wFzm0Nwz4d4kIngF0JM0IwmBG30nhuGSys6MjIX4IOTAXbw3pOTCJ3nwbj7Vz5KcUIdbVHoY_ml6slelqhqG0lv6Lp4E_VVXrg6DVBrLcZdncbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:nJNXYpf4xg3xT8QbOYXRz0BhAvxTW_1VFuFTOwnMqM-cLU-EKkS2MA>
    <xmx:nJNXYqNGh_rTIA_zb9QQmbWgENj8Q50ruDYj3rZo5BK0exTscn0NTA>
    <xmx:nJNXYrkhOi5RNoipLIJK8dpPxssxI2tYkBi9T7SRhgoCQLDNlv--ig>
    <xmx:nJNXYpez1v4YJubj6ZeowsZdGmi03Kkt3PgtefsAwxmFSlUTZ4b4KA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 23:23:08 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 6/6] phy: rockchip-inno-usb2: Handle ID IRQ
Date:   Wed, 13 Apr 2022 22:22:57 -0500
Message-Id: <20220414032258.40984-7-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414032258.40984-1-samuel@sholland.org>
References: <20220414032258.40984-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports detecting host mode for the OTG port without an extcon.

The rv1108 properties are not updated due to lack of documentation.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 2b29f5dd8873..e377b958d9b6 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -116,11 +116,15 @@ struct rockchip_chg_det_reg {
  * @bvalid_det_en: vbus valid rise detection enable register.
  * @bvalid_det_st: vbus valid rise detection status register.
  * @bvalid_det_clr: vbus valid rise detection clear register.
+ * @id_det_en: id detection enable register.
+ * @id_det_st: id detection state register.
+ * @id_det_clr: id detection clear register.
  * @ls_det_en: linestate detection enable register.
  * @ls_det_st: linestate detection state register.
  * @ls_det_clr: linestate detection clear register.
  * @utmi_avalid: utmi vbus avalid status register.
  * @utmi_bvalid: utmi vbus bvalid status register.
+ * @utmi_id: utmi id state register.
  * @utmi_ls: utmi linestate state register.
  * @utmi_hstdet: utmi host disconnect register.
  */
@@ -129,11 +133,15 @@ struct rockchip_usb2phy_port_cfg {
 	struct usb2phy_reg	bvalid_det_en;
 	struct usb2phy_reg	bvalid_det_st;
 	struct usb2phy_reg	bvalid_det_clr;
+	struct usb2phy_reg	id_det_en;
+	struct usb2phy_reg	id_det_st;
+	struct usb2phy_reg	id_det_clr;
 	struct usb2phy_reg	ls_det_en;
 	struct usb2phy_reg	ls_det_st;
 	struct usb2phy_reg	ls_det_clr;
 	struct usb2phy_reg	utmi_avalid;
 	struct usb2phy_reg	utmi_bvalid;
+	struct usb2phy_reg	utmi_id;
 	struct usb2phy_reg	utmi_ls;
 	struct usb2phy_reg	utmi_hstdet;
 };
@@ -161,6 +169,7 @@ struct rockchip_usb2phy_cfg {
  * @suspended: phy suspended flag.
  * @vbus_attached: otg device vbus status.
  * @bvalid_irq: IRQ number assigned for vbus valid rise detection.
+ * @id_irq: IRQ number assigned for ID pin detection.
  * @ls_irq: IRQ number assigned for linestate detection.
  * @otg_mux_irq: IRQ number which multiplex otg-id/otg-bvalid/linestate
  *		 irqs to one irq in otg-port.
@@ -179,6 +188,7 @@ struct rockchip_usb2phy_port {
 	bool		suspended;
 	bool		vbus_attached;
 	int		bvalid_irq;
+	int		id_irq;
 	int		ls_irq;
 	int		otg_mux_irq;
 	struct mutex	mutex;
@@ -419,6 +429,19 @@ static int rockchip_usb2phy_init(struct phy *phy)
 			if (ret)
 				goto out;
 
+			/* clear id status and enable id detect irq */
+			ret = property_enable(rphy->grf,
+					      &rport->port_cfg->id_det_clr,
+					      true);
+			if (ret)
+				goto out;
+
+			ret = property_enable(rphy->grf,
+					      &rport->port_cfg->id_det_en,
+					      true);
+			if (ret)
+				goto out;
+
 			schedule_delayed_work(&rport->otg_sm_work,
 					      OTG_SCHEDULE_DELAY * 3);
 		} else {
@@ -913,11 +936,30 @@ static irqreturn_t rockchip_usb2phy_bvalid_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t rockchip_usb2phy_id_irq(int irq, void *data)
+{
+	struct rockchip_usb2phy_port *rport = data;
+	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
+	bool id;
+
+	if (!property_enabled(rphy->grf, &rport->port_cfg->id_det_st))
+		return IRQ_NONE;
+
+	/* clear id detect irq pending status */
+	property_enable(rphy->grf, &rport->port_cfg->id_det_clr, true);
+
+	id = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
+	extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !id);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t rockchip_usb2phy_otg_mux_irq(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
 
 	ret |= rockchip_usb2phy_bvalid_irq(irq, data);
+	ret |= rockchip_usb2phy_id_irq(irq, data);
 
 	return ret;
 }
@@ -1015,6 +1057,25 @@ static int rockchip_usb2phy_port_irq_init(struct rockchip_usb2phy *rphy,
 					"failed to request otg-bvalid irq handle\n");
 				return ret;
 			}
+
+			rport->id_irq = of_irq_get_byname(child_np, "otg-id");
+			if (rport->id_irq < 0) {
+				dev_err(rphy->dev, "no otg-id irq provided\n");
+				ret = rport->id_irq;
+				return ret;
+			}
+
+			ret = devm_request_threaded_irq(rphy->dev, rport->id_irq,
+							NULL,
+							rockchip_usb2phy_id_irq,
+							IRQF_ONESHOT,
+							"rockchip_usb2phy_id",
+							rport);
+			if (ret) {
+				dev_err(rphy->dev,
+					"failed to request otg-id irq handle\n");
+				return ret;
+			}
 		}
 		break;
 	default:
@@ -1289,10 +1350,14 @@ static const struct rockchip_usb2phy_cfg rk3228_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x0680, 3, 3, 0, 1 },
 				.bvalid_det_st	= { 0x0690, 3, 3, 0, 1 },
 				.bvalid_det_clr	= { 0x06a0, 3, 3, 0, 1 },
+				.id_det_en	= { 0x0680, 6, 5, 0, 3 },
+				.id_det_st	= { 0x0690, 6, 5, 0, 3 },
+				.id_det_clr	= { 0x06a0, 6, 5, 0, 3 },
 				.ls_det_en	= { 0x0680, 2, 2, 0, 1 },
 				.ls_det_st	= { 0x0690, 2, 2, 0, 1 },
 				.ls_det_clr	= { 0x06a0, 2, 2, 0, 1 },
 				.utmi_bvalid	= { 0x0480, 4, 4, 0, 1 },
+				.utmi_id	= { 0x0480, 1, 1, 0, 1 },
 				.utmi_ls	= { 0x0480, 3, 2, 0, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
@@ -1348,11 +1413,15 @@ static const struct rockchip_usb2phy_cfg rk3308_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x3020, 3, 2, 0, 3 },
 				.bvalid_det_st	= { 0x3024, 3, 2, 0, 3 },
 				.bvalid_det_clr = { 0x3028, 3, 2, 0, 3 },
+				.id_det_en	= { 0x3020, 5, 4, 0, 3 },
+				.id_det_st	= { 0x3024, 5, 4, 0, 3 },
+				.id_det_clr	= { 0x3028, 5, 4, 0, 3 },
 				.ls_det_en	= { 0x3020, 0, 0, 0, 1 },
 				.ls_det_st	= { 0x3024, 0, 0, 0, 1 },
 				.ls_det_clr	= { 0x3028, 0, 0, 0, 1 },
 				.utmi_avalid	= { 0x0120, 10, 10, 0, 1 },
 				.utmi_bvalid	= { 0x0120, 9, 9, 0, 1 },
+				.utmi_id	= { 0x0120, 6, 6, 0, 1 },
 				.utmi_ls	= { 0x0120, 5, 4, 0, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
@@ -1391,11 +1460,15 @@ static const struct rockchip_usb2phy_cfg rk3328_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x0110, 3, 2, 0, 3 },
 				.bvalid_det_st	= { 0x0114, 3, 2, 0, 3 },
 				.bvalid_det_clr = { 0x0118, 3, 2, 0, 3 },
+				.id_det_en	= { 0x0110, 5, 4, 0, 3 },
+				.id_det_st	= { 0x0114, 5, 4, 0, 3 },
+				.id_det_clr	= { 0x0118, 5, 4, 0, 3 },
 				.ls_det_en	= { 0x0110, 0, 0, 0, 1 },
 				.ls_det_st	= { 0x0114, 0, 0, 0, 1 },
 				.ls_det_clr	= { 0x0118, 0, 0, 0, 1 },
 				.utmi_avalid	= { 0x0120, 10, 10, 0, 1 },
 				.utmi_bvalid	= { 0x0120, 9, 9, 0, 1 },
+				.utmi_id	= { 0x0120, 6, 6, 0, 1 },
 				.utmi_ls	= { 0x0120, 5, 4, 0, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
@@ -1453,8 +1526,12 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 				.bvalid_det_en	= { 0xe3c0, 3, 3, 0, 1 },
 				.bvalid_det_st	= { 0xe3e0, 3, 3, 0, 1 },
 				.bvalid_det_clr	= { 0xe3d0, 3, 3, 0, 1 },
+				.id_det_en	= { 0xe3c0, 5, 4, 0, 3 },
+				.id_det_st	= { 0xe3e0, 5, 4, 0, 3 },
+				.id_det_clr	= { 0xe3d0, 5, 4, 0, 3 },
 				.utmi_avalid	= { 0xe2ac, 7, 7, 0, 1 },
 				.utmi_bvalid	= { 0xe2ac, 12, 12, 0, 1 },
+				.utmi_id	= { 0xe2ac, 8, 8, 0, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
 				.phy_sus	= { 0xe458, 1, 0, 0x2, 0x1 },
@@ -1488,8 +1565,12 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
 				.bvalid_det_en  = { 0xe3c0, 8, 8, 0, 1 },
 				.bvalid_det_st  = { 0xe3e0, 8, 8, 0, 1 },
 				.bvalid_det_clr = { 0xe3d0, 8, 8, 0, 1 },
+				.id_det_en	= { 0xe3c0, 10, 9, 0, 3 },
+				.id_det_st	= { 0xe3e0, 10, 9, 0, 3 },
+				.id_det_clr	= { 0xe3d0, 10, 9, 0, 3 },
 				.utmi_avalid	= { 0xe2ac, 10, 10, 0, 1 },
 				.utmi_bvalid    = { 0xe2ac, 16, 16, 0, 1 },
+				.utmi_id	= { 0xe2ac, 11, 11, 0, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
 				.phy_sus	= { 0xe468, 1, 0, 0x2, 0x1 },
@@ -1515,8 +1596,12 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 				.bvalid_det_en	= { 0x0080, 3, 2, 0, 3 },
 				.bvalid_det_st	= { 0x0084, 3, 2, 0, 3 },
 				.bvalid_det_clr = { 0x0088, 3, 2, 0, 3 },
+				.id_det_en	= { 0x0080, 5, 4, 0, 3 },
+				.id_det_st	= { 0x0084, 5, 4, 0, 3 },
+				.id_det_clr	= { 0x0088, 5, 4, 0, 3 },
 				.utmi_avalid	= { 0x00c0, 10, 10, 0, 1 },
 				.utmi_bvalid	= { 0x00c0, 9, 9, 0, 1 },
+				.utmi_id	= { 0x00c0, 6, 6, 0, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
 				/* Select suspend control from controller */
-- 
2.35.1

