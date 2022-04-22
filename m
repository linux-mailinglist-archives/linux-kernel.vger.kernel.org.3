Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2641350B471
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387777AbiDVJ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446304AbiDVJ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:57:45 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861753E1A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:54:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VAms8gH_1650621288;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VAms8gH_1650621288)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Apr 2022 17:54:48 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] freevxfs: Fix vxfs_lookup() kernel-doc comment
Date:   Fri, 22 Apr 2022 17:54:45 +0800
Message-Id: <20220422095445.33483-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @ctx and delete obsolete content in vxfs_lookup()
kernel-doc comment to remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

fs/freevxfs/vxfs_lookup.c:216: warning: Function parameter or member
'ctx' not described in 'vxfs_readdir'
fs/freevxfs/vxfs_lookup.c:216: warning: Excess function parameter 'retp'
description in 'vxfs_readdir'
fs/freevxfs/vxfs_lookup.c:216: warning: Excess function parameter
'filler' description in 'vxfs_readdir'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/freevxfs/vxfs_lookup.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index a51425634f65..7a0d2b8ef0fa 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -201,12 +201,7 @@ vxfs_lookup(struct inode *dip, struct dentry *dp, unsigned int flags)
 /**
  * vxfs_readdir - read a directory
  * @fp:		the directory to read
- * @retp:	return buffer
- * @filler:	filldir callback
- *
- * Description:
- *   vxfs_readdir fills @retp with directory entries from @fp
- *   using the VFS supplied callback @filler.
+ * @ctx:	actor we feed the entries to
  *
  * Returns:
  *   Zero.
-- 
2.20.1.7.g153144c

