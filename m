Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558D052BBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbiERNXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbiERNXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:23:43 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8841114AA6E
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:23:40 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220518132334epoutp0162eac82b155be160b87d2992e33f03e6~wNcw5Wv-j0652506525epoutp01B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:23:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220518132334epoutp0162eac82b155be160b87d2992e33f03e6~wNcw5Wv-j0652506525epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652880214;
        bh=CnGU/A7M1yeYaWUm7k0+1S8Nxkduw+M+3XIJTfXDa1k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=hKD/kmo7MUnyhzhhoFnIdYG35y3bcogF1WCEKseotfKoU9aQMbqrrG662sJkzUo3a
         HCtc80PxLkrZhF8Rr/1auZbHuBqKm/OCA7NGfnV84lJH/EbgkqG4qKReXiVjGpBsRn
         xJUobdWRi1nHPFavCsaM00aIDvtD8Q+8/nbRUJ1g=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220518132333epcas5p4df94e5a86f294f9ed85d1f9233bdaebb~wNcwHvomf1869018690epcas5p4D;
        Wed, 18 May 2022 13:23:33 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4L3DFt1x23z4x9Pq; Wed, 18 May
        2022 13:23:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.4F.09827.253F4826; Wed, 18 May 2022 22:23:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220518132329epcas5p307c6908621c3faa94d085b4a2cc931e1~wNcsXtOKo0723307233epcas5p34;
        Wed, 18 May 2022 13:23:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220518132329epsmtrp1e930829366da60790eb3febc36b5a2e4~wNcsW84PV2433024330epsmtrp17;
        Wed, 18 May 2022 13:23:29 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-2f-6284f352f90e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.4D.08924.153F4826; Wed, 18 May 2022 22:23:29 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220518132328epsmtip1a7a941f9147da4406a180a3ba656cc2c~wNcrPpum22165221652epsmtip1_;
        Wed, 18 May 2022 13:23:28 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fsd@tesla.com,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH] arm64: dts: fsd: Add cpu cache information
Date:   Wed, 18 May 2022 18:53:50 +0530
Message-Id: <20220518132350.35762-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7bCmum7Q55Ykg/6V3BYP5m1js5h/5Byr
        Rd+Lh8wWmx5fY7V4+Crc4vKuOWwWrXuPsDuwe2xa1cnmcefaHjaPzUvqPfq2rGL0+Nc0l93j
        8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wc
        oEuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZG
        pkCFCdkZExrcC15rVcw58ZipgfGnfBcjJ4eEgIlE87Rl7CC2kMBuRonmVw5djFxA9idGidZt
        H5khnM+MEhd3nmaG6eh8tIwJIrGLUWLms1+sEE4Lk8S6G49ZQKrYBLQl7k7fwgRiiwi4Sdxo
        7ADrYBaYyigx9cYxsISwgLXE/bWTwZazCKhKTDv7FMzmFbCRuLPpFdQ6eYnVGw6A3SEhsIpd
        4mf3ESaIhIvE0wNHoYqEJV4d38IOYUtJvOxvA7I5gGwPiUV/pCDCGRJvl69nhLDtJQ5cmcMC
        UsIsoCmxfpc+SJhZgE+i9/cTJohOXomONiGIalWJ5ndXWSBsaYmJ3d2sELaHxL9z71hByoUE
        YiVO9WdPYJSZhTBzASPjKkbJ1ILi3PTUYtMCo7zUcnjMJOfnbmIEpygtrx2MDx980DvEyMTB
        eIhRgoNZSYSXMbclSYg3JbGyKrUoP76oNCe1+BCjKTCQJjJLiSbnA5NkXkm8oYmlgYmZmZmJ
        pbGZoZI4r8D/xiQhgfTEktTs1NSC1CKYPiYOTqkGphij2z68fbHhVSU6n9v6nkz+GP2/bsWM
        H6XFusx90X3p5t9NJeeoHrVXCag7ynq/XutEofMd6578nAn3E5PzxZdvd47lWxg4ZeOe8sDn
        olwfV2xMKGwWYVaeI+FuKvKhb5LrtXffps3/dW7at3IFvQSrKvGfjgzKjsy7vguYiYhOmMfO
        se3Ysp8zPc8qzr+52HPvacGOnMD9b62b4qffk+5iDfO7Oj+AZ8Xa3M8PXl7QTq7JXXLkVvai
        m8XzNGa2WXAssz6QW3UjrsptU+87yYiPCUW7hZ5N22b0yXmjxMnbkccXlTzodD+Z4PaBOUQ7
        78empvQLOY4WC1S5JRreb+tauSFiAiOT3KUz76yXKLEUZyQaajEXFScCANSXLL3aAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsWy7bCSnG7g55Ykg+s3FSwezNvGZjH/yDlW
        i74XD5ktNj2+xmrx8FW4xeVdc9gsWvceYXdg99i0qpPN4861PWwem5fUe/RtWcXo8a9pLrvH
        501yAWxRXDYpqTmZZalF+nYJXBkTGtwLXmtVzDnxmKmB8ad8FyMnh4SAiUTno2VMILaQwA5G
        ieZJ2hBxaYnrGyewQ9jCEiv/PWeHqGliknj+WgvEZhPQlrg7fQtYr4iAh0Tbv3vMIDazwExG
        iRM/WUFsYQFriftrJ4P1sgioSkw7+xTM5hWwkbiz6RUzxHx5idUbDjBPYORZwMiwilEytaA4
        Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOIy0tHYw7ln1Qe8QIxMH4yFGCQ5mJRFextyWJCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY6ie2N3RdDig6
        PVvxy4fuE/OOWn8NYeOdY/hF+MfW7VckoqI31Z65uKc8+PqX9zdYeT0EfkjLmq+IfRTxPCak
        smvVZzvHwCcyk41NDyUZZ6sl3mmQaRNTKCjctFfE8z3Lw2m/ni6asVBv/83bm9bc9Vf4d0My
        feO/cutzq6ee61mlbfH/1APdQzNEKg4aT96qt9fmrtCUN292Tv2asSHXKHajxqtJOU8uT5h6
        fPF9t0qhW7sEfhsmJ6sfn6cYbyVc1WvTZutyKqzs9+HVS5oCLsR+OT455by8gLq7kxhTsL99
        aKZk6qfA8iq2t3kTV3D//VAv6ZTPsPK0jAPzveCp8gy7NntLafOq3SloX8EapMRSnJFoqMVc
        VJwIAD0Xr+KSAgAA
