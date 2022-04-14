Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342CE5004A3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 05:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbiDNDZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 23:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239686AbiDNDZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:25:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DAE50E39
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 20:23:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 98FDC5C0599;
        Wed, 13 Apr 2022 23:23:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 Apr 2022 23:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649906584; x=1649992984; bh=Zx
        ce5/kMy/OOKoyZk0y1H+zbEfnzEMwAKLBLRkDpYTo=; b=gWIUGtDisH43Z1V5Aj
        Fkfz8gjlSTkvgnu6n/vdOVhXRGKjQQk26pdNeyMCMlp97bkKvPgZmYTykiftsY4T
        VO2vOT1OB4mH1DzIL+LZaoNVKLZruuKEeESt/yly6FNERKBsHTyRlbMUBlM2FQpm
        BSLlwgS+LR8YTkhIqHycj+on19azWQElnKx9eSPiFqAWfIsfXnPBLJRv8WFa3lW3
        E6HI6fCG3u36aiADxlwoFGlFUp6IxXuOydNn+EplrLhwW1mZu0NDQec7LxtA4/oF
        8SyDc3vFs/ba0SghT1MBwIjCU7AW20ZKlJ+EtQ/pWOtDUvPPuWlOY6gvTVC0A4vy
        4z3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649906584; x=1649992984; bh=Zxce5/kMy/OOKoyZk0y1H+zbEfnzEMwAKLB
        LRkDpYTo=; b=fK5xWL6vqy8kwPYCMsYSnXm0WDAkqifrittZPyqJ3oFfYQ6MlG+
        7+8Vrh011hPj5rvYS61g4301ypL/2bWHRZUJajk2WEKgbRmZDLVD+ykSbzmv0ASV
        Rze6qXaw9j343bz1DF5nkipvBISJtnPYn/fGlMiAZIiI5VODtGf0Ck/Grpax8byK
        98qpHwiOU+tzrK04m4gvkwgbGPjio0Lf7edx+MH6pSu8INSt+nOAKNHOV9iYP0qF
        brxKXihHKsu+im66LICdr0ywRteoXpoYIrtD7MhFKZdL227bh/1WWwtUexPBrx+C
        k4xmIvS/ICJnXWkIE9W1xTt1EO9P1EyHNNA==
X-ME-Sender: <xms:mJNXYrzBN6VfFdKy2S78KIWeUr504Sp3yqwWjBlN-b5ROVpb7Z2p4Q>
    <xme:mJNXYjSBElpqOHxzgb-gkTfgchJvLGAdog0q0taSgW10tPGnqHUg4I4_ipOHXhG4e
    XyIb-h3Y8kEMQLYDw>
X-ME-Received: <xmr:mJNXYlUTRiVy7bkr11mmE4ozGBl7i7uhJcWD_66cqFILevMuEp11t9W6HbXvon43uXZSI17SX3cEuNrt0P2q3cjqSXVjGEtxCbvwd8ZyF13Y4UFnoiCpyXDZrGtC2UL0SW5PoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:mJNXYlgFdKFpvxCTCQSXutohXY8kn5usudjk7SPJ4b8HEygSLizktg>
    <xmx:mJNXYtAal3TT5bSrTIPqNtigMZzNmVCoLt-lnhNZrEPlQh0SEzDmYQ>
    <xmx:mJNXYuLmE_9jM9qFP_aqKpK2FVMbrJrhkOWsMRiEaF_W-Alf01-7KQ>
    <xmx:mJNXYnDArgFyNVyPX04hI3zHukrQbrvk6hq5Qwv5DFnqzC3htHXgFA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 23:23:03 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: [PATCH 3/6] phy: rockchip-inno-usb2: Do not lock in bvalid IRQ handler
Date:   Wed, 13 Apr 2022 22:22:54 -0500
Message-Id: <20220414032258.40984-4-samuel@sholland.org>
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

Clearing the IRQ is atomic, so there is no need to hold the mutex.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 29407b36f5fa..3422db56be76 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -905,13 +905,9 @@ static irqreturn_t rockchip_usb2phy_bvalid_irq(int irq, void *data)
 	if (!property_enabled(rphy->grf, &rport->port_cfg->bvalid_det_st))
 		return IRQ_NONE;
 
-	mutex_lock(&rport->mutex);
-
 	/* clear bvalid detect irq pending status */
 	property_enable(rphy->grf, &rport->port_cfg->bvalid_det_clr, true);
 
-	mutex_unlock(&rport->mutex);
-
 	rockchip_usb2phy_otg_sm_work(&rport->otg_sm_work.work);
 
 	return IRQ_HANDLED;
-- 
2.35.1

