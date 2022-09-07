Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319705AFC7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIGGfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIGGfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:35:36 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A73792E2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:35:32 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220907063530epoutp027d398d42791afbcae90c72b75b77b95e~SgIc_G6KA0568005680epoutp02h
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 06:35:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220907063530epoutp027d398d42791afbcae90c72b75b77b95e~SgIc_G6KA0568005680epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662532530;
        bh=iofHHmP/ShOvBt8CMTXPyRfeBkGPEWA7NbQY+OIdU5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dxh2ch3Da9CaOfa42frMeeC2sBJBNETyw/1If8ZOy/bhpZm9nN8/XA5+7Ej4wqmIN
         TbGJBtZXflY9lNvIA4fqReOl0aR0WGBUf9eiITU4Fo+RAAHFNuFhBePAwPd+I15fwT
         vXCBpCvxu8xcmyHOYZFjaygOC4jsIGswZFq84dfQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220907063530epcas5p4a29bda1f5164f428bfe8a4a6ac215600~SgIcR65PF3093030930epcas5p4-;
        Wed,  7 Sep 2022 06:35:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MMsvM1L5sz4x9Q1; Wed,  7 Sep
        2022 06:35:27 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.50.54060.FAB38136; Wed,  7 Sep 2022 15:35:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7~SgGdJbWTf2222422224epcas5p1E;
        Wed,  7 Sep 2022 06:33:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220907063313epsmtrp117b2d10631ece073bc8b7da0845695bc~SgGdIU1-L0507305073epsmtrp1m;
        Wed,  7 Sep 2022 06:33:13 +0000 (GMT)
X-AuditID: b6c32a4b-e33fb7000000d32c-08-63183baf3969
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.CC.14392.92B38136; Wed,  7 Sep 2022 15:33:13 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.109.115.6]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220907063310epsmtip1f2ccff2a4d1df6e1e136b2f58e108160~SgGZ4Z_dU2638426384epsmtip1x;
        Wed,  7 Sep 2022 06:33:09 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v2 01/15] dt-bindings: media: s5p-mfc: Add new DT schema for
 MFC
