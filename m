Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DEB49641F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380793AbiAURkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:40:47 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:16066 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381153AbiAURko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:40:44 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220121174041epoutp0278a7efe7684d77edfa0efd40632d14c1~MWe3A8Hsa0803608036epoutp02I
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220121174041epoutp0278a7efe7684d77edfa0efd40632d14c1~MWe3A8Hsa0803608036epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786841;
        bh=uh4mpLb4+q+1g0773K97q9bDmc76A9ifTQHlJe0oGYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8jjGu0BA4m0SB4PyVsCNFi00YzcFxqlSNVx7W6ygZ0RyTYRXo+jlA8J3SKRAK14o
         HPqdxMACxvuinet9ADFT0Nz83DuP3RkriVwRcO10RG2S7W1np8qvX6xJ9Gf1uWFaxf
         0H32gW7SOk7tVuZ8/blNa79WuTzX1WMoNd9gKZfk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220121174040epcas5p3ec928cc685a8c922657e5177b8fdead3~MWe1rWSE32795427954epcas5p3J;
        Fri, 21 Jan 2022 17:40:40 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JgRVV6l0zz4x9Pq; Fri, 21 Jan
        2022 17:40:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.8B.46822.13FEAE16; Sat, 22 Jan 2022 02:36:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220121174033epcas5p1d7b305397c87497e101ebd4d1eb5ae0d~MWevPBWfd2780827808epcas5p1E;
        Fri, 21 Jan 2022 17:40:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220121174033epsmtrp12d8d5c5dffaff7ae8765f54ba67d5bcc~MWevJQqTZ2608726087epsmtrp1E;
        Fri, 21 Jan 2022 17:40:33 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-0c-61eaef31ecc3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.B7.08738.110FAE16; Sat, 22 Jan 2022 02:40:33 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174030epsmtip29126513695c3d33b280abdbe3e839392~MWesR3jMQ1230312303epsmtip2b;
        Fri, 21 Jan 2022 17:40:30 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v3 03/16] dt-bindings: clock: Document FSD CMU bindings
