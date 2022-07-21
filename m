Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B773457C276
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiGUCwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGUCwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:52:14 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5051F7538F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 19:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TRxQr
        Zx9zT/lB4cBWUlEBqAkvfj+SD/k4IU+JEhSinI=; b=fYAo89z5OwX9i05A3KdJo
        OaWu2wrMtRluSgdaajUayQyy4UHD0qnC6kpKPlHLqm4lDjNn9L/XleAxubQ88BSJ
        H2+/mse82lod/kJ5NeJvFnFFTlrK4FqYW7s+Fms5VQiz/wxddm4Pa+HC96H7pUfB
        A3ISmiC+13+ddkCdkIpFeQ=
Received: from localhost.localdomain (unknown [223.104.68.243])
        by smtp12 (Coremail) with SMTP id EMCowADHzHRQv9hiTgofCw--.16S2;
        Thu, 21 Jul 2022 10:52:07 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     monstr@monstr.eu
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] microblaze: Fix typo in comment
Date:   Thu, 21 Jul 2022 10:51:58 +0800
Message-Id: <20220721025158.21856-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowADHzHRQv9hiTgofCw--.16S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW3uFW8Zw4fAFy3Jw4kXrb_yoW3KFcEq3
        47Jw4kGr4ftFy2vFs8tr1avry3Kws8K3ZYvws7KrZFgF95WayIqFna9rn5XFn5Wr4ktFWv
        kr9xZasFkwn7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi5rc3UUUUU==
X-Originating-IP: [223.104.68.243]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJRdFZGAJpJZG+AAAs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 arch/microblaze/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index b179f8f6d287..8651fe351276 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -456,7 +456,7 @@ TRAP_return:		/* Make global symbol for debugging */
 
 
 /* This the initial entry point for a new child thread, with an appropriate
-   stack in place that makes it look the the child is in the middle of an
+   stack in place that makes it look the child is in the middle of an
    syscall.  This function is actually `returned to' from switch_thread
    (copy_thread makes ret_from_fork the return address in each new thread's
    saved context).  */
-- 
2.25.1

