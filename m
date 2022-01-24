Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3CF498230
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238664AbiAXO3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:29:16 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:47676 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiAXO3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:13 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220124142911epoutp04c627bffbc5c2c09725fd07ed6f7a5010~NOzg0Kv3T2185021850epoutp049
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:29:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220124142911epoutp04c627bffbc5c2c09725fd07ed6f7a5010~NOzg0Kv3T2185021850epoutp049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034551;
        bh=uh4mpLb4+q+1g0773K97q9bDmc76A9ifTQHlJe0oGYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJHuPVNbnIkA6TbnFcatazL/l1u4wTDJm8m1BHhE+f8tBqQzB3xLfHRQfONpWtl3z
         M7sycPhyuA4UxTsPdSjMM+vc6OjeUUD7VZPxDOt54hdA1VISLPZOfu0fkBFLrKkrSa
         yDf+S3nTv7RmCBm968WoLc/24aKsim8GZoD/zGoE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220124142911epcas5p1f5ae0907b09c2be28d268d161059726d~NOzgUbY6q3199131991epcas5p10;
        Mon, 24 Jan 2022 14:29:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JjC6B1hhrz4x9Pr; Mon, 24 Jan
        2022 14:29:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.24.05590.2B7BEE16; Mon, 24 Jan 2022 23:29:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220124142905epcas5p33a863799819fb904932d2e88c682940a~NOzbRQqsZ0627306273epcas5p3V;
        Mon, 24 Jan 2022 14:29:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220124142905epsmtrp108958a0ae68e101a80215c4ad3770f27~NOzbQUnDS2824028240epsmtrp1s;
        Mon, 24 Jan 2022 14:29:05 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-52-61eeb7b2cdb3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9F.DA.29871.1B7BEE16; Mon, 24 Jan 2022 23:29:05 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142903epsmtip1d409b638eddf9d58a9a8a6627c8a8b39~NOzY345Bd1678916789epsmtip1z;
        Mon, 24 Jan 2022 14:29:02 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH v5 03/16] dt-bindings: clock: Document FSD CMU bindings
Date:   Mon, 24 Jan 2022 19:46:31 +0530
Message-Id: <20220124141644.71052-4-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmuu6m7e8SDRrOcFo8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
        oa6hpYW5kkJeYm6qrZKLT4CuW2YO0D9KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
        nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMaaunsRX0GlU8uNTD1sD4RLGLkYNDQsBE4swV
        pi5GTg4hgd2MEstnANlcQPYnRokt99qYIZxvjBK9r6+xglSBNJze9JgdIrGXUeLv9ZusEE4L
        k8SC58fYQKrYBLQl7k7fAjZXRMBN4kZjB9hcZoH/TBIbe5aBFQkLuEtc2PKBGcRmEVCVODN5
        KyOIzStgI9GzfQczxDp5idUbDoDZnAK2EvMWfgMbJCGwhUNi6ab5jBBFLhLnpt5igrCFJV4d
        38IOYUtJvOxvY4d4NFuiZ5cxRLhGYum8YywQtr3EgStzWEBKmAU0Jdbv0gcJMwvwSfT+fsIE
        0ckr0dEmBFGtKtH87ipUp7TExO5uaKB4SKyd+YMFEg4TgEH39xbjBEbZWQhTFzAyrmKUTC0o
        zk1PLTYtMM5LLYfHU3J+7iZGcCrV8t7B+OjBB71DjEwcjIcYJTiYlUR4q1LeJQrxpiRWVqUW
        5ccXleakFh9iNAUG2URmKdHkfGAyzyuJNzSxNDAxMzMzsTQ2M1QS5z2VviFRSCA9sSQ1OzW1
        ILUIpo+Jg1OqgemhyTGuJ59iTTNzY3gyA982hscUnRfSEA47YBux9viusC1Wd1v7zDPKxZ58
        l0udd6MzW5Pzx4QbK7abpBpp5W6TXBx9nkFlqc+N/bI3Diy3jblyZDPXLD39x1GbbjF80rCR
        4DivFl64bU5P/mXzBZpfGPg/mahlqK54pLF1TbjXw9i5uZxXuWyfsx5+utj3s6DKoacrTYs4
        dizcPkk63zPzjNOeV5WrZJK9OAMYfxjwnF2+W1FWUd1o45/e885f1beKpwfUK61jOlfeYX+m
        4IHU+pz1CxpmLWFbeGOBzwJtHlutpoU7GYtkuY/HvmKRWd1xYG3oqa8i671mmeVIvxB7H/Tw
        AJtaLPPO7AkfHiuxFGckGmoxFxUnAgDpgN2ELgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO7G7e8SDR71yls8mLeNzeLvpGPs
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNa/Lu2kcXi8fU/bA6CHmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28Pm
        sXlJvceVE02sHn1bVjF6/Guay+7xeZNcAFcUl01Kak5mWWqRvl0CV8a01dPYCnqNKh5c6mFr
        YHyi2MXIySEhYCJxetNj9i5GLg4hgd2MEgv+T2eESEhLXN84gR3CFpZY+e85VFETk8TkCR/B
        itgEtCXuTt/CBGKLCHhItP27xwxSxCwwkVli496zLCAJYQF3iQtbPjCD2CwCqhJnJm8Fa+YV
        sJHo2b6DGWKDvMTqDQfAbE4BW4l5C78BDeUA2mYjce63ygRGvgWMDKsYJVMLinPTc4sNCwzz
        Usv1ihNzi0vz0vWS83M3MYIjQUtzB+P2VR/0DjEycTAeYpTgYFYS4a1KeZcoxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUAxPfrty4J5Prk36U/J/6MXSG
        4c66vro+Pr3Lc7892zP/jMUK3caIv77zziywFDHlt4h/WbjrNFepBf/CphrO/TXNssk+ooHL
        uYTunOJunWnQuHkJK2vZdgkXt23ab76UCPrWHUs2DWrk5vu582D+yu+sTf+PMVdIPVO+ssRN
        vDhS9Ui0xpXvPy8orfLOnKT3JyC9ZFO/8NNk10nBCnWbX90M3Prgp9sitlv7JF6/u25oKbe5
        /x737d5Ind/7VSTEOtxiqo8dtrJK3Le89U4G4ym5rG6m8ItJ+T1Lr+3WquSLWuHVO+dUCuOJ
        gqduxYvieNp4ziiU+p6Iuldn9sSk4XDzsuM8HltXLw08zZkcrsRSnJFoqMVcVJwIAEYC3XDz
        AgAA
X-CMS-MailID: 20220124142905epcas5p33a863799819fb904932d2e88c682940a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142905epcas5p33a863799819fb904932d2e88c682940a
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142905epcas5p33a863799819fb904932d2e88c682940a@epcas5p3.samsung.com>
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

