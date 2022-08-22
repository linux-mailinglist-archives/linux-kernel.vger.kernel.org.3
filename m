Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053F459BF4E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiHVMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHVMMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:12:30 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE083A4A1;
        Mon, 22 Aug 2022 05:12:28 -0700 (PDT)
X-QQ-mid: bizesmtp83t1661170338twb7vb34
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 20:12:16 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: RLrSOnjbvYHVsoZ0KgpA3ywFWIMAxPdBZL8kKszameGgDMNy/jmgbK3uJOZ35
        A4brLhdDqDexZgqW0m16AkoNfbdcjCFsH8rj9O7v2ONzD8Pt3dW1BFpLtUIL3y0q0TqHJb8
        fkH62SCUgr9x5puxKNFTfQ8BH7hW/ez88J6SEeLkYx/XrsyZ/3XQkSf/wsywWDhtcunv0MC
        gv8ALqRQtrYYL8LQ0z+a70qMZdvvspVW+/XS5R+inPwoXloa+sMYP04Dw6FGKjy+fpH90d2
        5D2uIPTCIfeIA/jdqDgDWugxNcBkrdQOjc5Uu8lzRTdWQ3QoB30hrJtOCtPQn+mfh6K8UBS
        bV5tx41sABhmS3iSUGmrf3c0g54opdp48sL8CSbJ6Ahjv4KabFL24bpL1y6vcWce4jyUVws
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] serial/8250: fix repeated words in comments
Date:   Mon, 22 Aug 2022 20:12:10 +0800
Message-Id: <20220822121210.19425-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?43.154.54.12>]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'have'.
 Delete the redundant word 'don't'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/tty/serial/8250/8250_omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ac8bfa042391..f60b7a8e4f70 100644
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
@@ -579,7 +579,7 @@ static void omap_serial_fill_features_erratas(struct uart_8250_port *up,
 
 	/*
 	 * AM65x SR1.0, AM65x SR2.0 and J721e SR1.0 don't
-	 * don't have RHR_IT_DIS bit in IER2 register. So drop to flag
+	 * have RHR_IT_DIS bit in IER2 register. So drop to flag
 	 * to enable errata workaround.
 	 */
 	if (soc_device_match(k3_soc_devices))
-- 
2.36.1

