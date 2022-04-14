Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B165750049A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239711AbiDNDZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDNDZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:25:27 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF8241611
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:23:02 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AEDEF5C0593;
        Wed, 13 Apr 2022 23:23:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Apr 2022 23:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649906581; x=1649992981; bh=ch
        oSBkcVUXVApD971k8AjvM5Di3IKxbalXzWvZFEOsQ=; b=NErAcTQAq1I4MEV3Md
        WOIhg8i8iNaeIJp4L23O7hjX0YoIFdqmi4UaEZXzlBsgUrQhd5Mi4CWTxszNQ7fy
        tg3LOmNdLu47VJsAJRg6KPBFnvSNn73ikGgWaadAg8yQmtWk5tVOQettPc4gbvl4
        o/RhL8NorcTeVFQoXTc3Xct9XnMRMJYhOWSkzo7evemRicfG2KW+yWOc3CLX2j3m
        ZOWxqztiDq+MfcM2TPmOXBYmqvLrjraUWTL8amAVUaGN+Sqe5aHqN+BtvgbHwz8Y
        2eJYk8dqjWuzd4jaB0ZcuTgOSFvs6At6Ui+168euwn/g2eVBHexHCv81bQ0GQoKC
        ou9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649906581; x=1649992981; bh=choSBkcVUXVApD971k8AjvM5Di3IKxbalXz
        WvZFEOsQ=; b=TiNy7nmoKHrfFn7dLPXBts4WuuvknzXOGSuIFq2y1WlmR2B1gO7
        rLEC8CqY+Ey8AaJzFYVej3p6/Fr3fq8cBVbiDfuQHDGzPjAkMEDUpQAY8OMo5EMH
        ML+114CNUkNeG7D7xSX7qw8dE/nWSiokOeyIlxfC8ndUYcvU7xZckC4pFIC/pEem
        +yGVakCLr2FAwQp7xgYmkVN7Dqz998f0tA8atWIoqPzn4HV7LAj4COAJ7RN/i+Gw
        cmLzQHEPGnVrfGmbBmV2G7oPu2B1M1vljwe5kIhFoQ09u/i+CZPQruFe0wTIahDt
        1S+n6dF3KVP3dM5Bhf6PvRC7kQpbzTJQ4Vg==
X-ME-Sender: <xms:lZNXYn-auaiSUFBdldz7ARJ2KkOqosghuL-CRTGyemFxePuitnp1mw>
    <xme:lZNXYjv-3m6f2DCCPQAoje8ewSbk2oVYTluDqqAvzRxiWZs1UJdKcAKQlGVhuN-Ar
    S0m46nzRgepFZK7OA>
X-ME-Received: <xmr:lZNXYlCZHw3WLcyhAGG9a9Giub9K9R4jaLOa7a0t7Sb03aZr84g5083yy1D-zY7GL_BwFCg1FXIFHo1OSUWmYy9693T1bg3jRd-g2-XjjMbCmWBdDMQwCtnEdMLTUfXiwH-ofQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:lZNXYjeT1fRxuJOZYa7cN1zGZMJc7v2WN_PBTUXXHloRtRL7eF15WQ>
    <xmx:lZNXYsPcKsY4WABQWPDa0xIXXDNZj8sGPyVVKzawIwr0wy4ZSNQOCQ>
    <xmx:lZNXYlnNQQHRBMF-XrT8O1STFfxCUQO0nh1cYztOfVIelKILn5DlXg>
    <xmx:lZNXYjeNwCmadV0co6SPMaBimuBo6gTjEqOXvQ6mdoX4Xa_vTNkWLw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 23:23:01 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 1/6] phy: rockchip-inno-usb2: Fix muxed interrupt support
Date:   Wed, 13 Apr 2022 22:22:52 -0500
Message-Id: <20220414032258.40984-2-samuel@sholland.org>
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

This commit fixes two issues with the muxed interrupt handler. First,
the OTG port has the "bvalid" interrupt enabled, not "linestate". Since
only the linestate interrupt was handled, and not the bvalid interrupt,
plugging in a cable to the OTG port caused an interrupt storm.

Second, the return values from the individual port IRQ handlers need to
be OR-ed together. Otherwise, the lack of an interrupt from the last
port would cause the handler to erroneously return IRQ_NONE.

Fixes: ed2b5a8e6b98 ("phy: phy-rockchip-inno-usb2: support muxed interrupts")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index eca77e44a4c1..cba5c32cbaee 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -940,8 +940,14 @@ static irqreturn_t rockchip_usb2phy_irq(int irq, void *data)
 		if (!rport->phy)
 			continue;
 
-		/* Handle linestate irq for both otg port and host port */
-		ret = rockchip_usb2phy_linestate_irq(irq, rport);
+		switch (rport->port_id) {
+		case USB2PHY_PORT_OTG:
+			ret |= rockchip_usb2phy_otg_mux_irq(irq, rport);
+			break;
+		case USB2PHY_PORT_HOST:
+			ret |= rockchip_usb2phy_linestate_irq(irq, rport);
+			break;
+		}
 	}
 
 	return ret;
-- 
2.35.1

