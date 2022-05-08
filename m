Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2260551F03F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiEHTWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiEHTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:15:46 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376C212ABA;
        Sun,  8 May 2022 12:11:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 248J8qSO030019;
        Mon, 9 May 2022 04:08:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 248J8qSO030019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652036934;
        bh=EBR85XaMbeh0T44CkrvtpS6BU3Sm5SGyK1Gdmfon54A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTC5AciDMODiNXRU2PTnmk/Nwzp1l6EM7aBTzt78lmVSYpuq8SdjA4xBxBzEkxcdO
         8WrNcZpTU18ZLSLe5RFUcBbBPM7kyxEZTH/zOWHL8C4wQ2mjaQXDATd+mLzL/WqRvK
         nB4F9ntC1xAYdFhznHMTS0b7bHzOqc3VrFk8oarmJfY/M0jRNN482Y+jU2uoA3GbMz
         jjfZU1+e+qCno/glVueakLSuyqIXsW/RhI6oS3mmuadLcm0zDhY5JVRFPlQPrPxgad
         uCN4On5jSUifzzZ+HwqT6LOFaIPIKmmo+qhlwFRv9QWb+wVX8f0y3r59ljMhUa0dSA
         vyUu9oISFXdpQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 01/14] modpost: remove left-over cross_compile declaration
Date:   Mon,  9 May 2022 04:06:18 +0900
Message-Id: <20220508190631.2386038-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220508190631.2386038-1-masahiroy@kernel.org>
References: <20220508190631.2386038-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a remnant of commit 6543becf26ff ("mod/file2alias: make
modalias generation safe for cross compiling").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v4:
  - New patch

 scripts/mod/modpost.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index cfa127d2bb8f..d9daeff07b83 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -174,7 +174,6 @@ static inline unsigned int get_secindex(const struct elf_info *info,
 }
 
 /* file2alias.c */
-extern unsigned int cross_build;
 void handle_moddevtable(struct module *mod, struct elf_info *info,
 			Elf_Sym *sym, const char *symname);
 void add_moddevtable(struct buffer *buf, struct module *mod);
-- 
2.32.0

