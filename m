Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6342B55FB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiF2JHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiF2JHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:07:12 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D32B19A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:07:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n185so8911186wmn.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLqWKbW2jwJoT9mNlPi4MBFHRkwb+jBW6zLXAKBErh8=;
        b=MaLVsYckZFbAjneDp1wl2bbc1COXSVjuKYl2p1EVBs3dtRA5vY4YysKcEfAe03l6lt
         mjGmfJ1lHWvBIHl76k0usAJgjhTdfVxh0nOAB+J/FbWB9tPhdBOJdddZ2nXK3wh18Ihx
         1YYzEleHO9Rrxnpqmj1jDvnJ3YfVBMqJSAPjpKyZN5mCbSg9d6kzDR+TeqdBssFLDa7i
         ZsgEFV6AN03F3gbA89NV02joCPEen9BeGnRt7V+QsSfQm+1XQfRVpogoOcpt61bIxl9d
         UmUjU/Fvm0iV3e4Pfx3Eci5JMo+WBEn4l7dVeTcV8WlEFTQv8iTYu1eCbSwaOcZAxPMu
         opVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLqWKbW2jwJoT9mNlPi4MBFHRkwb+jBW6zLXAKBErh8=;
        b=ltgZFdXEH7gONnUOeWN2bYKWoOg9aGOuantkuRbs7cSLl1Wb0sflYpersTsNqRtuOx
         JYMEPyuPX03yslEDjKVw5ajMLnvpyPcahdt3MvnzTqlZO6tTezFnhGF4fvfHvzGWF5+F
         D7ZpbAiszRrl6GgfDV1LDoIElArAxlMp+dC19rak/ceJRb7yjLOrbxZ/UfsAWedDZLCf
         RrIIkTJg6MzjD+Yv0UWHMWBED0xPSFWOGUZZjDhXwGYmkwuJ4exEANh8yYtKPl1kFqwG
         T8uM47VGenlcBOV77cbZzYcMIwnUM/52aSvLqS1hvfAjJmRtCpEMRiqMiR7IDFFj8+PG
         PCIw==
X-Gm-Message-State: AJIora+siOUGS2bug3BB3RMNzwQCcnjaHRsnvhexWEaYFvNyaGpkON7N
        3Ld+wntrnQJzrRr7v34mZlqy8w==
X-Google-Smtp-Source: AGRyM1sDF/x8aEU0SfRrjCu32S9j0ZFkdiKNSRBehEA0uZ6Cr/wxrTUDHyPdd6wQKF7O+2E+9kMjgw==
X-Received: by 2002:a1c:e907:0:b0:3a0:3e42:9c72 with SMTP id q7-20020a1ce907000000b003a03e429c72mr2453247wmc.162.1656493625564;
        Wed, 29 Jun 2022 02:07:05 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d530c000000b002185d79dc7fsm15993341wrv.75.2022.06.29.02.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:07:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] ASoC: dt-bindings: Add WSA883x bindings
Date:   Wed, 29 Jun 2022 10:06:41 +0100
Message-Id: <20220629090644.67982-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
References: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for WSA883x Smart Speaker Amplifier.
This Amplifier also has a simple thermal sensor for temperature
measurments with speaker protection.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wsa883x.yaml          | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
new file mode 100644
index 000000000000..6113f65f2990
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wsa883x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for The Qualcomm WSA8830/WSA8832/WSA8835
+  smart speaker amplifier
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  WSA883X is the Qualcomm Aqstic smart speaker amplifier
+  Their primary operating mode uses a SoundWire digital audio
+  interface. This binding is for SoundWire interface.
+
+properties:
+  compatible:
+    const: sdw10217020200
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO spec for Powerdown/Shutdown line to use
+    maxItems: 1
+
+  vdd-supply:
+    description: VDD Supply for the Codec
+
+  '#thermal-sensor-cells':
+    const: 0
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - powerdown-gpios
+  - "#thermal-sensor-cells"
+  - "#sound-dai-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    soundwire-controller@3250000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x3250000 0x2000>;
+
+        speaker@0,1 {
+            compatible = "sdw10217020200";
+            reg = <0 1>;
+            powerdown-gpios = <&tlmm 1 0>;
+            vdd-supply = <&vreg_s10b_1p8>;
+            #thermal-sensor-cells = <0>;
+            #sound-dai-cells = <0>;
+        };
+
+        speaker@0,2 {
+            compatible = "sdw10217020200";
+            reg = <0 2>;
+            powerdown-gpios = <&tlmm 89 0>;
+            vdd-supply = <&vreg_s10b_1p8>;
+            #thermal-sensor-cells = <0>;
+            #sound-dai-cells = <0>;
+        };
+    };
+
+...
-- 
2.25.1

