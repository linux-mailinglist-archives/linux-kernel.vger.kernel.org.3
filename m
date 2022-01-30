Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C74C4A34CE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 08:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354295AbiA3HR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 02:17:28 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:24639 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354286AbiA3HR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 02:17:27 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220130071725epoutp03a9a84fd2f87db46ed05911f9066927c6~O_yPzCGXJ1928019280epoutp039
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 07:17:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220130071725epoutp03a9a84fd2f87db46ed05911f9066927c6~O_yPzCGXJ1928019280epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643527045;
        bh=OqVKBBDdQmDFundTIJwrdp/DGY2Qok3thjIBjRyDscI=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=fKGiciLE1Hkrn+/LIQDamSsIiulFCrJkw+idfzO/VSrBvUTsUIlgvzX7VPS8VS/sV
         TbOM6bnadHO0RqvmnnjT3sVJYtJaS6HcvrBwQ8tD4VA6xKqlqmpiWMU4guH3Kn8foi
         XfnczpU1lpGIl3DFeKdCG6ZJ+3ByMf5q81jpzZQY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220130071724epcas5p2e72fb4e5b62cf732e8e68cdbdae1057f~O_yO2JGKC3190031900epcas5p2M;
        Sun, 30 Jan 2022 07:17:24 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JmjFF20shz4x9Pq; Sun, 30 Jan
        2022 07:17:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.C2.06423.08B36F16; Sun, 30 Jan 2022 16:17:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220130071720epcas5p1521c11e9d6cb248e6a453a6a639db61c~O_yK81SUF3035830358epcas5p1K;
        Sun, 30 Jan 2022 07:17:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220130071720epsmtrp298b5fe0004c389389e29ab38859429a2~O_yK7AL4Y2905329053epsmtrp22;
        Sun, 30 Jan 2022 07:17:20 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-a7-61f63b805b42
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.A0.29871.08B36F16; Sun, 30 Jan 2022 16:17:20 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220130071718epsmtip2f490518c357877a1256185d624e2e7d2~O_yJV2cPk0887608876epsmtip2C;
        Sun, 30 Jan 2022 07:17:18 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Lee Jones'" <lee.jones@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
In-Reply-To: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 1/5] arm64: dts: exynos: align pl330 node name with
 dtschema
Date:   Sun, 30 Jan 2022 12:47:17 +0530
Message-ID: <00d601d815a9$6b509890$41f1c9b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkI64pg85Gv5s7Nhqj/7nYjMyAEQFgtqenrNgFj+A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmhm6D9bdEg09fzCzmHznHatG8eD2b
        xca3P5gs7n89ymix6fE1VovLu+awWcw4v4/J4sziXnaLtUfuslu07j3CbnH4TTurA7fHrIZe
        No9NqzrZPO5c28PmsX/uGnaPzUvqPfq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7
        ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hGJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+
        cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xuLDy5gLdkpU/Dj6kLGB8ahIFyMn
        h4SAicSue1fYuhi5OIQEdjNKXPu5iR3C+cQo8X/LWUYI5xujxNHZ+9hgWvYeu8IKkdjLKHF3
        0jUmCOclo0TT5RtgVWwCuhI7FreBDRYRuMkssWpLCwtIglPAQ2LPuelgRcICQRLP5/4Fs1kE
        VCUmzTsJZvMKWEps/36WFcIWlDg58wlYL7OAvMT2t3OYIc5QkPj5dBlYjYiAlcTsy8/ZIGrE
        JV4ePcIOUbOHQ2LezGAI20Vi9/btUHFhiVfHt0DZUhKf3+0F6uUAsrMlenYZQ4RrJJbOO8YC
        YdtLHLgyhwWkhFlAU2L9Ln2ITXwSvb+fMEF08kp0tAlBVKtKNL+7CtUpLTGxu5sVwvaQaH34
        EhpUs4FB1bGXaQKjwiwkT85C8uQsJM/MQti8gJFlFaNkakFxbnpqsWmBYV5qOTzCk/NzNzGC
        k7CW5w7Guw8+6B1iZOJgPMQowcGsJMI7Y9OnRCHelMTKqtSi/Pii0pzU4kOMpsCQn8gsJZqc
        D8wDeSXxhiaWBiZmZmYmlsZmhkrivKfTNyQKCaQnlqRmp6YWpBbB9DFxcEo1MOXxhRSFc3tx
        dOx1ebvyq893bWtbmdWrs74uMAwqDAmKlPx3Wn/WHgW+//+v3Lv+a3bx47+nVi9YyWyvlxZ+
        88dX8RkJa6TehBmYVzDxyd+4u+7xKxs/5VVf+D0Xak3JnV3+oiDh9sYjW7NCRB/ouK2auTRS
        5oHg/8eaZ6P7Nt6buuWj0Vb3Wq8JtxUDXcX4jaIsr28+nMX4+LbDVFbHb+yptycnbv6Rpu7w
        o/Ruufx5qXUyulMnrViWMK9jy+a7T5M5uw5PTPxyXL5xyXzDQAdr4Rz1uhce9i+P/kuUO23O
        d7lOLcba8Nu0SevWCbFWrvhp65dVoXN90vUwXe/7L/dvFp4qIj5lz1b2U4rTlC4psRRnJBpq
        MRcVJwIAEAjuzUsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSvG6D9bdEgxOnBSzmHznHatG8eD2b
        xca3P5gs7n89ymix6fE1VovLu+awWcw4v4/J4sziXnaLtUfuslu07j3CbnH4TTurA7fHrIZe
        No9NqzrZPO5c28PmsX/uGnaPzUvqPfq2rGL0+LxJLoA9issmJTUnsyy1SN8ugStj8eFlzAU7
        JSp+HH3I2MB4VKSLkZNDQsBEYu+xK6xdjFwcQgK7GSWaTx5ghEhIS1zfOIEdwhaWWPnvOTtE
        0XNGiakHHrCBJNgEdCV2LG5jA0mICDxkltj1YxLUqJmMErdOzQOr4hTwkNhzbjqYLSwQIDFt
        zyomEJtFQFVi0ryTYHFeAUuJ7d/PskLYghInZz5h6WLk4GAW0JNo2wh2EbOAvMT2t3OYIS5S
        kPj5dBlYuYiAlcTsy8/ZIGrEJV4ePcI+gVFoFpJJsxAmzUIyaRaSjgWMLKsYJVMLinPTc4sN
        CwzzUsv1ihNzi0vz0vWS83M3MYIjTktzB+P2VR/0DjEycTAeYpTgYFYS4Z2x6VOiEG9KYmVV
        alF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzub2TX7vvtaLBqnm9z
        TEXo0rtKtvw/f65ek1S5/+KT0y/vTk/mmr7n6uKIRzIM+fltpk1zm4xY30xm5DsioPnbxeB3
        3K++ILWgmntObiXhhf2B7wO+fDeIFo2eVvbJv/L1nfp/dks6+qLEZD1jeiotld13uC65fVf5
        TdeTzhD/9bcTc1KfvxJZ1y692NfrGp/w9pRi7dBj7qLm09bY5D6Sbw2+/7EsILjo/7wLv5+6
        fM1kXhmgy3G16ESC8KzuT2dOXVVdtvB4EONGiwdSm4QtKkzsFk9pevnikuwULwclQz7u/PgY
        DovTzn8viZ+K1W6/vS/qytFlr+8HHDimdHxafHSTU7XidXHzz1+2LldiKc5INNRiLipOBAAx
        fYv2JwMAAA==
