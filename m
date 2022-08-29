Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A720E5A51F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiH2Qhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH2Qhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:37:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F64E28E1D;
        Mon, 29 Aug 2022 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661791051; x=1693327051;
  h=from:to:subject:date:message-id:mime-version;
  bh=A1VEmne0snHaGjKcfU7tUe6o4yAShx73DU0pV+pnCYY=;
  b=fb6R02Y4gN5ieJt6vPAWVNiMzqPd86ZaS4hQaDniwCuJUbtyUkVFEScd
   I3QgLnjjmnwYK6YhvcJs4jgEsNEuFh2I9IZJ/UB0+PqppGlDOXuo5OIyV
   UnAuJ25wdlZG9tW5lwng8cr+qDksQt0vQ3qwDrvwcW97Sq1hkkAyOOCEs
   nUP2RStNdVv9repbYRzF1wwD/Bl9d6FV5l9dB6NAG7/sO62O0I1tyRCRs
   aaN13Rlt2wzn3xxAhOQsiQQGHkDTVs3AgFy5F+V3Pavp9orIknrFlSnvv
   4U7new2omEsBL0HQElWbMuecJE/C9PlwyhMGd6c9Zfc7l9CG6rcIRP0sl
   g==;
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="178174174"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2022 09:37:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 29 Aug 2022 09:37:29 -0700
Received: from AUS-LT-C33025.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 29 Aug 2022 09:37:28 -0700
From:   Jerry Ray <jerry.ray@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <MPUSWLinux@microchip.com>,
        Jerry Ray <jerry.ray@microchip.com>
Subject: [PATCH v4 1/2] dts: arm: Adding documentation for SAMA5D3-EDS board
Date:   Mon, 29 Aug 2022 11:37:26 -0500
Message-ID: <20220829163727.29841-1-jerry.ray@microchip.com>
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

