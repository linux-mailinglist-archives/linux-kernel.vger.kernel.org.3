Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B41553041E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 17:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbiEVP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348972AbiEVP6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 11:58:03 -0400
Received: from herzl.nuvoton.co.il (unknown [212.199.177.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EF83B3F6;
        Sun, 22 May 2022 08:57:55 -0700 (PDT)
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 24MFp5Ms031636;
        Sun, 22 May 2022 18:51:05 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C53D563A4A; Sun, 22 May 2022 18:51:05 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 09/19] dt-bindings: reset: add syscon property
Date:   Sun, 22 May 2022 18:50:36 +0300
Message-Id: <20220522155046.260146-10-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220522155046.260146-1-tmaimon77@gmail.com>
References: <20220522155046.260146-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,KHOP_HELO_FCRDNS,NML_ADSP_CUSTOM_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe syscon property that handles GCR registers
in Nuvoton BMC NPCM reset driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
index 17b7a6a43a29..cb1613092ee7 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
+++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible : "nuvoton,npcm750-reset" for NPCM7XX BMC
 - reg : specifies physical base address and size of the register.
 - #reset-cells: must be set to 2
+- syscon: a phandle to access GCR registers.
 
 Optional property:
 - nuvoton,sw-reset-number - Contains the software reset number to restart the SoC.
@@ -16,6 +17,7 @@ Example:
 		compatible = "nuvoton,npcm750-reset";
 		reg = <0xf0801000 0x70>;
 		#reset-cells = <2>;
+		syscon = <&gcr>;
 		nuvoton,sw-reset-number = <2>;
 	};
 
-- 
2.33.0

