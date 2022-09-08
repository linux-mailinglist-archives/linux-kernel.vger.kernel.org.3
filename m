Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7F5B1B24
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiIHLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIHLSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:18:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98585F56CC;
        Thu,  8 Sep 2022 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662635882; x=1694171882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmjzFPLTzirPRRdjytSXcGvB/NkyTEAOoOOffWQqE6s=;
  b=RP/HjZOXROziM8j2qk6Ax9+pZxhKasbsRhuy+47U1cm8NS5h7ZYQAi4D
   LP/A97hudfHWj2/qW5RCKn3bMlYij6ZbPQSsVLTsSM4asMsI6TJIjF0Ci
   lhky94PaZOxCSgENm5M9twINylNP1lRrnV+DUcZ1cyG6J0jQn3J8LmCUq
   xgUCNog4WAk8XV3VzkSOXUENSxE2wyTdaLYco2yYrZaWH594ikAyKZn3g
   oRm7vpzLvVJ/eEvoHiCHxIL794scidS6SpVUYOdGgobNMRGHlt+cC1iR7
   9iN3OaSrbU3GKFH2HTFkqzQTKcSrgLdO160ouBHgX7wkQBmxUhD7MnNtP
   w==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="112724601"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 04:18:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 04:18:01 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 04:17:58 -0700
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
Subject: [PATCH v4 01/10] dt-bindings: riscv: microchip: document icicle reference design
Date:   Thu, 8 Sep 2022 12:17:04 +0100
Message-ID: <20220908111712.665287-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220908111712.665287-1-conor.dooley@microchip.com>
References: <20220908111712.665287-1-conor.dooley@microchip.com>
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

The icicle kit reference design's v2022.09 release,made some changes
to the memory map - including adding the ability to read the fabric
clock controllers via the system controller bus & making the PCI
controller work with upstream Linux.

While the PCI was not working in the v2022.03 design, so nothing is
broken there in terms of backwards compatibility, the fabric clocks
used in the v2022.03 design were chosen by the individual run of the
synthesis tool. In the v2022.09 reference design, the clocks are fixed
to use the "north west" fabric Clock Conditioning Circuitry.

Make use of a new compatible to denote that this is not backwards
compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/riscv/microchip.yaml   | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 1aa7336a9672..485981fbfb4b 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -17,12 +17,18 @@ properties:
   $nodename:
     const: '/'
   compatible:
-    items:
-      - enum:
-          - microchip,mpfs-icicle-kit
-          - microchip,mpfs-icicle-reference-rtlv2203
-          - sundance,polarberry
-      - const: microchip,mpfs
+    oneOf:
+      - items:
+          - enum:
+              - microchip,mpfs-icicle-reference-rtlv2203
+              - microchip,mpfs-icicle-reference-rtlv2209
+          - const: microchip,mpfs-icicle-kit
+          - const: microchip,mpfs
+
+      - items:
+          - enum:
+              - sundance,polarberry
+          - const: microchip,mpfs
 
 additionalProperties: true
 
-- 
2.36.1

