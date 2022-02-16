Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD74B8A86
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiBPNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:43:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiBPNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:43:33 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDE21F6BB1;
        Wed, 16 Feb 2022 05:43:20 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id o6so3398502ljp.3;
        Wed, 16 Feb 2022 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNEbYOXug2TkNtFKnR8leLqegu8S1mDW3Iy+I30evSA=;
        b=XlBUqn1mo/dVGe4KKT5MgCvSTLL9Sb/vmf9EqPafFriEjceFyODQSG8ztxvePBnVS5
         bXOOg5Osx1GEwITfyJnvxQlcWDeukJGsObBOoHaOU99RHOfaSqoQlc2nxBTmdNi2MAjH
         5IYWR9fNACMRkkDHzM+Fq7CMy5fz//EY4Lmoy8lsvAURFAjA48/U8o2exV6NFHDq389N
         OuLWp1dRTQEOZ4FnEbcfmVkYscybTikloMjoFZLo0EX6A36XdZnQVIYVKW93frN8heHu
         lGd1H/yt2um1RYa3LRgALxv9q029MyZZKA/fEP9PPXp7D3fXMfbfD0A6ugX6m5N/Zvxy
         G6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNEbYOXug2TkNtFKnR8leLqegu8S1mDW3Iy+I30evSA=;
        b=psK3HUlNniIaZS4lE3m4GjuLjlVtQbhZ+OpoxJNGTMhjQHyPCQ/IGlKgkFh+Um3zx5
         8X/z6X+K9071WWSA0R5rkZiDoDJ3FMZ9fd9EZZ3lJH2wJS/NklrzeBvtlvFnf0hLpLU7
         /V+ypfODSXd/5tRbMPZc1HWblzCIARfuVpXhWwRAiCpk3KBk80kIWRYxxY6L+vOuuQOg
         JXv4LNim5IlZhaj5Jpr+hTXeMdIFbcYcajZMck23u3kAYxpwvW9VS35HJrD9UDMypEgY
         6U0ZZ+EIR8veYAwNbkHhE700FPByLsdpEd1N9Ov6g9hXPqJO51XR6vLg9D9gI/jT0bNL
         azUw==
X-Gm-Message-State: AOAM531sITPcp08JVuHUYxkrC+FxyPiLT4up8aUIpUo7Gl/36t66CBsi
        CzRox3XixZdpoGtHbD3ZpmhKTZn7ew/LAz9b
X-Google-Smtp-Source: ABdhPJyz9yVyXUG56FkHyVIA8XvKJAIv0kQTQ/rrS3g9c7TOlI7brFaaRhMoWR6erHHDUCCRRbL8LQ==
X-Received: by 2002:a05:651c:200c:b0:23b:8267:9ed1 with SMTP id s12-20020a05651c200c00b0023b82679ed1mr2164387ljo.368.1645018998526;
        Wed, 16 Feb 2022 05:43:18 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id a22sm1049934lfr.24.2022.02.16.05.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 05:43:18 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: input/touchscreen: bindings for Imagis
Date:   Wed, 16 Feb 2022 15:43:00 +0200
Message-Id: <20220216134302.5153-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220216134302.5153-1-markuss.broks@gmail.com>
References: <20220216134302.5153-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device-tree bindings for the Imagis
IST3038C touch screen IC.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../input/touchscreen/imagis,ist3038c.yaml    | 74 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
new file mode 100644
index 000000000000..e3a2b871e50c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/imagis,ist3038c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis IST30XXC family touchscreen controller bindings
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  $nodename:
+    pattern: "^touchscreen@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - imagis,ist3038c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply regulator for the chip
+
+  vddio-supply:
+    description: Power supply regulator for the I2C bus
+
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-fuzz-x: true
+  touchscreen-fuzz-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@50 {
+        compatible = "imagis,ist3038c";
+        reg = <0x50>;
+        interrupt-parent = <&gpio>;
+        interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+        vdd-supply = <&ldo1_reg>;
+        vddio-supply = <&ldo2_reg>;
+        touchscreen-size-x = <720>;
+        touchscreen-size-y = <1280>;
+        touchscreen-fuzz-x = <10>;
+        touchscreen-fuzz-y = <10>;
+        touchscreen-inverted-x;
+        touchscreen-inverted-y;
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index cdc851e275f1..9357cdc5aef5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -551,6 +551,8 @@ patternProperties:
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
     description: ILI Technology Corporation (ILITEK)
+  "^imagis,.*":
+    description: Imagis Technologies Co., Ltd.
   "^img,.*":
     description: Imagination Technologies Ltd.
   "^imi,.*":
-- 
2.35.0

