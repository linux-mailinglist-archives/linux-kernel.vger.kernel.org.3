Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D52492918
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbiARPAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:00:35 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:28804 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbiARPAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:00:31 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220118150029epoutp016a243e9001613c2f7374f54b7f4903cd~LZXIJWgW42790327903epoutp018
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:00:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220118150029epoutp016a243e9001613c2f7374f54b7f4903cd~LZXIJWgW42790327903epoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518029;
        bh=f3sWB1+x1NMqfjGXw3jaRSg7rwQyVren5xfwcHI4Qa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vo3jFdI9mIrrNHhw0jKV+26rtR0/zUMIMIlLknSjPFMkjgMMdIdkWbGaiEVjo3CKy
         RLnlHQi/7E6E+ur7pSdRtQcFqMz3hp5+wMg6ktus9Qjye00J/XRc9o+Z+WRDNywx32
         EKkqPGIApHKuspnmwn/AWA8sTzGtTU2aOW+vr6sk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220118150028epcas5p262c8484100fe88f9942ba27e42383357~LZXHjdldy1720217202epcas5p2n;
        Tue, 18 Jan 2022 15:00:28 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JdX5259ntz4x9Pp; Tue, 18 Jan
        2022 15:00:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.09.06423.606D6E16; Wed, 19 Jan 2022 00:00:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220118150022epcas5p21912423606220552a78c7e22e4133a05~LZXBK019S1720217202epcas5p2Z;
        Tue, 18 Jan 2022 15:00:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220118150022epsmtrp2e07aa2b905e89bb57d406727a52c56d2~LZXBJ9Poy1913119131epsmtrp2N;
        Tue, 18 Jan 2022 15:00:22 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-00-61e6d606ee99
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.91.29871.506D6E16; Wed, 19 Jan 2022 00:00:22 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150019epsmtip17d02491cf523fcd7d1d140eedd3dca24~LZW-CCrLw0428804288epsmtip1Y;
        Tue, 18 Jan 2022 15:00:19 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com
Subject: [PATCH v2 03/16] dt-bindings: clock: Document FSD CMU bindings
Date:   Tue, 18 Jan 2022 20:18:38 +0530
Message-Id: <20220118144851.69537-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsWy7bCmhi7btWeJBp0XVC0ezNvGZvF30jF2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w+Yg4LFm3hpGj9+/JjF6zGroZfPYtKqTzePOtT1sHpuX1Htc
        OdHE6tG3ZRWjx7+muewenzfJBXBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAL2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdAr
        TswtLs1L18tLLbEyNDAwMgUqTMjOOLVlJ1PBHMOKDwf3sDYw/lXoYuTkkBAwkXjW+Iiti5GL
        Q0hgN6PE1xkPWSCcT4wSfQ/uQjnfGCWe9Mxig2lpOjSHFcQWEtjLKHFyOz9EUQuTRM+nU8wg
        CTYBbYm707cwgdgiAm4SNxo7mECKmAXeMklM3/cdbJKwgLvEzK9vgBo4OFgEVCV+fdIBCfMK
        2EgsW/WWGWKZvMTqDQfAbE4BW4mpDVPBbpUQWMsh8bKriwWiyEXizqyr7BC2sMSr41ugbCmJ
        z+/2soHMlxDIlujZZQwRrpFYOu8YVKu9xIErc1hASpgFNCXW79IHCTML8En0/n7CBNHJK9HR
        JgRRrSrR/O4qVKe0xMTublaIEg+Jz8cyISEygVGiq1NqAqPsLISZCxgZVzFKphYU56anFpsW
        GOallsNjKTk/dxMjOHlqee5gvPvgg94hRiYOxkOMEhzMSiK8UvXPEoV4UxIrq1KL8uOLSnNS
        iw8xmgLDayKzlGhyPjB955XEG5pYGpiYmZmZWBqbGSqJ855O35AoJJCeWJKanZpakFoE08fE
        wSnVwLTwDNPmpY1V7brrIq73PtsWMtnkQH9nt8FerbJX3KaBE/i/62WxrzN9dEZ7KdPBkyEv
        TfcIBf23i+W6tldubsTkLzvfzZfUZl/1S2mP39Vv8eHlX9PNPCoz3/5Z6i5ydlOr2CaZn1ZF
        OzZv8xLdxH//8XmNnpurI6YIy6x7nF9lv5+F7UK/34b8dRJdExYv+BFc2L/76U3V+93++yee
        CrQQ0Xt2yCd/Xds9p5D34ZcytGf1NXwUWP/ko4OZG9Pjl9aNOmap3RZeq5Z/eHr2yeGHVhoc
        L3de6mbTEDvJ8XyB7mtFsyM7X4qElD8TT85UuZKquo/liRz7r3rVdffYlH1e8a0tlXCJfO3e
        u9ulfbsSS3FGoqEWc1FxIgBkbXeBJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSnC7btWeJBusmMls8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNaPL7+h81BwGPNvDWMHr9/TWL0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CK4rJJSc3JLEst0rdL4Mo4tWUnU8Ecw4oPB/ewNjD+Vehi
        5OSQEDCRaDo0h7WLkYtDSGA3o8S77gWsEAlpiesbJ7BD2MISK/89Z4coamKS+NAzH6yITUBb
        4u70LUwgtoiAh0Tbv3vMIEXMAn+ZJL6+fsgIkhAWcJeY+fUNUIKDg0VAVeLXJx2QMK+AjcSy
        VW+ZIRbIS6zecADM5hSwlZjaMJUNxBYCqrm4chrzBEa+BYwMqxglUwuKc9Nziw0LDPNSy/WK
        E3OLS/PS9ZLzczcxgsNfS3MH4/ZVH/QOMTJxMB5ilOBgVhLhlap/lijEm5JYWZValB9fVJqT
        WnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD05byF//2vPm8j+FFXHriejNHhtIv
        eUneb9zXSixf9/qvmN677rr+91Ev5K7O1nyYuy5Zo5rbIad0XZL3ng9a+7Tz9q7s0Oo62mRc
        aXX5O1fJKo7UeypnPrK9WjtfiHfanJIjQnvleEQacpusuC7f6fA+sos9PkfgXR/Ptkc/Qk+z
        N/DMEpH56xxhONnDdb2g3R0J64cLZ9UIyeXMX7ZUoIWHdSGzRnBZ48q8q3ufRYpu/bMuxOGd
        9xvFqEnOQnVH9C41i+k+ExaL7zjUtCWj0T5cvPmo0VbdX0ftso2r/2dU/JnTw8Kf71G788VF
        76B5njqbz379wR717X3ziSomgzWdAf4bjokbC6jtS16vxFKckWioxVxUnAgACyooHe4CAAA=
X-CMS-MailID: 20220118150022epcas5p21912423606220552a78c7e22e4133a05
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150022epcas5p21912423606220552a78c7e22e4133a05
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150022epcas5p21912423606220552a78c7e22e4133a05@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-schema documentation for Tesla FSD SoC clock controller.

Cc: linux-fsd@tesla.com
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

