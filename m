Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1670D580415
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbiGYSgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiGYSgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD61263D;
        Mon, 25 Jul 2022 11:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3695260B55;
        Mon, 25 Jul 2022 18:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D24C341D0;
        Mon, 25 Jul 2022 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658774209;
        bh=mA3aiYbCg1RFcIAqL21d0TvLx6LId+F1ynP5gxcWKis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHdt22eSL1YZ4JLiRkWotwA7r7sZ0hpDIDz0Y1NwZatcdfP29QNwKp5DpTpoxZQTd
         G7Of5r/Qp/uE7sE+lkEn75j6EMZ8hYpLKL2MMAwj2XxkBBDU4+Fo7F38IbwkM945bh
         ukzcyv/vHBxIquUbf1fPzAgRisukeG0ViNKKk0Ht7EU+oiBMqg6qpomZAtaQGNX3RX
         HF6eKYkqObAG7dfXyx0GxpQta+DOIO7DeWV2kXKkyHjV0AEaChm5k2PaE/8dV8Z7CW
         bQudPr3xB7LxxpV+hWCHBAlfAazhe5X3s3ehwg9NFo1Bfu2xxSSROZSHr8Cb/BzG5A
         q1K+I5LGIdoww==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld " <Jason@zx2c4.com>
Subject: [PATCH v3 3/3] crypto: lib - remove __HAVE_ARCH_CRYPTO_MEMNEQ
Date:   Mon, 25 Jul 2022 11:36:36 -0700
Message-Id: <20220725183636.97326-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220725183636.97326-1-ebiggers@kernel.org>
References: <20220725183636.97326-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

No architecture actually defines this, so it's unneeded.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/crypto/memneq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/crypto/memneq.c b/lib/crypto/memneq.c
index d1e8c86fbb0fcf..243d8677cc515d 100644
--- a/lib/crypto/memneq.c
+++ b/lib/crypto/memneq.c
@@ -63,8 +63,6 @@
 #include <crypto/algapi.h>
 #include <linux/module.h>
 
-#ifndef __HAVE_ARCH_CRYPTO_MEMNEQ
-
 /* Generic path for arbitrary size */
 static inline unsigned long
 __crypto_memneq_generic(const void *a, const void *b, size_t size)
@@ -173,5 +171,3 @@ noinline unsigned long __crypto_memneq(const void *a, const void *b,
 	}
 }
 EXPORT_SYMBOL(__crypto_memneq);
-
-#endif /* __HAVE_ARCH_CRYPTO_MEMNEQ */
-- 
2.37.0

