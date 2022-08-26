Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA14D5A2548
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbiHZKBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343728AbiHZKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:14 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB919C1EB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx301.security-mail.net (Postfix) with ESMTP id 2BFA424BD028
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508066;
        bh=hhOYLhZ0Thp1ufst82WAZqogrd7sD1+tS8JKIzZ37Hk=;
        h=From:To:Cc:Subject:Date;
        b=oBRI7Yy1NzrSjUWLFbcYo1M6imqSgBOrjO1jbpTLuP344M4JZZ2sCMll2VH9KIxcX
         UvhOnKUV3Wcko8yJ8T0OeaQ6FSkgaG6iKuEZzSltjuxy727DBdjyVe1WZ+P5Ce4mOM
         yeZ18B/0DLpVQf8q27sQmGhDXoWM8RdZMi41/8aE=
Received: from fx301 (localhost [127.0.0.1])
        by fx301.security-mail.net (Postfix) with ESMTP id 9F62924BD12A;
        Fri, 26 Aug 2022 12:01:05 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <170fd.630899e1.a1e5.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx301.security-mail.net (Postfix) with ESMTPS id 0A92724BD00F;
        Fri, 26 Aug 2022 12:01:05 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id E2D2027E0396;
        Fri, 26 Aug 2022 12:01:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id CC47627E0392;
        Fri, 26 Aug 2022 12:01:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu CC47627E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508064;
        bh=Wp9aSFG2p9IVzrOw1Dt8uvYixAPMsrZHnFgKIw20GKw=;
        h=From:To:Date:Message-Id;
        b=c90Tz4kWNNKSBPc1Dp0a4E3tpXdmz6DQEVqPWQSOxvRnKEO2ykUAgXVWFaxkqdIE0
         +YNiYdOSKzUrjQTe/ISezhAy7n3J+NbxAZDIh4/X7JA5yYWkFNi6CJw4kmDqWnubyt
         tiqjmPBNqTApqp69Z+vTuI6b6nCW49WhnnHN+ihs=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TUoMplY1eKUm; Fri, 26 Aug 2022 12:01:04 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id B0BAB27E02FA;
        Fri, 26 Aug 2022 12:01:04 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:33 +0200
Message-Id: <20220826100052.22945-5-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: Vignesh Raghavendra <vigneshr@ti.com>
CC: linux-mtd@lists.infradead.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 drivers/mtd/ubi/ubi.h                      | 4 ++--
 drivers/mtd/ubi/wl.c                       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 93da23682d86..01ccbde748f3 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -1361,7 +1361,7 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
 /*
  * Handles block mark swapping.
  * It can be called in swapping the block mark, or swapping it back,
- * because the the operations are the same.
+ * because the operations are the same.
  */
 static void block_mark_swapping(struct gpmi_nand_data *this,
 				void *payload, void *auxiliary)
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
2.17.1

