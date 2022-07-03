Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208D1564513
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiGCEsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiGCEsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:48:20 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A221D51
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 21:48:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E0B07320084E;
        Sun,  3 Jul 2022 00:48:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 03 Jul 2022 00:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656823695; x=1656910095; bh=ol
        CiYvC962ScfzpATAfPxC22ukY6tzWgafn4Ey43S+4=; b=EfMkqEqG0QhxvKeQZW
        ym5ISAdVpH1WN2eFeFeFtiswkR3fL4GrAwfN9yNJQ35E3V8TG8r9jtxu/XJ4eeQS
        uAUY0MmDUkbFuoTGByqQz1BGkE1jfqz4xotpGq3dsvhV5+i6uT/5Obh4KDv2qlbl
        OnN//vIZX8UbkJRDYLB9qW6ib9Eg/BwgJhVnpXXkSMQ7X6YJaaQG1LPUJAmu/G0p
        tPAD6lA/fBsQilQcVmnYesqxlM9SXv5CcOhF5t/QN6orerFUB6OBDWTQ75Ik5x2s
        vV5uG+1g3iTo8eXOOfR1AlqtNCYKuV/UrvznaRfuZFwv3dJUx0DwE2p7gsj0KX3F
        4Cpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656823695; x=1656910095; bh=olCiYvC962Scf
        zpATAfPxC22ukY6tzWgafn4Ey43S+4=; b=qD1hEv/SKN0K1qPYrLjgz7eGaG1RZ
        9rjaAY9wIzKRPBbiOLv+Xsi9dx7hjD8mBnk8bHttyRX4MiJ5zILAKF19/rox3FcI
        VC2+gJdYENX9YFsX3J6qBLxujqxLfrBdsaYX1+HfVkBzo0j08qm9DkAHSR+WPvNl
        +IzjfKZ+h/+hjwS5H89+aHsYf1kfa9cCWiLdQuPGSuXq0Sm8BdWOTpzdfEMClnup
        I9dI1+JcrcQAhoaV+gWDIvoU0Ovf71niONkZRpi93JiJrV50pG3blo8YJh0lPUU+
        vYaneGzdKNgkqMmB1tyAEFY4ezGbvtg7g36QRUxtb5iGAgBwyJDgvvtog==
X-ME-Sender: <xms:jx_BYlYd9PpYbZfcDgGYzltH8_fgQymNFIZExwA3mvfNOyXGgjjvqg>
    <xme:jx_BYsbdiRPbqwXHpwpnafXcYXbTlYjHkLKDoc4v4IZ68FsrTXXN9nW9-uAmu3uMy
    5gx5Z18gPcvQgX0kQ>
X-ME-Received: <xmr:jx_BYn-p20zsgwHzJZw1Rau6piSEF2FTmE6Dl51wBIDNFLCsP8Ilk0EMZLUmJTUFV5u-yZ_9rJrqJO4cSonVE-DtBQdBicY1RClzXa1o5FOrS0RXaYPS3zYxu4ly>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleejgfdvfefhudektddtveegtdekieegffdtkeeljeetudevffeltdei
    feeugeeinecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:jx_BYjqxxrvCNSAmbnezHrcmV4AWeuNut2g-Zq3nntt8W5MansIzcA>
    <xmx:jx_BYgpWj2DGOhLavY_PNox5dqEyb93nQfmUij7j0uYr8U9C6e3fgw>
    <xmx:jx_BYpQ6c2KU8js_aM1bLwGGhIAvQrymdPPkhlkdnuo521RAF1vMlg>
    <xmx:jx_BYpkQjeOtADeyaIyHZUcOT6_0oATI3fWYy4SFpIqwa-0lR36sLw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 00:48:15 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     linux-kernel@vger.kernel.org
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v1 3/3] tools: Use tools/dis-asm-compat.h to fix compilation errors with new binutils
Date:   Sat,  2 Jul 2022 21:48:14 -0700
Message-Id: <20220703044814.892617-5-andres@anarazel.de>
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

Use the previously introduced compat header to fix the build failures.

