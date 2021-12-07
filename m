Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBC046B674
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhLGI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhLGI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:57:27 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A1BC061359;
        Tue,  7 Dec 2021 00:53:57 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id f20so13616533qtb.4;
        Tue, 07 Dec 2021 00:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YQ8iQqe0A5/uglekK6JjLVqTME4ar4CUT63VuUJgkz0=;
        b=VFGQZwmSmPMaFk9St2+ciFlM2xEVgkrOleUY15Qxw3ioZ44fqjfldMQc1W6lScyNOy
         hgcOyXKRWpd41EITJkMKqSmJzKgt9oQX9QncbiaXcaDrXC3mG9hfmoJO3cFsEmMuHrJx
         9e166SSaQcYbQJYXRevjs7uQqE/9oI153ue4VeXfRPCWK8TlKf8Zf+5Nk0L+scE9FQMN
         fBm4cK3H2Okg5BrfyooHVvc8CI91vYiJk5oUt015owzm1R1HATe+S3KsfV2XyJZXoIYe
         vs7oBXj7q3dXqDc5Qs8mdNKDEgvUjZKTC0EgvdTx3vfBU4qFxSMI8qUIjsS0ulunSzgf
         qrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YQ8iQqe0A5/uglekK6JjLVqTME4ar4CUT63VuUJgkz0=;
        b=YyGp0e2wl/slsk4l6EiRAXiqZ2JHjsIvnCn5u8NEeTti68o/NCjIPk3FiYgsvOjWnm
         B+tz0a/M2p+gZh/W/3lUAcuZ0Skt+RUDa/GOHnCidOc2/6WHJsz6p9ydx5DVz0BQCF5Q
         tooXXtY6I3H7a0SVHVQSIkZIDbirv+g6znx/CiJ+AZF3C5yZfQGgthKYboMHhBnvag2+
         M8WnXOF2V6MKwcpDcHgA+YIZU/kiQ2GRy5PDe+6qARcDK3G+JAVF8EoRkrwfp3ddwmxa
         Luv37hI0U+ri62o1L3mEk2VrYcDM+bITLdDZTTrtxCCCKfppRirFutX+TiRvWyS/nw9u
         p44g==
X-Gm-Message-State: AOAM530IIn0U/LXg1vU3RPg15nQyhaOvlxzEVFJx7+2EuxMhxwU+QfSU
        ZO+8a2Q0BigFGWYsQx1WM0aeG5kXYaY=
X-Google-Smtp-Source: ABdhPJyDp/o/b9Dck15/LZ9TULFM/NU7si9K5iYw6W4JSgsfDDBQlxLmuKjb6cCkGEI5Ol1VvJOMAQ==
X-Received: by 2002:ac8:20f:: with SMTP id k15mr46428797qtg.173.1638867236469;
        Tue, 07 Dec 2021 00:53:56 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id bp38sm7797797qkb.66.2021.12.07.00.53.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 00:53:56 -0800 (PST)
From:   Vincent Shih <vincent.sunplus@gmail.com>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        wells.lu@sunplus.com
Cc:     Vincent Shih <vincent.sunplus@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver
Date:   Tue,  7 Dec 2021 16:53:53 +0800
Message-Id: <1638867233-8383-3-git-send-email-vincent.sunplus@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638867233-8383-1-git-send-email-vincent.sunplus@gmail.com>
References: <1638867233-8383-1-git-send-email-vincent.sunplus@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings doc for Sunplus OCOTP driver

Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
---
Changes in v2:
 - Address the comments from Mr. Rob Herring

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

