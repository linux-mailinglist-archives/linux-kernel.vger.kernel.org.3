Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7834F4FC3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349025AbiDKR5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349049AbiDKR5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:57:40 -0400
X-Greylist: delayed 573 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 10:55:25 PDT
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 115EC35AA2;
        Mon, 11 Apr 2022 10:55:24 -0700 (PDT)
Received: from localhost (255.red-83-50-200.dynamicip.rima-tde.net [83.50.200.255])
        by iodev.co.uk (Postfix) with ESMTPSA id 3F2A99D0C8;
        Mon, 11 Apr 2022 19:45:50 +0200 (CEST)
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] Bluetooth: btusb: Add 0x0bda:0x8771 Realtek 8761BUV (UGREEN CM390)
Date:   Mon, 11 Apr 2022 19:47:47 +0200
Message-Id: <20220411174747.13704-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 drivers/bluetooth/btusb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2afbd87d77c9..07db720baaa0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -490,6 +490,10 @@ MODULE_DEVICE_TABLE(usb, btusb_table);
 	{ USB_DEVICE(0x2550, 0x8761), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 
+	/* Additional Realtek 8761BUV Bluetooth devices */
+	{ USB_DEVICE(0x0bda, 0x8771), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
-- 
2.35.1

