Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C05564511
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiGCEsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiGCEsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:48:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18791CF8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 21:48:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E563C32008FE;
        Sun,  3 Jul 2022 00:48:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 03 Jul 2022 00:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656823695; x=1656910095; bh=L7
        LRQqIR8WOHwS7jDqNkq63t9PzY923/O9a9gLSfxTw=; b=mcbDT4RfgZtz+gw7q0
        Ho+HEZAINBpYjJAgcCSvvPfxfD0beLq08mBgH/pRgOxgAJYrgPMBIWo8TOCTnc0a
        lldBKZn5BIQiYW30J8IqoZfqL4MFEUWHWsd0lis177jZQP/skz3Sc38WKUY81Yz3
        4Y5NCieHWyANhrSQK70T7z0UWWOe/pw7vtHaDtCnyUJ8//+dmNPY6tl0c7LbRapg
        UjBipbgkhNKOTkrXnZVrrt9NCAQoQ1y8JXowqmtN+cEoMHXRrO3X0U9lFRYHiXau
        vTc0bA0a/EEnSUIn28u75ZisW4M2XswhHaCvElqwkc0yIV5Iq5t/wSNhyjffwB6/
        VBIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656823695; x=1656910095; bh=L7LRQqIR8WOHw
        S7jDqNkq63t9PzY923/O9a9gLSfxTw=; b=qJr6SL6SyR2m6KTR42ZWRtct0iINl
        8bE9SVD077P0QpDl/us/W/AvpcFy2UCGvKgVA7kqSU16irXmx9RSlRqS37Mt8m/w
        aydVb3TF7eBLchFwdZK2ytgAXN43yBbURBNBPHSxrCe9WpYMNLgq4w4ew5KbkSd0
        xwPVHOjCPi0HJMQNwb1HGdRWQP2FoEVhvKrW7iHYDf01uZMHsK4THTqMjo4fnr7j
        6mzm/sg2ETVPYKLPcxaSEMC9t2VTvP9OIEvboS6fvERn/vEOnBti4F06y4ZHj/U7
        mTlzLehBuSW1ppzbPY0Kck6HQS5dPuqTH/FBAo1O45Q05HccvL6QxXNXA==
X-ME-Sender: <xms:jx_BYufhPJnBDvsmlCO-dZ7zLcuG2Fnf0UHRzxOXJqevxWwjDLeNug>
    <xme:jx_BYoPVy8w3KUWVYijV_s3FjE53Uj1i7t495RAcp0JfQF6dskKNSwaYcAgE8gNZe
    fM-K-Hi20xpPgDV5w>
X-ME-Received: <xmr:jx_BYvjywbq4_0k8LFtUc0Wrw3qByLjcKheqtcEpMtYEmQbbYL5kO_FqRdASxGSDQbpvHZQbefZTXHeonk4orEX3Hzy5WcsKKR9XwR5nOB-6ko_WCXCGQqpv64dW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleejgfdvfefhudektddtveegtdekieegffdtkeeljeetudevffeltdei
    feeugeeinecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:jx_BYr-vYhZ0p6xUNMcXoM0TRyCigenFrcsAtWybjUNYdjHtfrXpKQ>
    <xmx:jx_BYqsyQhTsDd2WpfUQX8ODOyRYOnJQ0nx1cdWOvA0Jw8iUv_OTcg>
    <xmx:jx_BYiHRP5pGLgsnAj70EvMUEv72_HjmHOfo-aqYTaJ80gDmAseZQQ>
    <xmx:jx_BYj7Kgv50eUAYFo2Z_I3X6JExsfMmRL5MYJ3Jn_ATj9BFYtzskg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 00:48:15 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     linux-kernel@vger.kernel.org
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v1 1/3] tools build: add feature test for init_disassemble_info API changes
Date:   Sat,  2 Jul 2022 21:48:11 -0700
Message-Id: <20220703044814.892617-2-andres@anarazel.de>
X-Mailer: git-send-email 2.35.1.677.gabf474a5dd
In-Reply-To: <20220703044814.892617-1-andres@anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703044814.892617-1-andres@anarazel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binutils changed the signature of init_disassemble_info(), which now causes
compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
binutils commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07

This commit adds a feature test to detect the new signature and enables it
for tools using init_disassemble_info().  Subsequent commits will change
the code.

Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/bpf/Makefile                                  |  7 +++++--
 tools/bpf/bpftool/Makefile                          |  7 +++++--
 tools/build/Makefile.feature                        |  4 +++-
 tools/build/feature/Makefile                        |  4 ++++
 tools/build/feature/test-all.c                      |  4 ++++
 tools/build/feature/test-disassembler-init-styled.c | 13 +++++++++++++
 tools/perf/Makefile.config                          |  8 ++++++++
 7 files changed, 42 insertions(+), 5 deletions(-)
 create mode 100644 tools/build/feature/test-disassembler-init-styled.c

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index b11cfc86a3d0..9c4e61c3a92b 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -34,8 +34,8 @@ else
 endif
 
 FEATURE_USER = .bpf
