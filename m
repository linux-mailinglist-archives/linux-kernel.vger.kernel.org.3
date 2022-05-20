Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B706D52E2AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344878AbiETCsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344852AbiETCsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:48:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D86149156;
        Thu, 19 May 2022 19:48:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n10so6854500pjh.5;
        Thu, 19 May 2022 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GEI1FA1mQ9xGFS7EtSwjOQXPWUXeFadWZPerzpqwRAc=;
        b=PFB4ILbRJm810cLegeLEsWT5rWG8WzpqER/rUGpXWgeZDbCZ/HRYrYX4wrPB/OG/bc
         fsoVNQDDprQmh9gNG7qVq11cg25gDw0VM7TsjUuiq4iaIXKTmiJEB5wK/EWMcr7u79BD
         ac3imQejy0qvvQ8N/9mbgsJnE3/1vcK+jsviEKwR2ywPck/sJhUsnqyGeoxtmDgf2BcE
         OcIZLxNjj2G6XcqN/0Nmunu4HhT9EuBtThnmjmt2Ison+dxCf+Ks+EAzYIpNR5NtY6bY
         70uyLc9gzN2iYSI2dbjYu7E5HHoHry3knPH3Gy+rkv2JJyAJcIRXRuZ05zNv8ignxcis
         fqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GEI1FA1mQ9xGFS7EtSwjOQXPWUXeFadWZPerzpqwRAc=;
        b=DBTU3aeJDTITFq+Y2BAsrwT9pHWqhjrSprJ8D8pwJBzxggGhGsU2KU4vRZnxe2ayo0
         1KuZY0g1WVTru/3YBR2jyeSdng/b7oEyqY8sg3bH+2sYvPaebnHQLShHfSjNnKPnvMmG
         j65LDPV+OYsZxNTMwmFOY6bOrfaQM+mj8TgmxnLqQPXqFfKfyTTTa0DOqYM+6Oh1DRRt
         ZCbLAQyKY5Ue+NIBVvR6M9aWXBosa1d9NfaHWGh3k9vGEiCpnH/6GAgBVi3EoBzk9tXF
         LQ1tLmZFcV4cUKn8m3p6UC6T7z8IH4vG8NyyTNGx0Ip/WYS9+BiiI3DeUPBMdSXUlPEG
         y87g==
X-Gm-Message-State: AOAM531LmQE3avzAihxeDveinK5WZQKy4j9hO1P8CqU4KZwaHq16mY7E
        bkLavrHnudESKNDJutr1J1c=
X-Google-Smtp-Source: ABdhPJzk268kD3hn+Ms+ZO5nQxmcrhq05zAdpEhaA4A37txo4wODOIaonE0GUjVc3BtPpsgoNQJluA==
X-Received: by 2002:a17:903:230e:b0:15e:d0a1:922f with SMTP id d14-20020a170903230e00b0015ed0a1922fmr7649488plh.75.1653014883673;
        Thu, 19 May 2022 19:48:03 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a629709000000b0050df474e4d2sm379406pfe.218.2022.05.19.19.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 19:48:03 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v3 3/5] dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
Date:   Fri, 20 May 2022 10:47:42 +0800
Message-Id: <20220520024744.25655-4-milkfafa@gmail.com>
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

