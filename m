Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2652476E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351232AbiELHxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346458AbiELHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:53:07 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622FA2E9CB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:53:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VCzphY9_1652341972;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VCzphY9_1652341972)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 15:52:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] freevxfs: Modify parameter description in kernel-doc comment
Date:   Thu, 12 May 2022 15:52:38 +0800
Message-Id: <20220512075238.29925-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify parameter description @file->@fp in vxfs_immed_read_folio()
kernel-doc comment to remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

fs/freevxfs/vxfs_immed.c:67: warning: Function parameter or member 'fp'
not described in 'vxfs_immed_read_folio'
fs/freevxfs/vxfs_immed.c:67: warning: Excess function parameter 'file'
description in 'vxfs_immed_read_folio'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/freevxfs/vxfs_immed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
index a37431e443d3..34df0327f580 100644
--- a/fs/freevxfs/vxfs_immed.c
+++ b/fs/freevxfs/vxfs_immed.c
@@ -49,7 +49,7 @@ const struct address_space_operations vxfs_immed_aops = {
 
 /**
  * vxfs_immed_read_folio - read part of an immed inode into pagecache
- * @file:	file context (unused)
+ * @fp:	file context (unused)
  * @folio:	folio to fill in.
  *
  * Description:
-- 
2.20.1.7.g153144c

