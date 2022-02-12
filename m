Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626E84B34E6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiBLMXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:23:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBLMXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:23:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7D26104
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 04:23:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3152960DB4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AE8C340EB;
        Sat, 12 Feb 2022 12:23:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gn1LM65x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644668611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/8yLwagpOGE8KLuzvBKf6qvWRtBMqmj3atts0qnQVI=;
        b=gn1LM65xX4stV85DckA5lqVnDaT7Anc58zjf0/E5JlwAUW+TNZ94dCb47sJTEGx5nhqpd6
        Y9P+1yRrsnwD/sZGEod7wo+6r6weyEojSbUWix5GZQd8jKMkFW94W4sM9xQkYh6U/SkIF3
        4ixyCMcZilsjYI1ywMtUvO3G1moqqfQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5796ac43 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 12 Feb 2022 12:23:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 03/10] random: remove whitespace and reorder includes
Date:   Sat, 12 Feb 2022 13:23:11 +0100
Message-Id: <20220212122318.623435-4-Jason@zx2c4.com>
In-Reply-To: <20220212122318.623435-1-Jason@zx2c4.com>
References: <20220212122318.623435-1-Jason@zx2c4.com>
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

This is purely cosmetic. Future work involves figuring out which of
these headers we need and which we don't.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 436b146b33be..7bb18422705a 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -193,11 +193,10 @@
 #include <linux/syscalls.h>
 #include <linux/completion.h>
 #include <linux/uuid.h>
+#include <linux/uaccess.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
-
 #include <asm/processor.h>
-#include <linux/uaccess.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/io.h>
-- 
2.35.0