Date:   Fri, 21 Jan 2022 22:58:27 +0530
Message-Id: <20220121172840.12121-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUxTVxjGd27b25akeK2gZ2Ub7C7OyAa0QNlhAprp8AZn1mRbdPunXuGm
        JZS26Qcwt4UOELAWKDgZEQXiNoiIG3RIpIIphVUCKgSBLoiA0y2KA2W4SPhybS/b/nvOc57f
        m/e85xVwxLW4RJCpNTEGLa0h8SBuR+/OHVGyJ7O0tH84Gs3UdeBorcrDR08abQDV993ioba5
        JQx9s9qEIcf9cR5asE3x0L3ZQ+i28yyOaoauYWjAu4ij85ef8dHx7j4+6v2zhIfWx9u46L53
        Fd+zmWqpawHUynIVoM5YynDK0XwCpybHu3Dq5+/zqdH+Ah5V3t4MqPWCc3xq0fGaIuizrCQ1
        Q2cwhghGm67LyNSqkskDHyn3KuUJUlmULBG9Q0Zo6Wwmmdz3gSIqNVPjew8ZkUNrzD5LQRuN
        ZExKkkFnNjERap3RlEwy+gyNPl4fbaSzjWatKlrLmN6VSaWxcl/wSJa6+mI1ri+LzZsZseEW
        8OB1KxAKIBEPHZ4m3AqCBGLiKoDWp6cx9vAXgNXl3Rz2sAhgu8cCrEAQQMZqd7G+E8DuyuvA
        X0pMFGFwbC3Rr3HiLXj323bMr0OIVPjr16WBqhziBQbbbI24/2ILsR/ae1oCMJfYDr3PTwUA
        EZEEl223cLa/cHix1cXxayGRDB/frAt0BIkrAugevMBlQ/vgHWvVBrAFzl5v57NaAh9VFPPZ
        rrOgzRnH2l/CH+o8G+hu6Bo9y/VHOMRO+JMzxm9ziGBYtvIAY0kRLC0Ws+ntsHB+bIMMg5Un
        T/JYTcHJO3YuOxM7gO7HLp4dvHrm/6oNADSDlxm9MVvFGOX6WC2T+98/peuyHSCwpZFpV8C9
        mafRboAJgBtAAYcMEel1s7RYlEF/fowx6JQGs4YxuoHcN7JKjiQ0Xedbc61JKYtPlMYnJCTE
        J8YlyMhtokFVKy0mVLSJyWIYPWP4l8MEQokFK5c+z52Gb04Ee/Y/S1LmflEhmisJ1eTUKzal
        zKdNFA2uZKKtFeqjLeGbjvbnD334dsElMuiTY5OuHdtOXEP0ZUX3K0LrexGXis8Vru0hQo+X
        jlliNodc6Mn7rVFz99Oaj4u61r2GwwNxy0ciEw2RqehGb+aAsMB8iLmadHhvg+uguYaR+jZh
        ovCN2oURVdhCQdaaI7qpL/fh72mLL9WXvGidIJBztOG7nBC729E1/DC/9eDpzuawGzFf9Ujs
        oGvXjwiOd0x3zr6/+++R4drgm84hfqVr3DvjCV9Cj1abGEXKnHrqtqSnzd15wLxEVE7L/9ia
        mjtfe145+Ut/UHjeFMk1qmlZJMdgpP8B4qtoUC4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvK7gh1eJBodfcFk8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8a01dPYCnqNKh5c6mFr
        YHyi2MXIwSEhYCJxdbZ1FyMXh5DADkaJSW92s3YxcgLFpSWub5zADmELS6z89xzMFhJoYpI4
        crkMxGYT0Ja4O30LE4gtIuAh0fbvHjPIIGaBicwSG/eeZQFJCAu4S0w4uIYRxGYRUJW4/n0y
        WAOvgI3Er55zbBAL5CVWbzjADGJzCthKvD47jxlimY1E86ytTBMY+RYwMqxilEwtKM5Nzy02
        LDDKSy3XK07MLS7NS9dLzs/dxAiOAy2tHYx7Vn3QO8TIxMF4iFGCg1lJhLcg/1WiEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzdhuLfztifengvMOfW
        BfXJBRJdb1P2eTx7oCqffbJgb9N+jT/WtQc2+hjdudB1zq1Ww7ey/Wz6qRO5lzU2ms54r37x
        lF1ex1FxXd+n6pytz+7nq2/t6GC5zFTYnrZykn+y5OdnsQekbvLMKVt1RKbvfxTXiQgTv+Is
        +0V+8dtKvs1uYjSR3aA6JUFO+ND9g2pd+2s7xP+7qRw5XLuHqaO9K3372o8ezhLtSwp2sLzt
        9zertVC6uDtyv4GZ8+dFFntEa46rfN2QrRCiLDo15J4mo2gvc1D/qqqgvxOTjWyaZL4uL73+
        aiOrzOwtHVEx+26kmGRouNQ3P1qcoflAaP77YnNpr8u1+9761j/PUWIpzkg01GIuKk4EAALu
        qcPyAgAA
X-CMS-MailID: 20220121174033epcas5p1d7b305397c87497e101ebd4d1eb5ae0d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174033epcas5p1d7b305397c87497e101ebd4d1eb5ae0d
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174033epcas5p1d7b305397c87497e101ebd4d1eb5ae0d@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-schema documentation for Tesla FSD SoC clock controller.