I verified that:
- perf can still disassemble bpf programs
- bpftool can still disassemble bpf programs, both plain in json
- bpf_jit_disasm still works - it does. Although it turns out that
  independent of these changes bpf_jit_enable = 2 currently is broken, see
  https://lore.kernel.org/20220703030210.pmjft7qc2eajzi6c@alap3.anarazel.de

Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/bpf/bpf_jit_disasm.c     |  5 ++++-
 tools/bpf/bpftool/jit_disasm.c | 40 +++++++++++++++++++++++++++-------
 tools/perf/util/annotate.c     |  7 +++---
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpf_jit_disasm.c b/tools/bpf/bpf_jit_disasm.c
index c8ae95804728..a90a5d110f92 100644
--- a/tools/bpf/bpf_jit_disasm.c
+++ b/tools/bpf/bpf_jit_disasm.c
@@ -28,6 +28,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <limits.h>
+#include <tools/dis-asm-compat.h>
 
 #define CMD_ACTION_SIZE_BUFFER		10
 #define CMD_ACTION_READ_ALL		3
@@ -64,7 +65,9 @@ static void get_asm_insns(uint8_t *image, size_t len, int opcodes)
 	assert(bfdf);
 	assert(bfd_check_format(bfdf, bfd_object));
 
-	init_disassemble_info(&info, stdout, (fprintf_ftype) fprintf);
+	init_disassemble_info_compat(&info, stdout,
+				     (fprintf_ftype) fprintf,
+				     fprintf_styled);
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);
 	info.buffer = image;
diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 24734f2249d6..f0d5c5f0eb60 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -24,6 +24,7 @@
 #include <sys/stat.h>
 #include <limits.h>
 #include <bpf/libbpf.h>
+#include <tools/dis-asm-compat.h>
 
 #include "json_writer.h"
 #include "main.h"
@@ -39,15 +40,12 @@ static void get_exec_path(char *tpath, size_t size)
 }
 
 static int oper_count;
-static int fprintf_json(void *out, const char *fmt, ...)
+static int printf_json(void *out, const char *fmt, va_list ap)
 {
-	va_list ap;
 	char *s;
 	int err;
 
-	va_start(ap, fmt);
 	err = vasprintf(&s, fmt, ap);
-	va_end(ap);
 	if (err < 0)
 		return -1;
 
@@ -73,6 +71,30 @@ static int fprintf_json(void *out, const char *fmt, ...)
 	return 0;
 }
 
+static int fprintf_json(void *out, const char *fmt, ...)
+{
+	va_list ap;
+	int r;
+
+	va_start(ap, fmt);
+	r = printf_json(out, fmt, ap);
+	va_end(ap);
+
+	return r;
+}
+
+static int fprintf_json_styled(void *out, enum disassembler_style style, const char *fmt, ...)
+{
+	va_list ap;
+	int r;
+
+	va_start(ap, fmt);
+	r = printf_json(out, fmt, ap);
+	va_end(ap);
+
+	return r;
+}
+
 void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 		       const char *arch, const char *disassembler_options,
 		       const struct btf *btf,
@@ -99,11 +121,13 @@ void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
 	assert(bfd_check_format(bfdf, bfd_object));
 
 	if (json_output)
-		init_disassemble_info(&info, stdout,
-				      (fprintf_ftype) fprintf_json);
+		init_disassemble_info_compat(&info, stdout,
+					     (fprintf_ftype) fprintf_json,
+					     fprintf_json_styled);
 	else
-		init_disassemble_info(&info, stdout,
-				      (fprintf_ftype) fprintf);
+		init_disassemble_info_compat(&info, stdout,
+					     (fprintf_ftype) fprintf,
+					     fprintf_styled);
 
 	/* Update architecture info for offload. */
 	if (arch) {
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 82cc396ef516..daea1867381d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -41,6 +41,7 @@
 #include <linux/string.h>
 #include <subcmd/parse-options.h>
 #include <subcmd/run-command.h>
+#include <tools/dis-asm-compat.h>
 
 /* FIXME: For the HE_COLORSET */
 #include "ui/browser.h"
@@ -1762,9 +1763,9 @@ static int symbol__disassemble_bpf(struct symbol *sym,
 		ret = errno;
 		goto out;
 	}
-	init_disassemble_info(&info, s,
-			      (fprintf_ftype) fprintf);
-
+	init_disassemble_info_compat(&info, s,
+				     (fprintf_ftype) fprintf,
+				     fprintf_styled);
 	info.arch = bfd_get_arch(bfdf);
 	info.mach = bfd_get_mach(bfdf);
 
-- 
2.35.1.677.gabf474a5dd

