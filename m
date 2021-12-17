Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B514790F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbhLQQF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbhLQQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:05:54 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B231DC06173E;
        Fri, 17 Dec 2021 08:05:53 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id l18so2521085pgj.9;
        Fri, 17 Dec 2021 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSgwCz/Z9D+vF+HDpWYjXKr9mr988NX6jKdB0/NhBGg=;
        b=AUAAJjDIfVLtQ1k3d2TuFHkU0XMv1g+pzIono4q6BEgSCxyknskUwOaQab9bDEqmJX
         mlAdgT64smgAG148TlTYKfw+GefdALmokNZ+Y3O+AXXhGGaB3AxCjn+jI9wzPKXYRigS
         eJXUQLfd57LKx+ehXXu3WyuW0TFa2CsQi+gK60Lwmnqs0xUgQaN+F6q10K+u+oUfgb8H
         BK022woOK3U6QyPBH3D+OgWa5ekcvcJEd/ZGaD48PemTiXdY+v0UA8p625PuqqVCEcSm
         E/GCW9LkBcEamtOikLmOUiZ9oQG8XM+hVQh9aUaBOxXRrFmW7hJKGM2ELHesQOZmazXz
         JqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSgwCz/Z9D+vF+HDpWYjXKr9mr988NX6jKdB0/NhBGg=;
        b=ro27eGJDG31Cb1pPETpts324u5zU0PX3gxUdB/S52RlfMyX5b0OLHS1dPJtcDNMVhB
         fcm3UOVqLC9COn9l72fkBGH1MedD1TMHjVFQ6akJGTsiuZREcmt3PGPTVH5s3Y+xIf9f
         jPBkumpMnbK4AZkn2Wqrqd+jI/mLZoZvbk5dnfZNDYD32oB9G4wFgFVhIalvJgDpj8s6
         qfby9zzDYJ2nu6ZGq4Qdfhs1ELHCXwBmGtsnIlrZno/OtG5vIrerMmb10T6eKuJ/CMon
         7lq6U5FM0hgQdc/W3si2ZDkNzjCuJWIoPpTod7sA/VfmkDTEPNhJpgklOiHnil8dEqIr
         DgdQ==
X-Gm-Message-State: AOAM532J81hIS4SI6cs6P3CBFCT4e+cE0huRs6f8dYdywl+KfiFyrbu0
        DKWMsBKl2rEtcSGtPldXEc35PNceFTw=
X-Google-Smtp-Source: ABdhPJwDGWrhzhR9vfHEEcvboxttzuXhb+r3KBvDyRPJlmmxtTk3OZDj3uCquSFCb44H2bGIM07q0w==
X-Received: by 2002:a05:6a00:1995:b0:4b1:38b5:cc92 with SMTP id d21-20020a056a00199500b004b138b5cc92mr3732949pfl.7.1639757152112;
        Fri, 17 Dec 2021 08:05:52 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z23sm4020760pfr.189.2021.12.17.08.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:05:51 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v5 2/2] dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120
Date:   Fri, 17 Dec 2021 08:05:46 -0800
Message-Id: <20211217160546.497012-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217160546.497012-1-f.fainelli@gmail.com>
References: <20211217160546.497012-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two bindings are very similar and should be covered by the same
document, do that so we can get rid of an additional binding file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../brcm,bcm3380-l2-intc.txt                  | 39 -------------------
 .../brcm,bcm7120-l2-intc.yaml                 | 31 +++++++++++++--
 2 files changed, 28 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
deleted file mode 100644
index 37aea40d5430..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Broadcom BCM3380-style Level 1 / Level 2 interrupt controller
-
-This interrupt controller shows up in various forms on many BCM338x/BCM63xx
-chipsets.  It has the following properties:
-
-- outputs a single interrupt signal to its interrupt controller parent
-
-- contains one or more enable/status word pairs, which often appear at
-  different offsets in different blocks
-
-- no atomic set/clear operations
-
-Required properties:
-
-- compatible: should be "brcm,bcm3380-l2-intc"
-- reg: specifies one or more enable/status pairs, in the following format:
-  <enable_reg 0x4 status_reg 0x4>...
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an interrupt
-  source, should be 1.
-- interrupts: specifies the interrupt line in the interrupt-parent controller
-  node, valid values depend on the type of parent interrupt controller
-
-Optional properties:
-
-- brcm,irq-can-wake: if present, this means the L2 controller can be used as a
-  wakeup source for system suspend/resume.
-
-Example:
-
-irq0_intc: interrupt-controller@10000020 {
-	compatible = "brcm,bcm3380-l2-intc";
-	reg = <0x10000024 0x4 0x1000002c 0x4>,
-	      <0x10000020 0x4 0x10000028 0x4>;
-	interrupt-controller;
-	#interrupt-cells = <1>;
-	interrupt-parent = <&cpu_intc>;
-	interrupts = <2>;
-};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
index 5d7731ea4182..46b2eb3c43ee 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm7120-l2-intc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Broadcom BCM7120-style Level 2 interrupt controller
+title: Broadcom BCM7120-style Level 2 and Broadcom BCM3380 Level 1 / Level 2
 
 maintainers:
   - Florian Fainelli <f.fainelli@gmail.com>
@@ -59,15 +59,29 @@ description: >
   ..
   31 ........................ X
 
+  The BCM3380 Level 1 / Level 2 interrrupt controller shows up in various forms
+  on many BCM338x/BCM63xx chipsets. It has the following properties:
+
+  - outputs a single interrupt signal to its interrupt controller parent
+
+  - contains one or more enable/status word pairs, which often appear at
+    different offsets in different blocks
+
+  - no atomic set/clear operations
+
 allOf:
   - $ref: /schemas/interrupt-controller.yaml#
 
 properties:
   compatible:
-    const: brcm,bcm7120-l2-intc
+    items:
+      - enum:
+          - brcm,bcm7120-l2-intc
+          - brcm,bcm3380-l2-intc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
     description: >
       Specifies the base physical address and size of the registers
 
@@ -124,3 +138,14 @@ examples:
       brcm,int-map-mask = <0xeb8>, <0x140>;
       brcm,int-fwd-mask = <0x7>;
     };
+
+  - |
+    irq1_intc: interrupt-controller@10000020 {
+       compatible = "brcm,bcm3380-l2-intc";
+       reg = <0x10000024 0x4>, <0x1000002c 0x4>,
+             <0x10000020 0x4>, <0x10000028 0x4>;
+       interrupt-controller;
+       #interrupt-cells = <1>;
+       interrupt-parent = <&cpu_intc>;
+       interrupts = <2>;
+    };
-- 
2.25.1

