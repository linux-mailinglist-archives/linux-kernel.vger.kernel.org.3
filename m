Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8523655B4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 03:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiF0BcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 21:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiF0BcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 21:32:03 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536252AF2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 18:32:00 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220627013157epoutp014d30f3e3140dd55f6f97b0c8a5eb43d4~8Vi2ucNBk1010610106epoutp01f
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:31:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220627013157epoutp014d30f3e3140dd55f6f97b0c8a5eb43d4~8Vi2ucNBk1010610106epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656293517;
        bh=DRuOUfGFx+COd6dQJMlvRgb9zEgrBMtsnZkmpUoOKdA=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=q+/OSGZp4UEXI1t3NZS2DjvzdEMe0YVvsI0GXFhIEMY1BzJ2+Uu0YKn8jtem7qNqU
         sDO9UdHasw3SO+SQcyG4s/tR8JNO4CGC7J/fW0yLU7Nd6MWmiV1xnH9DF6QknZO0Ww
         TYSkKs+jxNmbK+n+o5Ar48wCFSaUPjL87SOaOViA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220627013156epcas5p2e7d3bc1a234da5d6438694f855901725~8Vi2QXMJa0903509035epcas5p2K;
        Mon, 27 Jun 2022 01:31:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LWVZK1ftFz4x9Pt; Mon, 27 Jun
        2022 01:31:53 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.4C.09662.98809B26; Mon, 27 Jun 2022 10:31:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220627013152epcas5p45a12c2d14ddc03cc54ee6715731c5d1c~8ViybrjBE2495024950epcas5p4W;
        Mon, 27 Jun 2022 01:31:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220627013152epsmtrp142f57d8ef9f869841bb68395514a3053~8Viya3nVO2912129121epsmtrp1b;
        Mon, 27 Jun 2022 01:31:52 +0000 (GMT)
X-AuditID: b6c32a49-86fff700000025be-78-62b90889b72d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.07.08905.88809B26; Mon, 27 Jun 2022 10:31:52 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220627013151epsmtip159c923153394b8ed7a419c7d679e8f08~8Viw-gtGj2181421814epsmtip1o;
        Mon, 27 Jun 2022 01:31:50 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220626120342.38851-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/5] ARM: dts: exynos: align SDHCI node name with
 dtschema
Date:   Mon, 27 Jun 2022 07:01:49 +0530
Message-ID: <000a01d889c5$adb3bd30$091b3790$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ4rjjbOzoR1c1L7LjC2VF3+X9p2QFDPK8dAYzjnSGsC6x04A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmhm4nx84kg40nWS3mHznHanHjVxur
        Rd+Lh8wWe19vZbfY9Pgaq8XlXXPYLI7872e0mHF+H5NF694j7BbH14Y7cHlsWtXJ5nHn2h42
        j81L6j36tqxi9Pi8SS6ANSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8x
        N9VWycUnQNctMwfoJiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFp
        XrpeXmqJlaGBgZEpUGFCdsaMZyvYCrqEKhbumsPawPiPr4uRk0NCwETi2pPTjF2MXBxCArsZ
        JXr/XmeFcD4xSrS17mYEqRIS+MYoce9HKEzH3nlbmCGK9jJKHP24jA3Cecko0XS1gx2kik1A
        V2LH4jawhIjAcmaJ0+1r2EASnAIuEsd/zgUbKywQIPFm+WcmEJtFQFVi7uHjYDW8ApYStx4d
        gLIFJU7OfMICYjMLyEtsfzuHGeIMBYmfT5exgtgiAk4S+9bvYoKoEZd4efQIO8hiCYGFHBLP
        929lgWhwkXh2ex0jhC0s8er4FnYIW0riZX8bkM0BZHtILPojBRHOkHi7fD1Uub3EgStzWEBK
        mAU0Jdbv0odYxSfR+/sJE0Qnr0RHmxBEtapE87urUEulJSZ2d7NC2B4Sf271QIP6IqPE99ML
        WCYwKsxC8uUsJF/OQvLNLITNCxhZVjFKphYU56anFpsWGOallsMjPDk/dxMjOMlqee5gvPvg
        g94hRiYOxkOMEhzMSiK8r69vTRLiTUmsrEotyo8vKs1JLT7EaAoM+onMUqLJ+cA0n1cSb2hi
        aWBiZmZmYmlsZqgkzut1dVOSkEB6YklqdmpqQWoRTB8TB6dUA1Ou+sN5FvXMDc87A/5uW5Ew
        KfBjlPcaPruIrU6pkdd73ur0NxbNWJv4vM36LRvL2t0RLefnSXxfeYKRszI7tZznGJuOoNEm
        NRe9z/UWL+c8KbnNq9GStUyx3HzL29T5ZRG3tp4rWS/+t8VHsP2kl6RbhMIqH6UWzbjJKp9e
        1PFqT7jw23iDyGFGZfk1i/7/faC9eMb89W9Oe9877JkzMfNS+3fL4pnxzU3Wpr6fJmTm5yvl
        3zh66dXpBOu+U84TlbU+7nflFyrcnT7jgJ2yVZHJys5ZmUcb/RZ7l/WsKTh4NdvsSu3l9baF
        h6eX+r9KdZdfxxQiE3Tlgg/zqzfZZy9G7vQ3f5iZFi9yr/7tHSWW4oxEQy3mouJEANdytNM7
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJTreDY2eSwbufUhbzj5xjtbjxq43V
        ou/FQ2aLva+3sltsenyN1eLyrjlsFkf+9zNazDi/j8mide8Rdovja8MduDw2repk87hzbQ+b
        x+Yl9R59W1YxenzeJBfAGsVlk5Kak1mWWqRvl8CVMePZCraCLqGKhbvmsDYw/uPrYuTkkBAw
        kdg7bwtzFyMXh5DAbkaJzu/NjBAJaYnrGyewQ9jCEiv/PWeHKHrOKHHn7R2wBJuArsSOxW1s
        IAkRgfXMEudv7WCDqDrLKLFx2RxWkCpOAReJ4z/ngo0VFvCT6Dm3jBnEZhFQlZh7+DgbiM0r
        YClx69EBKFtQ4uTMJyxdjBwczAJ6Em0bwVqZBeQltr+dwwxxkYLEz6fLwMaLCDhJ7Fu/iwmi
        Rlzi5dEj7BMYhWYhmTQLYdIsJJNmIelYwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/
        dxMjOKK0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe19e3JgnxpiRWVqUW5ccXleakFh9ilOZgURLn
        vdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXApPypoTTr7e1dKRsfeMQ6abw4d6Lz9Ep3Q4FrXuuW
        l8i9kMp9VWvjL+pi2bZtS7lbWbmmv/60oifXj/67v93vssOsDs7Gnco/o17xxj5oKlzyNKU4
        9oy0qFWhqH3X4qX2h2QmdrneeLddN1frQFX3tM3vhVrz+X0zxYtusk6tCOjaIhlze2+serq0
        4LPt9cdn9QUaV3moz1UK+K7zMTkmPdYg7IM+q79doCff7S2nl0/w/r5EyfFMYv89G03ueyf5
        l8bYaN96+qO4dbLzOu//s9YsXjQx3aEld1PV5/fqLzYY1a6SPH+uotw92HfK1N1lm9UlFjVb
        bVjaKnksrYXB1nVT4ve/C7PvFj13uKapxFKckWioxVxUnAgAGCDvCRcDAAA=
