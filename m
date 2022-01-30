Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A124A3516
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353306AbiA3IIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:08:32 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:31337 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245345AbiA3IIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:08:22 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220130080820epoutp02a3f1046402cbe4c7bf578d530424a245~O-etBEN_x2721627216epoutp02j
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 08:08:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220130080820epoutp02a3f1046402cbe4c7bf578d530424a245~O-etBEN_x2721627216epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643530100;
        bh=iVHfYySX0uZde70Cb3/ShP3rvvcqEzm23LV8gBQesNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQverYwVBRcIsCkv8yPhg/KmU4lV2UzHoFXVDCrv8uso3yrGQMDnv0xZlakl/8OOy
         +sp3Oa+neZ8vDAWaQCTzBSubZdU0nM37pBBfIjq2RJJUzY3sPoQYU7ABZlCNFfFWOS
         vZa1ZPAvhY3SmNZ4XvTmAeWaBc6ds6UV22pyhoWk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220130080820epcas5p485c0a9bc45f9a3ea9b785c273df955d4~O-esmLVNI1949419494epcas5p4F;
        Sun, 30 Jan 2022 08:08:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JmkN03cXrz4x9Pt; Sun, 30 Jan
        2022 08:08:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.D1.46822.A1546F16; Sun, 30 Jan 2022 16:58:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220130080815epcas5p33462c816b7ca206bf1ce498cb04f7686~O-eoT_hiC1295912959epcas5p3Y;
        Sun, 30 Jan 2022 08:08:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220130080815epsmtrp10b1d874805d94895d608925847a2d5ab~O-eoPgC6l1370913709epsmtrp1P;
        Sun, 30 Jan 2022 08:08:15 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-0d-61f6451a4ade
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.51.29871.F6746F16; Sun, 30 Jan 2022 17:08:15 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220130080813epsmtip2ec387b27d7fd6082d118f3a302968515~O-emgtdOs0518005180epsmtip2L;
        Sun, 30 Jan 2022 08:08:13 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 2/3] ARM: dts: exynos: update dma nodename for exynos4