Date:   Wed,  7 Sep 2022 12:17:01 +0530
Message-Id: <20220907064715.55778-2-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907064715.55778-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1CTdRzH7/s82/MMaNzToPrGFa2n6JL4scmGX1DCTrLnwoyT7rrrShjb
        0+CAbW3DAjOXkx+igAVeiIAEKBci4IQ5flg0UfxB3A2Q6dmCEEHwvCEkBdNqbFj/vT4/3p/P
        5/v5fr88XDBBBPEyVHpWq5Jl0YQvx3xhXWh420YoFz2wEuiO5SgXTdSaCdTw1wyGxhsWOch6
        tpNEHaPHcNQ00MdFx/uHuOjcz5McdOauO2o76uCgmeOtAM1W/UYg0+0xLvp97kM00l1NoEPt
        nVx0ut9BohN2G4ZOmh5hqL7zDxLln+8nkaPXDND+gn5sM2RaalsAY3E0AsbeuIAzXVUOkmno
        ncUYU/MBgvl1rJdgzjbuZfIvrnCY0o5mwPy9r4ZkivvtBLNoCmauPlwkk/w/ytyUzsoUrFbI
        quRqRYZKGUcnJqdsSZFGi8Th4hi0gRaqZNlsHJ2wLSl8a0aWew20cJcsK8ftSpLpdHTkm5u0
        6hw9K0xX6/RxNKtRZGkkmgidLFuXo1JGqFh9rFgkWi91J6Zmpt+3Xic150RfzFQYcQO48mox
        8OFBSgIP7LtEFANfnoDqAfCWsx54jQUApxrbuV5jCcD5O/OcYsDzSAptEq//PICHvx3HVksJ
        KCMGbcu7VpmgwuCS8xqxyoHU1wDeLtKvCnDKyIGOQRe5GgigdsCRrg6PmEOFQEOT2SPgUzGw
        p8+Je+d7CZ5q7/OwDxULbRWXPRNB6qAPnK2pJ71JCbC5w7rGAXBuoGONg+BsWcEaK+H4ohF4
        WQNrDN7GkIqHfaPVnpPh1DrY1h3pdb8Ij1xt9aTglD8scU2tpfOhpfYJ07B+8PJaeQiv3+/k
        epmBNyoHMe+GSgB8OFZIHAbBVf+3qAOgGTzPanTZSlYn1USp2M//uzW5OtsEPE89NNECJifm
        I6wA4wErgDycDuQrLIFyAV8hy81jteoUbU4Wq7MCqXuB3+BBz8jV7r+i0qeIJTEiSXR0tCQm
        KlpMP8eveAPIBZRSpmczWVbDap/oMJ5PkAHDRxddkHm5PD/AKXl2roJkC53x1bL3Mx64Hkck
        d+7PPfHOjtmZti+n/CZbvseHDRF+1OnvLmwmseXXH5uUda/sTcirHjQX/fjDpXfpcnte8l3L
        Ledg5VvE9uWdpY6yexNdL3A+eDtfGlLZW7b7yknfM0898g1JbOAtpWkxVUn3L4aeovjgsAD7
        TLXkPW6ay3iqwN702obp9J1FI7Qqd+TPm866PX55yaN+US3yyYvBCuON8AH08T89n+jThksO
        RvqXfhX5U3lBqnAoJGO93/CnvbvvdN/8TLptpSZ2xTD0tO9G/rGwgNYjFQPYteRRvfle31ah
        a4FJ3TO9ZXt+Y1GMbVogpjm6dJk4FNfqZP8Cg8yE7HMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSnK6mtUSywbupkhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzWLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJXx9tBV9oLtBhXP
        pzQzNzCeVOli5OCQEDCRaL9o0sXIySEksJtRYvkcexBbQkBCYuXvSYwQtrDEyn/P2bsYuYBq
        Gpkkfv/rA0uwCehIfHt/mg0kISLQyihxfWUnE4jDLDCbReLHpAOsIBuEBQIk1h0MA2lgEVCV
        aFi+jQ3E5hWwlNh94D0zxAZ5idUbDoDZnAJWEhennGCFuMhS4vGMbewTGPkWMDKsYpRMLSjO
        Tc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjjotzR2M21d90DvEyMTBeIhRgoNZSYQ3ZYdIshBv
        SmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M8V+956T8V1sp
        2SqzJaBMdKr5230Rxcy+Jbtk+hsnqE/pfbwqeVe26HzPV50lx/fkL/OYvFil6gTjacmEF3yb
        Zj8oDnbokz2lvtd0k7Ve9v1d540nL17D4/rugWOakZXOdzsPc/6sxaULRNZkFHixNLI+EdmV
        tuRrzNd6va2lZzVEP1j2PWMRCr8W+5nHb+nhucwNYpplz2MYulYaGXm1CcmnubVdPB7w8qBB
        YO7NV5oHAgUaJ35mWazAcMNWXV8zrH2a9anJn25Nk3suI6a4ZceON9ZpCtw+y+qfX3vc/XxX
        wK+Mwq6407c17rA6SOw1Plk6+12DkEWTwv0nrP7hEft/BjyJuMybavmb56ASS3FGoqEWc1Fx
        IgA6V7SVKQMAAA==
X-CMS-MailID: 20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds DT schema for s5p-mfc in yaml format

Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 .../devicetree/bindings/media/s5p-mfc.txt     |  77 +------------
 .../bindings/media/samsung,s5p-mfc.yaml       | 109 ++++++++++++++++++
 2 files changed, 110 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml

diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
index aa54c8159d9f..0b7c4dd40095 100644
--- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
+++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
@@ -1,76 +1 @@
-* Samsung Multi Format Codec (MFC)
-
-Multi Format Codec (MFC) is the IP present in Samsung SoCs which
-supports high resolution decoding and encoding functionalities.
-The MFC device driver is a v4l2 driver which can encode/decode
-video raw/elementary streams and has support for all popular
-video codecs.
-
-Required properties:
-  - compatible : value should be either one among the following
-	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
-	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
-	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
-	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
-	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
-	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
-
-  - reg : Physical base address of the IP registers and length of memory
-	  mapped region.
-
-  - interrupts : MFC interrupt number to the CPU.
-  - clocks : from common clock binding: handle to mfc clock.
-  - clock-names : from common clock binding: must contain "mfc",
-		  corresponding to entry in the clocks property.
-
-Optional properties:
-  - power-domains : power-domain property defined with a phandle
-			   to respective power domain.
-  - memory-region : from reserved memory binding: phandles to two reserved
-	memory regions, first is for "left" mfc memory bus interfaces,
-	second if for the "right" mfc memory bus, used when no SYSMMU
-	support is available; used only by MFC v5 present in Exynos4 SoCs
-
-Obsolete properties:
-  - samsung,mfc-r, samsung,mfc-l : support removed, please use memory-region
-	property instead
-
-
-Example:
-SoC specific DT entry:
-
-mfc: codec@13400000 {
-	compatible = "samsung,mfc-v5";
-	reg = <0x13400000 0x10000>;
-	interrupts = <0 94 0>;
-	power-domains = <&pd_mfc>;
-	clocks = <&clock 273>;
-	clock-names = "mfc";
-};
-
-Reserved memory specific DT entry for given board (see reserved memory binding
-for more information):
-
-reserved-memory {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	ranges;
-
-	mfc_left: region@51000000 {
-		compatible = "shared-dma-pool";
-		no-map;
-		reg = <0x51000000 0x800000>;
-	};
-
-	mfc_right: region@43000000 {
-		compatible = "shared-dma-pool";
-		no-map;
-		reg = <0x43000000 0x800000>;
-	};
-};
-
-Board specific DT entry:
-
-codec@13400000 {
-	memory-region = <&mfc_left>, <&mfc_right>;
-};
+This file has moved to samsung,s5p-mfc.yaml
diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
new file mode 100644
index 000000000000..7cd26d4acbe4
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,s5p-mfc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos Multi Format Codec (MFC)
+
+maintainers:
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+  - Aakarsh Jain <aakarsh.jain@samsung.com>
+
+description:
+  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
+  supports high resolution decoding and encoding functionalities.
+
+properties:
+  compatible:
+    enum:
+      - samsung,mfc-v5                  # Exynos4
+      - samsung,mfc-v6                  # Exynos5
+      - samsung,mfc-v7                  # Exynos5420
+      - samsung,mfc-v8                  # Exynos5800
+      - samsung,exynos5433-mfc          # Exynos5433
+      - samsung,mfc-v10                 # Exynos7880
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 2
+
+  iommu-names:
+    maxItems: 2
+
+  power-domains:
+    maxItems: 1
+
+  memory-region:
+    maxItems: 1
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,mfc-v5
+    then:
+      properties:
+        memory-region:
+          maxItems: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    # SoC specific DT entry
+    mfc: mfc@12880000 {
+        compatible = "samsung,fsd-mfc";
+        reg = <0x0 0x12880000 0x0 0x10000>;
+        interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "mfc";
+        clocks = <&clock_mfc MFC_MFC_IPCLKPORT_ACLK>;
+        iommus = <&smmu_isp 0x1000 0x0>, <&smmu_isp 0x1400 0x0>;
+        iommu-names = "left", "right";
+        power-domains = <&pd_mfc>;
+        memory-region = <&mfc_left>, <&mfc_right>;
+    };
+
+  - |
+    # Reserved memory specific DT entry for given board
+    # (see reserved memory binding for more information)
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        mfc_left: region@84000000 {
+                compatible = "shared-dma-pool";
+                no-map;
+                reg = <0x84000000 0x800000>;
+        };
+
+        mfc_right: region@a9000000 {
+                compatible = "shared-dma-pool";
+                no-map;
+                reg = <0xa9000000 0x800000>;
+        };
+    };
+
-- 
2.17.1

