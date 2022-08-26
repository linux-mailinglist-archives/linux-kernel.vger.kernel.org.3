Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7755A2982
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344242AbiHZO3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiHZO2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:28:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B06A2202;
        Fri, 26 Aug 2022 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661524131; x=1693060131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dymLK74hLsKZYKnCiDdXxOUqxIzAIxjPdTu2h4+/Loo=;
  b=Jt+iAQ7wrb+xT+DXY9kzFcnBIdktVeFRbho/WGFz65qQ3nzQ8lXD/9Xa
   HUj+6FjG5Wzp6RlouIdwEVqK0iJqRBRt/rvFDFP7YT3pEjhjJlu+7EZw6
   W0fMcRx3izu1ORkUqO34676cbDf/TkcLNK2TJGQPIHM35HrCnpCp+t5bR
   spJ/+zrUHYA8Bi5x1zAHG2BGdtCI4mWx0iinMVBuF84YgMf7iyFk5dQbj
   Rx3Q86APHLtXiG1SI4Ybuo3j/s3vA6SB1FuKjVaEUMsg9/JlCPDa7MPK2
   vMA3sAyRqi2gAGmCY/qfSzJCTVgr7irjlTA2JjfPHv+eRGSXg5eOgbJEs
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="171133588"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 07:28:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 07:28:50 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 26 Aug 2022 07:28:47 -0700
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
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/9] dt-bindings: riscv: microchip: document the sev kit
Date:   Fri, 26 Aug 2022 15:28:01 +0100
Message-ID: <20220826142806.3658434-4-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826142806.3658434-1-conor.dooley@microchip.com>
References: <20220826142806.3658434-1-conor.dooley@microchip.com>
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
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 04ebd48caaa7..f8b9a3288437 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -29,10 +29,10 @@ properties:
           - enum:
               - aries,m100pfsevp-emmc
               - aries,m100pfsevp-sdcard
+              - microchip,mpfs-sev-kit
               - sundance,polarberry
           - const: microchip,mpfs
 
-
 additionalProperties: true
 
 ...
-- 
2.36.1

