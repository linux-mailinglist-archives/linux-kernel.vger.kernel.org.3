Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D390A496893
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiAVAQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiAVAQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:16:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C55C06173B;
        Fri, 21 Jan 2022 16:16:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a18so45366867edj.7;
        Fri, 21 Jan 2022 16:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GwuVH4I59eQaG7p98/FZiWJJ0iSClS0+NYlBxkqRKh4=;
        b=PURVrcWLjZgtzaQZlZ/rVdY5MuNokOUVc4E5tg2wlx73lXCJbObGzQd5IRdtaqARKw
         PFZS4QhyddtOqlTx7p0OhAQQVdEZZzYVESPgIrlTmFIg9msxgpKe21bCJojVqyCASHXo
         mDQIrNLHf5MP2WK67mtg83ade/OVJDVz3XL4qShSa4aHl1hxYvHNVf92+5bB1VE7vdNl
         k5GNZpjudNVderryUvC3CwqLHNviSGEVmYabxjoWtf5cr+/4Fg13A/GtV8MK5V75vqoa
         kLzzfLPKRV45blDaaZFigmxk3oajMJKPmeDPdi0WhzguLOSL/68nRcyPQJ7FJVB8DkRl
         5eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwuVH4I59eQaG7p98/FZiWJJ0iSClS0+NYlBxkqRKh4=;
        b=m/LQXBL8O/gFRXS8VI//vknj6DMEZ7M/IrU3bQ9Gi7G61kToA3S5BLSgrtSGIDAn5f
         c++TmbeUFX/d8Lb9DZpi1wAcvWMp5bf9O2R5UusWcpelQ1k2VE6lLp8HwBHA0otdiIRn
         FXA4KWFg5vkPZlrcHvvC/NAD1v9d/Pn/3xRKM71uAotvL9DJP/t+Rdat9pR2ANPpkrOl
         8zG2LsZO5dVW6gdM4CCwhmFVguW3r0ZRcndrkf3962J8nPUv1v1f5ZvBPOGE23PNH77X
         GxfCZaUo0UGZTbLY4lQcrvdYQgVFxvAPYoelu4+nqIfPvPJAs7bSVUzGstcF2kmuU+Y8
         1Yig==
X-Gm-Message-State: AOAM530da4kRMIzeK7Cj7V5RDDlJqgz+KzeEoUmpolGO7IaV4rqghF3g
        OepeemNU5iLiJPWVlhc67M8=
X-Google-Smtp-Source: ABdhPJxqlVb+yKTVVWqSaSaxUaQ3uZVPdy1kI+x2f3SZYEH0uxkKLNYf2mPXan4OCPJ/Z79kSaujXA==
X-Received: by 2002:aa7:cb82:: with SMTP id r2mr6309976edt.47.1642810581963;
        Fri, 21 Jan 2022 16:16:21 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d8sm2445525ejy.107.2022.01.21.16.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:16:21 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: soc: qcom: add qcom,tcsr bindings
Date:   Sat, 22 Jan 2022 01:16:08 +0100
Message-Id: <20220122001609.15904-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220122001609.15904-1-ansuelsmth@gmail.com>
References: <20220122001609.15904-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom,tcsr-ipq8064 and qcom,tcsr-ipq4019 Documentation for the
tcsr present in ipq8064 and ipa4019 required to configure and
set various peripherals present in the SoC.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/soc/qcom/qcom,tcsr-ipq4019.yaml  | 93 +++++++++++++++++++
 .../bindings/soc/qcom/qcom,tcsr-ipq8064.yaml  | 47 ++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
new file mode 100644
index 000000000000..3a82ccbb6588
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,tcsr-ipq4019.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Top Control and Status Registers binding for IPQ4019
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  This binding describes the Qualcomm Top Control and Status Registers, used
+  for accessing configuration and mux settings for a variety of peripherals
+  for ipq4019.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,tcsr-ipq4019
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  qcom,usb-hsphy-mode-select:
+    description: Select usb hsphy mode for ipq4019
+    enum:
+      - 'host'
+      - 'device'
+
+  qcom,ess-interface-select:
+    description: Select ess interface mode for ipq4019
+    enum:
+      - 'psgmii'
+      - 'rgmii5'
+      - 'rmii0'
+      - 'rmii1'
+      - 'rmii0_rmii1'
+      - 'rgmii4'
+
+  qcom,wifi-glb-cfg-enable-axid:
+    description: Enable AXI master bus Axid translating
+                  to confirm all txn submitted by order for ipq4019
+    type: boolean
+
+  qcom,wifi-glb-cfg-socslv-mode:
+    description: Select wifi socslv mode for ipq4019
+                  snoc use SNOC socslv_wxi_bvalid.
+                  local use locally generate socslv_wxi_bvalid for performance.
+    enum:
+      - 'snoc'
+      - 'local'
+
+  qcom,wifi_noc_memtype_m0_m2:
+    description: Configure special wifi memory type needed for
+                  some IPQ40xx devicesfor ipq4019
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    tcsr@194b000 {
+      compatible = "qcom,tcsr-ipq4019", "syscon";
+      reg = <0x194b000 0x100>;
+      qcom,usb-hsphy-mode-select = "host";
+    };
+
+    tcsr@1949000 {
+      compatible = "qcom,tcsr-ipq4019", "syscon";
+      reg = <0x1949000 0x100>;
+      qcom,wifi-glb-cfg-enable-axid;
+      qcom,wifi-glb-cfg-socslv-mode = "local";
+    };
+
+    ess_tcsr@1953000 {
+      compatible = "qcom,tcsr-ipq4019", "syscon";
+      reg = <0x1953000 0x1000>;
+      qcom,ess-interface-select = "psgmii";
+    };
+
+    tcsr@1957000 {
+      compatible = "qcom,tcsr-ipq4019", "syscon";
+      reg = <0x1957000 0x100>;
+      qcom,wifi_noc_memtype_m0_m2;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
new file mode 100644
index 000000000000..4ccc0bfccec5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,tcsr-ipq8064.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Top Control and Status Registers binding for IPQ8064
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  This binding describes the Qualcomm Top Control and Status Registers, used
+  for accessing configuration and mux settings for a variety of peripherals
+  for ipq8064.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,tcsr-ipq8064
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  qcom,usb-ctrl-select:
+    description: Select usb3 ctrl type for ipq8064
+    enum:
+      - 'p0'
+      - 'p1'
+      - 'dual'
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    tcsr: syscon@1a400000 {
+      compatible = "qcom,tcsr-ipq8064", "syscon";
+      reg = <0x1a400000 0x100>;
+      qcom,usb-ctrl-select = "dual";
+    };
+
+...
-- 
2.33.1