Date:   Sun, 30 Jan 2022 13:25:19 +0530
Message-Id: <20220130075520.49193-2-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130075520.49193-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmhq6U67dEg1d7ZCwezNvGZjH/yDlW
        i41vfzBZbHp8jdXi8q45bBYzzu9jsmjde4Tdgd1jVkMvm8emVZ1sHpuX1Hv0bVnF6PF5k1wA
        a1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
        7Izzi3+xFxzlr5h7RKaB8TJPFyMnh4SAicSND19Zuxi5OIQEdjNK7Jp0gA3C+cQo8fP6ASYI
        5xujxIG3q5lgWtZ8/8QMkdjLKLG/vRGqpYVJYvfeNawgVWwC2hJ3p28B6xARcJO40dgBZjML
        LGaU+LUwHcQWBoo/OrqPGcRmEVCVeHFzPQuIzStgI3Fs+QlmiG3yEqs3HACzOQVsJdpubwNb
        JiFwjF1ifusERogiF4lF/z9BNQhLvDq+hR3ClpJ42d8GZHMA2dkSPbuMIcI1EkvnHWOBsO0l
        DlyZwwJSwiygKbF+lz7EmXwSvb+fMEF08kp0tAlBVKtKNL+7CtUpLTGxu5sVwvaQ2Ne0nxES
        DBMYJY6v/sI8gVF2FsLUBYyMqxglUwuKc9NTi00LjPJSy+HxlJyfu4kRnLa0vHYwPnzwQe8Q
        IxMH4yFGCQ5mJRHeGZs+JQrxpiRWVqUW5ccXleakFh9iNAUG2URmKdHkfGDizCuJNzSxNDAx
        MzMzsTQ2M1QS5z2dviFRSCA9sSQ1OzW1ILUIpo+Jg1OqgWn1tj+/Nfj+rwkI2K21rsG+an9Z
        TY9vyDMh8yzVfSoKRxOm/P+0OLZs2nmOKXdKNjq/5HVOeCJYHTB/1Y+Fn/5GLEtnck1XmqV8
        5sRxy6XnkrsWPChtZbg22fO5nNhu/dk78pW/vraeMHE621QfubsxndXfdrOnnz7/uDqlQe6T
        3sSrLTGT+aKdosKaXx7oyFr/s2qZ7/2Dmk66eguYjwV/7et3nMC+YbbgzbDX7uEXc6yKWXRP
        311wIemC2p6Gjd+2Sgrb2Yf2HdNf6SVoLLpW2NXxcc/Otx2nz57eeCePZYnZq6OfVFx2/jGz
        OMVRVlaq23R56q7v7M4yHHn7tV86n3HwDFtrdChVYRHbzDAlluKMREMt5qLiRACCnbVp5AMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvG6++7dEgzP/DS0ezNvGZjH/yDlW
        i41vfzBZbHp8jdXi8q45bBYzzu9jsmjde4Tdgd1jVkMvm8emVZ1sHpuX1Hv0bVnF6PF5k1wA
        axSXTUpqTmZZapG+XQJXxvnFv9gLjvJXzD0i08B4maeLkZNDQsBEYs33T8xdjFwcQgK7GSUe
        f2pkhUhIS1zfOIEdwhaWWPnvOTtEUROTxKPzp9lAEmwC2hJ3p29hArFFBDwk2v7dA5vELLCc
        UaJz13KwImEBN4lHR/cxg9gsAqoSL26uZwGxeQVsJI4tP8EMsUFeYvWGA2A2p4CtRNvtbWC9
        QkA103/2MU5g5FvAyLCKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM46LQ0dzBuX/VB
        7xAjEwfjIUYJDmYlEd4Zmz4lCvGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1
        tSC1CCbLxMEp1cDEUfw4clnIdcn1TxcGFjt6LzdkZ/wcUC0ZZewpYZrY9N+iLve22MHp/3d8
        E/qSe4lj8WrmsJ05+iflPG1+7NOPTy79PfNRwsOi9dFPhRTzWvxZZ7Mey5x/ZKPSvodi5yRm
        PWku+fJjW4n+4R2T3YMmebFVx/tl8ul1Vxy897u/YKVMly6LnPqqpl+1H1TLj1g5/M1YsPSo
        38qlgluPRv5d4dia/2Jt+uekw6ql+vtiL13PnyS5r9m4z+7KpUtZesYtMdu2btfJqVsosavR
        Z7Jr1Kqi/JDrN7QUNSdY7Ij0C5j47VPv5euLXvIUnvnR13Llv1XdWpat/szazVVGUS8elga/
        bpNwdF6h5/Cz2U6JpTgj0VCLuag4EQDPI8RFqQIAAA==
X-CMS-MailID: 20220130080815epcas5p33462c816b7ca206bf1ce498cb04f7686
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220130080815epcas5p33462c816b7ca206bf1ce498cb04f7686
References: <20220130075520.49193-1-alim.akhtar@samsung.com>
        <CGME20220130080815epcas5p33462c816b7ca206bf1ce498cb04f7686@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently dma node name does not matches the pl330
dt schema and make dtbs_check report below warning

'mdma@12850000' does not match '^dma-controller(@.*)?$'

Update the dma node name to match pl330 dt schema

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi                  | 6 +++---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index eab77a66ae8f..e81b3ee4e0f7 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -669,7 +669,7 @@ pwm: pwm@139d0000 {
 			status = "disabled";
 		};
 
-		pdma0: pdma@12680000 {
+		pdma0: dma-controller@12680000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12680000 0x1000>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
@@ -680,7 +680,7 @@ pdma0: pdma@12680000 {
 			#dma-requests = <32>;
 		};
 
-		pdma1: pdma@12690000 {
+		pdma1: dma-controller@12690000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12690000 0x1000>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
@@ -691,7 +691,7 @@ pdma1: pdma@12690000 {
 			#dma-requests = <32>;
 		};
 
-		mdma1: mdma@12850000 {
+		mdma1: dma-controller@12850000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x12850000 0x1000>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 170d54a0bb5c..138d606d58a5 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -659,7 +659,7 @@ &serial_3 {
 };
 
 &soc {
-	mdma0: mdma@12840000 {
+	mdma0: dma-controller@12840000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x12840000 0x1000>;
 		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

