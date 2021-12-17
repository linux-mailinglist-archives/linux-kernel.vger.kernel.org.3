Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E84479535
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhLQT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbhLQT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:57:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F6C06173E;
        Fri, 17 Dec 2021 11:57:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j9so6174165wrc.0;
        Fri, 17 Dec 2021 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w4WnYopJ+MjFxrLG5jbdWepbHL1AIT2pQAOmcq4aOS0=;
        b=KWgq/hjsNb7oTDTvs0OdRsT1MMm3cRHX9ZlorpSz6CWiWlJhmuWYu+HfmZw7Wbwfsm
         SND6nOH8vhG/evtVi2C+9ODuEUTkkDLvQxVOF+pSWFqJinZxJbcdcZ6GTIhcs8yCh1Tl
         Ihv0HxEKKn0fYYR60AOZwJhlhzqIWMNGsG+7ODKbTPyxpqVWncE4j/u9Xs48aWw4sp1d
         lCpL6mv/Ghx3deihQtpMBYynOiPZmdTYBMlb/1pI8RH6qnRUGVTjuehm8nzGZ8RZM4TY
         Z1kVewZjowp0GM6NE+92Ddqfdp5elSZebHb0jdSkZNV9BItfxh/jQf5pDSRg4cBpjFM9
         tivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w4WnYopJ+MjFxrLG5jbdWepbHL1AIT2pQAOmcq4aOS0=;
        b=ODKmUre2w7jFGiqSIMbJMNFl0fs3xunAULCtz+v1DBVHWzgpN23efyrdSjH5K3e2nx
         QBsyAaaRlky8o929ty21AKZebJGzn3CzYk3jsk+tKGt7W27r8Fo9YubwjBqgPWNCLDwU
         HcUg95neaTmBTA2+v+L/0pIGwefkyjgiOm2EalRU6uPWqtvpxWt3KyJ2CRp9OqMel3y+
         9hcDtZqv5ZUNmYHmXsFAmcWQ9USlQjgJOJU2kEvXoULQ0BVeEW5q3ZocYf/Bed3DxczL
         ygGrpwdWM6HlFPby2DnSIWnwiOJwsfA540OgYlz8hZIZVJgdvtYdNFolKG7mS9dk5ThT
         VrwQ==
X-Gm-Message-State: AOAM530gSll8T0s2/Ig7RCkJNDSgUporA+kt1+HWex6kxCw7JN/VZZrR
        EihZYYxWoAVYUnXe7Ekf1gw=
X-Google-Smtp-Source: ABdhPJz40c2vF2seBwepqXHI4jkPlyJ6XkF5fWJBc0opI3YJhOFcBgsN1oqCPu+GQPFH59KHQWxjtQ==
X-Received: by 2002:a05:6000:1a41:: with SMTP id t1mr3829849wry.261.1639771063324;
        Fri, 17 Dec 2021 11:57:43 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id y7sm7828848wrw.55.2021.12.17.11.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 11:57:42 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/6] dt-bindings: timer: Add Mstar MSC313e timer devicetree bindings documentation
Date:   Fri, 17 Dec 2021 20:57:25 +0100
Message-Id: <20211217195727.8955-5-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217195727.8955-1-romain.perier@gmail.com>
References: <20211217195727.8955-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the documentation for the devicetree bindings of the Mstar
MSC313e timer driver, found from MSC313e SoCs and newer.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/timer/mstar,msc313e-timer.yaml   | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
new file mode 100644
index 000000000000..03d5dba5d5b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/mstar,msc313e-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mstar MSC313e Timer Device Tree Bindings
+
+maintainers:
+  - Daniel Palmer <daniel@0x0f.com>
+  - Romain Perier <romain.perier@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - mstar,msc313e-timer
+      - sstar,ssd20xd-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@6040 {
+        compatible = "mstar,msc313e-timer";
+        reg = <0x6040 0x40>;
+        clocks = <&xtal_div2>;
+        interrupts-extended = <&intc_fiq GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
2.34.1

