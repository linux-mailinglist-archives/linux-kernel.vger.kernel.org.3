Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C5E55FC76
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiF2JoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiF2JoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:44:17 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC97F3BBF0;
        Wed, 29 Jun 2022 02:44:16 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id C32D31E80D11;
        Wed, 29 Jun 2022 17:43:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0WurLbxwHkwr; Wed, 29 Jun 2022 17:43:02 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7E7951E80CDC;
        Wed, 29 Jun 2022 17:43:01 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, andy.shevchenko@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] serial: Fix spelling mistake
Date:   Wed, 29 Jun 2022 17:44:11 +0800
Message-Id: <20220629094411.39066-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'timeing' to 'timing'.
Change 'Characteres' to 'Characters'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fdf21de74e90..a7ed5012b90e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1510,7 +1510,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		if (!(lsr & UART_LSR_THRE))
 			return;
 		/*
-		 * To provide required timeing and allow FIFO transfer,
+		 * To provide required timing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
 		 * shift register are empty. The device driver should either
 		 * enable interrupt on TEMT or set UART_CAP_NOTEMT that will
@@ -2796,7 +2796,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		port->read_status_mask |= UART_LSR_BI;
 
 	/*
-	 * Characteres to ignore
+	 * Characters to ignore
 	 */
 	port->ignore_status_mask = 0;
 	if (termios->c_iflag & IGNPAR)
-- 
2.34.1

