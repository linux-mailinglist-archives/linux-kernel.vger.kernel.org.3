Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63F753DAFE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348667AbiFEJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiFEJ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:27:48 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D7D127
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:27:42 -0700 (PDT)
X-QQ-mid: bizesmtp77t1654421256t9h2f1cj
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 17:27:29 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: +f7TOVQEmCMEk1UHGeDPVgfLv285XQabBO4i34w3L3bYAn+ciz2WOqULpcPCj
        OnFboviJKs1rtxa3NjBbHHUlVudDknDivELaNu+9LhiYnJOfo3Ihll4HXZub5XAGY1BUIBH
        o4qBAMWdnznkaFpk9mUyTfoEzFbSiNIwQhMOoZW+hqTLMtUXHfnVERCvh/z3FdHgedj4lBW
        rKEi1LJpRENG2uBN+7CsaAird+04PRNL3DsRj058/oKdklW+3fSjz208YIonmGpdxumF21f
        w4Z2wMirRgvFXxlAYmEI4srltkleD5fa8oxPI2ykIPJ2u/voVXAhhroI27ZyW4u1fqJsl9m
        92M/rbA7nIvTjKwdF0=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] tracefs: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 17:27:29 +0800
Message-Id: <20220605092729.13010-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 fs/tracefs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index de7252715b12..81d26abf486f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -553,7 +553,7 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
  *
  * Only one instances directory is allowed.
  *
- * The instances directory is special as it allows for mkdir and rmdir to
+ * The instances directory is special as it allows for mkdir and rmdir
  * to be done by userspace. When a mkdir or rmdir is performed, the inode
  * locks are released and the methods passed in (@mkdir and @rmdir) are
  * called without locks and with the name of the directory being created
-- 
2.36.1

