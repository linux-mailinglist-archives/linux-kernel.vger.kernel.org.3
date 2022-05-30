Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF00A53789C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbiE3KB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiE3KBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:01:21 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ECE7A445;
        Mon, 30 May 2022 03:01:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24UA19MO033207;
        Mon, 30 May 2022 05:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653904869;
        bh=7E8s2ZHwIhWZcauts4q3RWXr9HNIpWODBDLazgEK04g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oLc+2RWl95Xs1ZgKho9XdUAQz/RsKRnxKbQGBq+3c3mrRGOlzY4u9Qz18CqFWvJKb
         3SdNz9NnG7MySyDDUjgIH911bkkfImN7O8vnByLtVtDqs/hpi8JimaA/41xYo9xhab
         Cf+G9IPqhuvpTuUuBjZ1HNThmGo/8x3sKXRB7b9o=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24UA19g3052555
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 May 2022 05:01:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 30
 May 2022 05:01:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 30 May 2022 05:01:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24UA17Ij122212;
        Mon, 30 May 2022 05:01:08 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v3 1/3] dt-bindings: mfd: ti,j721e-system-controller: Add clock property
Date:   Mon, 30 May 2022 15:30:58 +0530
Message-ID: <20220530100100.10420-2-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220530100100.10420-1-r-ravikumar@ti.com>
References: <20220530100100.10420-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pattern property for clock-controller, also update the example
with a clock-controller node

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 .../bindings/mfd/ti,j721e-system-controller.yaml     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
index fa86691ebf16..701931996dc2 100644
--- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
@@ -48,6 +48,12 @@ patternProperties:
     description:
       This is the SERDES lane control mux.
 
+  "^clock-controller@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/clock/ti,am654-ehrpwm-tbclk.yaml#
+    description:
+      Clock provider for TI EHRPWM nodes.
+
 required:
   - compatible
   - reg
@@ -79,5 +85,11 @@ examples:
                 <0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
                 /* SERDES4 lane0/1/2/3 select */
         };
+
+        clock@4140 {
+            compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+            reg = <0x4140 0x18>;
+            #clock-cells = <1>;
+        };
     };
 ...
-- 
2.17.1

