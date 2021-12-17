Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04F547922F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhLQQ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbhLQQ72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:59:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A761C06173E;
        Fri, 17 Dec 2021 08:59:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id b73so2082811wmd.0;
        Fri, 17 Dec 2021 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ZlLUP4XgIE4NT0c5bAVzaLeJJFe/rNpm6y6BdtI1t8=;
        b=ExbrIwxXwoxPLQXfn69agiq3TU56Wo2t1df7LC324hHtbj4HpoGPOsiJqayYNK7A2R
         THAj07byNahifrH2LKT/EPf6B+VHACy3DFArJJ7pUeZFLiafBbrKzbG6UN1pdfMAP5ZO
         3ESciShODpXVslHCJLmdvBsA8UhvGkXr8FUAWjTccqv+T6qWyste7yGifLctCMXnq3Gj
         /LEpK4OTXPFzK+lHOBC+hVS6gFfszydzmKWbxtXg/Ey/VcsXriDJ4YWYqxCWemkpdDdd
         4XeZlONkEG32Tt3AoYI7QZNYfqaV258750AIIO3y6+mthAwWT8ayGftcm1BjXYlRGb3m
         KI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ZlLUP4XgIE4NT0c5bAVzaLeJJFe/rNpm6y6BdtI1t8=;
        b=K2xctTrYKcHkvPNCH3Lvy7a8XJXOc8jcDENANA9QWGhybaPLeTr/JvnmdLzgVOvNVR
         rdXmZlQDcjaUTNuw1VtwjurPAk4cUSeCuUL5E2poEJooh4Y9imzMEuVDztQGxSVnuf7b
         /fyyv3DUvW98pTOVcNi7wkOGjJdRnH3F+vdE9lMv/jeHqwRct6xR6ttR2jBEYBKpskm0
         sWGsvvICZhl9+1xeKAbFMxzpHwCEO6bdZaFyfdNEm60hRrS81NDO/iJ7MfuA4Du52i90
         FVobe7Yo44rw35g++23h2LL7YStUb2hmHwVFtYLYULtdSoKYQOT6Iju77JJ7Al8SAuKY
         vVRw==
X-Gm-Message-State: AOAM532GR9uNC7P1H3d58Z3CCpujPtFizoZ/gW9+FsnxnQZz18WSgNDY
        3RxI0n4LoggDO5wJJazivxQ=
X-Google-Smtp-Source: ABdhPJy8gxdB/XVC9F5X29i+1tv2zPWu+CB3KvQbUb7YwO+ucF2BRfonjEm9sWs4Fuja4K7DUDZDFg==
X-Received: by 2002:a7b:c4c8:: with SMTP id g8mr1502863wmk.171.1639760365833;
        Fri, 17 Dec 2021 08:59:25 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id r8sm4494715wru.107.2021.12.17.08.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:59:25 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: memory: Add Tegra114 memory controller bindings
Date:   Fri, 17 Dec 2021 17:59:17 +0100
Message-Id: <20211217165919.2700920-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217165919.2700920-1-thierry.reding@gmail.com>
References: <20211217165919.2700920-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Document the bindings for the memory controller found on Tegra114 SoCs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../nvidia,tegra114-mc.yaml                   | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra114-mc.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra114-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra114-mc.yaml
new file mode 100644
index 000000000000..2fa50eb3aadb
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra114-mc.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra114-mc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra114 SoC Memory Controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+description: |
+  The Tegra114 Memory Controller architecturally consists of the following parts:
+
+    Arbitration Domains, which can handle a single request or response per
+    clock from a group of clients. Typically, a system has a single Arbitration
+    Domain, but an implementation may divide the client space into multiple
+    Arbitration Domains to increase the effective system bandwidth.
+
+    Protocol Arbiter, which manage a related pool of memory devices. A system
+    may have a single Protocol Arbiter or multiple Protocol Arbiters.
+
+    Memory Crossbar, which routes request and responses between Arbitration
+    Domains and Protocol Arbiters. In the simplest version of the system, the
+    Memory Crossbar is just a pass through between a single Arbitration Domain
+    and a single Protocol Arbiter.
+
+    Global Resources, which include things like configuration registers which
+    are shared across the Memory Subsystem.
+
+  The Tegra114 Memory Controller handles memory requests from internal clients
+  and arbitrates among them to allocate memory bandwidth for DDR3L and LPDDR2
+  SDRAMs.
+
+properties:
+  compatible:
+    const: nvidia,tegra114-mc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mc
+
+  interrupts:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+  "#iommu-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#reset-cells"
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra114-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    memory-controller@70019000 {
+      compatible = "nvidia,tegra114-mc";
+      reg = <0x70019000 0x1000>;
+      interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks = <&tegra_car TEGRA114_CLK_MC>;
+      clock-names = "mc";
+
+      #reset-cells = <1>;
+      #iommu-cells = <1>;
+    };
-- 
2.34.1

