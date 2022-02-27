Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36E4C5ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiB0L7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiB0L7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:59:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC453DDF1;
        Sun, 27 Feb 2022 03:59:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s14so13747273edw.0;
        Sun, 27 Feb 2022 03:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+o8a4+sMFmJIptftdwbAGTNrygKBIVBJrDmKwhFceYY=;
        b=Edh57K8USvUrYtNnVvM9jioHrXrN/0nDElwH2Iq2SZBW0icqf0pXsKmaFnAFuqTBF9
         FutLkCioszFXPwbdkw9er37qeeVHPqnzZ3ebYqrB/Nkd7PMAvdSyRJvyJNZGC+lSsJuH
         wzvzOtS6U/FEGguPsZ1r2K9hAhRxWuOn/jEJReZCLRAYya0YrRB99RR8H/WFPCGEuoBJ
         Bb2KGtA/BJ3fTT9zbEZDPFr1QHKcmKUY3/KN2yLktfaVUPfzR+p4cd/Ma2KqvElPX1Mc
         Z0mJ2MYXL8ijbbPE82e3rGUuBHRcAuKWciTc8kDDH6Yh36TTeXET5WDM6Not83KzkCct
         hFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+o8a4+sMFmJIptftdwbAGTNrygKBIVBJrDmKwhFceYY=;
        b=AnFSZAfPwqdw7mOQN+uaywvk9GmXegebo7Xk7sK7UlpQC9BP/ERMZs7vEI75oe0u3j
         Rrmu/qb8pam+3auAoBRD2Zko6J4G6GcSJ/K7J3ZtLK8+b7w7pgGWfnx9omhiqAdBkfE7
         PqbEIGhn1VNjQWS09Qe4NOsASuycal4YH4YHtVLMihQoyOP06HuFawE6yvcisdBpJq6R
         VUFrEsm2jPipGqLuhWo/iXnSqTYuHMkKQxYnUAd/Ygf5/Uc321iNGBLhJ8TWGTtc+xm/
         AgVzPXcYhoPaBYZCerQX38/eAplSe23Bmmnqcp6dltHvlwnTAk/avpZT+mCb/Z4RnNaJ
         xMMA==
X-Gm-Message-State: AOAM532urIz+q0oLcLHYhAywZNkT5TmagDgYEJeHxK00EI7AfAcBFRpV
        L9WYqDl/MmPI4HvVjmJyBK0=
X-Google-Smtp-Source: ABdhPJxA03uU5tiQFzyry4IGeCczcdpoSqFDZOy3O6QJ4NicL07h6L5Fj3VLFUnbR1tLdQ8huS3E4w==
X-Received: by 2002:a05:6402:4409:b0:412:aac5:4e48 with SMTP id y9-20020a056402440900b00412aac54e48mr14866759eda.75.1645963142763;
        Sun, 27 Feb 2022 03:59:02 -0800 (PST)
Received: from localhost.localdomain ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id dn14-20020a05640222ee00b00410b88abd6fsm4474577edb.45.2022.02.27.03.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 03:59:02 -0800 (PST)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: remoteproc: Add AVM WASP
Date:   Sun, 27 Feb 2022 12:58:31 +0100
Message-Id: <20220227115832.13490-3-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220227115832.13490-1-kestrelseventyfour@gmail.com>
References: <20220227115832.13490-1-kestrelseventyfour@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../bindings/remoteproc/avm,wasp-rproc.yaml   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
new file mode 100644
index 000000000000..8b39fafc60aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
@@ -0,0 +1,56 @@
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
+  boots firmwares on the AVM Wireless Assistent Support Processor (WASP) SoC
+  that is attached to some AVM Fritzbox devices (3390, 3490, 5490, 5491, 7490).
+
+properties:
+  compatible:
+    enum:
+      - avm,fritzbox3390-wasp
+      - avm,fritzboxx490-wasp
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
+
+  avm,startup-gpios:
+    description: Startup gpio of the WASP SoC.
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
+        compatible = "avm,fritzboxx490-wasp";
+        avm,wasp-mdio = <&gswip_mdio>;
+        avm,wasp-port = <&port5>;
+        avm,reset-gpios = <&gpio 34 GPIO_ACTIVE_HIGH>;
+        avm,startup-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.17.1

