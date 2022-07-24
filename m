Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3859657F3A5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiGXHVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiGXHVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:21:05 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E49B11
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:20:59 -0700 (PDT)
X-QQ-mid: bizesmtp84t1658647256tsc6wua4
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:20:55 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: f+zPZQOarc9x+DFPvz5UO7M17Dkak6UjTYErqqYvLy4fMHU+GCNKuD0Ekb081
        3sTQCbgNS/kvqajoYW/GwVAoyaBHXXNh4Eg8k/mPdO8rfaGt1fCUGDkLbbiQ9j/c2Vx9gzU
        48P1qz+OdwKh4Loaw/oVazPjd0qv9/DpElzKVUj4PDWYP6JiIf6BEQQtkApyHcM384kBZAw
        552uanuTJcDNmGNNtbhfXiJ8twAi+qEbVB4Kcv6QrAsNPFKMeQ95VzIZ1M0lOguTz9rLv/K
        3NRyZlkG4+M2utcydHa7kjxqx+hERzzon9bYsYDSUcVkr6KD/4UXKqPYDN8fp2HNPt4NzBc
        t5UL0ocIEs+Ejk7Wi7wDAvOJ1wPiVJsdWUnGQuR
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] fs/romfs: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:20:38 +0800
Message-Id: <20220724072038.11775-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 fs/romfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index c59b230d55b4..b30bbba7001f 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -40,7 +40,7 @@
  *			2.3.9		clean up usage of ENOENT/negative
  *					  dentries in lookup
  *					clean up page flags setting
- *					  (error, uptodate, locking) in
+ *					  (error, uptodate, locking)
  *					  in read_folio
  *					use init_special_inode for
  *					  fifos/sockets (and streamline) in
-- 
2.36.1

