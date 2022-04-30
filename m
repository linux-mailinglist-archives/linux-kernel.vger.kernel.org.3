Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03AD516008
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbiD3TPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiD3TO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:14:57 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A339E4E38A;
        Sat, 30 Apr 2022 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e0ZCDtnIMVzgzfWQCQovtVuN+IS1i3LipeE9GjpMTe8=;
  b=Tr18/boI0Z2AgJxF2rr302biUh0q1AQANlvlKcmvdY9eom3AyvWrpEMv
   6MRT5rgcQhkhsklBgkToUI6RCtALDjmloQbS1Gd/+OfTfJ2Fm0ShCAyUQ
   HQiAecsDiG9DzwFejGZU0Gh0HkpHm6CGV2ZH6GMyZf2KFWpdA+BM9D1mw
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,188,1647298800"; 
   d="scan'208";a="34084614"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:11:32 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Michal Simek <monstr@monstr.eu>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: fix typos in comments
Date:   Sat, 30 Apr 2022 21:11:15 +0200
Message-Id: <20220430191122.8667-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/microblaze/kernel/kgdb.c |    2 +-
 arch/microblaze/lib/memmove.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/kernel/kgdb.c b/arch/microblaze/kernel/kgdb.c
index 130cd0f064ce..df4b9d0112e5 100644
--- a/arch/microblaze/kernel/kgdb.c
+++ b/arch/microblaze/kernel/kgdb.c
@@ -31,7 +31,7 @@
 #define GDB_RTLBLO	55
 #define GDB_RTLBHI	56
 
-/* keep pvr separately because it is unchangeble */
+/* keep pvr separately because it is unchangeable */
 static struct pvr_s pvr;
 
 void pt_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
diff --git a/arch/microblaze/lib/memmove.c b/arch/microblaze/lib/memmove.c
index 2e49d0ef1e07..c1f08c484e20 100644
--- a/arch/microblaze/lib/memmove.c
+++ b/arch/microblaze/lib/memmove.c
@@ -78,7 +78,7 @@ void *memmove(void *v_dst, const void *v_src, __kernel_size_t c)
 
 		i_dst = (void *)dst;
 		/* Choose a copy scheme based on the source */
-		/* alignment relative to dstination. */
+		/* alignment relative to destination. */
 		switch ((unsigned long)src & 3) {
 		case 0x0:	/* Both byte offsets are aligned */
 

