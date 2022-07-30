Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBCC58598C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiG3JUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiG3JUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:20:44 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FABC3A49A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Of0bd
        HiFbH5ZinM0dT5Z/0tlX2aPJjdsRXFlChnBl8A=; b=jubW/sPBDsb6sodOc1w/q
        MnKIWMAXv3g66vfYpwGIcKGSVmj7LhqQPPYDRxDdONewjFj7G+GDHU4YE9n0TyGc
        fA5TdhWubrzurqOJ5FmiJOCBrD47bHNK12kp5NSenDkcHbEKxQ8PX5xZoHaWUYaH
        K7VCy+M6k5zm3WlVXn8q38=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp5 (Coremail) with SMTP id HdxpCgAHDkqg9+RiIcxcRQ--.27135S2;
        Sat, 30 Jul 2022 17:19:29 +0800 (CST)
From:   studentxswpy@163.com
To:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Cc:     hubcap@omnibond.com, martin@omnibond.com,
        Xie Shaowen <studentxswpy@163.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH -next] orangefs: Fix spelling mistakes and cleanup code
Date:   Sat, 30 Jul 2022 17:18:38 +0800
Message-Id: <20220730091838.3102337-1-studentxswpy@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgAHDkqg9+RiIcxcRQ--.27135S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1DAFW7JF4UAry8tr1DZFb_yoW8Gw43pF
        Wak3WxGr4UXw4fA34xXr10934Iga9rWF4Iq3ZxXw1YyF45ZryYqrWYqa1j9r9rXFWrW3yx
        tF40g34agw15ZFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0SoXUUUUU=
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xvwxvv5qw024ls16il2tof0z/1tbiHQFOJGI66NQ2JwAAsD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xie Shaowen <studentxswpy@163.com>

fix follow spelling misktakes:
	futher ==> further
	overriden ==> overridden
	Alloced ==> Allocated

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: Xie Shaowen <studentxswpy@163.com>
---
 fs/orangefs/file.c           | 2 +-
 fs/orangefs/orangefs-cache.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 86810e5d7914..61a2bb0d78f5 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -244,7 +244,7 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 	if (type == ORANGEFS_IO_READ && new_op->downcall.resp.io.amt_complete) {
 		/*
 		 * NOTE: the iovector can either contain addresses which
-		 *       can futher be kernel-space or user-space addresses.
+		 *       can further be kernel-space or user-space addresses.
 		 *       or it can pointers to struct page's
 		 */
 
diff --git a/fs/orangefs/orangefs-cache.c b/fs/orangefs/orangefs-cache.c
index 3b6982bf6bcf..8d32492876bf 100644
--- a/fs/orangefs/orangefs-cache.c
+++ b/fs/orangefs/orangefs-cache.c
@@ -134,7 +134,7 @@ struct orangefs_kernel_op_s *op_alloc(__s32 type)
 		new_op->upcall.type = type;
 		new_op->attempts = 0;
 		gossip_debug(GOSSIP_CACHE_DEBUG,
-			     "Alloced OP (%p: %llu %s)\n",
+			     "Allocated OP (%p: %llu %s)\n",
 			     new_op,
 			     llu(new_op->tag),
 			     get_opname_string(new_op));
-- 
2.25.1

