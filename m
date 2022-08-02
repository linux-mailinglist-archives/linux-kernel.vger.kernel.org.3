Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC08587778
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiHBHGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiHBHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:06:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72AB1E1;
        Tue,  2 Aug 2022 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659423967; x=1690959967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jGI+QIBNsfuGN9appaI6ht1TfA1Oozu2Tl7H91y3oME=;
  b=Bi8J+LSwxTxjoldIPyOJZg4OeRYeL4Kt1AtI312O94NStgTnfEdoi2Oi
   GyoLEPCctFsk+lLt309Eh9p2EMyQz5aJQfTUP9WPT02ti79FvjXvv0v7o
   JhCWuryg+gZhpHKyvHnVj4GzqCotE5FFCzY4So//jpXb+0LzfYFMMAssi
   JRYrSgBghN6ySQXvP1hJ0vyFXTQ0Pc/anfs5y2IBFe71I+T32WIeKAreQ
   DD0pjb2PZlsPWIestTTdGRiSixQWlbK9aj2xBVkU1LbVoMhnMmMWC7WnN
   wDLruOAB22lYh1XYT+RBZAdjXjiYElVp2t3bXMpzihhXmWqoLRpz5nrGR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="107147668"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 00:06:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 2 Aug 2022 00:06:03 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 00:06:00 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH v2 1/3] spi: dt-binding: add Microchip CoreQSPI compatible
Date:   Tue, 2 Aug 2022 12:35:16 +0530
Message-ID: <20220802070518.855951-2-nagasuresh.relli@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
References: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Microchip CoreQSPI controller.

Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
---
 .../devicetree/bindings/spi/microchip,mpfs-spi.yaml  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index 7326c0a28d16..8d252eb8c460 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -14,9 +14,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - microchip,mpfs-spi
-      - microchip,mpfs-qspi
+    oneOf:
+      - description: Microchip's Polarfire SoC QSPI controller.
+        items:
+          - const: microchip,mpfs-qspi
+          - const: microchip,coreqspi-rtl-v2
+      - description: Microchip's fabric based QSPI IP core
+        const: microchip,coreqspi-rtl-v2
+      - description: Microchip's Polarfire SoC SPI controller.
+        const: microchip,mpfs-spi
 
   reg:
     maxItems: 1
-- 
2.25.1

