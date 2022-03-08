Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9D4D1E80
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348453AbiCHRT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348784AbiCHRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:19:07 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39D938186;
        Tue,  8 Mar 2022 09:18:08 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228FxhGc010224;
        Tue, 8 Mar 2022 11:17:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=fZnbEi3pbb9N3DLApUDIz41sBK2iZT83PUC2XBQ5GYs=;
 b=l6UuwKBW/+8HF4nlXofg1aJNLsnQApu6rO5GtiTbQyDVfr8vBPJthsXVs40s3bQL8R1D
 Dr2Te0kSnwgqNP9jaIAHsJQX1IjsR/NRgAqGjFUuGvgPVYrsoYIzsXWdWpUZeO3+emS7
 SA24kpgdruFGPOg3sFNH4vkc6LSyW2Cl4o+O5h6xbbPWDL/LC4mgV0y8reKCTlW5nSrx
 Cj8JaC0y9d/IOVHuglinOjsy4AMmPbwAcwPYKm6fGTI1fgnThzbSDZNm/ibBNMUEC0b+
 I23J0pGilRz8QanUkePe5ix7guAKXBNsj0WTkdBLEGKfjvVIS/U6fFR1bSavrURiv0HX uA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3em656mh5v-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Mar 2022 11:17:48 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 17:17:36 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 8 Mar 2022 17:17:36 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.38])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 89C5811D1;
        Tue,  8 Mar 2022 17:17:36 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Rhodes <drhodes@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 15/16] ASoC: dt-bindings: cs35l41: Document CS35l41 External Boost
Date:   Tue, 8 Mar 2022 17:17:29 +0000
Message-ID: <20220308171730.454587-16-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
References: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: m0AFY8slixbuSivZj1WSv-yRBwO1GuML
X-Proofpoint-GUID: m0AFY8slixbuSivZj1WSv-yRBwO1GuML
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rhodes <drhodes@opensource.cirrus.com>

Document internal and external boost feature for ASoC CS35L41.
For internal boost the following properties are required:
- cirrus,boost-peak-milliamp
- cirrus,boost-ind-nanohenry
- cirrus,boost-cap-microfarad

For external boost, the GPIO1 must be configured as output,
so the following properties are required:
- cirrus,gpio1-src-select = <1>
- cirrus,gpio1-output-enable

Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 .../bindings/sound/cirrus,cs35l41.yaml        | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 3235702ce402..09b515924c59 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
@@ -75,6 +75,19 @@ properties:
     maximum: 3
     default: 2
 
+  cirrus,boost-type:
+    description:
+      Configures the type of Boost being used.
+      Internal boost requires boost-peak-milliamp, boost-ind-nanohenry and
+      boost-cap-microfarad.
+      External Boost must have GPIO1 as GPIO output. GPIO1 will be set high to
+      enable boost voltage.
+      0 = Internal Boost
+      1 = External Boost
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    minimum: 0
+    maximum: 1
+
   cirrus,gpio1-polarity-invert:
     description:
       Boolean which specifies whether the GPIO1
@@ -131,9 +144,32 @@ required:
   - compatible
   - reg
   - "#sound-dai-cells"
-  - cirrus,boost-peak-milliamp
-  - cirrus,boost-ind-nanohenry
-  - cirrus,boost-cap-microfarad
+
+allOf:
+  - if:
+      properties:
+        cirrus,boost-type:
+            const: 0
+    then:
+      required:
+        - cirrus,boost-peak-milliamp
+        - cirrus,boost-ind-nanohenry
+        - cirrus,boost-cap-microfarad
+    else:
+      if:
+        properties:
+          cirrus,boost-type:
+            const: 1
+      then:
+        required:
+          - cirrus,gpio1-output-enable
+          - cirrus,gpio1-src-select
+        properties:
+          cirrus,boost-peak-milliamp: false
+          cirrus,boost-ind-nanohenry: false
+          cirrus,boost-cap-microfarad: false
+          cirrus,gpio1-src-select:
+            enum: [1]
 
 additionalProperties: false
 
@@ -150,6 +186,8 @@ examples:
           VA-supply = <&dummy_vreg>;
           VP-supply = <&dummy_vreg>;
           reset-gpios = <&gpio 110 0>;
+
+          cirrus,boost-type = <0>;
           cirrus,boost-peak-milliamp = <4500>;
           cirrus,boost-ind-nanohenry = <1000>;
           cirrus,boost-cap-microfarad = <15>;
-- 
2.35.1

