Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270C248D77C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiAMMXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:23:24 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21702 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiAMMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:23:18 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220113122317epoutp02807c0c98e53fd1921ab32eb1aaf6ac55~J0-cKW_GG2743127431epoutp022
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:23:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220113122317epoutp02807c0c98e53fd1921ab32eb1aaf6ac55~J0-cKW_GG2743127431epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076597;
        bh=DRO8JGSaUi0700h6SSShVymCZbM21m81WFCupyutnNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzpqwC2Axlny/Y8p4l8uOimIWUYmnOzwIWps4cBmM3icqIhT5oo1GoHPnw7/l4jl/
         9RGlJHVXGDu4+oyAcLaGdreQJtmL1tC95VumjQUZmvXEDSB1KWtCU9aX8wg8nZFHS3
         fQ5n+PQrU5LnIxC51m0izTQpLEwwPCEP2bKuDWGk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220113122316epcas5p11184f4e52168fb89b2c6e42955970225~J0-btu-sG1610816108epcas5p1G;
        Thu, 13 Jan 2022 12:23:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JZNqz4590z4x9Pt; Thu, 13 Jan
        2022 12:23:11 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        15.A6.06423.FA910E16; Thu, 13 Jan 2022 21:23:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220113122311epcas5p4b7c253b49dce3bd3580407fcf312e70e~J0-WkmLds2464824648epcas5p4D;
        Thu, 13 Jan 2022 12:23:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122311epsmtrp23c7c5fd44b78d3bcfcff32f7091f3ae6~J0-WnRKBQ3027830278epsmtrp2C;
        Thu, 13 Jan 2022 12:23:11 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-4d-61e019af240e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.98.29871.EA910E16; Thu, 13 Jan 2022 21:23:10 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122308epsmtip275852b5cc5a98348cc2be60758ec3744~J0-UJEQlZ1245412454epsmtip2U;
        Thu, 13 Jan 2022 12:23:08 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH 01/23] dt-bindings: clock: Document FSD CMU bindings
