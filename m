Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237D94F18E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378753AbiDDPzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347996AbiDDPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:55:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A164842495;
        Mon,  4 Apr 2022 08:53:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qh7so10849021ejb.11;
        Mon, 04 Apr 2022 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OmtvB1Xni4XcAR/AuctQxx0e+3Qbn5XIYUFCQaI+LJU=;
        b=IErH6U0tNhUU8vEfXOEKllxvqP6wDQePPXjFRl5gQAFvyCiAE+c1BLD7aj7n1hlLnK
         +dEDAUOSXj+tbMoP8aMJywR3DucL6MOnODJgN/4icDWumqxEFCX2hv91uDZiOBfRDkNp
         OLQTZM/0mRPaQFObQvNz9CpM3jp3dv8HyhI3h21pGSRrrmELiHFxmZt7FXdcEeSI5SZb
         GVdHAgv14c2mK7KEF6r1ss72VzUXIAN8O5+JhDr66lWa6MYGOknvFL3ZHqag3xGIETmA
         SFjpSiMOOX4IJiZLDeLvkGPyFEUxXOi58wFEnfiGBSTsrmwBmhC4F2se1jXGIGxNBNm4
         oKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OmtvB1Xni4XcAR/AuctQxx0e+3Qbn5XIYUFCQaI+LJU=;
        b=ebx/dPIRjVzKB5jYuokWNQZt0GvUSFkbl4Yi/kYPY58QmXRq+R0t1t3JtoM0hTGkxF
         NddB0DFhMYdRqmGp9tFq6de3oQXnwVC5dlsKGfm0VKegeqW+KiZ26ewb+m9NOZjX2xee
         6XiLHehnpCIVCYvbcGa/Z75Vv1WVC4TKwOw6UYcOpZTy0fGQaK3wW1dX2sE7w6yNX4oK
         i0UYWaNS40tu6V4XJSla5T39xEBL9nl2KXe5mBsrRC+nRTB5TUGc6HF7qu3wfPSJJm1l
         2AOlmuHxXZohvE1zjhc9XkMuye84CNv3LEFX4SKQCHvuQo7Y31TuBGHQ9+6+p7bRlVWT
         fYkA==
X-Gm-Message-State: AOAM531PtynaMefMYAV2aSy00qHGitRxDVClC9KpPb4C2o9lfYm30X58
        0l+Go3dFv359EVPqNq5v2sr2CjhJg9g=
X-Google-Smtp-Source: ABdhPJzwJeGc1YsWyZ3XejtT7WJTyL7+GNgDVEBCrVG0A1kNQ2ykFToGbKHEcYTmznych0HjS5D5TA==
X-Received: by 2002:a17:907:d13:b0:6e0:b799:8fcc with SMTP id gn19-20020a1709070d1300b006e0b7998fccmr769623ejc.11.1649087596477;
        Mon, 04 Apr 2022 08:53:16 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id a5-20020aa7cf05000000b0041919e52a38sm5532723edy.46.2022.04.04.08.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 08:53:16 -0700 (PDT)
Date:   Mon, 4 Apr 2022 17:53:14 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: timer: Convert rda,8810pl-timer to YAML
Message-ID: <20220404155314.GA2944@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert RDA Micro Timer bindings to DT schema format.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:
  - Collect Krzysztof's and Manivannan's R-b's
  
 .../bindings/timer/rda,8810pl-timer.txt       | 20 --------
 .../bindings/timer/rda,8810pl-timer.yaml      | 47 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 48 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
deleted file mode 100644
index 4db542c9a0fd..000000000000
--- a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-RDA Micro RDA8810PL Timer
-
-Required properties:
-- compatible      :  "rda,8810pl-timer"
-- reg             :  Offset and length of the register set for the device.
-- interrupts      :  Should contain two interrupts.
-- interrupt-names :  Should be "hwtimer", "ostimer".
-
-Example:
-
-		apb@20900000 {
-			compatible = "simple-bus";
-			...
-			timer@10000 {
-				compatible = "rda,8810pl-timer";
-				reg = <0x10000 0x1000>;
-				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
-					     <17 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "hwtimer", "ostimer";
-			};
diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
new file mode 100644
index 000000000000..f9043a4488d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/rda,8810pl-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RDA Micro RDA8810PL Timer
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  compatible:
+    const: rda,8810pl-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: hwtimer
+      - const: ostimer
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@20910000 {
+      compatible = "rda,8810pl-timer";
+      reg = <0x20910000 0x1000>;
+      interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+                   <17 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "hwtimer", "ostimer";
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 6d5c2c035f82..cbf91f0ecbfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2563,7 +2563,7 @@ F:	Documentation/devicetree/bindings/arm/rda.yaml
 F:	Documentation/devicetree/bindings/gpio/gpio-rda.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/rda,8810pl-intc.txt
 F:	Documentation/devicetree/bindings/serial/rda,8810pl-uart.yaml
-F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
+F:	Documentation/devicetree/bindings/timer/rda,8810pl-timer.yaml
 F:	arch/arm/boot/dts/rda8810pl-*
 F:	drivers/clocksource/timer-rda.c
 F:	drivers/gpio/gpio-rda.c
-- 
2.25.1

