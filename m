Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66258A2B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbiHDVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiHDVIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:08:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D8D6FA2C;
        Thu,  4 Aug 2022 14:08:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id uj29so1609466ejc.0;
        Thu, 04 Aug 2022 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=bDY65iK3f8s/yjZhaD6JQ00YzqdpTQ8JcOL4UiG298s=;
        b=BdLirXU7VP5KAzYWnBhI+x6YOW96om5K2z5sWnhJtfv+Onlyj1sm2vIvF3ToV3njiF
         RPKxPqj2d8+ZfW+ZKHfOu9lFPkXekkF8Fy1+Moql5wQ1VqZuAbgDr+UaUT4VnYSes/7A
         saRx1vhXkqpkFxPVPwQvD9CON+9ZoIcyt81Xf4X6hKxx7pzvEWNpTODl/3o5w5361SA2
         7bcksBbDBvBaeSbuJZqyy9QbuR9wAmifGPDCi/9cKRLVGipDi9gTDlo6NYzQldIc3Qii
         +bqERsiQrPVuuUwoX1eu285mAtlUATQbd7WGbOyRJVEcvVQeR+Ug4nbULDs/uxq2Wv0I
         Cudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=bDY65iK3f8s/yjZhaD6JQ00YzqdpTQ8JcOL4UiG298s=;
        b=jYWR5qm8W60DZM92wepef+cexJ13iyGvVafnJEiqONrvxTOZl050Mfecj59l+AdQyI
         fw60ZJ2RL7iSUiqsYpdjZCPlstBcweagptEIAzzUn8zda/UT6/0UswrU1BiiGPZ3ki4G
         7ECnSqY98tqsZMValvUGAi4u2rTjnajA1z1XLoCI2QONcC7nhQufWlmWAmusMYm9Ke5e
         w0Tkg2DO7A/12wI+aeybPJD4bk7UwHDGimyZmENsRAiLOFvnDuyi7fEHyuT9kqjaosVy
         wTs9SjKhr9DPfMSpdMgDnp8K50Liwqw0dB+zZHK/CZqj8BG+AeAN6bLAo1TAszsNTiw9
         9QKg==
X-Gm-Message-State: ACgBeo0/0E7iCeXh+q4bKkGG60K7MhLP4uSgqomYawVHApXTa7S3cGaV
        5Xu0LFc1S+ua+ij7WMcEkL4=
X-Google-Smtp-Source: AA6agR6BMwu0gZQgExMwtMaJh6/s07tX0r8fYc6BHoAWlZ6S5wee6WkCgmkp7eMo5ym5y03RReumIg==
X-Received: by 2002:a17:907:1c11:b0:72f:20:e1ea with SMTP id nc17-20020a1709071c1100b0072f0020e1eamr2796985ejc.427.1659647301437;
        Thu, 04 Aug 2022 14:08:21 -0700 (PDT)
Received: from ubuntu.fritz.box ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709061baa00b007308fab3eb7sm699407ejg.195.2022.08.04.14.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 14:08:20 -0700 (PDT)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
To:     kestrelseventyfour@gmail.com
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: remoteproc: Add AVM WASP
Date:   Thu,  4 Aug 2022 23:08:05 +0200
Message-Id: <20220804210806.4053-3-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220804210806.4053-1-kestrelseventyfour@gmail.com>
References: <20220804210806.4053-1-kestrelseventyfour@gmail.com>
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
index 000000000000..2fd4ffb53945
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
+  mdio-device:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Lantiq GSWIP switch mdio.
+
+  link-interface:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Network interface, where the WASP SoC is connected to.
+
+  reset-gpios:
+    description: Gpio to reset the WASP SoC to initial state.
+    maxItems: 1
+
+  power-gpios:
+    description: Gpio to power the WASP SoC on and off.
+    maxItems: 1
+
+required:
+  - compatible
+  - mdio-device
+  - link-interface
+  - reset-gpios
+  - power-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    remoteproc {
+        compatible = "avm,fritzbox7490-wasp";
+        mdio-device = <&gswip_mdio>;
+        link-interface = <&port5>;
+        reset-gpios = <&gpio 34 GPIO_ACTIVE_HIGH>;
+        power-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.17.1

