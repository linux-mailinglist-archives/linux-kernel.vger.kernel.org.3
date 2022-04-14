Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06735004A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiDNDZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbiDNDZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:25:27 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85B750E37
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:23:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2215F5C0595;
        Wed, 13 Apr 2022 23:23:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Apr 2022 23:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649906583; x=1649992983; bh=h6
        K0lYRCU0VpHfM5lfVwAdVPmK6VD/PuBmR2+Mxj8mU=; b=ZLmjNyaoM/AaTirGXk
        GTjzV5f0XtmBnvgYM5cB5VFMySP6qmR+v0YB9SOEZ3VwO381WqyZgxkHUKYKqRJq
        /DW+a7mhH4ZPBYcS5NGvcGuOaDUflRaAlJUoXjkNngEizV+vNWNTpipO6CvpzNCy
        cCMVmzTGPbZ1W3F1ewbvkvZW8bljingPijRmPmuqiKSUPOaJT5C76RwKsqGuHbQF
        heT022a7yvgDOyo2S9iea82p6JA+kt+GNPJquktBJ+rNaDAJ9lQKLwL+a7RSqFbh
        Z3+7xiUALBzj0n0ldvLVMUgh/ipmrXZXWv+mlVlwmDJ6s/lUIs1acke9Fx9N/Yoz
        5SOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649906583; x=1649992983; bh=h6K0lYRCU0VpHfM5lfVwAdVPmK6VD/PuBmR
        2+Mxj8mU=; b=cUMRe8qScTlSVddK1lQIOj+IgaaWe7VDQvClDey1dt1UzzzQKQG
        QcL6Ad5eBitgwOV1X76LQJ//Lrh+f4HIaRzb+yqJsGRdaSjqYBZORlKFsRrJPiBC
        7jByPa3dsPUrsu361J8d1lPbGq9T7VyNl97y2rrWwrmT/OmAlE6yyK7BpEZ8cLnK
        iZCaRqNejy53I89DIzVXYoyaOoRPIFq4ziA/XODNQ1jkdQujM/cfmPvn+czoPzwb
        dubxqdW91amAorEajrELN2i4J2nCqYVM9F+tpgdx9ZatbUkXna/cWlMlYJny0azc
        EhDBQeGXFAYu/GRYevX1ozbagDEx17JtiPQ==
X-ME-Sender: <xms:lpNXYlzm5SOjfW3NA3PvW0TDwyzXxV1QCX-GnGqyk_k7iXZO-e8HrA>
    <xme:lpNXYlTZn0J_1JXVBApJPK2X-ARBkvN51Nm_tA4jsLk7LFbcWgr8uIfDbkU-2EeK4
    ux2wRN5W24nhg7aig>
X-ME-Received: <xmr:lpNXYvVYISQMB0GkDVAEGO7BaJkFES1VA-9H2Jrbj7_0qNy2U7eJes2CzNDAqLX_gft4QRWsEXmATlz5VE3WRowCbR7LBAK6rhJqoTAjDGA93RPOWGrQXjlTF5ovonUW5XMTEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:l5NXYnhq3hQfPMRmiIBlzEAtMteT0AbA8kvdqOB_zMB6624yF3oh8w>
    <xmx:l5NXYnDpPinx6ReXYQ3CJpDZwfuQENjKdf3iCAO-GT2CMNzO3k8B8w>
    <xmx:l5NXYgKhqum43LuxRnNs8q-_FBGzl5AXSsobsdszrur7bKt-pez5nA>
    <xmx:l5NXYpBgwhYkRxFTVsJYgO2ZBdUAJsTKhL8iiRYuVJfnY0WgQ_SYFA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 23:23:02 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 2/6] phy: rockchip-inno-usb2: Do not check bvalid twice
Date:   Wed, 13 Apr 2022 22:22:53 -0500
Message-Id: <20220414032258.40984-3-samuel@sholland.org>
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

The bvalid interrupt handler already checks bvalid status. The muxed IRQ
handler just needs to call the other handler (plus any other handlers
that will be added).

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index cba5c32cbaee..29407b36f5fa 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -919,13 +919,11 @@ static irqreturn_t rockchip_usb2phy_bvalid_irq(int irq, void *data)
 
 static irqreturn_t rockchip_usb2phy_otg_mux_irq(int irq, void *data)
 {
-	struct rockchip_usb2phy_port *rport = data;
-	struct rockchip_usb2phy *rphy = dev_get_drvdata(rport->phy->dev.parent);
+	irqreturn_t ret = IRQ_NONE;
 
-	if (property_enabled(rphy->grf, &rport->port_cfg->bvalid_det_st))
-		return rockchip_usb2phy_bvalid_irq(irq, data);
-	else
-		return IRQ_NONE;
+	ret |= rockchip_usb2phy_bvalid_irq(irq, data);
+
+	return ret;
 }
 
 static irqreturn_t rockchip_usb2phy_irq(int irq, void *data)
-- 
2.35.1

