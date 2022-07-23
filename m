Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D86E57EC88
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiGWHnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 03:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbiGWHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 03:43:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E024A814;
        Sat, 23 Jul 2022 00:42:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ss3so12004529ejc.11;
        Sat, 23 Jul 2022 00:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s79koBJKcUEHGr/LZx74gqZK4XdBpcqdo9YSWhBmsrI=;
        b=bI/+95tFnAcSmKP9LMOo8SdXOPhob1wblUBvtchK64vphseSxAwv2mNXuBgwQ91HqS
         fCxUzI/Ef3dAyWSrKG/eT60huPRQ6CYIg4vnxwvPFYBBr+6iukR1wKq9YCDwsm/QlDPK
         WYwpZ9SpeF0wHd7kMWDCmn7vdK99yzfgCZUrpEE9XSSuDcorz9jL9lwWBkU4Ka4hA1s9
         bDiw2jRoaubPaxh5MyCrXTFuAUuBPy7RbhetDnrmlKS4ggLtAdetZMQjXGLRhwmHu4L8
         xt5vaEurrNWLSbKcUJdQd40GpXiP+y0FNmPYyAJyN9//Z/s8Xep2b+b5k0vy9erJ6KYf
         UZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s79koBJKcUEHGr/LZx74gqZK4XdBpcqdo9YSWhBmsrI=;
        b=ikwl4BIoSoMafBDpC869Yclx7AEkO+MpQWa3y0IUnw6o5Pa85PMsbO7+XWTxq2TSoA
         wu24lou44/VgKgM5PsK0TKAcjN9+KwezmJ0M7PG+akbIKiPQjyQBjexxwduaLDTJNYTi
         Azazf4xGfBrnf4QodviYbQeDpAPFtH55Rwkn/j1kpNNj/fmXyi4jU1jsmK0tz8crtN4U
         vMD/IbRywRsTsExnBajDNW0cOQfCbRyYHzRjaFEckK2JsFuaFV78bpR2FtKjAjS/kgcM
         vPiPfWxnQrkwhmodoluCwTVBUIIV801LimCtiZ+UtZYtVAY5bFHrRppk1rNdJrHcpwdf
         jnMQ==
X-Gm-Message-State: AJIora8U4iN8jR/LcNyUDiJKgflvGzQ1ekLuIF3cixauPCLI/HZjoBMp
        csEZW8nKadBp5JLMxNxRJNfy1E5qgULhdg==
X-Google-Smtp-Source: AGRyM1tsscvyXtfVwO4liCIv/PM8Tp/O6mMevt/kZ3BW1TaiRi5m+R4buCI+eS64QEFPvtnlAW+poQ==
X-Received: by 2002:a17:906:2dd:b0:712:1293:3dd8 with SMTP id 29-20020a17090602dd00b0071212933dd8mr2725109ejk.448.1658562177735;
        Sat, 23 Jul 2022 00:42:57 -0700 (PDT)
Received: from ubuntu.fritz.box ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b0072aadbd48c7sm2819204ejc.84.2022.07.23.00.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 00:42:57 -0700 (PDT)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
To:     kestrelseventyfour@gmail.com
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: remoteproc: Add AVM WASP
Date:   Sat, 23 Jul 2022 09:42:46 +0200
Message-Id: <20220723074247.32523-3-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220723074247.32523-1-kestrelseventyfour@gmail.com>
References: <20220723074247.32523-1-kestrelseventyfour@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AVM Fritzbox router boards may contain an additional ATH79
based SoC that has the wifi cards connected.
This patch adds bindings for this remote processor.

Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
---
 .../bindings/remoteproc/avm,wasp-rproc.yaml   | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
new file mode 100644
index 000000000000..e8618706a34f
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/avm,wasp-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AVM WASP processor controller bindings
+
+maintainers:
+  - Daniel Kestrel <kestrelseventyfour@gmail.com>
+
+description: |
+  This document defines the bindings for the remoteproc component that loads and
+  boots firmwares on the AVM Wireless Assistant Support Processor (WASP) SoC
+  that is attached to some AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490).
+
+properties:
+  compatible:
+    enum:
+      - avm,fritzbox3390-wasp
+      - avm,fritzbox3490-wasp
+      - avm,fritzbox5490-wasp
+      - avm,fritzbox5491-wasp
+      - avm,fritzbox7490-wasp
+
+  avm,wasp-mdio:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Lantiq GSWIP switch mdio.
+
+  avm,wasp-port:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Network port, where the WASP SoC is connected to.
+
+  avm,reset-gpios:
+    description: Reset gpio of the WASP SoC.
+    maxItems: 1
+
+  avm,startup-gpios:
+    description: Startup gpio of the WASP SoC.
+    maxItems: 1
+
+required:
+  - compatible
+  - avm,wasp-mdio
+  - avm,wasp-port
+  - avm,reset-gpios
+  - avm,startup-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    remoteproc {
+        compatible = "avm,fritzbox7490-wasp";
+        avm,wasp-mdio = <&gswip_mdio>;
+        avm,wasp-port = <&port5>;
+        avm,reset-gpios = <&gpio 34 GPIO_ACTIVE_HIGH>;
+        avm,startup-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.17.1

