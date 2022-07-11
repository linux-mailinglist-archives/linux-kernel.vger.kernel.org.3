Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6765056D521
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiGKHEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGKHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:04:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D939192A8;
        Mon, 11 Jul 2022 00:04:44 -0700 (PDT)
Date:   Mon, 11 Jul 2022 07:04:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657523082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdjj1R/imuMYaZ7BQ2xKnF5yKF83Y2IRj8WiLTcPsEA=;
        b=HHmPRew/ed5uRmN/ap0nCrpgOlAOJoLM9wVRsrIi4OGicJxE5R5zky/sCRs6hze/XHFpNn
        OU3IMo+t/Y8HndlCJgHvGOqjfk2bPsEII2Nv0/KEaGVMojwhTYBZUGRDCgUjMfSfZUJMd3
        Tqs25yx+zmJk/HuMlXFLVymtkr0PavrDSe0fPmqZRBQWxyUjgvITjztyJvS3vjFjfIMkYN
        Jl8jwwrnoCGRYgvW9Pb2v+Syu7hj/kOweUKXc/BEsT7wI2CN3Oqbh8Qu2th86D1d0CjANf
        v2hiZ+ZchAqP63023x38hSAwLMVnCNXPmo2fgnkt5u/3svsndXZYPC1U+7alDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657523082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fdjj1R/imuMYaZ7BQ2xKnF5yKF83Y2IRj8WiLTcPsEA=;
        b=ZW9A5Nxk/aK9bbjTE0EPD8OLOJYJdoG9KAMIgfC4wlTkWHK0OoRje64bssjeKn9ZgbGzya
        ZZRkvGYC3TmEApDA==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Remove unused OBJECT_FILES_NON_STANDARD_test_nx.o
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220711041247.119357-1-masahiroy@kernel.org>
References: <20220711041247.119357-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <165752308055.15455.5543628264449563147.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     8b979924b9f9e945a095a2f622b39b9fd9f65acb
Gitweb:        https://git.kernel.org/tip/8b979924b9f9e945a095a2f622b39b9fd9f65acb
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 11 Jul 2022 13:12:47 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Jul 2022 08:53:28 +02:00

x86/build: Remove unused OBJECT_FILES_NON_STANDARD_test_nx.o

Commit 3ad38ceb2769 ("x86/mm: Remove CONFIG_DEBUG_NX_TEST")
removed arch/x86/kernel/test_nx.c

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220711041247.119357-1-masahiroy@kernel.org
---
 arch/x86/kernel/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4c8b6ae..a20a5eb 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -34,8 +34,6 @@ KASAN_SANITIZE_sev.o					:= n
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE := n
 
-OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
-
 # If instrumentation of this dir is enabled, boot hangs during first second.
 # Probably could be more selective here, but note that files related to irqs,
 # boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
