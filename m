Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B613A4CD738
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbiCDPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbiCDPJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:09:18 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACBF13EFAA;
        Fri,  4 Mar 2022 07:08:17 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2244w2hN013723;
        Fri, 4 Mar 2022 09:07:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=GEv9qT1f52mVGZUhddgvUUHJMJPW1Ae8wHQRQufXyns=;
 b=QG1PrPybqd2HLHukhtNuQxQQ4gELVs/29DrwyxaSGeANw2uasdyvW345dMCHp9HASpS6
 4erMNh79lXsoJ7qOryhoxXbOEK9dWykgsSLlSW90zqSMMmjw9VenkesOGHn5q5/CV27o
 37BX8fMGuhOehby8d3YeIsP5yd6L9R0KKQYqm+xLWcrd6iTvy4UsBZM4lJiAcIaWYj4Y
 WJjJ12WTdFG39QzDKvLMMlxlIgdWS5W6VDGTwIlU19/Z2gYltQtYXsKT3lA4Pkjai0c2
 tSK29Ur1YfXXjebxtjq0UyMEawt/km7D5zknSdJmQIuVjxmpK43eYDbfqyAfN7ai63o+ Ew== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h414-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:07:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:07:30 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:07:30 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A41517C;
        Fri,  4 Mar 2022 15:07:30 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        David Rhodes <drhodes@opensource.cirrus.com>
Subject: [PATCH v2 20/20] ASoC: cs35l41: Document CS35l41 External Boost
Date:   Fri, 4 Mar 2022 15:07:21 +0000
Message-ID: <20220304150721.3802-21-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: o8ixPIuU6yT6JzdEqSm8p5Nrifm-qFt3
X-Proofpoint-ORIG-GUID: o8ixPIuU6yT6JzdEqSm8p5Nrifm-qFt3
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

Document external boost feature on CS35L41

Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
---
 .../bindings/sound/cirrus,cs35l41.yaml        | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 3235702ce402..2f60776b3e9b 100644
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
+          contains:
+            const: 0
+
+    then:
+      required:
+        - cirrus,boost-peak-milliamp
+        - cirrus,boost-ind-nanohenry
+        - cirrus,boost-cap-microfarad
+
+  - if:
+      properties:
+        cirrus,boost-type:
+          contains:
+            const: 1
+
+    then:
+      required:
+        - cirrus,gpio1-output-enable
+      properties:
+        cirrus,gpio1-src-select:
+          const: 1
 
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

