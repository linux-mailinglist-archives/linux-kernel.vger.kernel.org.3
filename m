Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58272569433
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiGFVUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiGFVUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:20:33 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBC91CFFB;
        Wed,  6 Jul 2022 14:20:31 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id z12so12035825qki.3;
        Wed, 06 Jul 2022 14:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UhZoitLijiPNAqkv3CxoYd+Lpg8Yl4Q/B3mulaHhdfA=;
        b=fWecbpk3TcbtAl7jH2DFXWI+ZYpx+0Ecl3Ccmb0RpTCvzMDnFmZhRhgq/LSdtDYb34
         6nYjoqUU8oqWiNWUJ8etuZPaflUukg+fQAkuVy2iJgp2yIxaZrucVuKqKr+f0w2mvXQZ
         AsucKcBz3thKoBwi1kyTSTMC+DcWBnFsimBc6+lIyUVV76Yobs/J/5l78jw8imy59L5o
         5CdNuPRMhFFIu3/cErm2T5eQmdtLWDWZ2eUAWAC4Zw+Uepize7Xa6HScr10y+dkFHtLj
         IGsifzpOYMzcrUEaj6PvWM0BXAmKsOpEI9UseA4R1LUvawz3sLrxrHlXOND1NL+TUWVC
         XyDw==
X-Gm-Message-State: AJIora+VMHIiayEkyjLpGLigEWz52jyx3tH9Hd63hUUngycEhPx5jdwU
        IODYb6n6F+fy6d+r3CZ3Rg==
X-Google-Smtp-Source: AGRyM1vLksfEbmgZTWC3JTIY/XUPlZEUEUJd/Qvv4YtXmYQAiWVfNp/9Xu+RP+Hxr0ST8igasPl8Og==
X-Received: by 2002:a05:620a:1924:b0:6b2:85c1:7c7e with SMTP id bj36-20020a05620a192400b006b285c17c7emr13557929qkb.142.1657142430724;
        Wed, 06 Jul 2022 14:20:30 -0700 (PDT)
Received: from xps15.. ([172.58.107.140])
        by smtp.googlemail.com with ESMTPSA id c7-20020a05620a268700b006aef1e5eb87sm31500678qkp.24.2022.07.06.14.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:20:30 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: stm32-timers: Move fixed string node names under 'properties'
Date:   Wed,  6 Jul 2022 15:19:33 -0600
Message-Id: <20220706211934.567432-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed string node names should be under 'properties' rather than
'patternProperties'. Additionally, without beginning and end of line
anchors, any prefix or suffix is allowed on the specified node name.

Move the stm32 timers 'counter' and 'timer' nodes to the 'properties'
section.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/st,stm32-lptimer.yaml        | 28 +++++++++----------
 .../bindings/mfd/st,stm32-timers.yaml         | 20 ++++++-------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index ec7f0190f46e..a58f08aa430d 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -58,43 +58,43 @@ properties:
       - "#pwm-cells"
       - compatible
 
-patternProperties:
-  "^trigger@[0-9]+$":
+  counter:
     type: object
 
     properties:
       compatible:
-        const: st,stm32-lptimer-trigger
-
-      reg:
-        description: Identify trigger hardware block.
-        items:
-          minimum: 0
-          maximum: 2
+        const: st,stm32-lptimer-counter
 
     required:
       - compatible
-      - reg
 
-  counter:
+  timer:
     type: object
 
     properties:
       compatible:
-        const: st,stm32-lptimer-counter
+        const: st,stm32-lptimer-timer
 
     required:
       - compatible
 
-  timer:
+patternProperties:
+  "^trigger@[0-9]+$":
     type: object
 
     properties:
       compatible:
-        const: st,stm32-lptimer-timer
+        const: st,stm32-lptimer-trigger
+
+      reg:
+        description: Identify trigger hardware block.
+        items:
+          minimum: 0
+          maximum: 2
 
     required:
       - compatible
+      - reg
 
 required:
   - "#address-cells"
diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
index 10b330d42901..1bd663f886dc 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
@@ -87,6 +87,16 @@ properties:
       - "#pwm-cells"
       - compatible
 
+  counter:
+    type: object
+
+    properties:
+      compatible:
+        const: st,stm32-timer-counter
+
+    required:
+      - compatible
+
 patternProperties:
   "^timer@[0-9]+$":
     type: object
@@ -107,16 +117,6 @@ patternProperties:
       - compatible
       - reg
 
-  counter:
-    type: object
-
-    properties:
-      compatible:
-        const: st,stm32-timer-counter
-
-    required:
-      - compatible
-
 required:
   - compatible
   - reg
-- 
2.34.1

