Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC1E47318D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbhLMQWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbhLMQWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:22:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1FC06173F;
        Mon, 13 Dec 2021 08:22:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t18so27928102wrg.11;
        Mon, 13 Dec 2021 08:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGHox2XqcjEj0O3Eur0yu9+lJ3dQ0YslyKM1fbePmRo=;
        b=cWug8ImL45Z3L6e3qp1CFXrS5DTcrO1zMThPVCSyBLex2puX5KOL7BJIQlDJCAfV9b
         9bn08c3/6MkNI+tPJXoDCgONiUX16CP+R5cy5jz2R2b5S3WqxrPvdNwimL6d9s52/R1D
         4iRf1pqmEES/1IPuVbM/B1JA1UH3u7ZLpliz6fONoWHRCnBRRxFboViAk2CHBSf4NV9k
         oomJCiSI0bY/rR+Sr4imzBnruBaPUQo9zq2Hn9SnrSkBdFZgVNtEqXuVlXMiHfUl7OgW
         knxagiH1F+2mJh+6GqcQ80kGROrlwJEilcdXxS3XyeRDfZAmJ2K5zXnNcW88rr71nRhY
         CMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGHox2XqcjEj0O3Eur0yu9+lJ3dQ0YslyKM1fbePmRo=;
        b=ZfpSysKheXnqDZuvmTMdlY9sMqBK+RyoG7JyW/5Uie/K9vdeAO79NoGs7xbjgFXKfn
         n3g3Vk5Ga6JJEwlI3iJjOjXDaOvu78HcJzTHrq4CpO+szApONaP/x7PFLE62ID59w0Jw
         apLA0G7gcu3tS7TbT470L2WUaHRbJ/y0cZGNj+DJ+EhV0fiUkfhDtr7TdOO6HMBcO8Ax
         CPEG1NhNXJkCiexg3/dr4SRb3VRgowDXp7BD5eSlNTblV6ib7jVUBtNdyrSXEazQTr2s
         ftUv1Hront5+ydOf+r428PwtVStCK78x6Re5MOby/bAS0InUxgSB6Be0TjuZw7LAJtbB
         tV3g==
X-Gm-Message-State: AOAM530De6W0wTAW3Ij+G1vMwF9d8s0MtFdKG8Cv0f7gQ4wPgdfWj0Jy
        GH2Gd2AzjAeH4wB0z30FmfA=
X-Google-Smtp-Source: ABdhPJy06Rl/IoOIeGjjxTeDZHBrhTb8RtvMu+pKy78q229/joyNihyVnJc6Z0QNnqCFD4+PKlAAOg==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr31648153wru.388.1639412519331;
        Mon, 13 Dec 2021 08:21:59 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id j18sm9391554wmq.44.2021.12.13.08.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:21:58 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/6] dt-bindings: memory: tegra: Add Tegra234 support
Date:   Mon, 13 Dec 2021 17:21:47 +0100
Message-Id: <20211213162151.916523-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213162151.916523-1-thierry.reding@gmail.com>
References: <20211213162151.916523-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Document the variant of the memory controller and external memory
controllers found on Tegra234 and add some memory client and SMMU
stream ID definitions for use in device tree files.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- conditionally set minItems for reg properties

 .../nvidia,tegra186-mc.yaml                   | 20 ++++++++++++
 include/dt-bindings/clock/tegra234-clock.h    |  9 ++++++
 include/dt-bindings/memory/tegra234-mc.h      | 32 +++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 include/dt-bindings/memory/tegra234-mc.h

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index b496564b1bdf..13c4c82fd0d3 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -31,6 +31,7 @@ properties:
       - enum:
           - nvidia,tegra186-mc
           - nvidia,tegra194-mc
+          - nvidia,tegra234-mc
 
   reg:
     minItems: 1
@@ -68,6 +69,7 @@ patternProperties:
           - enum:
               - nvidia,tegra186-emc
               - nvidia,tegra194-emc
+              - nvidia,tegra234-emc
 
       reg:
         minItems: 1
@@ -112,6 +114,15 @@ patternProperties:
             reg:
               minItems: 2
 
+      - if:
+          properties:
+            compatible:
+              const: nvidia,tegra234-emc
+        then:
+          properties:
+            reg:
+              minItems: 2
+
     additionalProperties: false
 
     required:
@@ -142,6 +153,15 @@ allOf:
         reg:
           minItems: 3
 
+  - if:
+      properties:
+        compatible:
+          const: nvidia,tegra234-mc
+    then:
+      properties:
+        reg:
+          minItems: 3
+
 additionalProperties: false
 
 required:
diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bindings/clock/tegra234-clock.h
index 21ed0c732fb9..8d7e66e1b6ef 100644
--- a/include/dt-bindings/clock/tegra234-clock.h
+++ b/include/dt-bindings/clock/tegra234-clock.h
@@ -9,6 +9,15 @@
  * @defgroup bpmp_clock_ids Clock ID's
  * @{
  */
+/**
+ * @brief controls the EMC clock frequency.
+ * @details Doing a clk_set_rate on this clock will select the
+ * appropriate clock source, program the source rate and execute a
+ * specific sequence to switch to the new clock source for both memory
+ * controllers. This can be used to control the balance between memory
+ * throughput and memory controller power.
+ */
+#define TEGRA234_CLK_EMC			31U
 /** @brief output of gate CLK_ENB_FUSE */
 #define TEGRA234_CLK_FUSE			40U
 /** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC4 */
diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
new file mode 100644
index 000000000000..2662f70c15c6
--- /dev/null
+++ b/include/dt-bindings/memory/tegra234-mc.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+
+#ifndef DT_BINDINGS_MEMORY_TEGRA234_MC_H
+#define DT_BINDINGS_MEMORY_TEGRA234_MC_H
+
+/* special clients */
+#define TEGRA234_SID_INVALID		0x00
+#define TEGRA234_SID_PASSTHROUGH	0x7f
+
+
+/* NISO1 stream IDs */
+#define TEGRA234_SID_SDMMC4	0x02
+#define TEGRA234_SID_BPMP	0x10
+
+/*
+ * memory client IDs
+ */
+
+/* sdmmcd memory read client */
+#define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
+/* sdmmcd memory write client */
+#define TEGRA234_MEMORY_CLIENT_SDMMCWAB 0x67
+/* BPMP read client */
+#define TEGRA234_MEMORY_CLIENT_BPMPR 0x93
+/* BPMP write client */
+#define TEGRA234_MEMORY_CLIENT_BPMPW 0x94
+/* BPMPDMA read client */
+#define TEGRA234_MEMORY_CLIENT_BPMPDMAR 0x95
+/* BPMPDMA write client */
+#define TEGRA234_MEMORY_CLIENT_BPMPDMAW 0x96
+
+#endif
-- 
2.34.1

