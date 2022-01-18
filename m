Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084EF491314
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbiARBB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiARBBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:01:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77987C06161C;
        Mon, 17 Jan 2022 17:01:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j7so24188150edr.4;
        Mon, 17 Jan 2022 17:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M1ATHqKukkS8wdcox6Oca6+wxzUoLyKhXdX3OudoHRM=;
        b=fFMoHeEPVOAEEVkE3CTtbtVkXhTTwrQeaKaYiBYD1+WStpoySc37Ht398xyrmfRLbN
         qLWTrLlnycDSayXUrxIgQ0roZpimVQtscWRWCkxEzPPD8u/k1oX1agrUL1KLD6TCWgzS
         RrQJ8pNUjmKoB9zBYIfHGw6PH86VF0R53MSJgiMB0H4KJBpgOryxZOT1nGAVzngWJ4kb
         srvzXnHQ8frt4xcXAMScrmlxUTqhHe8xvjSHwyz8IQzsPWl9b7+96sGZU3qMF8mj9Ev5
         FG0La58RXiMaC2kzwMV03qok5Jh01n3s6mz4WAWhfzvJHeTMFmnQKakFW1vltp8hdG9Q
         kYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1ATHqKukkS8wdcox6Oca6+wxzUoLyKhXdX3OudoHRM=;
        b=FKSaz7mR9dXWRmp6eFgfxq0LoD3hBJN/NEJJwJO9SdPd4X/THxy900pRhEoHXOcVgY
         Gh6O6uYhIkhfSp/ex4YbLJKY1FxuFDcqGF+LG5/2Ob5OTpE3aRN6HrvHr1pxad7vRwq+
         cpOdnSzqXiAEX6sU75bCaoaFKH6RszdkHen377AoKHDJZ9PUifp9jFBNSS7KMW80OQER
         Hkpb53N3ZeYXlMt9VftaW53MPJQXhisDJJe3iPR5H8J/kjXqPYBMbZsO9rjTmdjsPE+F
         vpnJWFbf4Vo69bjo5cjhY3ez+CXPLjDkqXoS6GyB3M4n7aMW6BgBfY/77zUuGutD0Idw
         ycjg==
X-Gm-Message-State: AOAM5327kfM3YaAJ7ie+gMZU8PinwiSDScTMa/Z+iHCt6KG9bNS4JASt
        xCT9zQcVC/Sk2S7pX3yd4Ko=
X-Google-Smtp-Source: ABdhPJxSJEsUeQTLwmAjMZUiRgjC3kNpj/Ok6kOddHIsMYUjHadf3yzQ/lLZBwOVNleYZFiFG8mlzg==
X-Received: by 2002:a17:906:7044:: with SMTP id r4mr18735298ejj.351.1642467712903;
        Mon, 17 Jan 2022 17:01:52 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:01:52 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] dt-bindings: clock: Document qcom,gcc-ipq8064 binding
Date:   Tue, 18 Jan 2022 01:44:21 +0100
Message-Id: <20220118004434.17095-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
clocks. The gcc node is also used by the tsens driver, already Documented,
to get the calib nvmem cells and the base reg from gcc.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-ipq8064.yaml      | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
new file mode 100644
index 000000000000..2dc254fdf161
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains on IPQ8064.
+
+properties:
+  compatible:
+    const: qcom,gcc-ipq8064
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PXO source
+      - description: CX0 source
+
+  clock-names:
+    items:
+      - const: pxo
+      - const: cxo
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: true
+
+examples:
+  - |
+    gcc: clock-controller@900000 {
+      compatible = "qcom,gcc-ipq8064", "syscon";
+      reg = <0x00900000 0x4000>;
+      clocks = <&pxo_board>, <&cxo_board>;
+      clock-names = "pxo", "cxo";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+
+      /* Tsens node definition */
+
+    };
+...
-- 
2.33.1