-FEATURE_TESTS = libbfd disassembler-four-args
-FEATURE_DISPLAY = libbfd disassembler-four-args
+FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
+FEATURE_DISPLAY = libbfd disassembler-four-args disassembler-init-styled
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean bpftool_clean runqslower_clean resolve_btfids_clean
@@ -56,6 +56,9 @@ endif
 ifeq ($(feature-disassembler-four-args), 1)
 CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
 endif
+ifeq ($(feature-disassembler-init-styled), 1)
+CFLAGS += -DDISASM_INIT_STYLED
+endif
 
 $(OUTPUT)%.yacc.c: $(srctree)/tools/bpf/%.y
 	$(QUIET_BISON)$(YACC) -o $@ -d $<
diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index c6d2c77d0252..62195118d377 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -93,9 +93,9 @@ INSTALL ?= install
 RM ?= rm -f
 
 FEATURE_USER = .bpftool
-FEATURE_TESTS = libbfd disassembler-four-args zlib libcap \
+FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled zlib libcap \
 	clang-bpf-co-re
-FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
+FEATURE_DISPLAY = libbfd disassembler-four-args disassembler-init-styled zlib libcap \
 	clang-bpf-co-re
 
 check_feat := 1
@@ -117,6 +117,9 @@ endif
 ifeq ($(feature-disassembler-four-args), 1)
 CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
 endif
+ifeq ($(feature-disassembler-init-styled), 1)
+    CFLAGS += -DDISASM_INIT_STYLED
+endif
 
 LIBS = $(LIBBPF) -lelf -lz
 LIBS_BOOTSTRAP = $(LIBBPF_BOOTSTRAP) -lelf -lz
diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 888a0421d43b..339686b99a6e 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -70,6 +70,7 @@ FEATURE_TESTS_BASIC :=                  \
         libaio				\
         libzstd				\
         disassembler-four-args		\
+        disassembler-init-styled	\
         file-handle
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
@@ -135,7 +136,8 @@ FEATURE_DISPLAY ?=              \
          bpf			\
          libaio			\
          libzstd		\
-         disassembler-four-args
+         disassembler-four-args	\
+         disassembler-init-styled
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7c2a17e23c30..c3059739318a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -18,6 +18,7 @@ FILES=                                          \
          test-libbfd.bin                        \
          test-libbfd-buildid.bin		\
          test-disassembler-four-args.bin        \
+         test-disassembler-init-styled.bin	\
          test-reallocarray.bin			\
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
@@ -248,6 +249,9 @@ $(OUTPUT)test-libbfd-buildid.bin:
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
 
+$(OUTPUT)test-disassembler-init-styled.bin:
+	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
+
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 5ffafb967b6e..957c02c7b163 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -166,6 +166,10 @@
 # include "test-disassembler-four-args.c"
 #undef main
 
+#define main main_test_disassembler_init_styled
+# include "test-disassembler-init-styled.c"
+#undef main
+
 #define main main_test_libzstd
 # include "test-libzstd.c"
 #undef main
diff --git a/tools/build/feature/test-disassembler-init-styled.c b/tools/build/feature/test-disassembler-init-styled.c
new file mode 100644
index 000000000000..f1ce0ec3bee9
--- /dev/null
+++ b/tools/build/feature/test-disassembler-init-styled.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <dis-asm.h>
+
+int main(void)
+{
+	struct disassemble_info info;
+
+	init_disassemble_info(&info, stdout,
+			      NULL, NULL);
+
+	return 0;
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 73e0762092fe..ee417c321adb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -298,6 +298,7 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
 FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
+FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
 
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -ggdb3
@@ -905,13 +906,16 @@ ifndef NO_LIBBFD
     ifeq ($(feature-libbfd-liberty), 1)
       EXTLIBS += -lbfd -lopcodes -liberty
       FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
+      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -ldl
     else
       ifeq ($(feature-libbfd-liberty-z), 1)
         EXTLIBS += -lbfd -lopcodes -liberty -lz
         FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
+        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
       endif
     endif
     $(call feature_check,disassembler-four-args)
+    $(call feature_check,disassembler-init-styled)
   endif
 
   ifeq ($(feature-libbfd-buildid), 1)
@@ -1025,6 +1029,10 @@ ifeq ($(feature-disassembler-four-args), 1)
     CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
 endif
 
+ifeq ($(feature-disassembler-init-styled), 1)
+    CFLAGS += -DDISASM_INIT_STYLED
+endif
+
 ifeq (${IS_64_BIT}, 1)
   ifndef NO_PERF_READ_VDSO32
     $(call feature_check,compile-32)
-- 
2.35.1.677.gabf474a5dd

