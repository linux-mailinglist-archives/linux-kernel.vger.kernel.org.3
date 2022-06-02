Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39553B328
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiFBFwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiFBFwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:52:40 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA982532EC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 22:52:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VF94WQJ_1654149154;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VF94WQJ_1654149154)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jun 2022 13:52:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ubifs: Fix some kernel-doc comments
Date:   Thu,  2 Jun 2022 13:52:33 +0800
Message-Id: <20220602055233.26161-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.
fs/ubifs/journal.c:1221: warning: Function parameter or member
'old_inode' not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Function parameter or member 'old_nm'
not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Function parameter or member
'new_inode' not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Function parameter or member 'new_nm'
not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Function parameter or member
'whiteout' not described in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Excess function parameter 'old_dentry'
description in 'ubifs_jnl_rename'
fs/ubifs/journal.c:1221: warning: Excess function parameter 'new_dentry'
description in 'ubifs_jnl_rename'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ubifs/journal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 75dab0ae3939..16857d4e9aa8 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1201,9 +1201,12 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
  * ubifs_jnl_rename - rename a directory entry.
  * @c: UBIFS file-system description object
  * @old_dir: parent inode of directory entry to rename
- * @old_dentry: directory entry to rename
+ * @old_inode: parent inode to rename
+ * @old_nm: name of old inode to rename
  * @new_dir: parent inode of directory entry to rename
- * @new_dentry: new directory entry (or directory entry to replace)
+ * @new_inode: new inode to rename
+ * @new_nm: name of new inode to rename
+ * @whiteout: whiteout inode
  * @sync: non-zero if the write-buffer has to be synchronized
  *
  * This function implements the re-name operation which may involve writing up
-- 
2.20.1.7.g153144c

