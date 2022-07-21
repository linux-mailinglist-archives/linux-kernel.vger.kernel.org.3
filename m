Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AEF57C519
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiGUHPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiGUHPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:15:33 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEC7461121
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=emaVs
        3PgOLL97Ep5cNDit7A4KQid3p8Z4dDZp6jnY0w=; b=XZ9PnfTj7Eu1SzZKQ/nZO
        4amQMHjV0BGeZ9ZETJ19B58Bgo6Z+TpstLOPJkRDoRuNqQN6MTZ+Ef0lq3pg+lID
        DJ57IuFjZoqIIwL35/OdVD1FGyngFaUaQIAt3mxIYDUHWl520QFVRuVpBjusLzzK
        JNMc/4UzGjQg4IkQQ/4nIM=
Received: from localhost.localdomain (unknown [112.97.57.47])
        by smtp1 (Coremail) with SMTP id GdxpCgBneXQL_dhitcFQPg--.2602S2;
        Thu, 21 Jul 2022 15:15:26 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     monstr@monstr.eu, mail@conchuod.ie
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] microblaze: Fix some typos in comment
Date:   Thu, 21 Jul 2022 15:15:20 +0800
Message-Id: <20220721071520.48384-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgBneXQL_dhitcFQPg--.2602S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1Dtw1xAF1UKw1ftFWDArb_yoWfWwcEqw
        17Xws7Gr4SyF9FvF4DKr1fZr93Kws8K3ZYvws2grZFgF95Wa1Iqr9agrn8XFn8WrsrtFWk
        urZxZ3ZFkwn7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_OJ53UUUUU==
X-Originating-IP: [112.97.57.47]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDQ5FZFaEKA1vcAAAsK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'like the' in the comment.
Replace 'an' with 'a'.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 arch/microblaze/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index b179f8f6d287..d875a0c01032 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -456,7 +456,7 @@ TRAP_return:		/* Make global symbol for debugging */
 
 
 /* This the initial entry point for a new child thread, with an appropriate
-   stack in place that makes it look the the child is in the middle of an
+   stack in place that makes it look like the child is in the middle of a
    syscall.  This function is actually `returned to' from switch_thread
    (copy_thread makes ret_from_fork the return address in each new thread's
    saved context).  */
-- 
2.25.1

