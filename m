Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7EE525A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376825AbiEMDgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376812AbiEMDfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:35:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA265586;
        Thu, 12 May 2022 20:35:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n8so6774946plh.1;
        Thu, 12 May 2022 20:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xTHRu8kouNwhCxQDkX6+/ir1de51U8hSVFEEAos2UZc=;
        b=ZgzgYr/7IwtIwX17Nl80RJQkuH42xgVL2X8NHC+oLVlZeYzBJ9f+cLZu5enRwZ/IDb
         GIo6VG63M4e7uMrsslPxwg18nfDJ31TNFEpjsIvoPMCGLaCvi3KxlYx4s76ooByBe3zv
         YgMd6I3QYW5PwqrkqHPRuSrAjud7PUBirXub6VMDq7VWf5Zp4eGjdTLophshUxpHysOt
         OLbQE9JAZ0bdcm0pgfIJbIifDarBPXo+yIR0jeZOeYoDKPItAeYpl/NPzhACDyxGxiHo
         P1h8/lTP8EkfwjGZoIR5u0yrVQ2lU0e2WfwqS08aHEaAmb1XtsOqjOMnk0zbaEQdyJ6O
         7Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xTHRu8kouNwhCxQDkX6+/ir1de51U8hSVFEEAos2UZc=;
        b=IDqEue83DiEiwDanEM9LtF1Tm+PEmaPQ/K6rBakyJR9IIejE5b6iwlCo1BN+5d7hyH
         wSFhrLM98ej1I+d0nrgw7W62QGgC27vp9uc7iWJuX7RXsnRPBMVeQqEr31JytL50hfIv
         y4aQeXiOnqdHpLyLY6Ty1eylgV/kjDykFVZ/KM83Pqn7HC6AoytkA32Xpar9UbFOlZD2
         dkr+G7PxNwaRpu7024/KNbypfIbVpEtEgFURxzjQxJckik7z7v8Mc+YghoBx1JtLTzFs
         f8BV9xgOmaz68QVUrQFVxCaY07mwoWwcp34VPR+MFO7ANEQij70fIQYepCt8bw6ZLacZ
         1FcA==
X-Gm-Message-State: AOAM532EQ+opFLDzlRH5zcPQ9DHNnXLfS9ACY4nrqKXmn1kAaJcwSobC
        AKEUzJCeZ+ARmVjxL3W+GOw=
X-Google-Smtp-Source: ABdhPJyNEXhQeQ+VVIUQz4CI/DLo26wwI0/f5yoSq3Y6+jRozND3s2pZBaBFwMSv5cHeJXLDxAo5Fw==
X-Received: by 2002:a17:90b:380d:b0:1dc:8dc2:bb2c with SMTP id mq13-20020a17090b380d00b001dc8dc2bb2cmr13943721pjb.236.1652412947645;
        Thu, 12 May 2022 20:35:47 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0015e8d4eb1c7sm685133plm.17.2022.05.12.20.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 20:35:44 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
X-Google-Original-From: Marvin Lin <kflin@nuvoton.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: [PATCH v2 3/5] dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
Date:   Fri, 13 May 2022 11:34:48 +0800
Message-Id: <20220513033450.7038-4-kflin@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513033450.7038-1-kflin@nuvoton.com>
References: <20220513033450.7038-1-kflin@nuvoton.com>
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

