Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60DC57F737
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 23:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiGXVe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 17:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGXVeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 17:34:22 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Jul 2022 14:34:21 PDT
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D505BC03;
        Sun, 24 Jul 2022 14:34:21 -0700 (PDT)
Received: from localhost (153.red-83-50-200.dynamicip.rima-tde.net [83.50.200.153])
        by iodev.co.uk (Postfix) with ESMTPSA id 8A9D3D0CAC;
        Sun, 24 Jul 2022 23:26:41 +0200 (CEST)
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     Ismael Luceno <ismael@iodev.co.uk>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: hci_sync: Fix opcode format in debug message
Date:   Sun, 24 Jul 2022 23:26:39 +0200
Message-Id: <20220724212639.29269-1-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 351c2390164d..d86d819465e8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -150,7 +150,7 @@
 	struct sk_buff *skb;
 	int err = 0;
 
-	bt_dev_dbg(hdev, "Opcode 0x%4x", opcode);
+	bt_dev_dbg(hdev, "Opcode 0x%04x", opcode);
 
 	hci_req_init(&req, hdev);
 
-- 
2.36.0