Cc: linux-fsd@tesla.com
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../bindings/clock/tesla,fsd-clock.yaml       | 198 ++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
new file mode 100644
index 000000000000..dc808e2f8327
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
@@ -0,0 +1,198 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/tesla,fsd-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tesla FSD (Full Self-Driving) SoC clock controller
+
+maintainers:
+  - Alim Akhtar <alim.akhtar@samsung.com>
+  - linux-fsd@tesla.com
+
+description: |
+  FSD clock controller consist of several clock management unit
+  (CMU), which generates clocks for various inteernal SoC blocks.
+  The root clock comes from external OSC clock (24 MHz).
+
+  All available clocks are defined as preprocessor macros in
+  'dt-bindings/clock/fsd-clk.h' header.
+
+properties:
+  compatible:
+    enum:
+      - tesla,fsd-clock-cmu
+      - tesla,fsd-clock-imem
+      - tesla,fsd-clock-peric
+      - tesla,fsd-clock-fsys0
+      - tesla,fsd-clock-fsys1
+      - tesla,fsd-clock-mfc
+      - tesla,fsd-clock-cam_csi
+
+  clocks:
+    minItems: 1
+    maxItems: 6
+
+  clock-names:
+    minItems: 1
+    maxItems: 6
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tesla,fsd-clock-cmu
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+        clock-names:
+          items:
+            - const: fin_pll
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tesla,fsd-clock-imem
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+            - description: IMEM TCU clock (from CMU_CMU)
+            - description: IMEM bus clock (from CMU_CMU)
+            - description: IMEM DMA clock (from CMU_CMU)
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_cmu_imem_tcuclk
+            - const: dout_cmu_imem_aclk
+            - const: dout_cmu_imem_dmaclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tesla,fsd-clock-peric
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+            - description: Shared0 PLL div4 clock (from CMU_CMU)
+            - description: PERIC shared1 div36 clock (from CMU_CMU)
+            - description: PERIC shared0 div3 TBU clock (from CMU_CMU)
+            - description: PERIC shared0 div20 clock (from CMU_CMU)
+            - description: PERIC shared1 div4 DMAclock (from CMU_CMU)
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_cmu_pll_shared0_div4
+            - const: dout_cmu_peric_shared1div36
+            - const: dout_cmu_peric_shared0div3_tbuclk
+            - const: dout_cmu_peric_shared0div20
+            - const: dout_cmu_peric_shared1div4_dmaclk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tesla,fsd-clock-fsys0
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+            - description: Shared0 PLL div6 clock (from CMU_CMU)
+            - description: FSYS0 shared1 div4 clock (from CMU_CMU)
+            - description: FSYS0 shared0 div4 clock (from CMU_CMU)
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_cmu_pll_shared0_div6
+            - const: dout_cmu_fsys0_shared1div4
+            - const: dout_cmu_fsys0_shared0div4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tesla,fsd-clock-fsys1
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+            - description: FSYS1 shared0 div8 clock (from CMU_CMU)
+            - description: FSYS1 shared0 div4 clock (from CMU_CMU)
+        clock-names:
+          items:
+            - const: fin_pll
+            - const: dout_cmu_fsys1_shared0div8
+            - const: dout_cmu_fsys1_shared0div4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tesla,fsd-clock-mfc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+        clock-names:
+          items:
+            - const: fin_pll
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tesla,fsd-clock-cam_csi
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+        clock-names:
+          items:
+            - const: fin_pll
+
+required:
+  - compatible
+  - "#clock-cells"
+  - clocks
+  - clock-names
+  - reg
+
+additionalProperties: false
+
+examples:
+  # Clock controller node for CMU_FSYS1
+  - |
+    #include <dt-bindings/clock/fsd-clk.h>
+
+    clock_fsys1: clock-controller@16810000 {
+          compatible = "tesla,fsd-clock-fsys1";
+          reg = <0x16810000 0x3000>;
+          #clock-cells = <1>;
+
+          clocks = <&fin_pll>,
+                   <&clock_cmu DOUT_CMU_FSYS1_SHARED0DIV8>,
+                   <&clock_cmu DOUT_CMU_FSYS1_SHARED0DIV4>;
+          clock-names = "fin_pll",
+                        "dout_cmu_fsys1_shared0div8",
+                        "dout_cmu_fsys1_shared0div4";
+    };
+
+...
-- 
2.25.1

