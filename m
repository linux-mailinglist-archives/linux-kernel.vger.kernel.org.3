Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CAF5246F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351010AbiELH1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350980AbiELH1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:27:45 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F413B8C2;
        Thu, 12 May 2022 00:27:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 7so3825268pga.12;
        Thu, 12 May 2022 00:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xTHRu8kouNwhCxQDkX6+/ir1de51U8hSVFEEAos2UZc=;
        b=OdN4wM8Mb3KbVJVyo5/ZT4Ve97E3N6JtVsYFOVpMZ3pdbubWh8RpgDxOzLi3UGRPeb
         wL1u3lEAvhO4g+nXyvQ4kN2z024WQjLlh68QRej/VJflosEW7RnWr0K13p5vfB++tZCr
         WHppO+GsUg6RyaZwGD7+srrCfZ73uK1ZMs2xnRBt14pNxwSTI1qCTCC9hapmJa0QJP16
         j2BwFWBro1jvx3WMd9VGM7B/EIYUCT8pinkPe8AO2VmZIcy4aIjVlsB/3uijUpx8+mfo
         W/ECm/fCpmqHYH6VI/v1bTvTx2dxBbdMaaSttif06SjZg5u0/2iUXz9Bx71SzxKSKPGZ
         CeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xTHRu8kouNwhCxQDkX6+/ir1de51U8hSVFEEAos2UZc=;
        b=PQMVe1NJL7RW4+rXxBcs9wMR10eTrwTCmoVEQdFKMsCvkmsk8y9Xq7JxJ4cr6D9ZbW
         wAXuTvWQbLiuKhDlPNv2zgINKQakYOsqiJmQyRKwg62D2imkAD4kSWAOYvaiUCr61586
         yWP2uR6fH+/pOAmFlHFSl1/zZVS2Xkdp3EZU6+gi98MttmSOLWJhytzx9D+aayQ8ZvM0
         aPKkE6YERSqS47zI7kZwJV0xvUtz8TWr43q2ygTYDL20xs08fUGB5tvzb4b6iv9bl6SI
         x4cC1mrkhwpPNxanaWU93JTruri69vcmh/XYA9OQ78om6rYxLbZw61YQesgQMOtcTbnq
         Kk3w==
X-Gm-Message-State: AOAM5316SONMafWrc1R3p1QBLrRXxd4+inCmlE1aB25nj8tbV5rXtSoJ
        Wr8fIkS0OfRq0nEEsmXc20s=
X-Google-Smtp-Source: ABdhPJwNO9Dm9dN8+IOZ5WxUnWOlu+WOfNoj1zFH4ybZ85dk3mXkSmiHefjlsuS3pn2sLeq6XiznZA==
X-Received: by 2002:a63:1a12:0:b0:3c6:870:e878 with SMTP id a18-20020a631a12000000b003c60870e878mr23889607pga.291.1652340463410;
        Thu, 12 May 2022 00:27:43 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z9-20020aa79e49000000b0050dc762813csm3082779pfq.22.2022.05.12.00.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:27:42 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
X-Google-Original-From: Marvin Lin <kflin@nuvoton.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: [PATCH v1 3/5] dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
Date:   Thu, 12 May 2022 15:27:20 +0800
Message-Id: <20220512072722.25005-4-kflin@nuvoton.com>
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

Add dt-bindings document for Graphics Core Information (GFXI) node. It is
necessary for the NPCM Video Capture/Encode Engine driver to retrieve
Graphics core information.

Signed-off-by: Marvin Lin <kflin@nuvoton.com>
---
 .../bindings/arm/npcm/nuvoton,gfxi.yaml       | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml

diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
new file mode 100644
index 000000000000..5b785bda5739
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gfxi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Graphics Core Information block in Nuvoton SoCs
+
+maintainers:
+  - Joseph Liu <kwliu@nuvoton.com>
+  - Marvin Lin <kflin@nuvoton.com>
+
+description:
+  The Graphics Core Information (GFXI) are a block of registers in Nuvoton SoCs
+  that analyzes Graphics core behavior and provides inforomation in registers.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,npcm750-gfxi
+          - nuvoton,npcm845-gfxi
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    gfxi: gfxi@e000 {
+      compatible = "nuvoton,npcm750-gfxi", "syscon", "simple-mfd";
+      reg = <0xe000 0x100>;
+    };
-- 
2.17.1

