Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A985246EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351004AbiELH1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350976AbiELH1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:27:42 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E313B8C6;
        Thu, 12 May 2022 00:27:41 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x23so4030177pff.9;
        Thu, 12 May 2022 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dtvS7FlIf6tiGDrDOHrDDb05Y2i6bh3qVCm0jbGaTfc=;
        b=Fq8DQqUiuTeBvjwMLN4ijRYR6zk7T3iscOZPOZpo7V/inYN1tARpbUpr9GcKrcWCtr
         xTcOAKcWGO8lgl7f6wQWzigNULVyeagQQ4hKrV9mwjh8BXMwVEhm8CMajdPGK50VPz3G
         2h/mi+I7Z6Eh4do3Rt53TT0xs8xLKehv7tWuDi98Iv3pD/fbQxskTjj6HbwaCCC4QHpy
         so4EoVeEbXLmDFOEZ16we9MwMbeNofGc+qgqRlkQDoHyFDtyTkgIndqLdzz08Uf7Tujl
         1O1/iXf4DcDzx3nZbsajrvMEWbzI3hl70ckN+sHthY00xk58ldQIovF/6a2D+mEe1QwT
         a1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dtvS7FlIf6tiGDrDOHrDDb05Y2i6bh3qVCm0jbGaTfc=;
        b=N3x2CL5P5ACLq97anGip62gTl+5eRqcWO4P2lx5WAgFVEsykXNhMoYILzE8nnrogZZ
         KNEnlGIaSiHL1IP0jiebDL2mscZtmi7bDG7hCuqfDMTr5/XYpMaRG1WGFnRir9CGc+F5
         0djAFsNGQhSQKRoYDAl+nOB9+WQGNIuT4sVEVTFq6+a0VoKprpCaqvIEc2O2/mCHrIiz
         X8EtyNoUYsmfqIqFCRHn94IFOT8I71eWQRsQ180OZ8m+fG1uguDUUvLooeZ/GRcbSSeH
         L/P9Di53F21pFBsr+2Vmtc0/yxx5/9gWMMqk0+8OJWX1gwLdFMoJuEsFUfT24FqwIgvH
         Cy3A==
X-Gm-Message-State: AOAM532IraCnqRkSRrthKPrjdujIRKv4MNZu+kaLwEKboC4Gb25yERoo
        vsrOYhSMqKCcrRxniKKuIak=
X-Google-Smtp-Source: ABdhPJzm+l7FZcdP7tr/TRaL9GcPdCoZClzkN7Do+4ZC93DqeO6ejV4QY6JXCMUuOVRs7H1YWO+O8Q==
X-Received: by 2002:a63:5619:0:b0:3ab:aac3:8e86 with SMTP id k25-20020a635619000000b003abaac38e86mr24565301pgb.300.1652340460930;
        Thu, 12 May 2022 00:27:40 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z9-20020aa79e49000000b0050dc762813csm3082779pfq.22.2022.05.12.00.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:27:40 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
X-Google-Original-From: Marvin Lin <kflin@nuvoton.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: [PATCH v1 2/5] dt-bindings: media: Add dt-bindings for NPCM Video Capture/Encode Engine
Date:   Thu, 12 May 2022 15:27:19 +0800
Message-Id: <20220512072722.25005-3-kflin@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512072722.25005-1-kflin@nuvoton.com>
References: <20220512072722.25005-1-kflin@nuvoton.com>
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

Signed-off-by: Marvin Lin <kflin@nuvoton.com>
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

