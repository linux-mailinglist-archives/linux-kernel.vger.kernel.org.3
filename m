Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA02352E2A8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344863AbiETCsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbiETCsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:48:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA15614675F;
        Thu, 19 May 2022 19:48:01 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a9so4596532pgv.12;
        Thu, 19 May 2022 19:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+FUdcVoA5R7wkkHkMVOX+IHghKx89t2KDXyDGNa8qBo=;
        b=WouXBvL+vHKZWuu6vKQYbwGmjdRl6Ye4GRzkIOLHtQE1JiDsact5fIISgcNju+IZoG
         J0JXPD3jm0bkHkrBthV5+g5Mh2gfu2ROsJO08DCg1hBi9tdxaJRIDzsMmNmSXiwB6jvc
         F040FSrHtllsSVi4h8y/extRO6fP2FvI5gVQ471Wnt16teBKoD+KsQrxTkH1Ef6PaPaS
         8KEXiIv9NUERG+sQhLMYVbkHu0PimR3jP3+Zcez2lRryXHs3rz51VxOVVvsNZrdK/w+0
         MzGNP5IDvzwLCDke+OEVRQkdDoiqpu0lJbF/Tl+/2RM8eUOxYBMw9j35pWvUIGJIP+iO
         t4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+FUdcVoA5R7wkkHkMVOX+IHghKx89t2KDXyDGNa8qBo=;
        b=6YIm3yjTMg1CxfanBIRCgPdOzeFOb7C+hkCKDTOVzPGtvE/lt5gEQTKupTZ202boNb
         ASja85GPMgrjD/WPt5iJ9Ff9KKW9yQchgqCvTFsR2AjyRbPKkDK2OlaryY/d1er4J+D/
         RU3FkA7BK3TCHLGTTqIgkRj/DPhi1LbRWg1I2D0046JJjHugUC5LW4ZIEPyqk12E7m2G
         Suhy1a5TZqzoS4WAflT8T1f/GHv1g11OzuSzmBZV3yaDQkTizg4mx0LGCimHr5nUUh9s
         oh5tgNqIlTXdIYpXqS1RBpyUmHJgTP5nfjSDSqNjGvGvmwd5UeHaEPd7jx45t67oXEd+
         /0ug==
X-Gm-Message-State: AOAM530aedQKkvkQLIwjS/Cngr6/YUZ4ZSwVEqnkB49l8uY3HXDteO/V
        dDXYd+GynYmyhoZGhW3/bUI=
X-Google-Smtp-Source: ABdhPJwz77gsU0BgSNw9Hd5aRxW0wyPZOWno9LkVbSt3UKkKyTlrUpY+kIO11BlBt0OICB2QlxVV0w==
X-Received: by 2002:a05:6a00:170d:b0:512:ebab:3b25 with SMTP id h13-20020a056a00170d00b00512ebab3b25mr7699883pfc.32.1653014881350;
        Thu, 19 May 2022 19:48:01 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a629709000000b0050df474e4d2sm379406pfe.218.2022.05.19.19.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 19:48:00 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v3 2/5] dt-bindings: media: Add dt-bindings for NPCM Video Capture/Encode Engine
Date:   Fri, 20 May 2022 10:47:41 +0800
Message-Id: <20220520024744.25655-3-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220520024744.25655-1-milkfafa@gmail.com>
References: <20220520024744.25655-1-milkfafa@gmail.com>
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

