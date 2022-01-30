Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714BD4A34D9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 08:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354319AbiA3HUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 02:20:41 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:19767 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354298AbiA3HUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 02:20:35 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220130072034epoutp04af7afe04d537ad5ce4fd9e5a05fe2667~O_0-IIrjy0890608906epoutp04z
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 07:20:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220130072034epoutp04af7afe04d537ad5ce4fd9e5a05fe2667~O_0-IIrjy0890608906epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643527234;
        bh=1yost2nb4QKF+LswDgDXOKPOEgZVrHtlpKyxrpDCbus=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=isBs76rzx6d8pA/OemZ2N61f9zRJRFSVWsjpbdQQeWNNmcqDHlureO8SvvkkbxoDt
         l5TdbwNLeaz+ZuRRGb77shm3VVxhB7WtZ2X7Y674mCYstY68X72N6CiQ8m94MWwIch
         QOQ9toKs2GMNwstmPZpnpPjNpbxxGjJs3IKvEi9c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220130072032epcas5p293f88f81631d61ff74b46b9d24793aef~O_09pCLQg0335603356epcas5p2A;
        Sun, 30 Jan 2022 07:20:32 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JmjJs3f3Cz4x9Px; Sun, 30 Jan
        2022 07:20:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.16.05590.D3C36F16; Sun, 30 Jan 2022 16:20:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220130072028epcas5p27d4050b2945fad377255c2bf7e01f1d5~O_051tDy10335603356epcas5p2_;
        Sun, 30 Jan 2022 07:20:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220130072028epsmtrp24bb3aa5cf85f1fc10175ee353b7cf74c~O_050iRhR2905329053epsmtrp2Y;
        Sun, 30 Jan 2022 07:20:28 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-c0-61f63c3dba66
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.B0.29871.C3C36F16; Sun, 30 Jan 2022 16:20:28 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220130072026epsmtip1626855f094476baf3002776e95d28aa6~O_04H-X1U3074830748epsmtip12;
        Sun, 30 Jan 2022 07:20:26 +0000 (GMT)
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
Date:   Sun, 30 Jan 2022 12:50:25 +0530
Message-ID: <00d801d815a9$db41f9a0$91c5ece0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkI64pg85Gv5s7Nhqj/7nYjMyAEQFgtqenrNgGeLA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmhq6tzbdEgyu/uS3mHznHatG8eD2b
        xca3P5gs7n89ymix6fE1VovLu+awWcw4v4/J4sziXnaLtUfuslu07j3CbnH4TTurA7fHrIZe
        No9NqzrZPO5c28PmsX/uGnaPzUvqPfq2rGL0+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7
        ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hGJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+
        cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xt7ru9gKNkpUzH30lbGB8YBIFyMn
        h4SAicTB1y0sXYxcHEICuxkl3vVfZYVwPjFKtHf1MEM43xgltk3fxQTT8rHhOVTVXkaJmx+f
        skE4Lxklrs26xghSxSagK7FjcRtYQkTgJrPEqi0gWzg5OAU8JPacm84GYgsLBEk8n/sXzGYR
        UJX4uGojK4jNK2Ap8ffUL0YIW1Di5MwnYL3MAvIS29/OYYY4Q0Hi59NlYPUiAlYSy1auZoao
        EZd4efQIO0TNDg6Jc/eKIGwXiV2z9kD1Cku8Or4FqkZK4vO7vUA3cADZ2RI9u4whwjUSS+cd
        Y4Gw7SUOXJnDAlLCLKApsX6XPsQmPone30+YIDp5JTrahCCqVSWa312F6pSWmNjdzQphe0i0
        PnzJBAmq2YwSTR17mSYwKsxC8uQsJE/OQvLMLITNCxhZVjFKphYU56anFpsWGOellsMjPDk/
        dxMjOAlree9gfPTgg94hRiYOxkOMEhzMSiK8MzZ9ShTiTUmsrEotyo8vKs1JLT7EaAoM+YnM
        UqLJ+cA8kFcSb2hiaWBiZmZmYmlsZqgkznsqfUOikEB6YklqdmpqQWoRTB8TB6dUA1Na6gv3
        B4/6nhTLrTnpEeKx4ucdi6JTiZxhbV7Xf/yy/lS12u+H/N3Lc219Gpo0S+Tf1HhJPL6vN6eC
        obSl4EXgiTtKLVcnvYiPEXL+zJTAbG+4m6HhjfYy/o3MDIdcJ+asb3nLtcVXMZg58VTdfCFd
        kfkLi9bb92e/vhtx81frNLclK3Oc305UsLzsXJktOG3GFZdQcQ/L6cxvw4v4rgsarog1v9Ux
        +7J6553tHe9N0+rmHOs5/uM419P00MaaxI39z9OW1Syvj5U+xJHUJ1Qc915ofdn+5wWnK5vE
        zpVX9J0Rc9a7JMs/SclLZI/r8ebZ4rIWRh5/qvZev3hi49FKGWkPk9hTloeV2LY8VGIpzkg0
        1GIuKk4EAIbC7atLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnK6NzbdEg7+trBbzj5xjtWhevJ7N
        YuPbH0wW978eZbTY9Pgaq8XlXXPYLGac38dkcWZxL7vF2iN32S1a9x5htzj8pp3VgdtjVkMv
        m8emVZ1sHneu7WHz2D93DbvH5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJWx9/outoKN
        EhVzH31lbGA8INLFyMkhIWAi8bHhOWsXIxeHkMBuRonGfzOYIBLSEtc3TmCHsIUlVv57zg5R
        9JxRYt/vBhaQBJuArsSOxW1sIAkRgYfMErt+TIIaNZNR4tapeWwgVZwCHhJ7zk0Hs4UFAiSm
        7VkFtoJFQFXi46qNrCA2r4ClxN9TvxghbEGJkzOfAG3g4GAW0JNo2wgWZhaQl9j+dg4zxEUK
        Ej+fLgNrFRGwkli2cjUzRI24xMujR9gnMArNQjJpFsKkWUgmzULSsYCRZRWjZGpBcW56brFh
        gWFearlecWJucWleul5yfu4mRnDEaWnuYNy+6oPeIUYmDsZDjBIczEoivDM2fUoU4k1JrKxK
        LcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1Oqgamu+4hOY57fhBPTTO8v
        fZg2/5yQhp61ltEeQX+X/a+ZFbv/+DrGz/8oHn59QouSWP/pvCOfv94+G+KZs62n8KW0m+CK
        TaeMai11qxvmV7xq9xd2vsh6eVPl5R/XJzAZLIs72OrLrXbH2Uoi76ehCl/d5sUi5ik14jsc
        H0u+PPz8u3xrmOv5RxELFk/qrTunIXOfLTmzpy87K6r1yifmW0Ur/u7RWj+pSfV+hvayNWLN
        jx9/Z5/w+4x0wrpGJgOGC1GbUz+Eia3JS79hbNmyQbpUSfVCxqmi6ImeCxQ4zBWkXriz+V27
        cz6Lo4Cl3OTIdgbNiQpxM86La/7bHv3pHPdH6a8VfZ3akdPvPD0rp8RSnJFoqMVcVJwIACk1
        XrQnAwAA
X-CMS-MailID: 20220130072028epcas5p27d4050b2945fad377255c2bf7e01f1d5
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
Thanks

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


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


