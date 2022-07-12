Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71896571099
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiGLDFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiGLDF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:05:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60575C360;
        Mon, 11 Jul 2022 20:05:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e132so6406380pgc.5;
        Mon, 11 Jul 2022 20:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4lS8+zJE8FkMh+rcBQMyeBKxWljY5Kknqq/+RkB5aPM=;
        b=QLk8ugMaS87e46OGJw34p1JQuJCPFYcLDA6dbuBGRggdk9aN6eOu5hlh+66d5Xj9YO
         UNA62zuv2i/zOXYYW3yRmIVy+x2ytO5LBDaOOYeLB8NsBu02ee/C1kswZbCQfgdBPCBA
         m8NsvlsUTXOfnqJMe8orQoNGHroSuTnu1JLfz7/bpiWfswNpeKdqRzGSbRcvC5ayh0JM
         f9BTV13J93YISnXQyUQimICvfmtBZZ3Sg/1USZZ0mjgWeKMoC9Z7T2xoAHuAHkiA1xXb
         mq1pRMTr5829fYR5wY+eLbvZN8HNsMFXoeiLZ2YaSfAP/+PoEDrptoQRoxOznMptSMSC
         Lp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4lS8+zJE8FkMh+rcBQMyeBKxWljY5Kknqq/+RkB5aPM=;
        b=A9N8EVojvOD+5Pqnu0aSxYWW7qpChi5AtSsrFB8z5uheAOIrQh2e0MkdflhR64zUEA
         sND8vm7IuL/bSa3woP1EoHyJv9mY/SsDYVsyIDYm3DIfsmhBtrQq65tzhxUNcdEi8xEf
         VIIe1BWO2r+nBc2a3IHu9jOypZLa4MS1UzEjXoaoQYAlSoJpXZKMgsHcde0UvRQYTu18
         FGzT1227A/4qdUizGiafjfvtcUwj27UXhoJSIJpjA6lwPMQua/r1TZKnwmUopgn07JeS
         +i8XUeVm3SJIz2iTApHg9vHAJ/cFl+BBS37urU9iUzoRXDag3mvGARGWbp0izKyO8CBr
         NPqg==
X-Gm-Message-State: AJIora9/ZsoPPCgNDXoLbIQQCjBkA/kCzwhT2FTRktTb8HNLxl83ng00
        KPdr66Yo895eDcBpY+RBaiw=
X-Google-Smtp-Source: AGRyM1tQO4CWPGdl73SLzWYSfHmFu587fXuNLzKHXoIpnO2NcjVUioWrnOWv8DFBbHk1LEup5cXg3A==
X-Received: by 2002:a63:4b20:0:b0:401:ae11:2593 with SMTP id y32-20020a634b20000000b00401ae112593mr19013325pga.375.1657595122288;
        Mon, 11 Jul 2022 20:05:22 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id i68-20020a626d47000000b005255263a864sm5467642pfc.169.2022.07.11.20.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 20:05:21 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ctcchien@nuvoton.com, medadyoung@gmail.com, mimi05633@gmail.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, KFTING@nuvoton.com,
        JJLIU0@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
Date:   Tue, 12 Jul 2022 11:05:07 +0800
Message-Id: <20220712030509.23904-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220712030509.23904-1-mimi05633@gmail.com>
References: <20220712030509.23904-1-mimi05633@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.

Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 .../bindings/rtc/nuvoton,nct3018y.yaml        | 45 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
new file mode 100644
index 000000000000..7a1857f5caa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nuvoton,nct3018y.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NUVOTON NCT3018Y Real Time Clock
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+maintainers:
+  - Medad CChien <ctcchien@nuvoton.com>
+  - Mia Lin <mimi05633@gmail.com>
+
+properties:
+  compatible:
+    const: nuvoton,nct3018y
+
+  reg:
+    maxItems: 1
+
+  start-year: true
+
+  reset-source: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@6f {
+            compatible = "nuvoton,nct3018y";
+            reg = <0x6f>;
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf141501..eca54b275559 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2448,6 +2448,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
 F:	Documentation/devicetree/bindings/arm/npcm/*
+F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
-- 
2.17.1

