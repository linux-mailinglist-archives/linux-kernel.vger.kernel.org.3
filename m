Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE259CC08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiHVXSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHVXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:18:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF25B101D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DB072CE17B5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04F0C433C1;
        Mon, 22 Aug 2022 23:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661210291;
        bh=p2jVqFX8K2UVaGZve9czBNa9bn69C5yS4yarQ+BR9aA=;
        h=From:To:Cc:Subject:Date:From;
        b=i4rOcaC6Ap5/eZ54afL61CtYVgPcwNDCfJGDge1Tcai90ChOXS8fo9p5GtnmB1JE6
         /p0esLl/qCM7rL8RPNTHgfm4CF6NTgNFPi8F+yBHT66jWl14Um6MvUcE7mSV78s7mA
         Dn7aWKseCvybx8Nd9Hocl+4ZjnTT7sMX1I/IU5HRInW5mRAUdrvY+Tx9BAGWhqegvX
         7Y7Q4l4lG/oOeuNgdcuFToKguFHOafDp77NGCR1exB+Hq54Fx3ZGrGLCHNfzY0Q7NK
         kZTVXUar3ekP/9a5QAzivkaHJVopP9j3+i39/MtQUeixYXkw8ep/NPU/eTz+NId4Lq
         cMfgPYT8RWIJA==
Received: by pali.im (Postfix)
        id 32F3997B; Tue, 23 Aug 2022 01:18:08 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gabriel Paubert <paubert@iram.es>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Child <nick.child@ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: udbg: Remove extern function prototypes
Date:   Tue, 23 Aug 2022 01:17:51 +0200
Message-Id: <20220822231751.16973-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'extern' keywork is pointless and deprecated for function prototypes.

Signed-off-by: Pali Rohár <pali@kernel.org>
Suggested-by: Gabriel Paubert <paubert@iram.es>
---
Depends on patch:
https://lore.kernel.org/linuxppc-dev/20220819211254.22192-1-pali@kernel.org/
---
 arch/powerpc/include/asm/udbg.h | 56 ++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index 20b5a37ab772..2d74b264b326 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -15,13 +15,13 @@ extern void (*udbg_flush)(void);
 extern int (*udbg_getc)(void);
 extern int (*udbg_getc_poll)(void);
 
-extern void udbg_puts(const char *s);
-extern int udbg_write(const char *s, int n);
+void udbg_puts(const char *s);
+int udbg_write(const char *s, int n);
 
-extern void register_early_udbg_console(void);
-extern void udbg_printf(const char *fmt, ...)
+void register_early_udbg_console(void);
+void udbg_printf(const char *fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
-extern void udbg_progress(char *s, unsigned short hex);
+void udbg_progress(char *s, unsigned short hex);
 
 void __init udbg_uart_init_mmio(void __iomem *addr, unsigned int stride);
 void __init udbg_uart_init_pio(unsigned long port, unsigned int stride);
@@ -31,29 +31,29 @@ unsigned int __init udbg_probe_uart_speed(unsigned int clock);
 
 struct device_node;
 void __init udbg_scc_init(int force_scc);
-extern int udbg_adb_init(int force_btext);
-extern void udbg_adb_init_early(void);
-
-extern void __init udbg_early_init(void);
-extern void __init udbg_init_debug_lpar(void);
-extern void __init udbg_init_debug_lpar_hvsi(void);
-extern void __init udbg_init_pmac_realmode(void);
-extern void __init udbg_init_maple_realmode(void);
-extern void __init udbg_init_pas_realmode(void);
-extern void __init udbg_init_rtas_panel(void);
-extern void __init udbg_init_rtas_console(void);
-extern void __init udbg_init_debug_beat(void);
-extern void __init udbg_init_btext(void);
-extern void __init udbg_init_44x_as1(void);
-extern void __init udbg_init_40x_realmode(void);
-extern void __init udbg_init_cpm(void);
-extern void __init udbg_init_usbgecko(void);
-extern void __init udbg_init_memcons(void);
-extern void __init udbg_init_ehv_bc(void);
-extern void __init udbg_init_ps3gelic(void);
-extern void __init udbg_init_debug_opal_raw(void);
-extern void __init udbg_init_debug_opal_hvsi(void);
-extern void __init udbg_init_debug_16550(void);
+int udbg_adb_init(int force_btext);
+void udbg_adb_init_early(void);
+
+void __init udbg_early_init(void);
+void __init udbg_init_debug_lpar(void);
+void __init udbg_init_debug_lpar_hvsi(void);
+void __init udbg_init_pmac_realmode(void);
+void __init udbg_init_maple_realmode(void);
+void __init udbg_init_pas_realmode(void);
+void __init udbg_init_rtas_panel(void);
+void __init udbg_init_rtas_console(void);
+void __init udbg_init_debug_beat(void);
+void __init udbg_init_btext(void);
+void __init udbg_init_44x_as1(void);
+void __init udbg_init_40x_realmode(void);
+void __init udbg_init_cpm(void);
+void __init udbg_init_usbgecko(void);
+void __init udbg_init_memcons(void);
+void __init udbg_init_ehv_bc(void);
+void __init udbg_init_ps3gelic(void);
+void __init udbg_init_debug_opal_raw(void);
+void __init udbg_init_debug_opal_hvsi(void);
+void __init udbg_init_debug_16550(void);
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_UDBG_H */
-- 
2.20.1

