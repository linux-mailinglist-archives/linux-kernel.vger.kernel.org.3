Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A715A7366
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiHaBeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiHaBeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:34:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D371A4B16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p18so12775478plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eIoCfjLB426DRP9MvovxxghsKJLwtNHROlQefu7G3lM=;
        b=Ki8P1MpBQRb9aIYA2fhBuAY5M6rpPD29NWh06tTHoMqGNXybFoWDxZJVo/FTX6/K99
         XHP/ssC68TEdCm0IgQe0jv6o794TxNNnEimNr3d0oAXsH/ShNnoElbJtQGvgT86jGsyD
         VdpoXKDvfmwZexXkjzONrz6ncSuj++OMsES/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eIoCfjLB426DRP9MvovxxghsKJLwtNHROlQefu7G3lM=;
        b=46NzgyEquC8ls+VMLk0hFuShnYXXy3157Xtacgn2MlicgPguVJci6itRng9oObMBn2
         vjr+wc2Wc24Q/R0szouutsFL0M0jl4OBwTVAKfW9V46B5dDzCDQLO6YFeZSiog3I8On8
         zZtWJzKcFvN+6C9ueXra2shplKJmvSHfcDt6DE5y6yWlD8FqYaCHUPu7kUMKOCU6qeiD
         xy2Y7EdnOBhb1yHZwpedh1NPSnF8nDAYm0jPneCwAVrzY/8nWsma8CV4ZseXy02n/07d
         YccgeimvnIc+XcsZULp4XHgSywNnyszDlDgoUOR9aVIXga11Gb3AbzMaSqGkufX44VAv
         yPkg==
X-Gm-Message-State: ACgBeo1Cpmvtt1nKxgbwR94QjlnbgBacx1eo6sPRTg5qQ3pBlgBZa/nG
        X4AT2NACqSykoOXJq1p0HR0pRA==
X-Google-Smtp-Source: AA6agR4+UrfNtofcyCHtH47Ino/bD141jp1fwWjV2p16FoV1gDN1vRx63iCxCXogE/VBzdTJYsPapg==
X-Received: by 2002:a17:902:bf06:b0:172:cf73:df43 with SMTP id bi6-20020a170902bf0600b00172cf73df43mr23869443plb.13.1661909648090;
        Tue, 30 Aug 2022 18:34:08 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:2e75:b9a4:fb1:b1b8])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b00174f4316c24sm4261382plg.245.2022.08.30.18.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:34:07 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 2/4] dt-bindings: memory: Add numeric LPDDR compatible string variant
Date:   Tue, 30 Aug 2022 18:33:57 -0700
Message-Id: <20220831013359.1807905-3-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220831013359.1807905-1-jwerner@chromium.org>
References: <20220831013359.1807905-1-jwerner@chromium.org>
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
cannot be matched to hardcoded part numbers.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../memory-controllers/ddr/jedec,lpddr-props.yaml    | 10 ++++++++++
 .../memory-controllers/ddr/jedec,lpddr2.yaml         |  8 +++++---
 .../memory-controllers/ddr/jedec,lpddr3.yaml         | 12 ++++++++----
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
index 8b31c60ea2435b..0c7d2feafd77c8 100644
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
   manufacturer-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index 63c47235cb9896..0eb7a66dfd08db 100644
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
index 5969166cdc9e0f..cd076a4fd91194 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -14,10 +14,14 @@ maintainers:
 
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

