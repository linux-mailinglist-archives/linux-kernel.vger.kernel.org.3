Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A83F5A10D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiHYMmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbiHYMmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:42:00 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156C84DF00;
        Thu, 25 Aug 2022 05:41:58 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661431303tun531a5
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 20:41:41 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: zT6n3Y95oi325WtJj3R+SBXlydZNdWUy0p7FgGbcskg2dnkGMzsGYmwG7L/st
        Ks9uO2pGqM/aDIMLA8yM6Mqjsj+PCVLbesg6+nKFBRm3JeMyN6mw4Zig5C9GSw83NdwZu6E
        MJtfRTNqF8OJuG/1lvMqv6vTG3796B+rXImur3swG911Yl7ah70h6WaCTdLDfFU3PK+ouTH
        /DTGsE//cA9cgiiRVugOxpRVNTjf4syPV+mF2IGleeUPdjCjNB3H+1ywlGHopjWOkxBO7ig
        Jw4HMDPLji53V7iWnRhLbjx1VQWhnHyL5qLpQcgbwk979y5jQjziiC+Dw0oGkUorrNFGTCR
        HYjBPraHnV9wsqmLui+Yh+iIMfsjKWXjpGfgKlLrWHw97tGFwSr+mBQVdqvevf75B0WvTfu
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     linus.walleij@linaro.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pinctrl/nuvoton: Use 'unsigned int' instead of just 'unsigned'.
Date:   Thu, 25 Aug 2022 20:41:34 +0800
Message-Id: <20220825124134.30242-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' should be clearer than 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index 64d8a568b3db..1c4e89b046de 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -81,11 +81,11 @@ struct npcm7xx_gpio {
 	int			irq;
 	struct irq_chip		irq_chip;
 	u32			pinctrl_id;
-	int (*direction_input)(struct gpio_chip *chip, unsigned offset);
-	int (*direction_output)(struct gpio_chip *chip, unsigned offset,
+	int (*direction_input)(struct gpio_chip *chip, unsigned int offset);
+	int (*direction_output)(struct gpio_chip *chip, unsigned int offset,
 				int value);
-	int (*request)(struct gpio_chip *chip, unsigned offset);
-	void (*free)(struct gpio_chip *chip, unsigned offset);
+	int (*request)(struct gpio_chip *chip, unsigned int offset);
+	void (*free)(struct gpio_chip *chip, unsigned int offset);
 };
 
 struct npcm7xx_pinctrl {
-- 
2.36.1

