Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AC05A50B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiH2Pws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiH2Pwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:52:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3659568D;
        Mon, 29 Aug 2022 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661788366; x=1693324366;
  h=from:to:subject:date:message-id:mime-version;
  bh=g5yzd8L7II2JBpMtP7lLdPs2Abj6k2C6OVLZObBANPE=;
  b=xjC9vxcR1S8Wh5m6d7Mg7n9kDwWivHm3aXSL2mqe8vunwyJRGQl6E/bT
   z5CTLELEwIzF2P8UwXv+ROAuK0z9u+uwq6oqXNH+z2g+UkajzjCLdl1Uo
   CEDYz2QYfOrueQpZcYxNh1xRIXvN4z8itQXNhR4B+jOlrbiP0oDbbC215
   mkwPVSVZ1WrItaLkUKJGCNqfr/7kGO1wEnNFUMws4/3a7ELe/9vbIScKa
   ShLAwxznKjK7e2AWcm2Gv/bbiKNYPWgBuIhv/V4jWZY7iUwIJcxeNF5ck
   HRuWiX1EK/V5gkN/Oi4NYoe6BZqsZMbh2i0VB9dhFGIwCJRaLI7ijCOzL
   g==;
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="178166499"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2022 08:52:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 29 Aug 2022 08:52:44 -0700
Received: from AUS-LT-C33025.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 29 Aug 2022 08:52:42 -0700
From:   Jerry Ray <jerry.ray@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <MPUSWLinux@microchip.com>,
        Jerry Ray <jerry.ray@microchip.com>
Subject: [PATCH v3 1/2] dts: arm: Adding documentation for SAMA5D3-EDS board
Date:   Mon, 29 Aug 2022 10:52:40 -0500
Message-ID: <20220829155242.15685-1-jerry.ray@microchip.com>
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

