Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65855577D41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiGRIMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiGRIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:12:42 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D7D5186D0;
        Mon, 18 Jul 2022 01:12:40 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id CCEF51C811BF;
        Mon, 18 Jul 2022 16:12:39 +0800 (CST)
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 18
 Jul 2022 16:12:39 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 18 Jul
 2022 16:12:39 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 18 Jul 2022 16:12:39 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 7522263A20; Mon, 18 Jul 2022 11:12:38 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/3] dt-binding: spi: Add npcm845 compatible to npcm-fiu document
Date:   Mon, 18 Jul 2022 11:11:45 +0300
Message-ID: <20220718081146.256070-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220718081146.256070-1-tmaimon77@gmail.com>
References: <20220718081146.256070-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string and description for Nuvoton BMC NPCM845 FIU.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/spi/nuvoton,npcm-fiu.txt    | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
index a388005842ad..c63ce4cc0a80 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
@@ -6,8 +6,13 @@ The NPCM7XX supports three FIU modules,
 FIU0 and FIUx supports two chip selects,
 FIU3 support four chip select.
 
+The NPCM8XX supports four FIU modules,
+FIU0 and FIUx supports two chip selects,
+FIU1 and FIU3 supports four chip selects.
+
 Required properties:
-  - compatible : "nuvoton,npcm750-fiu" for the NPCM7XX BMC
+  - compatible : "nuvoton,npcm750-fiu" for Poleg NPCM7XX BMC
+			     "nuvoton,npcm845-fiu" for Arbel NPCM8XX BMC
   - #address-cells : should be 1.
   - #size-cells : should be 0.
   - reg : the first contains the register location and length,
@@ -30,6 +35,12 @@ Aliases:
   		fiu1 represent fiu 3 controller
   		fiu2 represent fiu x controller
 
+  In the NPCM8XX BMC:
+  		fiu0 represent fiu 0 controller
+  		fiu1 represent fiu 1 controller
+  		fiu2 represent fiu 3 controller
+  		fiu3 represent fiu x controller
+
 Example:
 fiu3: spi@c00000000 {
 	compatible = "nuvoton,npcm750-fiu";
-- 
2.33.0

