Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA950049E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbiDNDZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiDNDZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:25:30 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A719641611
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:23:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 182545C059B;
        Wed, 13 Apr 2022 23:23:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 Apr 2022 23:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649906586; x=1649992986; bh=JB
        SEPKc915xSzefZ0CTW6PeicSizTdW4KnF7s2wyqrw=; b=SmJ7IUBpwx3EqhSJY4
        e/zpgcBX9Il00K34p5aXOFBfnpfQy/a6JvXxQ62nAWfoZnti5cBbv/l13dFdi3fp
        gNSnYGCnmyc2882xmIf6wRCNj6eRyXenfS7RbJDqk/NxxC+o/AJtyk1qITbCuSy1
        3GomB3ipmkivnenGcMmqSi2/n4FA8RzbkMQGGgAGET6oraIVc2f6hiF6SKgRyCqA
        BqGEnREyPPKI3w2w9esjuXErgZ8A5I9VAdDRWe6GhN7jhEav+K1jgaTu4YDVCDIs
        Jokx2Tmnl+Lq03/lbKtEaoohQ48j3w7SiqPJT8RjcQRdvPLD3cCqjAgUsRHLGscC
        ypNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649906586; x=1649992986; bh=JBSEPKc915xSzefZ0CTW6PeicSizTdW4KnF
        7s2wyqrw=; b=xrPsAt+QqBqT90qN6D+S4/Ub1LWKZoZGedhcntw3XPXdfkSiRXI
        MrhxmdpM8DZqrKrAcyoRyr9Q41+OYyI6sKXBufjM5LvW7dw8yG1orLn/Bg+zvbfF
        5QVmUhIA9mX9ZIyFDW8XUQW9197Ns3agg0CVUr5rtwwNnPyxmZYW83jhwQJnDWUY
        XemtgbyzoXCSMSkPUkk1y1c2BdmqdH/nM4NArZo9LQrO9o+G4ItNlhtUc//SqhTn
        J3HEfcF3UNFv8y+RyHW7EmWr8w9+TNo0CdTRxdBnnMB0MItSrJzpoSL2FDvX8QOs
        EmPSSYmgJi4fgf4ExkRWUnldgrKypcwNr8Q==
X-ME-Sender: <xms:mZNXYuZwspIk2uvkvNiqDkaemI3R1qo-gctN2TQJ_8Vml_ta4GqcTQ>
    <xme:mZNXYhbSZpfRabiFtBSs_pTqEmo9lhppX8ee4g6KBkAuRmcoAe9IJZTMZlRLDBNik
    jUkeTfI4eZAq2PKtw>
X-ME-Received: <xmr:mZNXYo-PL48EFmopz945PF34cIVmKzK4OuhBgWwq9RJXd2GKui2TuFaLM-3KN93kZCs9rzRZueXoLbfXdKvvfCpnloZ7J5H4uy1-UtBYPtX6YPkXmXMaQBvR4M6oLEMlTVC8AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:mZNXYgoG8lCB6807iws35L0oXY_fyQMY7mozX5NWazl5yf5V4wxN1A>
    <xmx:mZNXYppS9WHQv6E1tF-YoV_vPTP4CdM5eM9pcCZggJfwKhpc8rmrbg>
    <xmx:mZNXYuQjiVBa5Z0uvSf4ao4FsrD7k7rhs-Ly7wgOmwLlbNAeyNBVMA>
    <xmx:mpNXYtINIaPPe74drjMJZSvC99cmYKJSuyhyhwINqtrLope-HeXJjw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 23:23:05 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 4/6] phy: rockchip-inno-usb2: Support multi-bit mask properties
Date:   Wed, 13 Apr 2022 22:22:55 -0500
Message-Id: <20220414032258.40984-5-samuel@sholland.org>
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

The "bvalid" and "id" interrupts can trigger on either the rising edge
or the falling edge, so each interrupt has two enable bits and two
status bits. This change allows using a single property for both bits,
checking whether either bit is set.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 3422db56be76..c694517496f8 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -253,7 +253,7 @@ static inline bool property_enabled(struct regmap *base,
 		return false;
 
 	tmp = (orig & mask) >> reg->bitstart;
-	return tmp == reg->enable;
+	return tmp != reg->disable;
 }
 
 static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
-- 
2.35.1

