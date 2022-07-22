Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D999257DB4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiGVHdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGVHc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:32:59 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95E7097D79
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ERumE
        dW4Zd6qlQYEct6GW3LcAxcw0D0ITMnR8G8AItU=; b=EVKXnhYwRPzGreSR6ntLl
        jrhc6daolicCf43oPnlUE+Pkm+v0y/rdB77pSCeuDXXcwrcTO/wvZT+HkaF94Sqo
        MSF0JwPGf5Jvuagl0iMzTGFIKuZme0L38oxFBCxwwmST4xWP5+Rk/6OiTQe6dteA
        rUU26tXNO/P61bjrRgt1Fo=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp1 (Coremail) with SMTP id GdxpCgB3cl2dUtpitxUZPw--.5903S2;
        Fri, 22 Jul 2022 15:32:46 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com, richard@nod.at
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] ubi: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 15:32:43 +0800
Message-Id: <20220722073243.73103-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgB3cl2dUtpitxUZPw--.5903S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyDtr43uFWkCw4DJrW8WFg_yoW8Ww4rp3
        yUZFW2qrWxJ3yDW3Z7Gw4kWrZxJayrZ3yfuFW2g34FgrWrJrWrAFyayFyrtrWUJF47Aa17
        XFy8A34kJFy09r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEARh_UUUUU=
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivx5GZFWB0jtjSwAAsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/mtd/ubi/ubi.h | 4 ++--
 drivers/mtd/ubi/wl.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 078112e23dfd..d9039e7f6703 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -281,7 +281,7 @@ struct ubi_eba_leb_desc {
 
 /**
  * struct ubi_volume - UBI volume description data structure.
- * @dev: device object to make use of the the Linux device model
+ * @dev: device object to make use of the Linux device model
  * @cdev: character device object to create character device
  * @ubi: reference to the UBI device description object
  * @vol_id: volume ID
@@ -439,7 +439,7 @@ struct ubi_debug_info {
 
 /**
  * struct ubi_device - UBI device description structure
- * @dev: UBI device object to use the the Linux device model
+ * @dev: UBI device object to use the Linux device model
  * @cdev: character device object to create character device
  * @ubi_num: UBI device number
  * @ubi_name: UBI device name
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 55bae06cf408..330f9ffec3a7 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -429,7 +429,7 @@ static int prot_queue_del(struct ubi_device *ubi, int pnum)
 /**
  * sync_erase - synchronously erase a physical eraseblock.
  * @ubi: UBI device description object
- * @e: the the physical eraseblock to erase
+ * @e: the physical eraseblock to erase
  * @torture: if the physical eraseblock has to be tortured
  *
  * This function returns zero in case of success and a negative error code in
-- 
2.25.1

