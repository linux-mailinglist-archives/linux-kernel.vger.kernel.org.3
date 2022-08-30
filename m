Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5C45A674C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiH3PYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiH3PYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:24:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B20B6D7D;
        Tue, 30 Aug 2022 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661873073; x=1693409073;
  h=from:to:subject:date:message-id:mime-version;
  bh=WIYMYXNuQxtPPXy3sID+B0KJkT+rhekTnPMM/ei80Jo=;
  b=YQtg2rtfYkkdBfxtUH8RcgCtI/myp6wKwqdPrwZorBfUXdhqNEHGqt3p
   0xZXw31itfVPhb4syTSTd43f22UkYXVInW32DUOtkofB7r6tKf2IdZhK3
   RIskLBNRCKRchhydd5TXs9q78V85c4MAKy8AmbUukysoDnvLtdkCVx2b5
   sts3QESL5CgVFj0BTSBJJa+talDFiZkRQxqRZYcV8M4GUGRYtq7/FUndf
   45bmEE3btqSg3n7Jpnp4eJWB0+ShUXgdT7x0XNVDVaw2HIjWIuhkZuFOo
   C4feUc4MrIsup1l6kE31F/53eokpdDQiRCnSo8KM4YIbPmtbHeauZJUHJ
   A==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="111411586"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 08:24:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 08:24:30 -0700
Received: from AUS-LT-C33025.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 08:24:29 -0700
From:   Jerry Ray <jerry.ray@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Jerry Ray" <jerry.ray@microchip.com>
Subject: [PATCH v5 1/2] dts: arm: Adding documentation for SAMA5D3-EDS board
Date:   Tue, 30 Aug 2022 10:24:27 -0500
Message-ID: <20220830152428.12625-1-jerry.ray@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

Adding the SAMA5D3-EDS board from Microchip into the atmel AT91 board
description yaml file.

Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v4->v5:
 - No change
v3->v4:
 - No change
v2->v3:
 - No change
v1->v2:
 - Added Device Tree documentation for Microchip SAMA5D3-EDS board
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 08efb259a947..635491aaeb0c 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -138,6 +138,13 @@ properties:
           - const: atmel,at91sam9g20
           - const: atmel,at91sam9
 
+      - description: Microchip SAMA5D3 Ethernet Development System Board
+        items:
+          - const: microchip,sama5d3-eds
+          - const: atmel,sama5d36
+          - const: atmel,sama5d3
+          - const: atmel,sama5
+
       - items:
           - enum:
               - atmel,sama5d31
-- 
2.17.1

