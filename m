Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CED4B1212
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243793AbiBJPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:50:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbiBJPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:50:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38DBBB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:50:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 070ABB825F3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401A7C004E1;
        Thu, 10 Feb 2022 15:50:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ho1WIj4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644508236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/RHUZEvXyNjDfIiWAS3xY4kT8bsmMQ7c0HlOTCYWeI=;
        b=Ho1WIj4OHG0dirWre1KLLILAvtnshu3XT9qiMDU4UXNdSthwjONxnAX67BYlCBmUBRLccb
        MikCmeGOQYrt46bokX4oE9w41sbQMTjZYP+zRWy6gODf1ZuWUItswIKGGsfE7CZzxl6Lu/
        zmIUBVjbFETs6c8Z22GR3f+YGcDWKFQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8e7b944a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 10 Feb 2022 15:50:35 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 3/3] random: add proper SPDX header
Date:   Thu, 10 Feb 2022 16:50:12 +0100
Message-Id: <20220210155012.136485-4-Jason@zx2c4.com>
In-Reply-To: <20220210155012.136485-1-Jason@zx2c4.com>
References: <20220210155012.136485-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow this file missed the SPDXification efforts several years ago.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c  | 40 ++--------------------------------------
 include/linux/random.h |  5 -----
 2 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 30a3c0717e3e..77131f7b0f06 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1,44 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * random.c -- A strong random number generator
- *
  * Copyright (C) 2017-2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
- *
  * Copyright Matt Mackall <mpm@selenic.com>, 2003, 2004, 2005
- *
- * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
- * rights reserved.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- * 1. Redistributions of source code must retain the above copyright
- *    notice, and the entire permission notice in its entirety,
- *    including the disclaimer of warranties.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in the
- *    documentation and/or other materials provided with the distribution.
- * 3. The name of the author may not be used to endorse or promote
- *    products derived from this software without specific prior
- *    written permission.
- *
- * ALTERNATIVELY, this product may be distributed under the terms of
- * the GNU General Public License, in which case the provisions of the GPL are
- * required INSTEAD OF the above restrictions.  (This clause is
- * necessary due to a potential bad interaction between the GPL and
- * the restrictions contained in a BSD-style copyright.)
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
- * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
- * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
- * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
- * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
- * DAMAGE.
+ * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All rights reserved.
  */
 
 /*
diff --git a/include/linux/random.h b/include/linux/random.h
index e92efb39779c..1a6861aa1277 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -1,9 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * include/linux/random.h
- *
- * Include file for the random number generator.
- */
 #ifndef _LINUX_RANDOM_H
 #define _LINUX_RANDOM_H
 
-- 
2.35.0

