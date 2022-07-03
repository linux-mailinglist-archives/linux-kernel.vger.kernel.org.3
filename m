Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA78564512
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiGCEsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiGCEsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:48:19 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A353D60
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 21:48:17 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E545D320085B;
        Sun,  3 Jul 2022 00:48:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 03 Jul 2022 00:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656823695; x=1656910095; bh=If
        /pilaQUcOJoPemXdCwt98hRdp4GDkn/LpQze2e7pA=; b=fmcCA4HDPHbQ7xfb5D
        OC/UHa/I8tJW5f8NI4bZj8xgcB6VRjSH4Vzda716/DzC2cNF+xQcz59loX7DJmSF
        OKin5hv8FKUQqBz4rOIXMlwu8nLnCcx0aheKeJWxPR5YRHq4/0ZRqkg4GG/TJJsE
        Zw4JLIKe7kQg4Lfx4GfOZzZOAgF8WSeKRTARtED/bEdYRHbUyFpPuQTXizE/Ii5x
        pLj7Asn4J2bnKkUOTn0bLza5+USCuEO7onHncA9cHc3mMht8bowjk4x3HvAIU+lz
        80TcdX7Gp71NWs2LWxQY0IZzmajn0BAt/LaQ04uJzgyVboYJooyG46cacgpfhQqz
        SOgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656823695; x=1656910095; bh=If/pilaQUcOJo
        PemXdCwt98hRdp4GDkn/LpQze2e7pA=; b=lLDxBgk4ym0i3Lh+u1hW/c63U9TEO
        torBNInjQURaIyBkmrvUyOhNpncXOZfICuhVIrM3VxOU8ccOvz8AjQVWKf9d1kVS
        4cgjFPClIx+cZXjkU3f8u0ozQNVBXHUkkATi8HEUqinGqoSgvCooGjSa1ZxXD1D/
        LUQzBxmCQooPLp9Asrmc5A26vqZtF2TAMVSuxelQS/qU9tiZm5QibxzG2rMm47IL
        gzoy9Fd3QooTV23hcLcr+VqNV3UXJkAK71dsQ2xw8tufD8hx5xYjlJn/FPs712BA
        SkI0LNKaQ6SMCgWQpa4QVN7qayuFxcolIV+ep/YOV/bzaRMtPDf2O9QVg==
X-ME-Sender: <xms:jx_BYiYuXP4cyqJyHG1pMzl8LR5_Y5zp1C1lTg6fHmp47uy2USdccA>
    <xme:jx_BYlbms-VVCE1wbRCErj5RTRCF407DHJ___KkgKaDloTtc2S36GwkNRJ8V_Dnea
    7mknU6LDNVqNmdjpQ>
X-ME-Received: <xmr:jx_BYs-uMlGG6Ftt-96Cm7eumf6_cyiqbkbokUA0pv7wXOuTAi1n8hSNnUR8l_X4HLNzUSDyfHiEu6V2cZ56NivupuFXTUFxsrLIm6JXFHJmURVlBQfD_xqOfHd3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleejgfdvfefhudektddtveegtdekieegffdtkeeljeetudevffeltdei
    feeugeeinecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:jx_BYkrUWQnO2QuE175Fz_RGh3ieMdAq6gfbIugxa3pARCrBhcrEVw>
    <xmx:jx_BYtqjdcwx0xiC_nUEmFIZ3y4QZAmpc3QRg4zsu0Zh4vSzqqQ_Jg>
    <xmx:jx_BYiQ8K1mOqN0DsEcI6eV3BM0Aav5iDRoXcumQPkNfuRw17m-gcQ>
    <xmx:jx_BYkWCyUsZFvBjrtGJQEtAAPoscLVWokZFXwTTTNJQvXk-nzYzFA>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 00:48:15 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     linux-kernel@vger.kernel.org
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v1 2/3] tools: add dis-asm-compat.h to centralize handling of version differences
Date:   Sat,  2 Jul 2022 21:48:12 -0700
Message-Id: <20220703044814.892617-3-andres@anarazel.de>
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

This commit introduces a wrapper for init_disassemble_info(), to avoid
spreading #ifdef DISASM_INIT_STYLED to a bunch of places.

It likely is worth adding a wrapper for disassember(), to avoid the already
existing #ifdef DISASM_FOUR_ARGS_SIGNATURE.

Cc: Quentin Monnet <quentin@isovalent.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/include/tools/dis-asm-compat.h | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/include/tools/dis-asm-compat.h

diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
new file mode 100644
index 000000000000..d1d003ee3e2f
--- /dev/null
+++ b/tools/include/tools/dis-asm-compat.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_DIS_ASM_COMPAT_H
+#define _TOOLS_DIS_ASM_COMPAT_H
+
+#include <stdio.h>
+#include <linux/compiler.h>
+#include <dis-asm.h>
+
+/* define types for older binutils version, to centralize ifdef'ery a bit */
+#ifndef DISASM_INIT_STYLED
+enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
+typedef int (*fprintf_styled_ftype) (void *, enum disassembler_style, const char*, ...);
+#endif
+
+/*
+ * Trivial fprintf wrapper to be used as the fprintf_styled_func argument to
+ * init_disassemble_info_compat() when normal fprintf suffices.
+ */
+static inline int fprintf_styled(void *out,
+				 enum disassembler_style style __maybe_unused,
+				 const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = vfprintf(out, fmt, args);
+	va_end(args);
+
+	return r;
+}
+
+/*
+ * Wrapper for init_disassemble_info() that hides version
+ * differences. Depending on binutils version and architecture either
+ * fprintf_func or fprintf_styled_func will be called.
+ */
+static inline void init_disassemble_info_compat(struct disassemble_info *info,
+						void *stream,
+						fprintf_ftype unstyled_func,
+						fprintf_styled_ftype styled_func __maybe_unused)
+{
+#ifdef DISASM_INIT_STYLED
+	init_disassemble_info(info, stream,
+			      unstyled_func,
+			      styled_func);
+#else
+	init_disassemble_info(info, stream,
+			      unstyled_func);
+#endif
+}
+
+#endif /* _TOOLS_DIS_ASM_COMPAT_H */
-- 
2.35.1.677.gabf474a5dd