Date:   Thu, 13 Jan 2022 17:41:21 +0530
Message-Id: <20220113121143.22280-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTXXe95INEg7ZmVosH87axWbxf1sNo
        Mf/IOVaLjW9/MFlM+bOcyWLT42usFh977rFaPHwVbnF51xw2ixnn9zFZnLr+mc1i0dYv7Bat
        e4+wWxx+085q8fj6HzYHfo8189Ywesxq6GXz2LSqk83jzrU9bB6bl9R7XDnRxOrRt2UVo8e/
        prnsHp83yQVwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
        6Lpl5gA9oKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2x
        MjQwMDIFKkzIzlgxT6HgnGHFwbM72RoYJyp2MXJySAiYSHycc5qpi5GLQ0hgN6PEtu5mVgjn
        E6PE5LVPWSCcb4wS65qPsMK0nFjUxAyR2MsosezGT0YIp4VJYknPZiaQKjYBbYm707eA2SIC
        bhI3GjvAljAL3GOS+HG4gRkkISzgItF/fQo7iM0ioCrxe+8csBW8AjYSC8/cZYdYJy+xesMB
        oHoODk4BW4m7q/JA5kgIzOWQmPV/CVSNi8SXU3dYIGxhiVfHt0DFpSQ+v9vLBtIrIZAt0bPL
        GCJcI7F03jGocnuJA1fmsICUMAtoSqzfpQ8SZhbgk+j9/YQJopNXoqNNCKJaVaL53VWoTmmJ
        id3d0DDxkFh6djE7JBgmMErMnjyBdQKj7CyEqQsYGVcxSqYWFOempxabFhjmpZbD4yk5P3cT
        IzhZannuYLz74IPeIUYmDsZDjBIczEoivP1F9xOFeFMSK6tSi/Lji0pzUosPMZoCQ2wis5Ro
        cj4wXeeVxBuaWBqYmJmZmVgamxkqifOeTt+QKCSQnliSmp2aWpBaBNPHxMEp1cA0xb1lij77
        vpP5tuFd2a6XwoVdTh+alntnh8y840Uzk553euve++2XfSMxh/Xrl+bwf86q3zw7Vqh9kF0r
        pmi5JaB1jV6A4+NbtwsWLWZkmftuTu7UA6ZL522SeVzdHhJZ+G6zz6sLWeI5jmFrrqbvvpD3
        zenwZeuIq+9iX6+dvLx827oX7UdvcPy6yG8lcdLo8NF96/r+hjX1zM58W2gn09ev7T7zsEyb
        tP2UtDpfE5/P+0q3Ve+oVPT+8f1MUvzS7n8vfX/YKL82jGbVPqlzZWGulzeLtrCnH+Pa+Zq8
        h3Q+Nd7V8Nj9dqPXckOxvw86Lbb1342OEfiRcebYlaCDnzY3Oy3UuKUZ1yDHtXCbEktxRqKh
        FnNRcSIAMjlZ7x8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvO46yQeJBn1tqhYP5m1js3i/rIfR
        Yv6Rc6wWG9/+YLKY8mc5k8Wmx9dYLT723GO1ePgq3OLyrjlsFjPO72OyOHX9M5vFoq1f2C1a
        9x5htzj8pp3V4vH1P2wO/B5r5q1h9JjV0MvmsWlVJ5vHnWt72Dw2L6n3uHKiidWjb8sqRo9/
        TXPZPT5vkgvgjOKySUnNySxLLdK3S+DKWDFPoeCcYcXBszvZGhgnKnYxcnJICJhInFjUxNzF
        yMUhJLCbUeLR2essEAlpiesbJ7BD2MISK/89Z4coamKSmHj8NhtIgk1AW+Lu9C1MILaIgIdE
        2797YJOYBd4wSfy/PwdskrCAi0T/9Slgk1gEVCV+753DCmLzCthILDxzF2qDvMTqDQeAmjk4
        OAVsJe6uygMJCwGVnHu1nm0CI98CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB
        ga6luYNx+6oPeocYmTgYDzFKcDArifD2F91PFOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetk
        vJBAemJJanZqakFqEUyWiYNTqoHJ4OaL1rsLvF58NNMokfW+tXfyA56k1/Hf+MXOppqkzc+Z
        7/7T057zcrXSLK24Ak3TzEO+72VL23QKlvFvNi7Z+kchqVzLdMulj/mX35xOmh5k2d8427BV
        wPKe1/cfDI55s/+H3NgT1/5qU4ZEQPM+Ht6Z/G35+VHsDJc/l99YNTXt7pPf28ruZVWyL7/h
        +ZH1+pX7fE+kbx+6WX3iS/zH4iyWR4L83RF7mW9e2Js+bU3cxnNxWYkaLZvX2CpZCv/S8wt9
        +KD5Vfc7p4hL/U4flt47UJtmYVWyxflo8hm22mT1Zw0vJ9jqTv5wMIf1y5Wcl1oef/TiLh97
        /fEi/2drl0euz/x2z7+25XKAV9kMJZbijERDLeai4kQAAMHgjOMCAAA=
X-CMS-MailID: 20220113122311epcas5p4b7c253b49dce3bd3580407fcf312e70e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122311epcas5p4b7c253b49dce3bd3580407fcf312e70e
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122311epcas5p4b7c253b49dce3bd3580407fcf312e70e@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-schema documentation for Tesla FSD SoC clock controller.

Cc: linux-fsd@tesla.com
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 .../bindings/clock/tesla,fsd-clock.yaml       | 212 ++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
new file mode 100644
index 000000000000..58f341e5004d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
@@ -0,0 +1,212 @@
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
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+
+        clock-names:
+          items:
+            - const: fin_pll
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tesla,fsd-clock-imem
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+            - description: IMEM TCU clock (from CMU_CMU)
+            - description: IMEM bus clock (from CMU_CMU)
+            - description: IMEM DMA clock (from CMU_CMU)
+
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
+
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
+
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
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+            - description: Shared0 PLL div6 clock (from CMU_CMU)
+            - description: FSYS0 shared1 div4 clock (from CMU_CMU)
+            - description: FSYS0 shared0 div4 clock (from CMU_CMU)
+
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
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+            - description: FSYS1 shared0 div8 clock (from CMU_CMU)
+            - description: FSYS1 shared0 div4 clock (from CMU_CMU)
+
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
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+
+        clock-names:
+          items:
+            - const: fin_pll
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tesla,fsd-clock-cam_csi
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (24 MHz)
+
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
+          reg = <0x0 0x16810000 0x0 0x3000>;
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
2.17.1

