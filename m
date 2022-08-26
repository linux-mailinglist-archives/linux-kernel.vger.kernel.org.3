Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8635A1EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbiHZCmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244748AbiHZCmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:42:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9DCCD5D;
        Thu, 25 Aug 2022 19:42:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 12so220317pga.1;
        Thu, 25 Aug 2022 19:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=+FUdcVoA5R7wkkHkMVOX+IHghKx89t2KDXyDGNa8qBo=;
        b=O1yY9SrKjXVg8w8ll1K2qXubRS4PVOu+gxofkQ4mui3WXNad6GOUznkcKf0WcModKU
         YhPWCEEFr460gdgc1NLOHLAK7XDCYl6U3BiNkn4woazHNMkLpHcBsaZyZ821ifCTyKx6
         T5Jv3tRAS89bvJo6zL+SHgmuAnkPJ6zh6l/5EDYwzlcXhll4FwaAO1OYHSbHePPjonG1
         f/MuDRc+BsyRJ2OiiK4Eu9SQZN7oMKM2KfsTHRUZsiRNGgo8vEk55VdHg1RbSQRvnQsw
         EzvWKHtelymzgPB5T/FKpzzYewyx7nY6xKmeXTaHS/sekrFK6vNSiRE2vun6cvueYn7O
         TraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=+FUdcVoA5R7wkkHkMVOX+IHghKx89t2KDXyDGNa8qBo=;
        b=xzC+KjEQ2lPNuTD9fZKhyHR1phOcBXSbQP8+FpiqfZ+w6BQjaIn65X1njzbYhzlocV
         +2DupaznNilZNPszms/m12VIC2oaazzkUuhxvP1f6NFHka3BCOYuYLTNBPMeHeen/9CZ
         h7FKDHf9/4YVaVUD0VDocQjuWCnewnB0QyNjhphqU/609/8sf+QTWZ2b2B/KraEZ863U
         wGBbZ0OQnECC3oQ8nLrb8GsYFV7il5c7yH7b1PDzMuBzrIRPftOfVKmIcGVEyND4wxt4
         IKLRWbl+RRb+8ZloOllgL25JJ6cxFFk1aLEU7eRai+sfX0PEJ4vl4AqRxmgBNk+LcoSH
         VOxA==
X-Gm-Message-State: ACgBeo1WzvWDMWIpmBx8TqlY20EIcmfx+CTk8AgE/yyQUQYE3uUJPcjS
        7MbTjrH4r7dFhXjYhdwn234=
X-Google-Smtp-Source: AA6agR6mwiqFX/p94jAcY8/iikp0verp2///cSIUq74RzqcxUx14VBpxcOpjtIOcBIVsWvtK86zqKg==
X-Received: by 2002:a63:8348:0:b0:42b:57d7:bc08 with SMTP id h69-20020a638348000000b0042b57d7bc08mr1575436pge.219.1661481722661;
        Thu, 25 Aug 2022 19:42:02 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s34-20020a17090a69a500b001f021cdd73dsm444473pjj.10.2022.08.25.19.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 19:42:02 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v5 2/5] dt-bindings: media: Add dt-bindings for NPCM Video Capture/Encode Engine
Date:   Fri, 26 Aug 2022 10:41:21 +0800
Message-Id: <20220826024124.22747-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220826024124.22747-1-milkfafa@gmail.com>
References: <20220826024124.22747-1-milkfafa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings document for NPCM Video Capture/Encode Engine.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 .../bindings/media/nuvoton,npcm-video.yaml    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml

diff --git a/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
new file mode 100644
index 000000000000..b5be7ef09038
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/nuvoton,npcm-video.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM Video Capture/Encode Engine Device Tree Bindings
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description: |
+  Video Capture/Differentiation Engine (VCD) and Encoding Compression Engine
+  (ECE) present on Nuvoton NPCM SoCs.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-video
+      - nuvoton,npcm845-video
+
+  reg:
+    items:
+      - description: VCD registers
+      - description: ECE registers
+
+  reg-names:
+    items:
+      - const: vcd
+      - const: ece
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: VCD reset control
+      - description: ECE reset control
+
+  reset-names:
+    items:
+      - const: vcd
+      - const: ece
+
+  nuvoton,syscon-gcr:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description: Phandle to the Global Control Register DT node
+
+  nuvoton,syscon-gfxi:
+    $ref: /schemas/types.yaml#definitions/phandle
+    description: Phandle to the Graphics Core Information DT node
+
+  memory-region:
+    description:
+      CMA pool to use for buffers allocation instead of the default CMA pool.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - resets
+  - reset-names
+  - nuvoton,syscon-gcr
+  - nuvoton,syscon-gfxi
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/nuvoton,npcm7xx-reset.h>
+
+    video: video@f0810000 {
+        compatible = "nuvoton,npcm750-video";
+        reg = <0xf0810000 0x10000>,
+              <0xf0820000 0x2000>;
+        reg-names = "vcd", "ece";
+        interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>,
+                 <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+        reset-names = "vcd", "ece";
+        nuvoton,syscon-gcr = <&gcr>;
+        nuvoton,syscon-gfxi = <&gfxi>;
+    };
-- 
2.17.1

