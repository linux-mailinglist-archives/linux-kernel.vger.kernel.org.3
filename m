Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F234E1CD2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245684AbiCTQaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245557AbiCTQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665923585B;
        Sun, 20 Mar 2022 09:28:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j10so4786862wrb.13;
        Sun, 20 Mar 2022 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Uw2FgXL2MG6c1O6jLTs0CVZuitMyMBRaze5ZuwDxY6M=;
        b=MlcxB5b6b6VXQQFL4W/XmzxZwI1BpuQNepAMcrLZAhfmZZRhm1j1W6jChuCiwZ50Fw
         Mb3IVa66bZUPLCi4X7WRw/hcAflBCE2r2dKnKcAdRGfgMScfi/JYhtpD+O0JhspS4xwk
         yn8tusbHISLjtvBd8hF16y+TmTZ5OJ8IOT7dbh/OnLawNn4cAEQadxuHHXGIxN5DdR0C
         A/XW0tp7jmBMU3sBEOMjsohrazOlB37opjvsftWsShWGnHz+1g5g9ULOHRp9Zj6K1xd2
         onR0GxF1ccM4Fi22Pz01YsM9sMIoBAsniaUD7CSZYQR9Yvjtq4DI29kf1e7BfDvemwsu
         d+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uw2FgXL2MG6c1O6jLTs0CVZuitMyMBRaze5ZuwDxY6M=;
        b=sZld4a6u/okxgmQX8XBs8/IB8AfTvl13d0yCJFLQ/QtcjekTjHdyDb0W6Fl5z4px2z
         46ebTShbb5MiwdBOOFnZyBsTh6u6yYgcIYCvzP8h58h1vXsS0a5hu513Nha4FtjI2Y5Q
         OzSJSa9eWPsNbT+XQvbNNIKplog08wnd5r6jkpc4RMWoDAFbODhnSnvIjty6DVl5XmKc
         6i0DRSXq9yXaj/gnNoeDQS3X51Am8nOblf6R1pdFIqtvhL88oADP+8Mn8KrBnFjMA12M
         Qzisqu6+uqGfvKRth4s8m//5vNiDaPHSzq0eQ2NapejWIhaZg3VM7KM59Vqsuo5FV/RO
         p8hw==
X-Gm-Message-State: AOAM533w0RaubIp41YrIc2bD0tjBBYtj9DTg56lfxjBti6t/WS96x/xN
        ccNU2FL8KbFYUx+CqCN9wrk=
X-Google-Smtp-Source: ABdhPJxuN/CtqeHIEo6ox/UTDdleHxTwkFNSSbvHF/17UR/qoDBoag9oEwXwNDgCcK4K+MmQ2aMlTA==
X-Received: by 2002:a05:6000:1ace:b0:203:d465:1a83 with SMTP id i14-20020a0560001ace00b00203d4651a83mr15195713wry.26.1647793706671;
        Sun, 20 Mar 2022 09:28:26 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:26 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 14/18] dt-bindings: clock: Convert qcom,krait-cc to yaml
Date:   Sun, 20 Mar 2022 12:34:26 +0100
Message-Id: <20220320113430.26076-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert qcom,krait-cc to yaml Documentation.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,krait-cc.txt          | 34 -----------
 .../bindings/clock/qcom,krait-cc.yaml         | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
deleted file mode 100644
index 030ba60dab08..000000000000
--- a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Krait Clock Controller
-
-PROPERTIES
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-			"qcom,krait-cc-v1"
-			"qcom,krait-cc-v2"
-
-- #clock-cells:
-	Usage: required
-	Value type: <u32>
-	Definition: must be 1
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the clock parents of hfpll, secondary muxes.
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
-
-Example:
-
-	kraitcc: clock-controller {
-		compatible = "qcom,krait-cc-v1";
-		clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
-		clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
-		#clock-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
new file mode 100644
index 000000000000..3223fce915bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,krait-cc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Krait Clock Controller
+
+maintainers:
+  - Ansuel Smith <ansuelsmth@gmail.com>
+
+description: |
+  Qualcomm Krait Clock Controller used to correctly scale the CPU and the L2
+  rates.
+
+properties:
+  compatible:
+    enum:
+      - qcom,krait-cc-v1
+      - qcom,krait-cc-v2
+
+  clocks:
+    items:
+      - description: phandle to hfpll for CPU0 mux
+      - description: phandle to hfpll for CPU1 mux
+      - description: phandle to CPU0 aux clock
+      - description: phandle to CPU1 aux clock
+      - description: phandle to QSB fixed clk
+
+  clock-names:
+    items:
+      - const: hfpll0
+      - const: hfpll1
+      - const: acpu0_aux
+      - const: acpu1_aux
+      - const: qsb
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+      compatible = "qcom,krait-cc-v1";
+      clocks = <&hfpll0>, <&hfpll1>, <&hfpll_l2>,
+               <&acpu0_aux>, <&acpu1_aux>, <&acpu_l2_aux>, <&qsb>;
+      clock-names = "hfpll0", "hfpll1",
+                    "acpu0_aux", "acpu1_aux", "qsb";
+      #clock-cells = <1>;
+    };
+...
-- 
2.34.1

