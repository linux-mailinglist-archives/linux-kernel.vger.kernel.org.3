Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52355E243
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbiF1Da1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbiF1DaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:30:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9EB10BF;
        Mon, 27 Jun 2022 20:30:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n10so9947437plp.0;
        Mon, 27 Jun 2022 20:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GEI1FA1mQ9xGFS7EtSwjOQXPWUXeFadWZPerzpqwRAc=;
        b=U+fOV2v1sJ74tAGKSDutwxAjn8WfFAGL+W4N0TogvIZ5eld1TEXqlHrX/psC/4RAPF
         pZEDT26sAGoOI7RL7EPsPeqR0yZqWzrQF9nay9XtTeKOZnjLo6FTT6I4KWq/e0ADwFD4
         f/wpJsXvkfMnJrmoHT7DxCgDL/o2jB0ZjqKMdYkkvbdeFFP/d/DZoSA1IMU4cdZ1zxhU
         ZG+xFT42WTbAh03Pwk23aEJCFBtKn5dpDNwP+mn7Coh7m2FWYWQ0vDeuGTvzW4UF4hjk
         EjqrXcjpdAEEfI5Ka/2q3psGy9F+4UG7MgXmq0HXpNuIm9fssx54Tq8DrOkWQ5XVciDJ
         h0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GEI1FA1mQ9xGFS7EtSwjOQXPWUXeFadWZPerzpqwRAc=;
        b=OiZAgW6IMMF/L4qBELRRmuVZ5SJtYkQ99gNA/RZaLsjiPlqmnbJ62SDtRdicIcnskP
         VGVmCU6O/I3zvhi3ztJzDq73KESUPnWnRt8OU3sE/Kw+8Yqp3mjP+KE3Co2UZLOKFgqD
         QfTBBDqkHLxyfj3bynDfCMNwQmjjvIK6Fg3vLcJe7/t9jc1QN96cECKxmSglkYCBeC/3
         LLJdXzoEcrL8xt64GU/unu9yzoaRPzmczdurJW2y+0Gt0899ghy+9/JSUool2t7KSorM
         SUu7AuD0nXDm6CgyzwxkoegBxGc3hNLcdXkof5lrNm8bWa0tvWjleHY9wmXIUGvrVCvl
         sGSA==
X-Gm-Message-State: AJIora9cRRzqdNN5vz1IaHqMeYfME/6hkb659tjnIboMPBZA4Xtn8QLG
        fKfM5IpKf0ZBEIag/lzhVVc=
X-Google-Smtp-Source: AGRyM1uvWbK4wa/KhCuPEUhrWgsNAfn1M8V6mnTSD8KS1054N/LTGlzEcRK5eT6t3Qe+tBXPR1HeWQ==
X-Received: by 2002:a17:902:848d:b0:168:ab37:327c with SMTP id c13-20020a170902848d00b00168ab37327cmr2832693plo.112.1656387004569;
        Mon, 27 Jun 2022 20:30:04 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b0050dc762816dsm8091160pfi.71.2022.06.27.20.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:30:04 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [RESEND PATCH v4 3/5] dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
Date:   Tue, 28 Jun 2022 11:29:43 +0800
Message-Id: <20220628032945.15410-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628032945.15410-1-milkfafa@gmail.com>
References: <20220628032945.15410-1-milkfafa@gmail.com>
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

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
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

