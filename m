Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC8471C25
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhLLSTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhLLSTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:19:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923EC0617A1;
        Sun, 12 Dec 2021 10:19:14 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k9so5750641wrd.2;
        Sun, 12 Dec 2021 10:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0nR4PIR3OnyUGUTm0c+KArFCzRTtEJ8r3UvB0CQeS4=;
        b=QFq1Bm+UG2w/MhI8RuxuY9xElFvii+rP5j8p5MLKeMkG1DqLsCY+HII7sNcPY1gasr
         3GUyN0EnC69aRLdSVqPQuag3gyA4OpliXwET7SeRQjyuZpuDRotoF6RODrjr4HvL6mO8
         venCb/1pdCPOgo7H+2EIAFVtIHsRdOLNv4B1MIU5ug46oiDa10Tj4PusAEUOwGxqhwHP
         CkNRbMPQU7eoYwQ4VrcgW/qc+vjK7NM2fyGCiBTie/PTxdlATUn3+x2cwDMnMc/yK2KV
         ekcv6tF/xqoH5WJ9lApEPZWumyvMBSLCIrVFfuWaX541bEA9ziilN40+CN2S6b8PdE7O
         74OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0nR4PIR3OnyUGUTm0c+KArFCzRTtEJ8r3UvB0CQeS4=;
        b=cl6h3NYNaeRC3wpTbiGwmhfrD/1QX8TaQW7KTlQ4KmSdyecbG/umcn5oVlslKGv5Me
         hF/gCl7t0b/W9Q1WRp+5cYx8pwcuokV6eCMkRnXDXrls3sfUAIfsfg3DTS0sI7MJVCRZ
         epX5iVVTPZ0G63J42Dy3HfdhhhvkFFwh7jtJyAGbMwvbfIOP2I82IHKaT0Dw4NXRCow9
         +cF8BxveqCNQYFwY5BS3dDaBTYzSYwP6KTPCAWxt6dosQfzWw+lUW+LKxzu0CRM8rcSx
         h1GiF/SkTWk3bmJ7ZQihBsW8fvfF+JYh8PGop58FIhBjxp1AOlYQ1wYCYSZdZPWjshP0
         Hw+w==
X-Gm-Message-State: AOAM532AdJTZfgslpn/6mnH7ej12FX36XhS6gIgpalv/LZ0cWco84hLF
        XJpaqmlZwNlXbK+Y5RhfoilabBa5ZPI=
X-Google-Smtp-Source: ABdhPJytrFUrVnTGh8Yd56GrBAMZLvk3RaThDeLPwSjdH5r/VLZ7WEBxC/FaoHdXfcBZA6GoKoTD7A==
X-Received: by 2002:a05:6000:1a86:: with SMTP id f6mr87634wry.231.1639333152939;
        Sun, 12 Dec 2021 10:19:12 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id o12sm10580061wrc.85.2021.12.12.10.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:19:12 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] dt-bindings: timer: Add Mstar MSC313e timer devicetree bindings documentation
Date:   Sun, 12 Dec 2021 19:19:04 +0100
Message-Id: <20211212181906.94062-5-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212181906.94062-1-romain.perier@gmail.com>
References: <20211212181906.94062-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the documentation for the devicetree bindings of the Mstar
MSC313e timer driver, found from MSC313e SoCs and newer.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
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
2.33.0

