Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF2542D7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiFHKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiFHKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:23:04 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0D921F66F6;
        Wed,  8 Jun 2022 03:12:24 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 7FBDC1C811B6;
        Wed,  8 Jun 2022 17:56:35 +0800 (CST)
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 8 Jun 2022
 17:56:35 +0800
Received: from taln60.nuvoton.com (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 8 Jun 2022 17:56:34 +0800
Received: by taln60.nuvoton.com (Postfix, from userid 10070)
        id 7542963A20; Wed,  8 Jun 2022 12:56:33 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <jirislaby@kernel.org>,
        <shawnguo@kernel.org>, <bjorn.andersson@linaro.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <vkoul@kernel.org>, <biju.das.jz@bp.renesas.com>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robert.hancock@calian.com>,
        <j.neuschaefer@gmx.net>, <lkundrak@v3.sk>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 12/20] dt-bindings: reset: npcm: Add support for NPCM8XX
Date:   Wed, 8 Jun 2022 12:56:15 +0300
Message-ID: <20220608095623.22327-13-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220608095623.22327-1-tmaimon77@gmail.com>
References: <20220608095623.22327-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document and device tree binding
constants for Nuvoton BMC NPCM8XX reset controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/reset/nuvoton,npcm-reset.yaml    |  13 +-
 .../dt-bindings/reset/nuvoton,npcm8xx-reset.h | 128 ++++++++++++++++++
 2 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/reset/nuvoton,npcm8xx-reset.h

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
index c6bbc1589ab9..93ea81686f58 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
@@ -9,9 +9,20 @@ title: Nuvoton NPCM Reset controller
 maintainers:
   - Tomer Maimon <tmaimon77@gmail.com>
 
+description: |
+  The NPCM reset controller used to reset various set of peripherals. 
+  Please refer to reset.txt in this directory for common reset
+  controller binding usage.
+
+  For list of all valid reset indices see
+    <dt-bindings/reset/nuvoton,npcm7xx-reset.h> for Poleg NPCM7XX SoC,
+    <dt-bindings/reset/nuvoton,npcm8xx-reset.h> for Arbel NPCM8XX SoC.
+
 properties:
   compatible:
