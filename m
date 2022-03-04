Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFB94CD8BE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiCDQNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbiCDQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:13:29 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B321959DF;
        Fri,  4 Mar 2022 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646410361; x=1677946361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ItwHa2LGg6vVjt4JwnVSxcBCS+3q6NmheNIr1H3INP4=;
  b=FqyacSBVeBCvFvgc1Cp6wOlWBZmgZgt6A06qLnjHDhlnC+Iv9Y8MbM2w
   YxpJEqq7St03un4dGKKALp4/dhgyyc6uGno0HPFRfx+aYO0X+2OAyVydl
   cOk3GAB30X20Vug4XfkLskgdcilBHMGCbn4bDVKbn/JosFD89IAeTXoLF
   CrY/mZ0laRRoBZkOghBjPImLd+bnxZeQXtuzvOIlZ5t000/Cpy1dlNbjE
   bh9mb6aWPe/of574qKCwgaD9uS2BiWkfAEuvJiN/IUoJMLDMS7YToQZbK
   pvbxWKGs1gf1b0HEFUYmXzVX0OJ7jbQy7PSZrHxl0dFHrHshzA4aGwuWe
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="150883336"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 09:12:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 09:12:36 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 09:12:32 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v4 4/4] dt-bindings: rtc: at91: Add SAMA7G5 compatible strings list
Date:   Fri, 4 Mar 2022 18:11:59 +0200
Message-ID: <20220304161159.147784-5-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304161159.147784-1-sergiu.moga@microchip.com>
References: <20220304161159.147784-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings list for SAMA7G5.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
index d2452067bfe4..e5c3c384e172 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
@@ -21,6 +21,10 @@ properties:
       - items:
           - const: microchip,sam9x60-rtt
           - const: atmel,at91sam9260-rtt
+      - items:
+          - const: microchip,sama7g5-rtt
+          - const: microchip,sam9x60-rtt
+          - const: atmel,at91sam9260-rtt
 
   reg:
     maxItems: 1
-- 
2.25.1

