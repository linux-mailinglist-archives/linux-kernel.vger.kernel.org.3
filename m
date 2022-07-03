Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE38F564516
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiGCEsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiGCEsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:48:20 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A159D45
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 21:48:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BF68A3200684
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 00:48:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 03 Jul 2022 00:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656823695; x=1656910095; bh=OY
        wocANUXn60/A2NoBeSFagq8/qEqoWs1FFCQ5dENPI=; b=p98g3GeifKBPvTULvn
        A8a8E/S/4/aaSIWrlLAQpqOwVm1UEYhq5Y1SCAHEKCHFMSJ/OAMiputsC/+DDb3C
        hWqZ7WV8px6wH33L5KuKrqoA8RoI8M4qrehzvB39rXHVDo2+dcPt6v3ArW0FmLve
        629bc907XUSULEopfTSP1aHI4NmBwPqx7wFBilJ6s2uRjDuYmepcw+FiLqFEtQ3e
        k9vNe9l6XjV33ktODibFWPSXwD3rspfGCauD+dlTKwDGtjWP2yQvHcrJ8DYRVoAi
        Viqj50UbeOFCUs+fwmH+ttwnrVWZQlieeUuH2JErtagwHQrqGAZu4/dTPKoOsS/k
        lAdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656823695; x=1656910095; bh=OYwocANUXn60/
        A2NoBeSFagq8/qEqoWs1FFCQ5dENPI=; b=w4Dv/eeSd57ClVg5VrPTszlfYva/6
        b2wjKbHtlkFmbJT9Is+hHxr6/0JHz6UgixKX/ByVHk/KZKdmeGIRTI1l/p6moSUX
        1glJMcjTu5KdzrdAOoGtNk+gWkl4VXO8vi9pG3682KHmq6TgW4F8kMn7vrCUg4JF
        Ve+OlaYqa1g1f+CtHlUbKc+MeP0d/Uny9RpA42V+0AIAlZXZobzQj+qO6sgEYqs1
        8AQoEtondgIWdNWGgVarUf14FgXHCSDukYcsDD9NBKfiHQFNQ6D3mF3J1H0oZZIw
        K0wdfPbhbBA47QaVbRgl+HwBdeCkWno8v4aiL9grqtPPx7MfosRCkxBcA==
X-ME-Sender: <xms:jx_BYiCmsKwVW-TL7JRjCM5owwgx7wXaT2bwvWxyvaV2UD-jjUpiQw>
    <xme:jx_BYsiX7WnnDdW-Km1uK5QintGuEiRDnvajgIsXKBlPJz7uq83w67c46WR_L4ZIO
    n42JL3YcBPWEozIdg>
X-ME-Received: <xmr:jx_BYlmoR-TxsoGw6wC6_lkaQwh3erfmMbIKyAZ7knTjIirbTepcSesKlsrtHc7J8FQXset23Bdn0U2ioMLyz81NDaNwqcuPzf1INFZ-Br-bA2xQtaWcK1tgNlFK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehiedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghn
    rghrrgiivghlrdguvgeqnecuggftrfgrthhtvghrnhepiefgieduueeiudeugfevffeugf
    dvffevgfdufeeujeeuheelffdtffetteffjefhnecuffhomhgrihhnpehsohhurhgtvgif
    rghrvgdrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:jx_BYgwQsjiHWtEmZN_qrzNQdGsGdK3kvTwuqntnCNAoQh5snOm9dw>
    <xmx:jx_BYnRhj43M1Qw_mpufc-YX_sbo1nfB5nbO0T9v9X9YmZ9FWXeBuA>
    <xmx:jx_BYrZScQdjgSn0kqPVwN4r3trlRjt4GNcqHWzpq5pMlpsz2nzmIQ>
    <xmx:jx_BYqP7kdBYbP523lxAiekgrWr9M5I92Q9gI60EumblrEpdKf5O1Q>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-kernel@vger.kernel.org>; Sun, 3 Jul 2022 00:48:15 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] tools: introduce dis-asm.h wrapper to hide version differences
Date:   Sat,  2 Jul 2022 21:48:13 -0700
Message-Id: <20220703044814.892617-4-andres@anarazel.de>
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
perf and bpftool to fail to compile (e.g. on debian unstable). Relevant
binutils commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07

This just wraps init_disassemble_info(), to avoid spreading #ifdef
DISASM_INIT_STYLED to a bunch of places. It likely is worth adding a
wrapper for disassember(), to avoid the already existing #ifdef
DISASM_FOUR_ARGS_SIGNATURE.

Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Signed-off-by: Andres Freund <andres@anarazel.de>
---
 tools/include/tools/dis-asm-compat.h | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 tools/include/tools/dis-asm-compat.h

diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
new file mode 100644
index 000000000000..f44f7d9f053e
--- /dev/null
+++ b/tools/include/tools/dis-asm-compat.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_DIS_ASM_COMPAT_H
+#define _TOOLS_DIS_ASM_COMPAT_H
+
+#include <stdio.h>
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
+static inline int fprintf_styled(void *out, enum disassembler_style style, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	(void)style;
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
+						fprintf_ftype fprintf_func,
+						fprintf_styled_ftype fprintf_styled_func)
+{
+#ifdef DISASM_INIT_STYLED
+	init_disassemble_info(info, stream,
+			      fprintf_func,
+			      fprintf_styled_func);
+#else
+	(void)fprintf_styled_func;
+	init_disassemble_info(info, stream,
+			      fprintf_func);
+#endif
+}
+
+#endif /* _TOOLS_DIS_ASM_COMPAT_H */
-- 
2.35.1.677.gabf474a5dd

