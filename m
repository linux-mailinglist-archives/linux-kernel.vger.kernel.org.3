Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC80576E56
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiGPNwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:52:47 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05A1D323;
        Sat, 16 Jul 2022 06:52:41 -0700 (PDT)
X-QQ-mid: bizesmtp87t1657979555te152duc
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 21:52:24 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: GfaJPLQO2RkAZyVAnW5Q50RJZpZJuWxwg0XOkRVupOsUJqEQb/8Qy5VaxvG2L
        fHetyB0DZnl1ft9VJtsVi/vQh79La6nDpc+hLtgZ9DitJPpE9cEdcRgzfVYqKvMVz/zpRYs
        UbQTBmdRXJKVN+n1t5GeFsQgDhqRIboTWPURw0/Fub5szXzanwtpZ2rfl/dAPuQk/oDenX9
        VqKfSjqan5d35R+Kj4LB2l/RKi74H+n9hMa91ECax46JCdY4id92kh8emywLKUOSqtcXSej
        QaX4t0wahHv7LzNjn2kOWX5ixX58luXAnlS1ThaSsQsf2p8IXyKKA9sQgahYO6gi47TWQLY
        1bdj9wrl3T8B7wW+Uv+NZjG21Whd4c7Jmtbbstts2+Se2nMshOUvAwh0p2eZg==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] usb/storage: fix repeated words in comments
Date:   Sat, 16 Jul 2022 21:52:17 +0800
Message-Id: <20220716135217.49866-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.
 Delete the redundant word 'buffer'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/usb/storage/sddr09.c    | 2 +-
 drivers/usb/storage/transport.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/sddr09.c b/drivers/usb/storage/sddr09.c
index 51bcd4a43690..cb0ae82b4abc 100644
--- a/drivers/usb/storage/sddr09.c
+++ b/drivers/usb/storage/sddr09.c
@@ -1215,7 +1215,7 @@ sddr09_read_map(struct us_data *us) {
 	/*
 	 * read 64 bytes for every block (actually 1 << CONTROL_SHIFT)
 	 * but only use a 64 KB buffer
-	 * buffer size used must be a multiple of (1 << CONTROL_SHIFT)
+	 * size used must be a multiple of (1 << CONTROL_SHIFT)
 	 */
 #define SDDR09_READ_MAP_BUFSZ 65536
 
diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 64d96d210e02..aa96f97e5ac4 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1179,7 +1179,7 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
 		 * If the device tried to send back more data than the
 		 * amount requested, the spec requires us to transfer
 		 * the CSW anyway.  Since there's no point retrying the
-		 * the command, we'll return fake sense data indicating
+		 * command, we'll return fake sense data indicating
 		 * Illegal Request, Invalid Field in CDB.
 		 */
 		if (result == USB_STOR_XFER_LONG)
-- 
2.36.1

