Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DC15A1EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiHZCmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbiHZCmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:42:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C87733A12;
        Thu, 25 Aug 2022 19:42:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y127so312837pfy.5;
        Thu, 25 Aug 2022 19:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=GEI1FA1mQ9xGFS7EtSwjOQXPWUXeFadWZPerzpqwRAc=;
        b=lTi2yQTgmzHejEIWCtvdcyLoL81OolmQ75eQLXma5WZCLHSAGujGvHacP5dN0ROPnv
         infaQlkv5eVZQbAmowRG9kTDCr2d97tlghdu39OBOowNamjJb7HkjnbIOkTNly0XHW3j
         nBE/OcoowBo4HmLTU+eb/78VUnNEnl6Oq5uQHwAkYXe68YdR6lIr9iBRowearErW04lx
         0jwW/OvcOe1LPBxIUQuvxyekvgIgoA+8VdEg1etW76GSUh4VTKLDQ6Kg+Lc/pks5PHFW
         txOj35lnWwa6e0q7EF0Neg/b6EJk9B362ifE3aNizroJAuK4Nr7LOpqJ3mpWgNdTqU2J
         xakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=GEI1FA1mQ9xGFS7EtSwjOQXPWUXeFadWZPerzpqwRAc=;
        b=bWxSE+7BKO5L/9KwvmzgKg60mhBv1L2J3sdALnZWl5XhKbiQ/Ln4lWSPRt8Lo5htQk
         NxvKVcdhCNpBMhPjVrU40+XLv8UMCnr2OG/ihmVhbqhod9c8b1Ix1zdkytLbDfVbwF9W
         y7130FiLRBbtSI+cd25Dc1a/ZmkWnoseVhW9p5WyPUaD/QgEyRkYxvaUI7J075T2XdXC
         0r++EquqK1QmCjAxZV1mQ4crAfmWKGZ56XVD5MIQtCEmAHwTkSHPthvfulYfiHkB3zak
         KfsPdaUipdCXVaoNMwAKkag44hfPq13OoxU5ptvc72obRx9JV4zdfnh3T2eNLYiOIkJY
         2FIQ==
X-Gm-Message-State: ACgBeo0De7uvmxAhWQXetiwtIK5EUNjyj/cMgIUJvEsVr7BaCKeQjelq
        r7e8KEZvNhV13lAvuMIhDBQ=
X-Google-Smtp-Source: AA6agR67rBv6+FhMk6AxnRgAPADvznHO5LhvB/IMh7Ea1QNP+S9PD6+fZnePPKP1wA+yDJIc0xvVFA==
X-Received: by 2002:a63:6a48:0:b0:42a:3cab:cc36 with SMTP id f69-20020a636a48000000b0042a3cabcc36mr1581147pgc.135.1661481725147;
        Thu, 25 Aug 2022 19:42:05 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s34-20020a17090a69a500b001f021cdd73dsm444473pjj.10.2022.08.25.19.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 19:42:04 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v5 3/5] dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
Date:   Fri, 26 Aug 2022 10:41:22 +0800
Message-Id: <20220826024124.22747-4-milkfafa@gmail.com>
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

