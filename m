Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78A4F8B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiDHAMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 20:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiDHAMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 20:12:20 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E6200
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 17:10:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V9T1Rb7_1649376615;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V9T1Rb7_1649376615)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 08 Apr 2022 08:10:16 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] freevxfs: Fix vxfs_immed_readpage() kernel-doc comment
Date:   Fri,  8 Apr 2022 08:10:14 +0800
Message-Id: <20220408001014.10061-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change parameter type to parameter name in vxfs_immed_readpage()
kernel-doc comment to remove warnings found by running
scripts/kernel-doc, which is caused by using 'make W=1'.

fs/freevxfs/vxfs_immed.c:67: warning: Function parameter or member 'fp'
not described in 'vxfs_immed_readpage'
fs/freevxfs/vxfs_immed.c:67: warning: Function parameter or member 'pp'
not described in 'vxfs_immed_readpage'
fs/freevxfs/vxfs_immed.c:67: warning: Excess function parameter 'file'
description in 'vxfs_immed_readpage'
fs/freevxfs/vxfs_immed.c:67: warning: Excess function parameter 'page'
description in 'vxfs_immed_readpage'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/freevxfs/vxfs_immed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
index bfc780c682fb..d7269217f80a 100644
--- a/fs/freevxfs/vxfs_immed.c
+++ b/fs/freevxfs/vxfs_immed.c
@@ -49,8 +49,8 @@ const struct address_space_operations vxfs_immed_aops = {
 
 /**
  * vxfs_immed_readpage - read part of an immed inode into pagecache
- * @file:	file context (unused)
- * @page:	page frame to fill in.
+ * @fp:	file context (unused)
+ * @pp:	page frame to fill in.
  *
  * Description:
  *   vxfs_immed_readpage reads a part of the immed area of the
-- 
2.20.1.7.g153144c

