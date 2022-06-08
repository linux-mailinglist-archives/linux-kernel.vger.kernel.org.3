Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A080F542D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiFHKZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiFHKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:23:02 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FD1B1F5C4F;
        Wed,  8 Jun 2022 03:12:10 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 634EC1C811B4;
        Wed,  8 Jun 2022 17:56:35 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 8 Jun 2022
 17:56:35 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 8 Jun 2022
 17:56:35 +0800
Received: from taln60.nuvoton.com (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 8 Jun 2022 17:56:34 +0800
Received: by taln60.nuvoton.com (Postfix, from userid 10070)
        id 4DE3563A17; Wed,  8 Jun 2022 12:56:33 +0300 (IDT)
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
Subject: [PATCH v2 09/20] dt-bindings: reset: npcm: add GCR syscon property
Date:   Wed, 8 Jun 2022 12:56:12 +0300
Message-ID: <20220608095623.22327-10-tmaimon77@gmail.com>
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

Describe syscon property that handles general
control registers(GCR) in Nuvoton BMC NPCM
reset driver.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/reset/nuvoton,npcm-reset.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
index 0998f481578d..c6bbc1589ab9 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/nuvoton,npcm-reset.yaml
@@ -19,6 +19,10 @@ properties:
   '#reset-cells':
     const: 2
 
+  nuvoton,sysgcr:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: a phandle to access GCR registers.
+
   nuvoton,sw-reset-number:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1
@@ -31,6 +35,7 @@ required:
   - compatible
   - reg
   - '#reset-cells'
+  - nuvoton,sysgcr
 
 additionalProperties: false
 
@@ -41,6 +46,7 @@ examples:
         compatible = "nuvoton,npcm750-reset";
         reg = <0xf0801000 0x70>;
         #reset-cells = <2>;
+        nuvoton,sysgcr = <&gcr>;
         nuvoton,sw-reset-number = <2>;
     };
 
-- 
2.33.0

