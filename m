Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C244A3517
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349903AbiA3IIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:08:37 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38161 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347717AbiA3II3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:08:29 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220130080828epoutp0325203641dfb7b6ac4fbcf7c93cc99420~O-e0MaQUe2581825818epoutp03h
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 08:08:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220130080828epoutp0325203641dfb7b6ac4fbcf7c93cc99420~O-e0MaQUe2581825818epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643530108;
        bh=HkUEc1GvRws2hCGHAS/Busf6caUOkPlQ858JwyoYSHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5Ls5pasipOGQBU64RsPsnebCOXv9/r1RcmK/KHscd/dWX7UZuYhgJ6rulVy476FL
         UI+8EbfbubTkqOjCr//dMfyfALYnzY0C0W6MYje68vFLfE6zXPB5MzzSCKpZtw9Rrp
         paH1PWMsGZh70OjNY4YoPR9ULB6aWufGVizGRy38=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220130080827epcas5p1be81b955d056e495033b4a7386408b28~O-ezDX43E3102231022epcas5p1n;
        Sun, 30 Jan 2022 08:08:27 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JmkN26Pssz4x9Pt; Sun, 30 Jan
        2022 08:08:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.F6.06423.37746F16; Sun, 30 Jan 2022 17:08:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220130080818epcas5p15adb431d08cb37060310fec00bb77cd2~O-eqi0bnT3102231022epcas5p1i;
        Sun, 30 Jan 2022 08:08:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220130080818epsmtrp1912459ece4236c838fa4a47a48d34390~O-eqdwXuy1370913709epsmtrp1Q;
        Sun, 30 Jan 2022 08:08:18 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-e1-61f6477303d6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.11.08738.27746F16; Sun, 30 Jan 2022 17:08:18 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220130080816epsmtip2605fd20040ca39835ce562f4c5f40e8c~O-epXXhEv0517905179epsmtip2M;
        Sun, 30 Jan 2022 08:08:16 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 3/3] ARM: dts: exynos: update dma nodename for exynos5
Date:   Sun, 30 Jan 2022 13:25:20 +0530
Message-Id: <20220130075520.49193-3-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130075520.49193-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7bCmum6x+7dEg9Of+CwezNvGZjH/yDlW
        i41vfzBZbHp8jdXi8q45bBYzzu9jsmjde4Tdgd1jVkMvm8emVZ1sHpuX1Hv0bVnF6PF5k1wA
        a1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
        7Iw3836wFZxUrGjdsYi5gfGvVBcjJ4eEgInEmmcXmLoYuTiEBHYzSmyb/okNwvnEKLHjyFVW
        COczo8Sjji3MMC09r1YzQiR2MUq8udIK5bQwSdw6cYwNpIpNQFvi7vQtTCC2iICbxI3GDjCb
        WWAxo8SvhekgtjBQ/PrpNWBxFgFVif7mTewgNq+AjcSUN9+ZILbJS6zecABsM6eArUTb7W1g
        90kIHGOX2H58EVSRi0Rf13UoW1ji1fEt7BC2lMTL/jYgmwPIzpbo2WUMEa6RWDrvGAuEbS9x
        4MocFpASZgFNifW79CHO5JPo/f2ECaKTV6KjTQiiWlWi+d1VqE5piYnd3awQtofEq2eNLJBg
        mMAocebmTOYJjLKzEKYuYGRcxSiZWlCcm55abFpgmJdaDo+o5PzcTYzgxKXluYPx7oMPeocY
        mTgYDzFKcDArifDO2PQpUYg3JbGyKrUoP76oNCe1+BCjKTDIJjJLiSbnA1NnXkm8oYmlgYmZ
        mZmJpbGZoZI47+n0DYlCAumJJanZqakFqUUwfUwcnFINTB6Fa/3S32kmBlVOsouZGiFf/fqh
        lh1D58vHEgwGfy0OXuNctvTEXKVd8izHXTwKrxjZqVwN33ne5UkBywktL22v5GDl0vLPc3c+
        VDjr6+N6jmER55bHlYofelcf+x0c5ya5lLXI8rm/86fb32OcOZMSQyXL/gTsLEix2vb6lIfK
        cjmVi7yX+OLuyaafkRL0LNNoCVjf/2rNh1tnTqgrrrs3Z91c359latZ3S33mhq7a1spld+lt
        eBaDdknGDTmLkk/HdCbWpngFMlWd2GzHIK8i9E9D+pjEt9z1a9bkiVSbfT624THf9q1TKp4x
        XDE0+D5zn9TVpT2Hf75hXeI7Y9LZkIkOL0Kf6PHVfJq+WYmlOCPRUIu5qDgRAGtSISzlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSvG6R+7dEg3PvOCwezNvGZjH/yDlW
        i41vfzBZbHp8jdXi8q45bBYzzu9jsmjde4Tdgd1jVkMvm8emVZ1sHpuX1Hv0bVnF6PF5k1wA
        axSXTUpqTmZZapG+XQJXxpt5P9gKTipWtO5YxNzA+Feqi5GTQ0LARKLn1WrGLkYuDiGBHYwS
        syesYYdISEtc3zgByhaWWPnvOTtEUROTxLsTT5lAEmwC2hJ3p28Bs0UEPCTa/t1jBiliFljO
        KNG5azkbSEJYwE3i+uk1YEUsAqoS/c2bwKbyCthITHnznQlig7zE6g0HmEFsTgFbibbb28B6
        hYBqpv/sY5zAyLeAkWEVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw2Glp7WDcs+qD
        3iFGJg7GQ4wSHMxKIrwzNn1KFOJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZq
        akFqEUyWiYNTqoHJ7kmkbrfm6naVUz9uasc+Y9TdvFXtfPo7m6Ksvyxes6fqfpINyjEzuiHB
        fldB/djNCV83v9wQLd9YZCX5eeeGbs2H9ow7zn9m7nq9qENs55a+kiUBWqevfvi8pk0tbWWG
        pxlr/olc1XnG8zb9kd4TnpibITDfaNO94DcuGsw5za9srdNs+AVy9G68uiO/2DvZp8tzavXb
        n+s23M0tvbJFfcUyv/v9frcXcBoUPI7rW3n7N6Pmqr8CWhd3r123V7jh4tMDexk4s57Ma3dr
        u7GNu3L3C7GawEgJn+v/30z/tSfwl1/U1FfNwhxFOV1B2oL/E57O2e638MNt66PPrntU7dmh
        E6Q+IcUvxurEfnsGJZbijERDLeai4kQAuUGDhKoCAAA=
