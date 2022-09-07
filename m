Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606765B1061
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiIGX3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIGX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:29:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97800284
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:29:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p18so16081430plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MlOPb3XVR5IRK5ZxofjuXduHPChlNop48psfgzBKHJY=;
        b=cFl1N51OzpkSw672IG23QrfmzPwt6ldguaFZCyZ6J+llhFGn59+uKUlQ0uJfSj52L1
         xguYNDk/9DeEQvUZFIM19LZZU+ccBPtOgp1jryTOrWoLWEN0fiVuvOH/dkcyLsRRxucb
         T6hCUvn3dgkQNTLK+IgjG5eftL3hevGdXGpFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MlOPb3XVR5IRK5ZxofjuXduHPChlNop48psfgzBKHJY=;
        b=xKkJXo7REZtI5db0GvRMFWPAixxdjxAeJffZz9U5pROawSUSaqBXlaamsakBi8UjiA
         N26HkctfiU4zzZC0tLoFovcBXIS3cROcCixvjMDbXfgx48HaODuZ2B1OmgrNTz/JJ4/G
         OhfeQHoUQ9rQlA/BOPRXFid763VegJl0z+gKOtgcgLrMUmYO0etELfK4XwPrAR2cgQ/N
         Gl+57c7iL+vm1GuqEnsvpuB12sNGLrpu3kzXvZI0OrPfENDURnITD3m0E6SeBOabCePk
         ludfAusi+6pQJFcUHF6XdtPZNr8INWuCPx9QGKDHDhkrhxh38YjQyqmCOfQg8jR9wZDK
         CRUA==
X-Gm-Message-State: ACgBeo2ALaW1ka/1Dn3rYodWzUmsY5ImQYXvUF/P3ORTcSYaH7mcjUmo
        nSnS6E3dH55DT3jy3yirAcjPZg==
X-Google-Smtp-Source: AA6agR7IVvnjzmzvq2V+gjstnEg8GqnDvhY7EPQ3GnO+vSbTS/7DGOdfgN1+4tBXu5YiwDdOgImsqQ==
X-Received: by 2002:a17:90b:1b12:b0:200:5dbd:adff with SMTP id nu18-20020a17090b1b1200b002005dbdadffmr966621pjb.43.1662593362141;
        Wed, 07 Sep 2022 16:29:22 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:1cee:f8f:cc9f:568f])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a708600b002000dabc356sm201521pjk.45.2022.09.07.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:29:21 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 2/4 v2] dt-bindings: memory: Add numeric LPDDR compatible string variant
Date:   Wed,  7 Sep 2022 16:29:12 -0700
Message-Id: <20220907232914.243502-2-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220907232914.243502-1-jwerner@chromium.org>
References: <20220907232914.243502-1-jwerner@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows a new kind of compatible string for LPDDR parts in the
device tree bindings, in addition to the existing hardcoded
<vendor>,<part-number> strings. The new format contains manufacturer and
part (revision) information in numerical form, such as lpddr3-ff,0201
for an LPDDR3 part with manufacturer ID ff and revision ID 0201. This
helps cases where LPDDR parts are probed at runtime by boot firmware and
cannot be matched to hardcoded part numbers, such as the firmware on the
qcom/sc7280-herobrine boards does (which supports 4 different memory
configurations at the moment, and more are expected to be added later at
a point where the boot firmware can no longer be updated to specifically
accomodate them).

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../memory-controllers/ddr/jedec,lpddr-props.yaml    | 10 ++++++++++
 .../memory-controllers/ddr/jedec,lpddr2.yaml         |  8 +++++---
 .../memory-controllers/ddr/jedec,lpddr3.yaml         | 12 ++++++++----
 3 files changed, 23 insertions(+), 7 deletions(-)

Changelog:

- v2
  - Updated commit message to describe intended use case as an example

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
index 02700ac3c387ec..4114cfa8de67f1 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -15,6 +15,16 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 properties:
+  compatible:
+    description:
+      Compatible strings can be either explicit vendor names and part numbers
+      (e.g. elpida,ECB240ABACN), or generated strings of the form
+      lpddrX-YY,ZZZZ where X is the LPDDR version, YY is the manufacturer ID
+      (from MR5) and ZZZZ is the revision ID (from MR6 and MR7). Both IDs are
+      formatted in lower case hexadecimal representation with leading zeroes.
+      The latter form can be useful when LPDDR nodes are created at runtime by
+      boot firmware that doesn't have access to static part number information.
+
   revision-id:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index 65f4926d39c254..400d8025f7f204 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -20,13 +20,15 @@ properties:
               - elpida,ECB240ABACN
               - elpida,B8132B2PB-6D-F
           - enum:
-              - jedec,lpddr2-s4
-      - items:
-          - enum:
+              - jedec,lpddr2-nvm
               - jedec,lpddr2-s2
+              - jedec,lpddr2-s4
       - items:
+          - pattern: "^lpddr2-[0-9a-f]{2},[0-9a-f]{4}$"
           - enum:
               - jedec,lpddr2-nvm
+              - jedec,lpddr2-s2
+              - jedec,lpddr2-s4
 
   revision-id1:
     $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index 91b64943062472..153066a352cd67 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -14,10 +14,14 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - samsung,K3QF2F20DB
-      - const: jedec,lpddr3
+    oneOf:
+      - items:
+          - enum:
+              - samsung,K3QF2F20DB
+          - const: jedec,lpddr3
+      - items:
+          - pattern: "^lpddr3-[0-9a-f]{2},[0-9a-f]{4}$"
+          - const: jedec,lpddr3
 
   '#address-cells':
     const: 1
-- 
2.31.0

