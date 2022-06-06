Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7733F53E799
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbiFFOpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbiFFOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:44:56 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627250E25;
        Mon,  6 Jun 2022 07:44:48 -0700 (PDT)
X-QQ-mid: bizesmtp72t1654526492t3xalub6
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 06 Jun 2022 22:41:27 +0800 (CST)
X-QQ-SSF: 01000000002000C0H000B00A0000000
X-QQ-FEAT: Zs8ezjsHqGqVO+NtohCHTvGsn9ZzwXkLosiX3GvNCx8F2jOhjICyYr5Ce91bI
        YiJWTHycGGX/iGbTpF+CfT3/mL0rGwqQsjJAN5zBDp8QAxmSHGLhjFFyuivmNnHUUkOBRmn
        sd8CX6QK1tQZ0+KrW4W+epe3vKlUvA1z6Vfk8cfdyuNjybAOkifKLQoHzIjUIKhMjOCBdyv
        UzZyykP2K1TLMD03XLdyBgOzENzE88q/L9UGs01lyb+2qzO87iAACHCLtCGOK622ywHgVe2
        E76AtUuf/KX0yfUReev5lwwYyV9CDTuu/OAdLlwpNdXKY7vs0QaCpu7tHHYMLKySn6gIJjT
        FYaFC10uXjWggl/MmFkzMgfvq39Zz+dwudKSGDU
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, nm@ti.com, tony@atomide.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v2] serial: 8250_omap: Fix syntax errors in comments
Date:   Mon,  6 Jun 2022 22:41:24 +0800
Message-Id: <20220606144124.29691-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'have'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---

Changes since v1
*Change commit log

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

