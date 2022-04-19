Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A015070F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiDSOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353558AbiDSOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:45:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0E93AA75;
        Tue, 19 Apr 2022 07:42:47 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:42:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650379361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LOo3jv59hXRUdOgz5Y1oBDekLS9RYevTVhGRpxqdpg=;
        b=ICUZ9rWqBUFJJ9SUeIPiiohgSCQsgcMQD2boh6TCFoZsCBQlHcjGG3azO40H1WYr5axUb8
        3Zu7edbInaDBNmCWtgwAtn/EmxvBeXeSeRKxys4lmHSv++jb5/jnC17RXGgKDePFNXsYvG
        dq/sN31vfY8OuNwqgW4K7Ggvm1KI5KW5AaTWxRqsNakEnajQrKVLk7BjAL8lhbF+caXEt+
        N4Hmjq7/QmJrbEKbBIdWHtySx0ORmnS9crZhinN8h7cyVFxjHPYQWxWkZvM1imPnoRPDH3
        Y1+wVTkZ0avw8ZHpKU28hL5SI8yh9Rru1Tm8eD82zAlnX10auJa+b8atRddnaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650379361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LOo3jv59hXRUdOgz5Y1oBDekLS9RYevTVhGRpxqdpg=;
        b=2N6+ZLUiDpFr30K6YkZ8Ir6+Oh1efqNVp7g19FfQ5Zw4F7RPYKBaJFxrBA0uvXQKECILo6
        UeSBk0OC1RoaPBAA==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/build: remove unused OBJECT_FILES_NON_STANDARD_test_nx.o
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220416174710.269226-1-masahiroy@kernel.org>
References: <20220416174710.269226-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <165037936030.4207.3583631675331739342.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     51e8253cf5444299db09e1027160bf503ef49ec9
Gitweb:        https://git.kernel.org/tip/51e8253cf5444299db09e1027160bf503ef49ec9
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sun, 17 Apr 2022 02:47:10 +09:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 19 Apr 2022 07:17:16 -07:00

x86/build: remove unused OBJECT_FILES_NON_STANDARD_test_nx.o

Commit 3ad38ceb2769 ("x86/mm: Remove CONFIG_DEBUG_NX_TEST")
removed arch/x86/kernel/test_nx.c

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220416174710.269226-1-masahiroy@kernel.org
---
 arch/x86/kernel/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index c41ef42..d8b2a81 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -34,8 +34,6 @@ KASAN_SANITIZE_sev.o					:= n
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE := n
 
-OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
-
 ifdef CONFIG_FRAME_POINTER
 OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o		:= y
 endif
