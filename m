Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A925308CA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 07:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355626AbiEWF0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 01:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355609AbiEWF0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 01:26:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F15CB7F1;
        Sun, 22 May 2022 22:26:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so16479348pjb.2;
        Sun, 22 May 2022 22:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GEI1FA1mQ9xGFS7EtSwjOQXPWUXeFadWZPerzpqwRAc=;
        b=InOjKJS8DtzGWYMxutlgKENhz4qFuLERtYlmjq9fnQFXa0d0V90lbi3toVIMrkN5rw
         E6mloFM2NrhVkI6+3dOMhZT81+4lMlFcqUlwVzd55b1tyKgX2+/unruVYNDYo/P3OqDP
         g0lrV/CJgpLUvvFguCLWrJFHjzfn255Jj6N8UBzzOzNyj1ofnHAevfyw2kgsg+yUsXOM
         /gO7n19Esuqk3U3xM8lkXwDajaur8Zt1p+4TmjVmOK/Ax2hfFSPnQrho0Nw9kIIzf4GF
         ifp/tN43q3nzTQlYE4ITL76ZtQWuSEpWYsxjgPcZW1WQe2Urlxub3Rh2GUmFQWZYTjdz
         K32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GEI1FA1mQ9xGFS7EtSwjOQXPWUXeFadWZPerzpqwRAc=;
        b=Ot5RnFhFGXulSjz8wpf0X5QyOiyo3h96oodu3ZrhEtdI6C8D9pGmxzf15pN1uAUWua
         zmlRVu0ELBPEspggSbpr9Y6hZOfBcKjsb78Ba67Awcx0Q45eaiJ1zNEcKqvBv+pAyXqG
         E1ySaOkxo4c0oGPr3NyyWQU2GuAHPQ0StP/8wbUUUXytQvVeOHtiyORYrdmtci0H4ZxR
         1qlvD+iNSRzNhrQ4++Y8bDMO8BA02gCCddfSU658sRO+6SzCAOc92dW1zz8yQv3zz1dV
         7VAzU1QEVC8jneGq9vG/HiwHYM3wpm1MRZWA3ln0h1V6D9HtKwxiBaroYvmNN0RYC1j0
         CTUw==
X-Gm-Message-State: AOAM533Ds5TP+OrlAfMF+cplD+tVysOifeX7bqs0jz7/iLfoPSIqmk+s
        wuD0DncAT8xu/6grgLmx3Qw=
X-Google-Smtp-Source: ABdhPJwZwLq1fbudjoA8h0YcXQh5GalUCiWIZyfB0meQ76SgOPTx6Y4vqoKhJXWOdMn9KJZZhFz2BQ==
X-Received: by 2002:a17:90b:4c48:b0:1e0:74b:324e with SMTP id np8-20020a17090b4c4800b001e0074b324emr14471709pjb.134.1653283573470;
        Sun, 22 May 2022 22:26:13 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a655285000000b003c14af50603sm3871523pgp.27.2022.05.22.22.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 22:26:11 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v4 3/5] dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
Date:   Mon, 23 May 2022 13:25:46 +0800
Message-Id: <20220523052548.28109-4-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220523052548.28109-1-milkfafa@gmail.com>
References: <20220523052548.28109-1-milkfafa@gmail.com>
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

