Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99A95B1B29
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiIHLSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiIHLSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:18:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8FEFCA13;
        Thu,  8 Sep 2022 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662635885; x=1694171885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gHwrhdKNh2gRti7y/1xovElw2DRB4M7uCFirk9to6l4=;
  b=cuwOcCGj12/rnQILGyOlmXN3QfsPhzKjwCEbEhdnapCfYqutoeaWQ7DA
   Gx75jPOTE+bGTbLw8m+UqMLNoSMgoS23nLnVljseoSWo8F4KixDCsQ0m/
   /L5p6SkGpnS5bmjCz+KjCGMiYHRA18H7+jWSS4SsEEGCiOWlb6AhFYj1g
   9M13NWGk5itE/d1UB71TSXxc356DLuvEVtD7iNVjRpob51XqUxuFo26Kr
   8RvdGPWdjiRT2dmzA5cbfuJxnaAS0Nqgbw6WAaB7HUhzZARESRm/olT1q
   Wdki2yjqdnJeraXFXPlGW5n+xGbr3UZbXdUm9ZikvsCLzIspXu2qsk2pv
   w==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="179549600"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 04:18:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 04:18:04 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 04:18:01 -0700
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
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 02/10] dt-bindings: riscv: microchip: document the aries m100pfsevp
Date:   Thu, 8 Sep 2022 12:17:05 +0100
Message-ID: <20220908111712.665287-3-conor.dooley@microchip.com>
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

Add a compatible for the Aries Embedded M100PFSEVP SOM + EVK platform.

Link: https://www.aries-embedded.com/polarfire-soc-fpga-microsemi-m100pfs-som-mpfs025t-pcie-serdes
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 485981fbfb4b..630f82c85a0c 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -27,6 +27,7 @@ properties:
 
       - items:
           - enum:
+              - aries,m100pfsevp
               - sundance,polarberry
           - const: microchip,mpfs
 
-- 
2.36.1

