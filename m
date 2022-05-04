Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDB519EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349198AbiEDMDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349203AbiEDMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:03:20 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD31D0D6;
        Wed,  4 May 2022 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651665576;
        bh=qGHD1viJbziYFStGKq39fNCCso+OQcti79hBaKlzEuc=;
        h=From:To:Cc:Subject:Date;
        b=AbahLkADFXJ1IKNHg9WdGxcadGrmd/Kew5XuNrTKQe2+IPDwGzoMbDOxECdBP/4GO
         J1f+qDMdsTcL1Gtzxro88VbU+wDfetAlxbbPiF66rcykiHHgM2MtLCVQHuaeF9SiIL
         dOmfjUH/K4WBrd0ytniNQbAC4zoJIGJ/NlIP4SmY=
Received: from huazheng-ThinkPad-X230 ([123.118.173.243])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id EE221EC3; Wed, 04 May 2022 19:59:34 +0800
X-QQ-mid: xmsmtpt1651665574tr0gbru5w
Message-ID: <tencent_70C1308DDA794C81CAEF389049055BACEC09@qq.com>
X-QQ-XMAILINFO: NnA3IMNPwBd+IxCjkbKaQkuHTVOHIcl4UXLtypL6wLupqxkQn/xCCUJTFpojHt
         +ufGNVQJsNA7nuS6+2mdk141ConobYSWk3Kj9jgsOPkw8C450NnG45Kz4fc40vTFaZL4zH91fMxF
         eCKJpiL88i8X7uTz0J+qFiuEdxI6L2aDmttqeMARhWd3vkWWO5z6H/oIX7O0kyc2R84bL+LTjCyZ
         pf9vP1SJjI1qA+1v54r0yjK2pPf9UvhDpa3JZ4lbseor47qT7iUx52hG6TqFhvQVWPXK5AV9XFTu
         sa7c16xQAs3BrtamykTsw9et6g/Le64bE05hdTNCN4pjWkXI5CvZvSCoi9IpnA/l7oj70R3s5sI8
         YTdW6/b8beGrpLFnYsjYE9ALrXGP5H1A7IALzt4/VgpXBYacNSOgHiX5EoG5VCsxgeiqkBP9haj9
         Cn+XNYKQZe4amdBBmjfVxfRpNhI+qSLp+s6H+rJJSQBEDJYt0Yaj20yJtnLy4ZG9g0Pa1OhddWgs
         KRLbqolshIqWc0+BV0va6pLdDBBQxtFnZ/BKQO4O2P6vMTTgJmyUh7Hsb+0N2gMfUwS9ympfvE1S
         A7yalFc97kpnGeSq0OkgbZiOQL1eTa1cwl4WdvQ7lVN6jPXtCBse5VvjIlFmC4mU97eQyXkk3rt8
         oHj6ENeKG+x90rsimXzWeHdqkeJDrmC9nK3PLlvlXto1NcjRGC/3J9GjRmxW2BufZeCDbqiZi75K
         j8/Jd7uQUk2UHKpExiT2thmXBkfanGawjZe7hwMBkMIGTxnvnNk169jg6jS2Cg1rlDE0gZ8eFN9E
         8qd/rv9fdazyDmNlkdmAy+LqDvlQGMY6YPR/3Eup1K3MWAhX6h9ZAmnHfLQ/yHRNsVgbsTkLd1SF
         wYgShtP7fibkTwPKtpajmEMnzE1ATY0tc/ri5aXhhyPpgHblJk8mLkLFEjD6O6yf0diIIeA6fB27
         84Fr2i6FvRSkgMbh85XNAezEvFfokMfGzIJFuM7XfOb4ppJaVftbzhUiVryEXl
From:   IotaHydrae <writeforever@foxmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     IotaHydrae <writeforever@foxmail.com>
Subject: [PATCH] arm: sunxi: fix f1c100s pinctrl function.
Date:   Wed,  4 May 2022 19:59:04 +0800
X-OQ-MSGID: <20220504115904.2553938-1-writeforever@foxmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. change suniv f1c100s pinctrl,PD14 multiplexing function lvds1 to uart2

When the pin PD13 and PD14 is setting up to uart2 function in dts,
there's an error occurred:
1c20800.pinctrl: unsupported function uart2 on pin PD14

Because 'uart2' is not any one multiplexing option of PD14,
and pinctrl don't know how to configure it.

So change the pin PD14 lvds1 function to uart2.

Signed-off-by: IotaHydrae <writeforever@foxmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
index 2801ca706273..68a5b627fb9b 100644
--- a/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
+++ b/drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
@@ -204,7 +204,7 @@ static const struct sunxi_desc_pin suniv_f1c100s_pins[] = {
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
 		  SUNXI_FUNCTION(0x1, "gpio_out"),
 		  SUNXI_FUNCTION(0x2, "lcd"),		/* D20 */
-		  SUNXI_FUNCTION(0x3, "lvds1"),		/* RX */
+		  SUNXI_FUNCTION(0x3, "uart2"),		/* RX */
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),
 	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
 		  SUNXI_FUNCTION(0x0, "gpio_in"),
-- 
2.32.0

