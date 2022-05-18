Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC3C52BBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiERNYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiERNYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DF714AF4D;
        Wed, 18 May 2022 06:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C505617C1;
        Wed, 18 May 2022 13:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F71C385AA;
        Wed, 18 May 2022 13:23:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AedMgvm1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652880235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=riCdYgYm6xWR+07QfZ5ZGl294AJhNyVhkZnipGK9nxE=;
        b=AedMgvm17KpzdenpHUkrbYOR9YrwdPYmjUW/kJw7USjbosMsJurspfiwDPnaBZyaTMwCDd
        P6O6QBmW1Ryk4oxvcoj/DZILksm6VAucnfqOADav7XLYEMlrj5HWV8xzSmySfNLimtS54t
        D7cG5aDXyEw4pvAMqJbtOKwHGDTr3LA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2d46933c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 18 May 2022 13:23:54 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] siphash: add SPDX tags as sole licensing authority
Date:   Wed, 18 May 2022 15:23:45 +0200
Message-Id: <20220518132345.40615-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_HEX
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The text "dual BSD/GPLv2 license" is somewhat ambiguous, and moving this
over to SPDX is overdue. This commit adds SPDX tags to the relevant
files and clarifies that it's GPLv2 only and 3-clause BSD. It also
removes the old text, so that the SPDX tags are the only source of the
information.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/siphash.h | 5 ++---
 lib/siphash.c           | 5 ++---
 lib/test_siphash.c      | 7 +++----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/siphash.h b/include/linux/siphash.h
index 3af1428da559..9153e77382e1 100644
--- a/include/linux/siphash.h
+++ b/include/linux/siphash.h
@@ -1,6 +1,5 @@
-/* Copyright (C) 2016 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
- *
- * This file is provided under a dual BSD/GPLv2 license.
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/* Copyright (C) 2016-2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
  * SipHash: a fast short-input PRF
  * https://131002.net/siphash/
diff --git a/lib/siphash.c b/lib/siphash.c
index 71d315a6ad62..15bc5b6f368c 100644
--- a/lib/siphash.c
+++ b/lib/siphash.c
@@ -1,6 +1,5 @@
-/* Copyright (C) 2016 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
- *
- * This file is provided under a dual BSD/GPLv2 license.
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/* Copyright (C) 2016-2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
  * SipHash: a fast short-input PRF
  * https://131002.net/siphash/
diff --git a/lib/test_siphash.c b/lib/test_siphash.c
index a6d854d933bf..a96788d0141d 100644
--- a/lib/test_siphash.c
+++ b/lib/test_siphash.c
@@ -1,8 +1,7 @@
-/* Test cases for siphash.c
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/* Copyright (C) 2016-2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
- * Copyright (C) 2016 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
- *
- * This file is provided under a dual BSD/GPLv2 license.
+ * Test cases for siphash.c
  *
  * SipHash: a fast short-input PRF
  * https://131002.net/siphash/
-- 
2.35.1

