Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEAD508ACA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379698AbiDTObj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356305AbiDTObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:31:37 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A44475E;
        Wed, 20 Apr 2022 07:28:50 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 1BAD5CC1CE;
        Wed, 20 Apr 2022 14:25:03 +0000 (UTC)
Received: from melee.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 3E61A4000C;
        Wed, 20 Apr 2022 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650464699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lpWbOBK6IO2z3uDyg+lEKla8M6bLRGjKIKLiN7eH2A=;
        b=UeGls1/Nu2/pL7jtBXGf/ZoBeCVa/JvdTjAuW+gH9Ej7jbnWCWt34wJbLgkK9IWVhATAvM
        pbXjbYpwNtP1Sa5qXZ53HPl2riukmqPZzLwtr1WFd64nHqTL2lKaeKFGp84fDyJ1uq/DQF
        5uCyJJ9r/ha/zbKmTQX5LuLskUGTzZP780UQAqmvmtlOgZYQhsPbSt1/cgWnk3J/k3mVaJ
        2xCQ6Yu3OnUD6BJm7FZ1ePfaNzzGR/XFXL6uyujvCQcShh6anII3lySicjPq6fOz9EP+MP
        MXAcuwbhITaUwB6FJF5l7lVYB4DdxFpzctNL0irx/7RxGRrT2vuRIQn+EBPw3Q==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-gpio@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: rockchip: sort the rk3308_mux_recalced_data entries
Date:   Wed, 20 Apr 2022 16:24:32 +0200
Message-Id: <20220420142432.248565-2-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420142432.248565-1-luca.ceresoli@bootlin.com>
References: <20220420142432.248565-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the entries are sorted according to num/pin except for two
entries. Sort them too.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 65fa305b5f59..2cb79e649fcf 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -512,20 +512,6 @@ static struct rockchip_mux_recalced_data rk3308_mux_recalced_data[] = {
 		.reg = 0x34,
 		.bit = 8,
 		.mask = 0xf
-	}, {
-		/* gpio3b4_sel */
-		.num = 3,
-		.pin = 12,
-		.reg = 0x68,
-		.bit = 8,
-		.mask = 0xf
-	}, {
-		/* gpio3b5_sel */
-		.num = 3,
-		.pin = 13,
-		.reg = 0x68,
-		.bit = 12,
-		.mask = 0xf
 	}, {
 		/* gpio2a2_sel */
 		.num = 2,
@@ -561,6 +547,20 @@ static struct rockchip_mux_recalced_data rk3308_mux_recalced_data[] = {
 		.reg = 0x68,
 		.bit = 6,
 		.mask = 0x3
+	}, {
+		/* gpio3b4_sel */
+		.num = 3,
+		.pin = 12,
+		.reg = 0x68,
+		.bit = 8,
+		.mask = 0xf
+	}, {
+		/* gpio3b5_sel */
+		.num = 3,
+		.pin = 13,
+		.reg = 0x68,
+		.bit = 12,
+		.mask = 0xf
 	},
 };
 
-- 
2.25.1

