Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2405684B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiGFKIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiGFKHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:07:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCB025582
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:07:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso11286472wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GsKQGIpQTwkDYs1a8G5UjaLMFoBV/yI+u/f+pS1dm38=;
        b=JWG78Yp3WrlWoKaASLgHfdjz+LxEyznkvbrAtialqhsPw+EMURbDhTzXdKtehHIl6Y
         kU8VPel7+w1BTiHXzBmNA7NmBpmLbdglclh5xVbfuvalYCOvurSK9IL/BTaNO94G0R+i
         ZOzH6EZK+I8M42oimuKRXs/k6cga+d7lOyJfw6UeN/Du2N/+Kq6PeZQVsEM5KspX0KoW
         XA/Bc0mjNPoU0eNuUKN7WrAyzy+cHuVnX757RWjKvy52lsJNYEGPTCL2l16+vlCU9dwe
         uawfbvqMSqmSoZC33TP5cV37M/q0ZYKCQxHa1fO7Ji9mqNoS0GWWEPZrl4mtmpC7S3OH
         auNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GsKQGIpQTwkDYs1a8G5UjaLMFoBV/yI+u/f+pS1dm38=;
        b=Xbs1QoJJ6uvLaS3ZGLTAs5K2Ur06f4sWmtIOkB9Iyt9mdHLgSJEeAfU+xPyHHhTMDR
         5x7zs4qbYx2qO+OfYW08FJk5gl2WKMaA8i8nnLaZ1JZu3JhmvHaP1xbAF0gsgtubsqjG
         WYfurKdNx8b9Ks23ZGl2KuM8f3hPL9X/dT97/Iru3M0DbJ6Rnu3GHlRLjTOZbd2qliLO
         edt9UIU3wHtAthmgkJ001yTPgzNHXJ0T8O56FIPxyjC+eH8c3hdbsngX/CEmrGrhJVAN
         SeSh1EWIaVmU5qBR051uzLGgP06h1C33sAGL3MvKyEG1/hFpcYagPq15d85IEbwVgLD1
         5QPA==
X-Gm-Message-State: AJIora/4NzB5kVJ6L1t+k8dyoSCTsskfyfjQ/VvOlvkL4At5rANkJGuG
        3FWepRgk2/p1UpXZmhX+Bx45Iw==
X-Google-Smtp-Source: AGRyM1ug07Xb+KtSaJbUNFPrOHVAJbo7g59lViVhfiEYaSDsFap5SpUUt4EMBSn8MOQ5R+Fyf5zUyQ==
X-Received: by 2002:a05:600c:a42:b0:39c:9166:5a55 with SMTP id c2-20020a05600c0a4200b0039c91665a55mr40867755wmq.141.1657102048501;
        Wed, 06 Jul 2022 03:07:28 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm24678143wms.18.2022.07.06.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:07:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/7] dt-bindings: microchip-otpc: document Microchip OTPC
Date:   Wed,  6 Jul 2022 11:06:21 +0100
Message-Id: <20220706100627.6534-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
References: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Document Microchip OTP controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../nvmem/microchip,sama7g5-otpc.yaml         | 50 +++++++++++++++++++
 .../nvmem/microchip,sama7g5-otpc.h            | 12 +++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 create mode 100644 include/dt-bindings/nvmem/microchip,sama7g5-otpc.h

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
new file mode 100644
index 000000000000..c3c96fd0baac
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/microchip,sama7g5-otpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip SAMA7G5 OTP Controller (OTPC)
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description: |
+  OTP controller drives a NVMEM memory where system specific data
+  (e.g. calibration data for analog cells, hardware configuration
+  settings, chip identifiers) or user specific data could be stored.
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: microchip,sama7g5-otpc
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/nvmem/microchip,sama7g5-otpc.h>
+
+    otpc: efuse@e8c00000 {
+        compatible = "microchip,sama7g5-otpc", "syscon";
+        reg = <0xe8c00000 0xec>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        temperature_calib: calib@1 {
+            reg = <OTP_PKT(1) 76>;
+        };
+    };
+
+...
diff --git a/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
new file mode 100644
index 000000000000..f570b23165a2
--- /dev/null
+++ b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
+#define _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
+
+/*
+ * Need to have it as a multiple of 4 as NVMEM memory is registered with
+ * stride = 4.
+ */
+#define OTP_PKT(id)			((id) * 4)
+
+#endif
-- 
2.25.1

