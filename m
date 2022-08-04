Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA670589B6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbiHDMIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiHDMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:08:11 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766891F630;
        Thu,  4 Aug 2022 05:08:09 -0700 (PDT)
X-QQ-mid: bizesmtp73t1659614883t2rkslxh
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 20:08:02 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: KSpVqVeA+UVBU25A1ROVSG0HqEehkY1vrwWuleKMGu6Z52rWGS8n2KA2HHms5
        eaWnfrmA0khDSCfTaZhYklwzhE9y60OBklcOiapYjKAVsphc6ynFsqmewL5kD8FL4nN6WHy
        nftoQkcIFNyjianbi6TGQ0OnT5VRKfK+GnIgoJytR2n5LVITDUrlfeIL5LiqusTOaoHSVMr
        EvcCCVZtX5ub1HxRyYHTRJo5m0LjBJjdW8L5pa1i4V71pBV+1Q+9ON0dQz3yVntUMRj2Zln
        pWkQLmxeKvfZ/octjw5Da73q3m65CBiVd0c/E4uh7APSAqDm4CbtY0KgKMhC6wbElGcNgPo
        sZE7mlYaxrj+sk6/6iY8bQijHSARJ/01chIKJ5xqsDwRp2uJkKziKYy2PYZkeMG43hjoh1+
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] Input: joydev - Fix comment typo
Date:   Thu,  4 Aug 2022 20:08:00 +0800
Message-Id: <20220804120800.60415-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `from' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/input/joydev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index b45ddb457002..5824bca02e5a 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -746,7 +746,7 @@ static void joydev_cleanup(struct joydev *joydev)
 }
 
 /*
- * These codes are copied from from hid-ids.h, unfortunately there is no common
+ * These codes are copied from hid-ids.h, unfortunately there is no common
  * usb_ids/bt_ids.h header.
  */
 #define USB_VENDOR_ID_SONY			0x054c
-- 
2.35.1

