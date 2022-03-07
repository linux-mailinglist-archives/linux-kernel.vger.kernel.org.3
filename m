Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B465D4D0320
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbiCGPmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiCGPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:42:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504F73076;
        Mon,  7 Mar 2022 07:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646667686; x=1678203686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XlQwsZSDIaDfWV/087cdbqswb5XX5+Ou9ZV0yaZmxrE=;
  b=UGBYK5svF3juTh1kCxlXM2GkpmbRt4hnsFKtsk3Y3k5OD3JdhPKO1yA0
   Ywn+QKRAlU475INVtJAD4ZNU0LasuvFsJZNbCgmUHsdwPuUe0mDtkbdQA
   uvkQ/hfFFOej12EY3qAxI8FS+yJQnGpltBJaW89zItrmzQM4flP4QpoR6
   rC0gKhE6Ihcf0hqv1vPjyVq+8+YyzUEh6V2NI5TfsEB5euCa5SLQh/NT8
   VaXgULSMuh2o/a3il/6nlzT9Gg1LHP1TNBjHk45NN9NVJ3YDViMSF7TqR
   0rNb63r0YZDyeq6IwSRmt+QDOglIwClIolI2Hq68mGdUiROw6kfwr2xfk
   A==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="155514444"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 08:41:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 08:41:23 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 08:41:19 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <claudiu.beznea@microchip.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v3 2/2] dt-bindings: pwm: at91: Add SAMA7G5 compatible strings list
Date:   Mon, 7 Mar 2022 17:36:56 +0200
Message-ID: <20220307153656.177589-3-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307153656.177589-1-sergiu.moga@microchip.com>
References: <20220307153656.177589-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../bindings/pwm/atmel,at91sam-pwm.yaml           | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
index 5e8bb5a8095d..ab45df80345d 100644
--- a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
@@ -15,11 +15,16 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - atmel,at91sam9rl-pwm
-      - atmel,sama5d3-pwm
-      - atmel,sama5d2-pwm
-      - microchip,sam9x60-pwm
+    oneOf:
+      - items:
+          - enum:
+              - atmel,at91sam9rl-pwm
+              - atmel,sama5d3-pwm
+              - atmel,sama5d2-pwm
+              - microchip,sam9x60-pwm
+      - items:
+          - const: microchip,sama7g5-pwm
+          - const: atmel,sama5d2-pwm
 
   reg:
     maxItems: 1
-- 
2.25.1

