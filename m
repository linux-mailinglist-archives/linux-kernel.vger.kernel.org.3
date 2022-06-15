Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C912A54BF35
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242101AbiFOBUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiFOBUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:20:46 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE349B4B8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:20:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VGQPSJc_1655256041;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VGQPSJc_1655256041)
          by smtp.aliyun-inc.com;
          Wed, 15 Jun 2022 09:20:42 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ericvh@gmail.com
Cc:     lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] 9p: Fix some kernel-doc comments
Date:   Wed, 15 Jun 2022 09:20:39 +0800
Message-Id: <20220615012039.43479-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.
fs/9p/fid.c:35: warning: Function parameter or member 'pfid' not described in 'v9fs_fid_add'
fs/9p/fid.c:35: warning: Excess function parameter 'fid' description in 'v9fs_fid_add'
fs/9p/fid.c:80: warning: Function parameter or member 'pfid' not described in 'v9fs_open_fid_add'
fs/9p/fid.c:80: warning: Excess function parameter 'fid' description in 'v9fs_open_fid_add'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/9p/fid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index 289a85eae2ae..3a0f5963b8bd 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -28,7 +28,7 @@ static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
 /**
  * v9fs_fid_add - add a fid to a dentry
  * @dentry: dentry that the fid is being added to
- * @fid: fid to add
+ * @pfid: fid to add
  *
  */
 void v9fs_fid_add(struct dentry *dentry, struct p9_fid **pfid)
@@ -72,7 +72,7 @@ static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
 /**
  * v9fs_open_fid_add - add an open fid to an inode
  * @inode: inode that the fid is being added to
- * @fid: fid to add
+ * @pfid: fid to add
  *
  */
 
-- 
2.20.1.7.g153144c

