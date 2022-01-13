Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E434848D02F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 02:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiAMBg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 20:36:27 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:33873 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231324AbiAMBg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:36:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V1hFwAI_1642037783;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1hFwAI_1642037783)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 09:36:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ubifs: Fix ubifs_check_dir_empty() kernel-doc comment
Date:   Thu, 13 Jan 2022 09:36:22 +0800
Message-Id: <20220113013622.102096-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in fs/ubifs/dir.c kernel-doc comment
to remove warning found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

fs/ubifs/dir.c:883: warning: expecting prototype for check_dir_empty().
Prototype was for ubifs_check_dir_empty() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ubifs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index ae082a0be2a3..d208d1e35361 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -872,7 +872,7 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
 }
 
 /**
- * check_dir_empty - check if a directory is empty or not.
+ * ubifs_check_dir_empty - check if a directory is empty or not.
  * @dir: VFS inode object of the directory to check
  *
  * This function checks if directory @dir is empty. Returns zero if the
-- 
2.20.1.7.g153144c

