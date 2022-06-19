Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8C9550D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiFSXS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiFSXSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 19:18:49 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A30F6348
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:18:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id g8so8265867plt.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fadevf1bs6VDcGLyy4O2HyRnez9ZhabTrz+0CTUd5+A=;
        b=RVh2It62abuvi1QAK4VY+OT83dWwyDjBvthZC3rPAeOeNpXRT2oND/R4N2KgCTUcON
         NlH7ECuk5UnDu2zy+CSjXILBN0V9e0UwTdiJvuDKAAA1Hcx5LVAmQ+rEbNUjqWDqlh5Z
         ZDzCYLKmP49WlLc9kABGVwuKCwMzkcSIoeRvIhUcg3+LC04fm7P7u670FLRbRW8q3Dai
         WAWbjhswFtTA1rMusAMpBBtVcuMmH1FxMsQUaBYPMXBJtoAZhXWQYpPQw4PYr4QMud/d
         UDjWdOc4DxVyFXvkxsJro/ztk8gZEq9g4zmroc7kQolAbDG7J3KOCVxZbhLt681whBG1
         3/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fadevf1bs6VDcGLyy4O2HyRnez9ZhabTrz+0CTUd5+A=;
        b=e0261EPX2BDfaJWlPA9on/fKLXSBt2zLbJS23HKjGA6N0B2zoOsQ4ZUgsuUZA1RW4P
         OrDgPlW7mO8NxL09s85Mab9HRrQTceWmgqbP5JLyiul+1y2LLFEcGwYbOVH9trMJAFes
         PXYvY6IbOoWgGHvtSvbXRTTPx8R5VHCEPTQkxE7o+qJTFP2P4TXUqQzw141dYhxIwCHJ
         UK3ib9UF1AlwvMZJZjw+AdrWzvLFFJdV18EJ1/tLyGQN7LTT2K/lSuPIznVAk1HNUJCC
         ZKAm1RtzSLxmtqRrNun33UwDqWRyYwhjifMisfm4u479ix1tzBVTtfWW6nzy1B0t7/1r
         j47A==
X-Gm-Message-State: AJIora9zIATTdQc6j5/uCgEgC5I8CHL3YSp4W9/kUNSpnCiDy3GXTevR
        Ny2sZrCWGLGC23lXP5MwiAc=
X-Google-Smtp-Source: AGRyM1tVfuIGugmSTqK3Mtr3o9pqcsb6GFqQuog7nFCKKXzWtgEdArBlE0zEMGotjXrwpxOuq1ljfQ==
X-Received: by 2002:a17:902:d4c4:b0:16a:2a8c:c4aa with SMTP id o4-20020a170902d4c400b0016a2a8cc4aamr488183plg.138.1655680728548;
        Sun, 19 Jun 2022 16:18:48 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:c443:f10c:f501:dd9f])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090aa58900b001e2f6c7b6f6sm6807016pjq.10.2022.06.19.16.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 16:18:48 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/2] xtensa: rename CONTEXT_TRACKING to CONTEXT_TRACKING_USER
Date:   Sun, 19 Jun 2022 16:18:37 -0700
Message-Id: <20220619231837.1150499-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220619231837.1150499-1-jcmvbkbc@gmail.com>
References: <20220619231837.1150499-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CONTEXT_TRACKING is renamed to CONFIG_CONTEXT_TRACKING_USER, do
it for the xtensa architecture.

Fixes: 2ad9b4c81ea4 ("context_tracking: Split user tracking Kconfig")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig        | 2 +-
 arch/xtensa/kernel/entry.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 0b0f0172cced..7927fed7bc83 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -33,7 +33,7 @@ config XTENSA
 	select HAVE_ARCH_KCSAN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_EXIT_THREAD
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index d72bcafae90c..fb67d85116e4 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -455,7 +455,7 @@ KABI_W	or	a3, a3, a2
 	abi_call	trace_hardirqs_off
 1:
 #endif
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	l32i		abi_tmp0, a1, PT_PS
 	bbci.l		abi_tmp0, PS_UM_BIT, 1f
 	abi_call	user_exit_callable
@@ -544,7 +544,7 @@ common_exception_return:
 	j		.Lrestore_state
 
 .Lexit_tif_loop_user:
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	abi_call	user_enter_callable
 #endif
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-- 
2.30.2

