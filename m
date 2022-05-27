Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E366535BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349958AbiE0IjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349891AbiE0Ih7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:37:59 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2FA1078BC;
        Fri, 27 May 2022 01:36:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24R8amxv025473;
        Fri, 27 May 2022 03:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653640608;
        bh=j3g2qof5jQ7uAXfAUoi+PBASzboPSxW3V7N2l+lUYjw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zG28+Vpm9Qruu52yW1WC5V+U4Oujy1ML3Ngj2DJicdzuIWLb3dhcum3KWNUYMSC74
         npF5pTWqNuLojmvNEWNq603r4jXQHGZy58OtVW8yZMeZ4GS5wq5rIYcGwGWbjSazm2
         zQe6X3V7d6fWE8LTFE9XPDpoO1gEz/zqVcVa1ioE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24R8amn1091522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 May 2022 03:36:48 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 27
 May 2022 03:36:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 27 May 2022 03:36:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24R8akLg027352;
        Fri, 27 May 2022 03:36:47 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH 1/3] dt-bindings: mfd: ti,j721e-system-controller: Add clock property
Date:   Fri, 27 May 2022 14:05:54 +0530
Message-ID: <20220527083556.18864-2-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220527083556.18864-1-r-ravikumar@ti.com>
References: <20220527083556.18864-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pattern property for clock, also update the example with
a clock node

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 .../bindings/mfd/ti,j721e-system-controller.yaml     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index fa86691ebf16..e774a7f0bb08 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -48,6 +48,12 @@ patternProperties:
     description:
       This is the SERDES lane control mux.
 
+  "^clock@[0-9a-f]+$":
+    type: object
+    $ref: ../clock/ti,am654-ehrpwm-tbclk.yaml#
+    description:
+      This is TI syscon gate clk.
+
 required:
   - compatible
   - reg
@@ -79,5 +85,11 @@ examples:
                 <0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
                 /* SERDES4 lane0/1/2/3 select */
         };
+
+        ehrpwm_tbclk: clock@4140 {
+                compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+                reg = <0x4140 0x18>;
+                #clock-cells = <1>;
+        };
     };
 ...
-- 
2.17.1

