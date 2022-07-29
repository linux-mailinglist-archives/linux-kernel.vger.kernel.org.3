Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D449584980
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiG2B6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiG2B6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:58:42 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D55F774344;
        Thu, 28 Jul 2022 18:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MCJfu
        rDn3Pbl+fwBZE/+qbUoubdS0oZHppIQCbE4b0I=; b=VL8nUoOozBGr6PTEv/Ckc
        g7sGnKk/mUosUJkHEbzduUxh1u93QIbA9y+HBbcxCluUNWox9khmov+F91X8c3tX
        3xYgc+BtmYkyR3PWUjPzGLKqni582PqgnCkf82E+bXQB13YNwMebBEQQEALwgFFF
        Zwecg5Y49PwoqRD5EI5xig=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp4 (Coremail) with SMTP id HNxpCgCn2NCNPuNivHoWRg--.38530S2;
        Fri, 29 Jul 2022 09:57:34 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     miklos@szeredi.hu, William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH -next] ovl: Fix spelling mistakes and cleanup code
Date:   Fri, 29 Jul 2022 09:57:26 +0800
Message-Id: <20220729015726.3076091-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgCn2NCNPuNivHoWRg--.38530S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryxCFyfZr17Ww15ArWrXwb_yoW8tF1kpF
        WrGayvgr93Jry7ur1fAF4qqr18Was8WF17Jr48G3s3XFWvg34S9Fy2gr15ZFyrCFWrZryY
        qF4Dt345C3WDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07brAp5UUUUU=
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/1tbiNxFMg1WBo552swADsG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

fix follow spelling misktakes:
	decendant  ==> descendant
	indentify  ==> identify
	underlaying ==> underlying

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 fs/overlayfs/namei.c | 4 ++--
 fs/overlayfs/super.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 65c4346a5b43..69dc577974f8 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -42,7 +42,7 @@ static int ovl_check_redirect(struct path *path, struct ovl_lookup_data *d,
 		 * One of the ancestor path elements in an absolute path
 		 * lookup in ovl_lookup_layer() could have been opaque and
 		 * that will stop further lookup in lower layers (d->stop=true)
-		 * But we have found an absolute redirect in decendant path
+		 * But we have found an absolute redirect in descendant path
 		 * element and that should force continue lookup in lower
 		 * layers (reset d->stop).
 		 */
@@ -648,7 +648,7 @@ static int ovl_get_index_name_fh(struct ovl_fh *fh, struct qstr *name)
  * If the index dentry for a copy up origin inode is positive, but points
  * to an inode different than the upper inode, then either the upper inode
  * has been copied up and not indexed or it was indexed, but since then
- * index dir was cleared. Either way, that index cannot be used to indentify
+ * index dir was cleared. Either way, that index cannot be used to identify
  * the overlay inode.
  */
 int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e4a95548705a..f8f1a190a8ab 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2052,7 +2052,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_stack_depth = 0;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	atomic_long_set(&ofs->last_ino, 1);
-	/* Assume underlaying fs uses 32bit inodes unless proven otherwise */
+	/* Assume underlying fs uses 32bit inodes unless proven otherwise */
 	if (ofs->config.xino != OVL_XINO_OFF) {
 		ofs->xino_mode = BITS_PER_LONG - 32;
 		if (!ofs->xino_mode) {
-- 
2.25.1

