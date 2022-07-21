Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC65B57C8C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiGUKQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiGUKQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:16:04 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 118F729CB6;
        Thu, 21 Jul 2022 03:16:04 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 83EF91C80467;
        Thu, 21 Jul 2022 18:16:03 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 21
 Jul 2022 18:16:03 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 21 Jul
 2022 18:16:03 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 21 Jul 2022 18:16:02 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 303F863A23; Thu, 21 Jul 2022 13:16:02 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible
Date:   Thu, 21 Jul 2022 13:15:56 +0300
Message-ID: <20220721101556.118568-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220721101556.118568-1-tmaimon77@gmail.com>
References: <20220721101556.118568-1-tmaimon77@gmail.com>
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

Add a compatible string for Nuvoton BMC NPCM845 PSPI.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
index b98203ca656d..a4e72e52af59 100644
--- a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
@@ -3,7 +3,8 @@ Nuvoton NPCM Peripheral Serial Peripheral Interface(PSPI) controller driver
 Nuvoton NPCM7xx SOC support two PSPI channels.
 
 Required properties:
- - compatible : "nuvoton,npcm750-pspi" for NPCM7XX BMC
+ - compatible : "nuvoton,npcm750-pspi" for Poleg NPCM7XX.
+				"nuvoton,npcm845-pspi" for Arbel NPCM8XX.
  - #address-cells : should be 1. see spi-bus.txt
  - #size-cells : should be 0. see spi-bus.txt
  - specifies physical base address and size of the register.
-- 
2.33.0

