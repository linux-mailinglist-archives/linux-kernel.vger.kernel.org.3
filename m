Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5EE579804
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbiGSK5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiGSK5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:57:05 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40ED28718
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 03:57:03 -0700 (PDT)
Received: from syscall.. (unknown [203.29.26.8])
        by gnuweeb.org (Postfix) with ESMTPSA id 9E7077E317;
        Tue, 19 Jul 2022 10:57:01 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1658228223;
        bh=NIurFmEsDNNT4BQtlqqjgXd6tGsciSmrKgoRlHsZcjs=;
        h=From:To:Cc:Subject:Date:From;
        b=eBkgt098i40opFjR4ooF4HlxRi011zA2KBS+RtBM/3Nn3uGmlfSbc/Q2ZQQLYDBlY
         pDiEu4xnbmgEJr+AsWeLIJorA4mxgzLma3/wJXqVOLpoamKmE4TrTcts6sZhnmhmah
         mfYPftTDhRymJXkTXT33v/+xgcLekea74Ow6B+n/icMLuWQxNVNbb8XLGXyKX3nHNs
         Jhp/XUCS3EgjRFDvHtDOTblZvFFbZsKbaFah+bDvDAfvFI0ZyJWKrOgaziAo/ueSXK
         tpOxzjUC05WxnGksJuxShHbR8LHoqyn5tzwEifcqjSTVn5byR/Eak6bNDcO84IHZHq
         YogI5FDvYZgLg==
From:   Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
Cc:     Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Fernanda Ma'rouf <fernandafmr2@gmail.com>
Subject: [PATCH nolibc v1] selftests/nolibc: Avoid generated files being committed
Date:   Tue, 19 Jul 2022 17:56:25 +0700
Message-Id: <20220719105625.251669-1-fernandafmr12@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After running the nolibc tests, the "git status" is not clean because
the generated files are not ignored. Create a `.gitignore` inside the
selftests/nolibc directory to ignore them.

Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Fernanda Ma'rouf <fernandafmr2@gmail.com>
Signed-off-by: Fernanda Ma'rouf <fernandafmr12@gnuweeb.org>
---
 tools/testing/selftests/nolibc/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/.gitignore

diff --git a/tools/testing/selftests/nolibc/.gitignore b/tools/testing/selftests/nolibc/.gitignore
new file mode 100644
index 000000000000..4696df589d68
--- /dev/null
+++ b/tools/testing/selftests/nolibc/.gitignore
@@ -0,0 +1,4 @@
+/initramfs/
+/nolibc-test
+/run.out
+/sysroot/

base-commit: 1e93ece89dd1c6217b92ef6fc100df9ba202c30c
-- 
Fernanda Ma'rouf

