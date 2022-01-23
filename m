Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE0497500
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbiAWTT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:19:59 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52477 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbiAWTTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:19:53 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220123191951epoutp0173dabd6a41ae6a2c6931309cbc9656be~M-IAn-liQ1800618006epoutp01q
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:19:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220123191951epoutp0173dabd6a41ae6a2c6931309cbc9656be~M-IAn-liQ1800618006epoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965591;
        bh=uh4mpLb4+q+1g0773K97q9bDmc76A9ifTQHlJe0oGYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hQuAEe1n/tUPYkFrXDjNyXCrfsWQwWpku9m59QS61DQDvK5s+j/nRt6kwVvsGForU
         k39FU6UwSXkzNIK9uJRcxpu47rIO0ctGGfhu771XTiJ2FGwEM//svELKzLYLg+lLdB
         srx+pAYJz7aT6vTy4Q9z1gPL99GSIsHBLrWCx4Vo=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220123191950epcas5p34fb0fd3f6b618a7cae5d0bcb82295c38~M-H-v2tEP2905929059epcas5p3e;
        Sun, 23 Jan 2022 19:19:50 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jhjc16Fg8z4x9Pp; Sun, 23 Jan
        2022 19:19:45 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.37.06423.15AADE16; Mon, 24 Jan 2022 04:19:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220123191945epcas5p48832df007e438be14b390a0a8dd97cde~M-H61Pik00895308953epcas5p43;
        Sun, 23 Jan 2022 19:19:45 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220123191945epsmtrp214f9cd6de6ccda4ecfcde820ad8f08d3~M-H60Zezs2018820188epsmtrp2U;
        Sun, 23 Jan 2022 19:19:45 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-63-61edaa5118cb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.F7.29871.05AADE16; Mon, 24 Jan 2022 04:19:45 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123191942epsmtip17fe194ac5720aed7cc8e187e697d6b13~M-H4h1ElG0562405624epsmtip1N;
        Sun, 23 Jan 2022 19:19:42 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v4 03/16] dt-bindings: clock: Document FSD CMU bindings
Date:   Mon, 24 Jan 2022 00:37:16 +0530
Message-Id: <20220123190729.1852-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmum7gqreJBrN+6lg8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMaaunsRX0GlU8uNTD1sD4RLGLkZNDQsBEYtnv
        GaxdjFwcQgK7GSXuNd5lg3A+MUrMPf+GEcL5xijxbd1udpiW7+vuM4PYQgJ7GSUuzEuDKGph
        kvh85j4bSIJNQFvi7vQtTCC2iICbxI3GDiaQImaB/0wSG3uWgRUJC7hLPJ/QADaVRUBVYnvH
        frA4r4C1xJv9t9ggtslLrN5wAGwbp4CNRO+rD2DHSgjs4JBYvGYBUBEHkOMi8furBES9sMSr
        41ugLpWS+PxuL1RJtkTPLmOIcI3E0nnHWCBse4kDV+awgJQwC2hKrN+lDxJmFuCT6P39hAmi
        k1eio00IolpVovndVahOaYmJ3d2sELaHxM7ZjcyQYOhnlFh98x/jBEbZWQhTFzAyrmKUTC0o
        zk1PLTYtMMxLLYfHU3J+7iZGcCrV8tzBePfBB71DjEwcjIcYJTiYlUR4C/JfJQrxpiRWVqUW
        5ccXleakFh9iNAWG2ERmKdHkfGAyzyuJNzSxNDAxMzMzsTQ2M1QS5z2dviFRSCA9sSQ1OzW1
        ILUIpo+Jg1OqgSnf0GW39xfhFkXl847s31Qbj594/mD7kouLtqheK1q0carxD03xLdtV9ySF
        RF1cMk1qi7ZjonDndFEx4TdF71QfXrP9LPBywtWi4pbkapZ9GTkXJ8/bFrC5OOYXV3ljWadF
        1PZ0l7kOM2Uf+Tvbs67t2Hth2tqKuceP6Ag9ZgtNdLmjs35Fp4T7EYaG34rf3/7+19zWei2a
        /USlcn6zz6fqdyfrGT+zfMo3msSplL2G49KVU83xP3c0X5xp4B3DtUkh5cjOpKme8/ad4Jib
        0ck1g824dleY6Fax6YG7WM22ZVg2sTdb/Pj8QGKCu+4dv/c9Hb8/fa8RFtoYMGGrqiYXZ76s
        davbAqk/zTcPHVZiKc5INNRiLipOBADBYP0wLgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnG7gqreJBh9WM1s8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8a01dPYCnqNKh5c6mFr
        YHyi2MXIySEhYCLxfd195i5GLg4hgd2MEn9etjFCJKQlrm+cwA5hC0us/PecHaKoiUli0tJ2
        NpAEm4C2xN3pW5hAbBEBD4m2f/fAJjELTGSW2Lj3LAtIQljAXeL5hAawSSwCqhLbO/aDNfMK
        WEu82X+LDWKDvMTqDQeYQWxOARuJ3lcfWLsYOYC2WUtMOCo3gZFvASPDKkbJ1ILi3PTcYsMC
        w7zUcr3ixNzi0rx0veT83E2M4EjQ0tzBuH3VB71DjEwcjIcYJTiYlUR4C/JfJQrxpiRWVqUW
        5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAJFNlw64q87I3jLeDZ//r
        K54b5i+Qi+xMv8Ooe8H7h0/1oy1JzA16XYEP245OuLGr1SLuEs//B5WrtheW/U4z6g+Mf/Mp
        bIVeTNuJ5n2nKyvKS/tUHr1gnz5Z/VJA4fzOe7q6a2a92vLv3TmF+Y/0ue2aZUPuRXGbc+5X
        X8EzQfL/jbPf8uz1b6na5V9g/b6vcmJGw51o3TMFZ5SDtvDz8Pl418q3RYk/UF2c2JLN65m4
        9rjkVps5vOJnDzulBt/42X4iPXpj+FOW5OIHu/9un5ZhOaVKSyH35MT7fd83hWVuO9675NC6
        pHdzQ1Xjj97MslvvLsR3paNglth3r1Php2Rk39xvkWVrbr4+q2GLEktxRqKhFnNRcSIARpA5
        yPMCAAA=
X-CMS-MailID: 20220123191945epcas5p48832df007e438be14b390a0a8dd97cde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123191945epcas5p48832df007e438be14b390a0a8dd97cde
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123191945epcas5p48832df007e438be14b390a0a8dd97cde@epcas5p4.samsung.com>
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