X-CMS-MailID: 20220518132329epcas5p307c6908621c3faa94d085b4a2cc931e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220518132329epcas5p307c6908621c3faa94d085b4a2cc931e1
References: <CGME20220518132329epcas5p307c6908621c3faa94d085b4a2cc931e1@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU caches information so that the same is available to
userspace via sysfs.  This SoC has 48/32 KB I/D cache for
each CPU cores and 4MB of L2 cache.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 91 ++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 7ad634533104..36480a9b34c4 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -93,6 +93,13 @@ cpucl0_0: cpu@0 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		cpucl0_1: cpu@1 {
@@ -102,6 +109,13 @@ cpucl0_1: cpu@1 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		cpucl0_2: cpu@2 {
@@ -111,6 +125,13 @@ cpucl0_2: cpu@2 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		cpucl0_3: cpu@3 {
@@ -119,6 +140,13 @@ cpucl0_3: cpu@3 {
 				reg = <0x0 0x003>;
 				enable-method = "psci";
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		/* Cluster 1 */
@@ -129,6 +157,13 @@ cpucl1_0: cpu@100 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		cpucl1_1: cpu@101 {
@@ -138,6 +173,13 @@ cpucl1_1: cpu@101 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		cpucl1_2: cpu@102 {
@@ -147,6 +189,13 @@ cpucl1_2: cpu@102 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		cpucl1_3: cpu@103 {
@@ -156,6 +205,13 @@ cpucl1_3: cpu@103 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		/* Cluster 2 */
@@ -166,6 +222,13 @@ cpucl2_0: cpu@200 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		cpucl2_1: cpu@201 {
@@ -175,6 +238,13 @@ cpucl2_1: cpu@201 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		cpucl2_2: cpu@202 {
@@ -184,6 +254,13 @@ cpucl2_2: cpu@202 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
 		};
 
 		cpucl2_3: cpu@203 {
@@ -193,6 +270,20 @@ cpucl2_3: cpu@203 {
 				enable-method = "psci";
 				clock-frequency = <2400000000>;
 				cpu-idle-states = <&CPU_SLEEP>;
+				i-cache-size = <0xc000>;
+				i-cache-line-size = <64>;
+				i-cache-sets = <256>;
+				d-cache-size = <0x8000>;
+				d-cache-line-size = <64>;
+				d-cache-sets = <256>;
+				next-level-cache = <&cpucl_l2>;
+		};
+
+		cpucl_l2: l2-cache0 {
+			compatible = "cache";
+			cache-size = <0x400000>;
+			cache-line-size = <64>;
+			cache-sets = <4096>;
 		};
 
 		idle-states {
-- 
2.25.1

