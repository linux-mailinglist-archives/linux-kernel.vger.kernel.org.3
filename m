Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8C951FE9B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiEINpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiEINoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:44:54 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FEC2670A8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:40:33 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8886:2b92:63eb:2922])
        by laurent.telenet-ops.be with bizsmtp
        id UdgX2700W0moLbn01dgX70; Mon, 09 May 2022 15:40:32 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1no3cl-003XlI-El; Mon, 09 May 2022 15:40:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1no3ck-003LGQ-TH; Mon, 09 May 2022 15:40:30 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] arm64: ARM Scalable Matrix Extension is ARMv9-A
Date:   Mon,  9 May 2022 15:40:30 +0200
Message-Id: <df002b0ff3cb89954d5a2c39a5dd8528d45771f3.1652103603.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The help text for the config option to enable support for the ARM
Scalable Matrix Extension does not mention the specification baseline
for this extension.  Make it clear this is an extension for the ARMv9-A
architecture, so users know when it is safe to disable this option,
which is enabled by default.

Fixes: a1f4ccd25cc25625 ("arm64/sme: Provide Kconfig for SME")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0e9bbeb1262d0ca8..f3a0d0cff3fb5265 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1964,9 +1964,9 @@ config ARM64_SME
 	default y
 	depends on ARM64_SVE
 	help
-	  The Scalable Matrix Extension (SME) is an extension to the AArch64
-	  execution state which utilises a substantial subset of the SVE
-	  instruction set, together with the addition of new architectural
+	  The Scalable Matrix Extension (SME) is an ARMv9-A extension to the
+	  AArch64 execution state which utilises a substantial subset of the
+	  SVE instruction set, together with the addition of new architectural
 	  register state capable of holding two dimensional matrix tiles to
 	  enable various matrix operations.
 
-- 
2.25.1

