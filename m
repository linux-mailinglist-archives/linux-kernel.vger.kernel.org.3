Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2FA53DAE0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350858AbiFEIk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbiFEIk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:40:57 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B5C2FE7D;
        Sun,  5 Jun 2022 01:40:51 -0700 (PDT)
X-QQ-mid: bizesmtp80t1654418311tvlory9q
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 16:38:25 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: rn/rQ7Qm5gXHO5VqooM6PnTZt2hjeKHWSrUfcWHx6TGyV+Z5pOcKssdtX7xT8
        MwX5zRl+Aqky24pOjxH9flN0Mox3fqViYw4s0zFkQ3tlyJ1G+o5PaIH/M88QuHNnb7eVNv3
        PzhDWR2JzMCfLdZ4Gt1yfo1l1qIwB/EN1GKoBYW0T+2PcqcmXZYu6GJy20WACPdFiyEK770
        Jb80L9Y3zkS7YCddKF1/YwqCi+kMs+qpoC59GmU8ohLd3fjMcjUqnSKLA9qi2zDMKqhO6if
        e0EWagQ84jz2VI4sJrIHNIJNf1iwADWqLcoufb6B0TaqAQMyejQw90MyRz3V1qIKpT/ZGfY
        Vl7oyG2Tw/Ck9hjNqY=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, nm@ti.com, tony@atomide.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] serial: 8250: 8250_omap: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 16:38:25 +0800
Message-Id: <20220605083825.9854-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'have'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ac8bfa042391..a7a95c013fe6 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -345,7 +345,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
 }
 
 /*
- * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have have
+ * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have
  * some differences in how we want to handle flow control.
  */
 static void omap_8250_set_termios(struct uart_port *port,
-- 
2.36.1

