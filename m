Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE5B47CEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243785AbhLVJM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243772AbhLVJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:12:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A92AC06173F;
        Wed, 22 Dec 2021 01:12:26 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f125so1748542pgc.0;
        Wed, 22 Dec 2021 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RMvKmba4JM/jTaewTS19tLIKpwQrfdMAgxZsYWo8gwI=;
        b=OhZIRRH3Rohw6lx/eqCxnykzIJUZq9CiuZsBXxiyeWP6+jaLyoASijR+IJJZYlltym
         jvUTGVfTAm3G9N2Kp3Kf1ajlcul4GeMcRw82nGHrels5v9mxxnle2b35L8+LZQPFtHI8
         AjLlPl564lZ0XwrzRox/7XCZY3M4CPU00NcviKkK7JIhLOc5k0CkdmSeZBoybuuQoeje
         jyJ8ljNSpAFwTvvi23X+dWZ04xo55JBmZ1z0P4sd0K79mFLxuR7Fe7KDrMvFldC6nQix
         +pDfKVFQIMJ1lyVYctCdlV2NPqOPeCKATx75j5p0gj7KQM08Ubx4mi0PAWK1ejxwYJSy
         rpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RMvKmba4JM/jTaewTS19tLIKpwQrfdMAgxZsYWo8gwI=;
        b=YlJ6wQ/qj8tT/svvtIEXnkatt//u8mQH86ZPeiZ/jnIdCOILPFzgjIJxCzBik078Fq
         tLBfciGxlE61x4jT/kcI4DX+69FtTQSAcXc+nP7O24lsLngEwp5aTXlsY6pgHRUmW0XT
         KuPzg9Rwck76Aoytu6DPobFthGG9Q6GZc3CfSWz2kEobOC1Uu/HEyx1nMhzpuqhpKaKk
         rBc9T1D2eZMc2bT7MidWokcoyThopg9FMWg7/KNiNx1M0UNM6GUrNrZz7P8/7lPtBEVF
         Gr56qicnV9c4iX4De29SJNspk5QxoNGNFUh19j3BvHwaX0ygfx4KOqL5lsQYn8XN6ASc
         fw1g==
X-Gm-Message-State: AOAM532f7Rb5F8eNakGLp8ViorupBj2gzW5quH8YICzZhrE04qsCpYPs
        +NzjuEGN8gMAyx7Ox7cx6m+ez/wj5Mk=
X-Google-Smtp-Source: ABdhPJwx0YVpaL2i/qvQx9mrylFHz9D4AMWpOvxDfauLp2jo0p9bpgQU+hUXDFJGfQOMBo2aDhjorg==
X-Received: by 2002:a05:6a00:22d2:b0:4b0:da80:2dac with SMTP id f18-20020a056a0022d200b004b0da802dacmr2067157pfj.66.1640164345847;
        Wed, 22 Dec 2021 01:12:25 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id y65sm1470011pgd.79.2021.12.22.01.12.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Dec 2021 01:12:25 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com, vincent.shih@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v4 2/2] dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver
Date:   Wed, 22 Dec 2021 17:12:26 +0800
Message-Id: <1640164346-26818-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1640164346-26818-1-git-send-email-vincent.sunplus@gmail.com>
References: <1640164346-26818-1-git-send-email-vincent.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus OCOTP driver

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v3
 - No change
 
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

