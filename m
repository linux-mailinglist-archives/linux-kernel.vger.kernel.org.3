Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8756B294
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiGHGOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGHGOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:14:41 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888B422517
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 23:14:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E5FB7320096D;
        Fri,  8 Jul 2022 02:14:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 08 Jul 2022 02:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1657260876; x=1657347276; bh=nopVA/lnqhA2exVnToP0mAgp/
        wxD75eWlnpPSbCMmhw=; b=qLifMKaVVYCsUgU9yiikgoZJSNfJzHy2jb+u9aDAk
        9hbbzrHTATV30Bcsy3EAcNyHGSq/YkJy/w3Rg1h3QiQPPtAZSXwRH0uLDTsT7SU2
        MlCNVYE3pDR+7PFerHhcw85mKR+89fWeFbk+gwS0iRSW6Ct7ulgPbBkdUGL6AZ/t
        JhJkOX6zp4WEYWtYOWQkcqVbQgGcVVvw01W39mOnSvdfoF/zbHXXC9nsgzCHFuTM
        cxX4ASOOR7hWvfBtX6McmfdpsDGRyWWEB2qYd3sljwhtjI3P3ebEMjEjRENrMDun
        mQYFa/lBuwS+0v7HUSNH1U2L6n+hLrX8xhoUaRnpcNhmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1657260876; x=1657347276; bh=nopVA/lnqhA2exVnToP0mAgp/wxD75eWlnp
        PSbCMmhw=; b=QfZYx+0hze5fBvUiMuj+l7/XD8s1hXCbdcXO7h0X/rMKnO2PZVS
        abnxnYlIm1PdbN6LsXwwNJfAWcJvYFvEq3OMAh7jsEYXmu05/rfC3SCxj4qSysi/
        SMPPnNxxgZxLO2LIbG0j8MkSizxYeDlbDHjqmv2XYtMHp1jjh2vxfls3acOoNIVO
        /pSnhYR+uGX66623GxMxJvJE8/QSdBZ78YZ0/qZWnRUdOgwGrqhEBFJP8XQAHIhk
        05WEHpIr74EzjTQFcuvoiVDgQCvyGoZlXbNDWfr7cSUGSF6j/1CuvPk4DBAiPem+
        ot4mpi/Nf84vyqj8sf9eufw3zVNYJKOYnDA==
X-ME-Sender: <xms:S8vHYoqMDTQMHWGLTx4sPNo-Weg9pgTx7Uo7AFhli8vJaMXi9aKjfQ>
    <xme:S8vHYuruNtlz6sY7beqEHHT4vMnCL5nUz9iYNdxuqJClokr8HrtNesVd1SI9eW5fh
    sNEIxwxtM-dzkDdEw>
X-ME-Received: <xmr:S8vHYtNNIvpcOw04o5Sugtui4oxFefbFjBSlBaj62v4FV41IhIv7MJdYHUNM_yanYoCHyMqOba1d89uykysp5n91A_txNLeB-BhvY859qq4w0guGt0086PVkfp9M89mI_q30WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeiiedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:S8vHYv4g7k8LVnEvLvHaHAAx_ydDpIiFO1kkp41ON7r2cIft0s-12A>
    <xmx:S8vHYn4EdORI1pXwVUYkz6narXRb4uz09FxV-d3XUNBuaNFNgNre_A>
    <xmx:S8vHYvi5fWrY6mdRR6qvUur3kNdA79q8gwXVkpd9clR-uSk7Q96K3w>
    <xmx:TMvHYkF95XdlQH0Fa61XApRMkJ1z7EuMK1RhTYfxoE009Eu6HiBW7Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Jul 2022 02:14:35 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Frank Wunderlich <frank-w@public-files.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH] phy: rockchip-inno-usb2: Ignore OTG IRQs in host mode
Date:   Fri,  8 Jul 2022 01:14:34 -0500
Message-Id: <20220708061434.38115-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the OTG port is fixed to host mode, the driver does not request its
IRQs, nor does it enable those IRQs in hardware. Similarly, the driver
should ignore the OTG port IRQs when handling the shared interrupt.

Otherwise, it would update the extcon based on an ID pin which may be in
an undefined state, or try to queue a uninitialized work item.

Fixes: 6a98df08ccd5 ("phy: rockchip-inno-usb2: Fix muxed interrupt support")
Reported-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 6711659f727c..26b841c49ec6 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -978,7 +978,9 @@ static irqreturn_t rockchip_usb2phy_irq(int irq, void *data)
 
 		switch (rport->port_id) {
 		case USB2PHY_PORT_OTG:
-			ret |= rockchip_usb2phy_otg_mux_irq(irq, rport);
+			if (rport->mode != USB_DR_MODE_HOST &&
+			    rport->mode != USB_DR_MODE_UNKNOWN)
+				ret |= rockchip_usb2phy_otg_mux_irq(irq, rport);
 			break;
 		case USB2PHY_PORT_HOST:
 			ret |= rockchip_usb2phy_linestate_irq(irq, rport);
-- 
2.35.1

