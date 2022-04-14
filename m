Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982CB5004A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbiDNDZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239704AbiDNDZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:25:31 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8EF41611
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:23:08 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E1A05C059D;
        Wed, 13 Apr 2022 23:23:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 13 Apr 2022 23:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649906587; x=1649992987; bh=2c
        yAbw+mxipdsb5EEU66tvRgQBKhpd5IuKusyVkj874=; b=XhA3LcPh3lLoixI8By
        KPeESI1K8CIRU6LzaxuhxxpdHsCg1mlkij18LLftHN/jxp/7L4IwaavHbQ4fXOJx
        J7LJd5hJ6CgrZwb4AMQRaYY4oQzm28H0pfVxLWU3XKhCfWb2BKyPHkMn7S6iHGO+
        CDniwfwMOSUd+NPd8vxYqomYatgRkx36sVDAqFwoC/TMlLH/t5E0w3oY/IovybNa
        thTPsYmprGhG77OubEhQe456t/WDboT1Blmy1dUSAtCFjLRTRMthN2Q1hKc3rkkR
        t2bPY+SC+mmGbmP5YFmPOwSkaXqe8fpULT8XIpES6nwG/J1Ce7+oVLcfNEUitnbM
        WcSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649906587; x=1649992987; bh=2cyAbw+mxipdsb5EEU66tvRgQBKhpd5IuKu
        syVkj874=; b=wxBVsRHPd5Jv5jy5SiqA2q32lXcafNFvG0H1ZkO8lk8lFc+yPXP
        WhR8kRwzrndJyLKkZmz65vz857eZexMxWe1G5TxYa5jeVUlUlKMt9tixJrNP3BCe
        FBwYfP2Rozt7VJjLiRB4Pw8jcgYgNX9KPL7gUBOkUnsYa2G3UczROmSOCYRSAbkK
        Gy+6RotiHwzRKK28oOVuLnTMkXkgZCBJoiOlwECdMg44fn1iReU11qrToGtGD7AW
        GoOSht/AUTmV9IbJwUzQk/CpukqLX5Aqs3SclkcJvWrdITlNblmufsf6Gfup/ThD
        2F+akDUvB1rqHUbQNJWc8351A1czdb4vwvw==
X-ME-Sender: <xms:m5NXYrl3TcjRTUtDc76XRCk14l-n7yb1JGhJWZKNv9a7alF4ukxGMw>
    <xme:m5NXYu1LDvdoM6Cx0LEsZPYhjJI9cp2ENqmXXeQHvDrocIoZ0h6WCEqxfCTK5QNai
    ereCgawomqzQ1_r0A>
X-ME-Received: <xmr:m5NXYhqaKYU3w9bXAyoefZRx_eRvbT6d9EBTN4wSx3eehnMIPwnUMYD9mTKGJfV_EKtYA_DnGEXYDga5GiTsOfaCKMIjhdL8zH9S2UYHRJzXfW0rihf2HMpaNPjgwUNcKfi8nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:m5NXYjllBfQmjTdABLa4I8f9CZzBRhMEmjH09wjqAGotUfz4zpoxvw>
    <xmx:m5NXYp0TDbrP8-oFAWlPtmyfrUHJ6wn7uwFOZZnKWqZRHiHsSEWyUQ>
    <xmx:m5NXYisE07IBkt07wUdjdpPQN3-ZYe295PT7Z_HDX00-PvC7hy_l4Q>
    <xmx:m5NXYmmrBhGTQPss8g92kpMAQepJ9tjStVuzEc_tpFCbi7uCRZQhhw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 23:23:06 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 5/6] phy: rockchip-inno-usb2: Handle bvalid falling
Date:   Wed, 13 Apr 2022 22:22:56 -0500
Message-Id: <20220414032258.40984-6-samuel@sholland.org>
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

Some SoCs have a bvalid falling interrupt, in addition to bvalid rising.
This interrupt can detect OTG cable plugout immediately, so it can avoid
the delay until the next scheduled work.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index c694517496f8..2b29f5dd8873 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1345,9 +1345,9 @@ static const struct rockchip_usb2phy_cfg rk3308_phy_cfgs[] = {
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
 				.phy_sus	= { 0x0100, 8, 0, 0, 0x1d1 },
-				.bvalid_det_en	= { 0x3020, 2, 2, 0, 1 },
-				.bvalid_det_st	= { 0x3024, 2, 2, 0, 1 },
-				.bvalid_det_clr = { 0x3028, 2, 2, 0, 1 },
+				.bvalid_det_en	= { 0x3020, 3, 2, 0, 3 },
+				.bvalid_det_st	= { 0x3024, 3, 2, 0, 3 },
+				.bvalid_det_clr = { 0x3028, 3, 2, 0, 3 },
 				.ls_det_en	= { 0x3020, 0, 0, 0, 1 },
 				.ls_det_st	= { 0x3024, 0, 0, 0, 1 },
 				.ls_det_clr	= { 0x3028, 0, 0, 0, 1 },
@@ -1388,9 +1388,9 @@ static const struct rockchip_usb2phy_cfg rk3328_phy_cfgs[] = {
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
 				.phy_sus	= { 0x0100, 15, 0, 0, 0x1d1 },
-				.bvalid_det_en	= { 0x0110, 2, 2, 0, 1 },
-				.bvalid_det_st	= { 0x0114, 2, 2, 0, 1 },
-				.bvalid_det_clr = { 0x0118, 2, 2, 0, 1 },
+				.bvalid_det_en	= { 0x0110, 3, 2, 0, 3 },
+				.bvalid_det_st	= { 0x0114, 3, 2, 0, 3 },
+				.bvalid_det_clr = { 0x0118, 3, 2, 0, 3 },
 				.ls_det_en	= { 0x0110, 0, 0, 0, 1 },
 				.ls_det_st	= { 0x0114, 0, 0, 0, 1 },
 				.ls_det_clr	= { 0x0118, 0, 0, 0, 1 },
@@ -1512,9 +1512,9 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
 				.phy_sus	= { 0x0000, 8, 0, 0, 0x1d1 },
-				.bvalid_det_en	= { 0x0080, 2, 2, 0, 1 },
-				.bvalid_det_st	= { 0x0084, 2, 2, 0, 1 },
-				.bvalid_det_clr = { 0x0088, 2, 2, 0, 1 },
+				.bvalid_det_en	= { 0x0080, 3, 2, 0, 3 },
+				.bvalid_det_st	= { 0x0084, 3, 2, 0, 3 },
+				.bvalid_det_clr = { 0x0088, 3, 2, 0, 3 },
 				.utmi_avalid	= { 0x00c0, 10, 10, 0, 1 },
 				.utmi_bvalid	= { 0x00c0, 9, 9, 0, 1 },
 			},
-- 
2.35.1

