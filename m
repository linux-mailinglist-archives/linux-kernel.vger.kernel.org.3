Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5834A4B381E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 22:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiBLVA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 16:00:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiBLVAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 16:00:54 -0500
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Feb 2022 13:00:50 PST
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB19606EF;
        Sat, 12 Feb 2022 13:00:50 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D5CFD5C0059;
        Sat, 12 Feb 2022 15:50:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 12 Feb 2022 15:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=NL/Ahk+WPU4CkAIAg5T9L6UjJVoy9SI/xkwzeH5XONQ=; b=UF0bi
        Tc1U1kc1Cy9m6CKlbolNZ6D3eUj2JsHViNrUj0IfESned2s9RYZxEgVuexG6u8Va
        zAJzpS4lj2k428Rp+0bChLsSlEtkGQZiTZJ1s8mv54VXqNXHlmGsvyn9m9KVqKDQ
        703fSqviwmqY6QqYk9WeKJgqy88uQXv9MKmi3nCfHGkJt9XA7Hx8WGJGjIGXVCOu
        +ZsM6rYWCmBhT16uMHWoITNvAE0E22fmwejvTbzJqGPeqnBEw+8VhmgY8vxAqBp0
        ru1N5oAP/5Jm6zsmSuk/PvbEQPs98dpbaHS9u5phA8a1qQTtVulDek0a1AUBoJhD
        W0D6rcP5COkGuMiIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=NL/Ahk+WPU4CkAIAg5T9L6UjJVoy9
        SI/xkwzeH5XONQ=; b=HxvKGSwA3u5Quzzm9ZSdqrQn4AH+KzwBWuKwZPGx2b/u/
        7J2xpW4+Ej0G6+338j5Z6uJCCmsXZmS4PgrvzqmhHlP3z8qGcPeJvakLH1k7ucBL
        UQfklqs876P9qyowr/TQ2xKFjxwGnG0RcAzSQUZEWPYvEOLpMo8qGOjFFAipo1K3
        pR3xYFZblixCaS2PQeMCqXjqLVCAOaehgy90bWoXmPFc+wovx73a+Euh5cT9CXr9
        I2aPu4wtl6v3SHZW+/L/hujJIUP3WfFyGPyb65n8yfM75nl2p9TxfGGrgxEYtWyl
        A7HE2g0KF5nHTcG3b4jQFPRRs567G0/AA9PchCyyg==
X-ME-Sender: <xms:qR0IYvZAjvCvnT4vRdd00LB3erfiTogZeyT_GSDKMDiEblGfMdpEmA>
    <xme:qR0IYubIrLlJB8M9ikCrQnGOEaoHy_UDL_Yvn7l6RziyUQk8jyBB3Svu0Sm_UaeWo
    HbLGVuifpO5GGqBZw>
X-ME-Received: <xmr:qR0IYh-GeOql1_4X1Y5yVxG83qoGv-MPBwV56wwUw1HhxbscQg52JF7fMqVlKfeM9d22kKLb66nvSGr9jdIHJ5I82JWg6-_W-XP6iRhCVi9gX8XZ5J-I_g2fuyJAaTT6B1blxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieehgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:qR0IYlphSOnpEpLJ3889t-tiihNFeCRlQVmW8mAKilfQqosG1ukJkA>
    <xmx:qR0IYqoThGLivE6mgQD5gZW3a1PCkCTm3g9BgmcOqzeAGt8esQwUTw>
    <xmx:qR0IYrS3hakmv7368cFsZXV8aVsvEmgdtIfUBgQrCAiKZgv8l5-Itg>
    <xmx:qh0IYmc0YRdPsiwKLJoHjhq-KsnzjZuFfxVe5StkD17vMcL7jqeSbQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Feb 2022 15:50:49 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Guillaume Savaton <guillaume@baierouge.fr>
Subject: [PATCH] gpio: rockchip: Reset int_bothedge when changing trigger
Date:   Sat, 12 Feb 2022 14:50:48 -0600
Message-Id: <20220212205048.43862-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
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

With v2 hardware, an IRQ can be configured to trigger on both edges via
a bit in the int_bothedge register. Currently, the driver sets this bit
when changing the trigger type to IRQ_TYPE_EDGE_BOTH, but fails to reset
this bit if the trigger type is later changed to something else. This
causes spurious IRQs, and when using gpio-keys with wakeup-event-action
set to EV_ACT_(DE)ASSERTED, those IRQs translate into spurious wakeups.

Fixes: 3bcbd1a85b68 ("gpio/rockchip: support next version gpio controller")
Reported-by: Guillaume Savaton <guillaume@baierouge.fr>
Tested-by: Guillaume Savaton <guillaume@baierouge.fr>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/gpio/gpio-rockchip.c | 56 +++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index a4c4e4584f5b..099e358d2491 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -403,65 +403,67 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_handler_locked(d, handle_edge_irq);
 	else
 		irq_set_handler_locked(d, handle_level_irq);
 
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	level = rockchip_gpio_readl(bank, bank->gpio_regs->int_type);
 	polarity = rockchip_gpio_readl(bank, bank->gpio_regs->int_polarity);
 
-	switch (type) {
-	case IRQ_TYPE_EDGE_BOTH:
+	if (type == IRQ_TYPE_EDGE_BOTH) {
 		if (bank->gpio_type == GPIO_TYPE_V2) {
-			bank->toggle_edge_mode &= ~mask;
 			rockchip_gpio_writel_bit(bank, d->hwirq, 1,
 						 bank->gpio_regs->int_bothedge);
 			goto out;
 		} else {
 			bank->toggle_edge_mode |= mask;
 			level |= mask;
 
 			/*
 			 * Determine gpio state. If 1 next interrupt should be
 			 * falling otherwise rising.
 			 */
 			data = readl(bank->reg_base + bank->gpio_regs->ext_port);
 			if (data & mask)
 				polarity &= ~mask;
 			else
 				polarity |= mask;
 		}
-		break;
-	case IRQ_TYPE_EDGE_RISING:
-		bank->toggle_edge_mode &= ~mask;
-		level |= mask;
-		polarity |= mask;
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		bank->toggle_edge_mode &= ~mask;
-		level |= mask;
-		polarity &= ~mask;
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-		bank->toggle_edge_mode &= ~mask;
-		level &= ~mask;
-		polarity |= mask;
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		bank->toggle_edge_mode &= ~mask;
-		level &= ~mask;
-		polarity &= ~mask;
-		break;
-	default:
-		ret = -EINVAL;
-		goto out;
+	} else {
+		if (bank->gpio_type == GPIO_TYPE_V2) {
+			rockchip_gpio_writel_bit(bank, d->hwirq, 0,
+						 bank->gpio_regs->int_bothedge);
+		} else {
+			bank->toggle_edge_mode &= ~mask;
+		}
+		switch (type) {
+		case IRQ_TYPE_EDGE_RISING:
+			level |= mask;
+			polarity |= mask;
+			break;
+		case IRQ_TYPE_EDGE_FALLING:
+			level |= mask;
+			polarity &= ~mask;
+			break;
+		case IRQ_TYPE_LEVEL_HIGH:
+			level &= ~mask;
+			polarity |= mask;
+			break;
+		case IRQ_TYPE_LEVEL_LOW:
+			level &= ~mask;
+			polarity &= ~mask;
+			break;
+		default:
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	rockchip_gpio_writel(bank, level, bank->gpio_regs->int_type);
 	rockchip_gpio_writel(bank, polarity, bank->gpio_regs->int_polarity);
 out:
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
 	return ret;
 }
 
-- 
2.33.1