X-CMS-MailID: 20220130080818epcas5p15adb431d08cb37060310fec00bb77cd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220130080818epcas5p15adb431d08cb37060310fec00bb77cd2
References: <20220130075520.49193-1-alim.akhtar@samsung.com>
        <CGME20220130080818epcas5p15adb431d08cb37060310fec00bb77cd2@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently dma node name does not matches the pl330
dt schema and make dtbs_check report below warning

'pdma@121a0000' does not match '^dma-controller(@.*)?$'
'mdma@10800000' does not match '^dma-controller(@.*)?$'

Update the dma node name to match pl330 dt schema

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |  8 ++++----
 arch/arm/boot/dts/exynos5410.dtsi |  4 ++--
 arch/arm/boot/dts/exynos5420.dtsi | 10 +++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index c6080bb75a62..5baaa7eb71a4 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -692,7 +692,7 @@ usb2_phy_gen: phy@12130000 {
 			samsung,pmureg-phandle = <&pmu_system_controller>;
 		};
 
-		pdma0: pdma@121a0000 {
+		pdma0: dma-controller@121a0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121A0000 0x1000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
@@ -703,7 +703,7 @@ pdma0: pdma@121a0000 {
 			#dma-requests = <32>;
 		};
 
-		pdma1: pdma@121b0000 {
+		pdma1: dma-controller@121b0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121B0000 0x1000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
@@ -714,7 +714,7 @@ pdma1: pdma@121b0000 {
 			#dma-requests = <32>;
 		};
 
-		mdma0: mdma@10800000 {
+		mdma0: dma-controller@10800000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x10800000 0x1000>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
@@ -725,7 +725,7 @@ mdma0: mdma@10800000 {
 			#dma-requests = <1>;
 		};
 
-		mdma1: mdma@11c10000 {
+		mdma1: dma-controller@11c10000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x11C10000 0x1000>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 584ce62361b1..4d797a9abba4 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -189,7 +189,7 @@ pinctrl_3: pinctrl@3860000 {
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		pdma0: pdma@121a0000 {
+		pdma0: dma-controller@121a0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121a0000 0x1000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
@@ -200,7 +200,7 @@ pdma0: pdma@121a0000 {
 			#dma-requests = <32>;
 		};
 
-		pdma1: pdma@121b0000 {
+		pdma1: dma-controller@121b0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121b0000 0x1000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index e23e8ffb093f..29e33cda14c4 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -430,7 +430,7 @@ pinctrl_4: pinctrl@3860000 {
 			power-domains = <&mau_pd>;
 		};
 
-		adma: adma@3880000 {
+		adma: dma-controller@3880000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x03880000 0x1000>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
@@ -442,7 +442,7 @@ adma: adma@3880000 {
 			power-domains = <&mau_pd>;
 		};
 
-		pdma0: pdma@121a0000 {
+		pdma0: dma-controller@121a0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121A0000 0x1000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
@@ -453,7 +453,7 @@ pdma0: pdma@121a0000 {
 			#dma-requests = <32>;
 		};
 
-		pdma1: pdma@121b0000 {
+		pdma1: dma-controller@121b0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x121B0000 0x1000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
@@ -464,7 +464,7 @@ pdma1: pdma@121b0000 {
 			#dma-requests = <32>;
 		};
 
-		mdma0: mdma@10800000 {
+		mdma0: dma-controller@10800000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x10800000 0x1000>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
@@ -475,7 +475,7 @@ mdma0: mdma@10800000 {
 			#dma-requests = <1>;
 		};
 
-		mdma1: mdma@11c10000 {
+		mdma1: dma-controller@11c10000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x11C10000 0x1000>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

