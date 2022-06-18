Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E195B550502
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 15:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiFRNKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFRNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:10:47 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E517048;
        Sat, 18 Jun 2022 06:10:41 -0700 (PDT)
X-QQ-mid: bizesmtp78t1655557745taoefuin
Received: from localhost.localdomain ( [125.70.163.206])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 18 Jun 2022 21:09:01 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: mp05QlZ6er31q1MrCHV1u0rzmqaMNdwuu85emdj4nemWnmenvIbukvyKp3Ayx
        9vIsiLGSMyz+7BzxjsSRiTUW/uBTcKFOpJq0OuX6DowBSqayWbdP4mDNpsgh3H+tLNSbLt3
        iN4JQsIc4fY62m5iaz8kvQ7MSXqtO6vAY9UqX6+gXa84X3RCRdzg+uiIoIK6RyPGooVW+56
        W1hUJzI+tHBjlJRkYHLCnnJllUTcf5LFL9Ka0sICt8npjubbVMYjCHQJVZr/1zqjSuelemA
        p+4T7MBBZETzvho73jWovfaGdeenUx7b6r0u8dXa0YzxeDpQxPoqPNytYodzgldmq12qGSi
        xRC/O5G
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     andrew@aj.id.au
Cc:     linus.walleij@linaro.org, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] pinctrl: aspeed: Fix typo in comment
Date:   Sat, 18 Jun 2022 21:08:54 +0800
Message-Id: <20220618130854.12321-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/pinctrl/aspeed/pinmux-aspeed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index 4d7548686f39..aaa78a613196 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -632,7 +632,7 @@ struct aspeed_pin_desc {
 	SIG_EXPR_LIST_ALIAS(pin, sig, group)
 
 /**
- * Similar to the above, but for pins with a dual expressions (DE) and
+ * Similar to the above, but for pins with a dual expressions (DE)
  * and a single group (SG) of pins.
  *
  * @pin: The pin the signal will be routed to
-- 
2.36.1

