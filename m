Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76F4FA645
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbiDIJQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239464AbiDIJPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:15:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDC2EB09F;
        Sat,  9 Apr 2022 02:13:39 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.16.1.2) with ESMTP id 2399CL53024715;
        Sat, 9 Apr 2022 04:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=hBQinX7DMbnXea5pWZLMBcryrlxjmtsbaxuSMa/QdYc=;
 b=hjxC1nzy80KlLcJN/X0dm3V8e1DmMqFbDIvuFIDUX24hJPCTvOwzwK8nQrFTGzO4RQrY
 WsF755GrfWHR3fQuuxMWcC/TX0zJbO+cRBCq0brs6n2BGPOFZwXpE+8sh1bDeh8EcPQH
 GdGOgYl6WEgc8+vUtAk/b7bW8+P2iH3gaMAcJYQdv7Fs9wOJGD3ZYiwxZ2JUp/PY02e2
 T7WgU+cKA7Oun3PqiQjSQ4z4o1Byvvs6DWZivCvbMU3pW3zvRg8YLG2956z7GWMSWxjy
 P9NMmGlwVBO5sI9kV2y3vbnGCRpVFX6+qv6V784gAozGfGIhmF0SujqbvoMZnw/3Uu34 Ig== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fb6py80ws-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 09 Apr 2022 04:13:24 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 9 Apr
 2022 10:13:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Sat, 9 Apr 2022 10:13:22 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.156])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F26E0B16;
        Sat,  9 Apr 2022 09:13:21 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Rhodes <drhodes@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 15/16] ASoC: cs35l41: Document CS35l41 External Boost
Date:   Sat, 9 Apr 2022 10:13:14 +0100
Message-ID: <20220409091315.1663410-16-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409091315.1663410-1-tanureal@opensource.cirrus.com>
References: <20220409091315.1663410-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: iC9gRbWi1UlkFxvVFS9aUBKexi6-AeVp
X-Proofpoint-GUID: iC9gRbWi1UlkFxvVFS9aUBKexi6-AeVp
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/cirrus,cs35l41.yaml        | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 3235702ce402..51d815d0c696 100644
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
+          const: 0
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