-    const: nuvoton,npcm750-reset
+    enum: 
+      - nuvoton,npcm750-reset        # Poleg NPCM7XX SoC
+      - nuvoton,npcm845-reset        # Arbel NPCM8XX SoC
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
new file mode 100644
index 000000000000..5b3b74534b50
--- /dev/null
+++ b/include/dt-bindings/reset/nuvoton,npcm8xx-reset.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Nuvoton Technology corporation.
+ * Author: Tomer Maimon <tmaimon77@gmail.com>
+ */
+
+#ifndef _DT_BINDINGS_NPCM8XX_RESET_H
+#define _DT_BINDINGS_NPCM8XX_RESET_H
+
+/* represent reset register offset */
+#define NPCM8XX_RESET_IPSRST1		0x20
+#define NPCM8XX_RESET_IPSRST2		0x24
+#define NPCM8XX_RESET_IPSRST3		0x34
+#define NPCM8XX_RESET_IPSRST4		0x74
+
+/* Reset lines on IP1 reset module (NPCM8XX_RESET_IPSRST1) */
+#define NPCM8XX_RESET_GDMA0		3
+#define NPCM8XX_RESET_UDC1		5
+#define NPCM8XX_RESET_GMAC3		6
+#define NPCM8XX_RESET_UART_2_3		7
+#define NPCM8XX_RESET_UDC2		8
+#define NPCM8XX_RESET_PECI		9
+#define NPCM8XX_RESET_AES		10
+#define NPCM8XX_RESET_UART_0_1		11
+#define NPCM8XX_RESET_MC		12
+#define NPCM8XX_RESET_SMB2		13
+#define NPCM8XX_RESET_SMB3		14
+#define NPCM8XX_RESET_SMB4		15
+#define NPCM8XX_RESET_SMB5		16
+#define NPCM8XX_RESET_PWM_M0		18
+#define NPCM8XX_RESET_TIMER_0_4		19
+#define NPCM8XX_RESET_TIMER_5_9		20
+#define NPCM8XX_RESET_GMAC4		21
+#define NPCM8XX_RESET_UDC4		22
+#define NPCM8XX_RESET_UDC5		23
+#define NPCM8XX_RESET_UDC6		24
+#define NPCM8XX_RESET_UDC3		25
+#define NPCM8XX_RESET_ADC		27
+#define NPCM8XX_RESET_SMB6		28
+#define NPCM8XX_RESET_SMB7		29
+#define NPCM8XX_RESET_SMB0		30
+#define NPCM8XX_RESET_SMB1		31
+
+/* Reset lines on IP2 reset module (NPCM8XX_RESET_IPSRST2) */
+#define NPCM8XX_RESET_MFT0		0
+#define NPCM8XX_RESET_MFT1		1
+#define NPCM8XX_RESET_MFT2		2
+#define NPCM8XX_RESET_MFT3		3
+#define NPCM8XX_RESET_MFT4		4
+#define NPCM8XX_RESET_MFT5		5
+#define NPCM8XX_RESET_MFT6		6
+#define NPCM8XX_RESET_MFT7		7
+#define NPCM8XX_RESET_MMC		8
+#define NPCM8XX_RESET_GFX_SYS		10
+#define NPCM8XX_RESET_AHB_PCIBRG	11
+#define NPCM8XX_RESET_VDMA		12
+#define NPCM8XX_RESET_ECE		13
+#define NPCM8XX_RESET_VCD		14
+#define NPCM8XX_RESET_VIRUART1		16
+#define NPCM8XX_RESET_VIRUART2		17
+#define NPCM8XX_RESET_SIOX1		18
+#define NPCM8XX_RESET_SIOX2		19
+#define NPCM8XX_RESET_BT		20
+#define NPCM8XX_RESET_3DES		21
+#define NPCM8XX_RESET_PSPI2		23
+#define NPCM8XX_RESET_GMAC2		25
+#define NPCM8XX_RESET_USBH1		26
+#define NPCM8XX_RESET_GMAC1		28
+#define NPCM8XX_RESET_CP1		31
+
+/* Reset lines on IP3 reset module (NPCM8XX_RESET_IPSRST3) */
+#define NPCM8XX_RESET_PWM_M1		0
+#define NPCM8XX_RESET_SMB12		1
+#define NPCM8XX_RESET_SPIX		2
+#define NPCM8XX_RESET_SMB13		3
+#define NPCM8XX_RESET_UDC0		4
+#define NPCM8XX_RESET_UDC7		5
+#define NPCM8XX_RESET_UDC8		6
+#define NPCM8XX_RESET_UDC9		7
+#define NPCM8XX_RESET_USBHUB		8
+#define NPCM8XX_RESET_PCI_MAILBOX	9
+#define NPCM8XX_RESET_GDMA1		10
+#define NPCM8XX_RESET_GDMA2		11
+#define NPCM8XX_RESET_SMB14		12
+#define NPCM8XX_RESET_SHA		13
+#define NPCM8XX_RESET_SEC_ECC		14
+#define NPCM8XX_RESET_PCIE_RC		15
+#define NPCM8XX_RESET_TIMER_10_14	16
+#define NPCM8XX_RESET_RNG		17
+#define NPCM8XX_RESET_SMB15		18
+#define NPCM8XX_RESET_SMB8		19
+#define NPCM8XX_RESET_SMB9		20
+#define NPCM8XX_RESET_SMB10		21
+#define NPCM8XX_RESET_SMB11		22
+#define NPCM8XX_RESET_ESPI		23
+#define NPCM8XX_RESET_USB_PHY_1		24
+#define NPCM8XX_RESET_USB_PHY_2		25
+
+/* Reset lines on IP4 reset module (NPCM8XX_RESET_IPSRST4) */
+#define NPCM8XX_RESET_SMB16		0
+#define NPCM8XX_RESET_SMB17		1
+#define NPCM8XX_RESET_SMB18		2
+#define NPCM8XX_RESET_SMB19		3
+#define NPCM8XX_RESET_SMB20		4
+#define NPCM8XX_RESET_SMB21		5
+#define NPCM8XX_RESET_SMB22		6
+#define NPCM8XX_RESET_SMB23		7
+#define NPCM8XX_RESET_I3C0		8
+#define NPCM8XX_RESET_I3C1		9
+#define NPCM8XX_RESET_I3C2		10
+#define NPCM8XX_RESET_I3C3		11
+#define NPCM8XX_RESET_I3C4		12
+#define NPCM8XX_RESET_I3C5		13
+#define NPCM8XX_RESET_UART4		16
+#define NPCM8XX_RESET_UART5		17
+#define NPCM8XX_RESET_UART6		18
+#define NPCM8XX_RESET_PCIMBX2		19
+#define NPCM8XX_RESET_SMB24		22
+#define NPCM8XX_RESET_SMB25		23
+#define NPCM8XX_RESET_SMB26		24
+#define NPCM8XX_RESET_USBPHY3		25
+#define NPCM8XX_RESET_PCIRCPHY		27
+#define NPCM8XX_RESET_PWM_M2		28
+#define NPCM8XX_RESET_JTM1		29
+#define NPCM8XX_RESET_JTM2		30
+#define NPCM8XX_RESET_USBH2		31
+
+#endif
-- 
2.33.0