X-CMS-MailID: 20220130071720epcas5p1521c11e9d6cb248e6a453a6a639db61c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220129175341epcas5p480a45065d3d6faee0e405a1efda46a1f
References: <CGME20220129175341epcas5p480a45065d3d6faee0e405a1efda46a1f@epcas5p4.samsung.com>
        <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Saturday, January 29, 2022 11:23 PM
>To: Lee Jones <lee.jones@linaro.org>; Rob Herring <robh+dt@kernel.org>;
>Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Sylwester Nawrocki
><s.nawrocki@samsung.com>; Marek Szyprowski
><m.szyprowski@samsung.com>; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-serial@vger.kernel.org
>Subject: [PATCH 1/5] arm64: dts: exynos: align pl330 node name with
>dtschema
>
>Fixes dtbs_check warnings like:
>
>  pdma@15610000: $nodename:0: 'pdma@15610000' does not match '^dma-
>controller(@.*)?$'
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@smasung.com>


> arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
> arch/arm64/boot/dts/exynos/exynos7.dtsi    | 4 ++--
> 2 files changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>index bfe4ed8a23d6..b4cde77e02d3 100644
>--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>@@ -1858,7 +1858,7 @@ mshc_2: mshc@15560000 {
> 			status = "disabled";
> 		};
>
>-		pdma0: pdma@15610000 {
>+		pdma0: dma-controller@15610000 {
> 			compatible = "arm,pl330", "arm,primecell";
> 			reg = <0x15610000 0x1000>;
> 			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
>@@ -1869,7 +1869,7 @@ pdma0: pdma@15610000 {
> 			#dma-requests = <32>;
> 		};
>
>-		pdma1: pdma@15600000 {
>+		pdma1: dma-controller@15600000 {
> 			compatible = "arm,pl330", "arm,primecell";
> 			reg = <0x15600000 0x1000>;
> 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
>@@ -1891,7 +1891,7 @@ audio-subsystem@11400000 {
> 			#size-cells = <1>;
> 			ranges;
>
>-			adma: adma@11420000 {
>+			adma: dma-controller@11420000 {
> 				compatible = "arm,pl330", "arm,primecell";
> 				reg = <0x11420000 0x1000>;
> 				interrupts = <GIC_SPI 73
>IRQ_TYPE_LEVEL_HIGH>; diff --git
>a/arch/arm64/boot/dts/exynos/exynos7.dtsi
>b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>index 960823b8247a..3364b09c3158 100644
>--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>@@ -142,7 +142,7 @@ gic: interrupt-controller@11001000 {
> 				<0x11006000 0x2000>;
> 		};
>
>-		pdma0: pdma@10e10000 {
>+		pdma0: dma-controller@10e10000 {
> 			compatible = "arm,pl330", "arm,primecell";
> 			reg = <0x10E10000 0x1000>;
> 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
>@@ -153,7 +153,7 @@ pdma0: pdma@10e10000 {
> 			#dma-requests = <32>;
> 		};
>
>-		pdma1: pdma@10eb0000 {
>+		pdma1: dma-controller@10eb0000 {
> 			compatible = "arm,pl330", "arm,primecell";
> 			reg = <0x10EB0000 0x1000>;
> 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
>--
>2.32.0


