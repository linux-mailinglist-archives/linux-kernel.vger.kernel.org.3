Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500175A9914
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiIANhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiIANg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:36:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4997419023;
        Thu,  1 Sep 2022 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662039304; x=1693575304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VqcEjdujxakv3noDHpoHtBuaB79FIa784j+2h1ikqjc=;
  b=BmmcXWZjWioUwkmMuHuNKBb5Bi4qU98/Ann4Td/O4zwABatdc7V0+1ne
   PozXt7oXt91ZYXgAltk5C/nPlrszwFhqTZmlTmpwxMlrwBIlF07XHJr3V
   Rsy46vxM5DvthOctmFF1WaJkqHSJYrNQNo/hmaYvhOLfjjpOqvCF4Vzam
   xj7nTTBuCBKWOXGdfWox8Jt9tQLWG5wLwQ7ZiSVAitAf6wedHLkpTX0SH
   jx7VqgZ0r0hKTawVHZPY+T3IDzpPQDOEaS+JMVr4rxikqD6+MH6yIVKd0
   xmuXKXGxwMoMtBN0kaBTc1neTLG+YQyVV8BvLdZuKUzZekfFz4t/kR0eJ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="175197600"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 06:34:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 06:34:54 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Sep 2022 06:34:51 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/9] dt-bindings: riscv: microchip: document the sev kit
Date:   Thu, 1 Sep 2022 14:33:58 +0100
Message-ID: <20220901133403.3392291-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901133403.3392291-1-conor.dooley@microchip.com>
References: <20220901133403.3392291-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shravan Chippa <shravan.chippa@microchip.com>

Update devicetree bindings document with PolarFire SoC Video Kit, known
by its "sev-kit" product code.

Link: https://onlinedocs.microchip.com/pr/GUID-404D3738-DC76-46BA-8683-6A77E837C2DD-en-US-1/index.html?GUID-065AEBEE-7B2C-4895-8579-B1D73D797F06
Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 630f82c85a0c..ab0a64cd5386 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -28,6 +28,7 @@ properties:
       - items:
           - enum:
               - aries,m100pfsevp
+              - microchip,mpfs-sev-kit
               - sundance,polarberry
           - const: microchip,mpfs
 
-- 
2.36.1

