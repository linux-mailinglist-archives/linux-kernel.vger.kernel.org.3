Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FE655F6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiF2GmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiF2GmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:42:01 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A59DD25C76;
        Tue, 28 Jun 2022 23:41:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id ADC551E80D11;
        Wed, 29 Jun 2022 14:40:47 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id foXwxc0emph8; Wed, 29 Jun 2022 14:40:45 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 753831E80CDC;
        Wed, 29 Jun 2022 14:40:44 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] USB: serial: io_edgeport: Fix spelling mistake
Date:   Wed, 29 Jun 2022 14:41:53 +0800
Message-Id: <20220629064153.23476-1-jiaming@nfschina.com>
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

Change 'paramater' to 'parameter'.
Change 'timedout' to 'timeout'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/usb/serial/io_edgeport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index bdee78cc4a07..ffa622539a25 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -220,7 +220,7 @@ struct edgeport_serial {
 	__u8			rxHeader3;			/* receive header byte 3 */
 	__u8			rxPort;				/* the port that we are currently receiving data for */
 	__u8			rxStatusCode;			/* the receive status code */
-	__u8			rxStatusParam;			/* the receive status paramater */
+	__u8			rxStatusParam;			/* the receive status parameter */
 	__s16			rxBytesRemaining;		/* the number of port bytes left to read */
 	struct usb_serial	*serial;			/* loop back to the owner of this object */
 };
@@ -901,7 +901,7 @@ static int edge_open(struct tty_struct *tty, struct usb_serial_port *port)
 
 	if (!edge_port->open) {
 		/* open timed out */
-		dev_dbg(dev, "%s - open timedout\n", __func__);
+		dev_dbg(dev, "%s - open timeout\n", __func__);
 		edge_port->openPending = false;
 		return -ENODEV;
 	}
-- 
2.34.1

