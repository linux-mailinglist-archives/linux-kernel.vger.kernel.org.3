Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF5F5866FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiHAJnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiHAJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:43:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA837F85;
        Mon,  1 Aug 2022 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659346984; x=1690882984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jPP0FujwLYnAYrihc+uhw2BRMxj5SwDhF+o0kLMUhrI=;
  b=lF93pgu7vtyISF/I0m/wluNeptxMnoVSB7JOz0AXUXw4XwlsDAjJia94
   QlDO0855FJ5AmrPvzLn+WIqvFULHQ7Ym/7F+JBV2wKXiXwSkahAaSvNbl
   wahUlEqcEQGX3XKgwOyONxKQg+2W5tWNOfNfoC8K2WAQeIi33v+Hkoy0l
   cLwdJD+Yf3v9Ecf/TCHoDqw5hSUQMdPqdTwREvlG2E/lD2XtXBwsK6IRN
   PD1d1Syl6qB0Ao6w19cAAKkOpH4l8IzYguf1n24OLfm0uEmkXaFn39YE2
   cm91qc2Tfdo7oK5K+eSNog8GvvdOXxrbqdg630mApzfgFn9YExzxwCv1I
   A==;
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="174561387"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2022 02:43:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 02:43:03 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 02:43:00 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Date:   Mon, 1 Aug 2022 15:12:54 +0530
Message-ID: <20220801094255.664548-2-nagasuresh.relli@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
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
 .../devicetree/bindings/spi/microchip,mpfs-spi.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index 7326c0a28d16..b65f4e070796 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -14,9 +14,13 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - microchip,mpfs-spi
-      - microchip,mpfs-qspi
+    oneOf:
+      - description: Microchip's Polarfire SoC SPI controller.
+        const: microchip,mpfs-spi
+      - description: Microchip's Polarfire SoC QSPI controller.
+        const: microchip,mpfs-qspi
+      - description: Microchip's FPGA QSPI controller.
+        const: microchip,coreqspi-rtl-v2
 
   reg:
     maxItems: 1
-- 
2.25.1