X-CMS-MailID: 20220627013152epcas5p45a12c2d14ddc03cc54ee6715731c5d1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220626120350epcas5p25a98e0669eeb11ce7959ace0f3634926
References: <20220626120342.38851-1-krzysztof.kozlowski@linaro.org>
        <CGME20220626120350epcas5p25a98e0669eeb11ce7959ace0f3634926@epcas5p2.samsung.com>
        <20220626120342.38851-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Sunday, June 26, 2022 5:34 PM
>To: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
><robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 1/5] ARM: dts: exynos: align SDHCI node name with
>dtschema
>
>The node names should be generic and DT schema expects "mmc".
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

 (for patch 1 ~ 4)

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> arch/arm/boot/dts/exynos4.dtsi | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm/boot/dts/exynos4.dtsi
>b/arch/arm/boot/dts/exynos4.dtsi index 6f0ca3354e39..5c4ecda27a47 100644
>--- a/arch/arm/boot/dts/exynos4.dtsi
>+++ b/arch/arm/boot/dts/exynos4.dtsi
>@@ -316,7 +316,7 @@ keypad: keypad@100a0000 {
> 			status = "disabled";
> 		};
>
>-		sdhci_0: sdhci@12510000 {
>+		sdhci_0: mmc@12510000 {
> 			compatible = "samsung,exynos4210-sdhci";
> 			reg = <0x12510000 0x100>;
> 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
>@@ -325,7 +325,7 @@ sdhci_0: sdhci@12510000 {
> 			status = "disabled";
> 		};
>
>-		sdhci_1: sdhci@12520000 {
>+		sdhci_1: mmc@12520000 {
> 			compatible = "samsung,exynos4210-sdhci";
> 			reg = <0x12520000 0x100>;
> 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
>@@ -334,7 +334,7 @@ sdhci_1: sdhci@12520000 {
> 			status = "disabled";
> 		};
>
>-		sdhci_2: sdhci@12530000 {
>+		sdhci_2: mmc@12530000 {
> 			compatible = "samsung,exynos4210-sdhci";
> 			reg = <0x12530000 0x100>;
> 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>@@ -343,7 +343,7 @@ sdhci_2: sdhci@12530000 {
> 			status = "disabled";
> 		};
>
>-		sdhci_3: sdhci@12540000 {
>+		sdhci_3: mmc@12540000 {
> 			compatible = "samsung,exynos4210-sdhci";
> 			reg = <0x12540000 0x100>;
> 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>--
>2.34.1


