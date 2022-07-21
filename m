Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3ED57D442
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiGUTf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiGUTfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:35:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5D641D37;
        Thu, 21 Jul 2022 12:35:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fy29so4807088ejc.12;
        Thu, 21 Jul 2022 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s79koBJKcUEHGr/LZx74gqZK4XdBpcqdo9YSWhBmsrI=;
        b=WTo+GhvWZ2KpXZg1ebEE9eP08FCf8HSzh+sndlzGb1VNmi1SjV2xXorXTioHI4iibT
         V6hjPWZFcm1UPVvXYSpI8HzO/zX6NHXmWCxCyKYu6lbg/4WF4e7tvO8FX/HZbtqihxmU
         YJHqWKQKjYsmKKzyp393lx09exdRE1BSodwXTUAw0f8VViViL8TFNp/6JqLaGrVIiXI4
         6GIYOaG+eHxrXq6aJIiEZWSbQsRg70mOfK8iRiF6YApGRFQGoeII0iq1XawDYifhHpen
         lgBWDn9H4DFWJrWRWvmMm0UCo7hVrg485esZctkE116jlJyeEa/AVk67HVZXrAwatbzn
         wR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s79koBJKcUEHGr/LZx74gqZK4XdBpcqdo9YSWhBmsrI=;
        b=o5/WaARLeDskYtm3eIHWfwE99LJJAm2YetQlMfvOC9SWmNBupPFIiHmmqUiHOD/a39
         TZCM0LOmcSG0V89g+ttUxXmTbj8LnJxYnqfcJVohYoXEYBomSL3CTDwby0UWgvfjq8sI
         pOIY4N6rJHBdiP5VkKiJYVETNQVBMgVnfiFqso/e2tp64AVbIt7uCxkiCKNyD6t20ikI
         vbRO0v9x4Brn1WZogS4/crGuAAbnX1kByvb7nHoIbVJwrcZETeTLI7RKgR7nXxiNvvvA
         fK9GtHvTqLf68UFzZfWTmVpsHabP2f8g3kVb9tVLsHM1uI8IlITH0xPXHAekEhIpSSl7
         I0Jw==
X-Gm-Message-State: AJIora+v6TuhbGhIo1SuicQNhdRskIQOfM7l/xVDPZraWQs8SfpdCOsJ
        BUMr8tJdCMpVo4wD3xTcpJM=
X-Google-Smtp-Source: AGRyM1v9GckEBIRe083XENtdxH6KPvli0SFKeCahz7f88NgopBVeh1KS77NWxtW7uHOP9KdyG9E08Q==
X-Received: by 2002:a17:906:fd56:b0:72b:47b0:6bfa with SMTP id wi22-20020a170906fd5600b0072b47b06bfamr129163ejb.62.1658432131191;
        Thu, 21 Jul 2022 12:35:31 -0700 (PDT)
Received: from localhost.localdomain ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402032600b0043574d27ddasm1430430edw.16.2022.07.21.12.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:35:30 -0700 (PDT)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: remoteproc: Add AVM WASP
Date:   Thu, 21 Jul 2022 21:34:54 +0200
Message-Id: <20220721193455.2717-3-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721193455.2717-1-kestrelseventyfour@gmail.com>
References: <20220721193455.2717-1-kestrelseventyfour@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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

