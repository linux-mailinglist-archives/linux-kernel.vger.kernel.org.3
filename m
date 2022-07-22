Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E8157E00A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiGVKcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiGVKcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:32:17 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75599B555F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k+VlV
        RC0HPfrL13ga2tLMhhygRE05MFSOLiB9Y83w0Q=; b=f1+ser1aBNaNxAvkz/QkJ
        aLMRolftFX9xW6eIdJ53Qn15cgX8ZpdTQEQ/n2IZ1zJgyL/wOR6LIVonmkYkbdDg
        7PskqjuHgFS5b8qUy5t+8gIsgPf+UNkJOJ1VLgrACKCgzbyViGmKZDpOfzk2FoS8
        sosatLKB7X2i4KxOqiKzec=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp3 (Coremail) with SMTP id G9xpCgDnn5mgfNpiwdmZQg--.22400S2;
        Fri, 22 Jul 2022 18:32:02 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     guoren@kernel.org, arnd@arndb.de, palmer@rivosinc.com
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] uapi: asm-generic: fcntl: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:31:58 +0800
Message-Id: <20220722103158.82218-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDnn5mgfNpiwdmZQg--.22400S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFykGr1UCw1ktw1fXw4DCFg_yoWfXFb_C3
        yrXrs7Gw1fWF9FgrsrZan7Wr1xKF45GrWkXFWaq34ayrWkK3y8K3Z5Cay7Jr48KrsrurW8
        Xa4rXrnYqw47ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtxRh3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAxZGZGB0LoU5+QAAsI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 tools/include/uapi/asm-generic/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index 0197042b7dfb..826afd9192d8 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -140,7 +140,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flock)
  * locks, and they are only released automatically when the last reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
-- 
2.25.1

