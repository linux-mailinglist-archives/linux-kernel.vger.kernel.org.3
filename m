Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3469559C5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 20:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiHVSNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 14:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiHVSNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 14:13:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7250C5FF2;
        Mon, 22 Aug 2022 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661191998; x=1692727998;
  h=from:to:subject:date:message-id:mime-version;
  bh=elWx/+2DVeMM0+Zevy+UZRjaSlHstH6Odf7Mh7lC6i8=;
  b=Xwnhp/EARcQHgDmiTxekDwC5Yl6Q5d72mNDqewoiz7GqGHtNdfzNsUYC
   3ybw4ZCz4nhJEq6RkmOY+c6/mmGQcNslNt1XSgaZfzX4GVxXZKFslKyOW
   rByxoiVjjPcU2kr/n65A/2v6pb6qBCA0odtJ5EBZHvpCqUFDC2qqVoDh+
   5KL0l7PniyuKcQUeJwguijm0EvyUDuYOSq+q0xwSsQ7BKwoCcqUyzwY5V
   9/wz+Jce9B8CmbZP2deJNIucC5u3Q6TPn41N9PQpavTPG1sjM5VN4pFlE
   zYuC82gk9nnvpjQ4WtOhlGPPGK1N9OuRFFwUikD0zruoAAeg03Iu3zeGa
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="173571097"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2022 11:13:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 22 Aug 2022 11:13:16 -0700
Received: from AUS-LT-C33025.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 22 Aug 2022 11:13:15 -0700
From:   Jerry Ray <jerry.ray@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Jerry Ray" <jerry.ray@microchip.com>
Subject: [linux][PATCH v2 1/2] dts: arm: Adding docs for SAMA5D3-EDS board
Date:   Mon, 22 Aug 2022 13:13:13 -0500
Message-ID: <20220822181314.8325-1-jerry.ray@microchip.com>
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
---
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

