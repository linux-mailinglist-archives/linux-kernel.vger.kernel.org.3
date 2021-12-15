Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11914757DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbhLOLfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242055AbhLOLft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:35:49 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8F3C06173F;
        Wed, 15 Dec 2021 03:35:49 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v19so16176897plo.7;
        Wed, 15 Dec 2021 03:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Dd4Iynyov0rxEU5X3WzUyRbSUURppVj3SwwqqmXdtM=;
        b=P4vXbgJQGdxCVcy5BjXs4B4IGR2tjeTtfcZeI1udxSF/dcfjYkriplN116uRU/RYXc
         oQBZzhvn2hjoVYYVNK5LHNDJpyKDuqVzUy9F/659F6kODJpxVGQlzg/Fiy0Ql/nFeZSP
         qOaht/NY9zLGJ/fcWlL/RYlpcY0Quy++vgrAfoXQkkoUCeAFG9W1mD0PsI61h/hb/ZQX
         Im61CfBcB+1oJQOarCnnJJLgMd8C5h1Vo4bRyi3FZxVobJiPHvUrFDR8KO1l4ZOTs1pu
         MbEHL2LkXApkueZCyQL8mQ4CfnXAxQgPrsiIqhWpf8y3ZaBZOiONzJfswSWQCojvtzP1
         q7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Dd4Iynyov0rxEU5X3WzUyRbSUURppVj3SwwqqmXdtM=;
        b=ThTbHYpuF4BjQxUKTdGV8+f90xR/jYPa6t6NO/3DrV47kKd1qKLbFZqrbKKpI4vOoW
         h31arxjM6TfwS4bklh2CP1SO1g+wVqDjXchQjDiNCTGJDcAs8VI9xxQKzCzIHcFgazZP
         0tXRuLQC/vhv8FCSV1kbxoxUShICs3iQYg2lPQ13wjcPB0LyQnjp/ctPC+fwy/ltboLx
         GR88GPT33Oi9F1FTywR4k8b6+HS9R9ISCcRecfpUl3Qhq/dCIYq7wFHXDmKse/DfTMp1
         AKFhWytJgqkFSKI/Y1lOryAMzBsRc/O9+KfMECaP4KDh6eeek6Nb5UJte7jZzk23Ws9e
         cTbQ==
X-Gm-Message-State: AOAM5314nHHHVpiA2Pih0zIyZFwMKy/u0+XoZn/lxrJUcJQZnHbpKMKT
        85hL1NupzKULgAnqvEF/f7S+tqnylBM=
X-Google-Smtp-Source: ABdhPJw7JvMEaTY18idhQffBraaCtzYuzpk0HoarmYuZnC1EygHUVWKef+CNbO3CBTCQngjnZn+eTg==
X-Received: by 2002:a17:903:22d2:b0:148:a2f7:9d46 with SMTP id y18-20020a17090322d200b00148a2f79d46mr3979873plg.101.1639568148647;
        Wed, 15 Dec 2021 03:35:48 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id s19sm2558727pfu.104.2021.12.15.03.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Dec 2021 03:35:48 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, vincent.shih@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v3 2/2] dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver
Date:   Wed, 15 Dec 2021 19:35:48 +0800
Message-Id: <1639568148-22872-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639568148-22872-1-git-send-email-vincent.sunplus@gmail.com>
References: <1639568148-22872-1-git-send-email-vincent.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus OCOTP driver

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v3
 - No change. It has been reviewed by Mr. Rob Herring
 
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml       | 86 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
new file mode 100644
index 0000000..4b28f37
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/sunplus,sp7021-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: On-Chip OTP Memory for Sunplus SP7021
+
+maintainers:
+  - Vincent Shih <vincent.sunplus@gmail.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    const: sunplus,sp7021-ocotp
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: hb_gpio
+      - const: otprx
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  thermal-calibration:
+    type: object
+    description: thermal calibration values
+
+  disconnect-voltage:
+    type: object
+    description: disconnect voltages of usb2 port 0 and port 1
+
+  mac-address0:
+    type: object
+    description: MAC address of ethernet port 0
+
+  mac-address1:
+    type: object
+    description: MAC address of ethernet port 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sp-sp7021.h>
+
+    otp: otp@9c00af00 {
+        compatible = "sunplus,sp7021-ocotp";
+        reg = <0x9c00af00 0x34>, <0x9c00af80 0x58>;
+        reg-names = "hb_gpio", "otprx";
+        clocks = <&clks OTPRX>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        therm_calib: thermal-calibration@14 {
+          reg = <0x14 0x3>;
+        };
+        disc_vol: disconnect-voltage@18 {
+          reg = <0x18 0x2>;
+        };
+        mac_addr0: mac-address0@34 {
+          reg = <0x34 0x6>;
+        };
+        mac_addr1: mac-address1@3a {
+          reg = <0x3a 0x6>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e6593a..2afd1ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17950,6 +17950,7 @@ F:	drivers/net/ethernet/dlink/sundance.c
 SUNPLUS OCOTP DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 F:	drivers/nvmem/sunplus-ocotp.c
 
 SUPERH
-- 
2.7.4

