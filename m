Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA053CDAC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbiFCRDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344181AbiFCRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:03:07 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D8051E4D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:03:04 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220603170302epoutp02b25fb35ae32bee85b179e539e5c2b207~1Kw9Pz0Zo0857608576epoutp02s
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 17:03:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220603170302epoutp02b25fb35ae32bee85b179e539e5c2b207~1Kw9Pz0Zo0857608576epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654275782;
        bh=fRjZpvBqgm0e4vtEHxsVikRwtr0X3cotIrSnsfpdVQM=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=XiNYweJdZN/LhZc5djRDY4eAquwQA4lHFzEWwvXD+k0kYGabgeGbuXT0Qt3H5XRVa
         2VcPHxCY604Bi7yZ/KCu9LeDF1JLrV5d7w1xiBtWF55sJGAcGBhYh85sswQJl7bLMF
         mLUGw1AcHmJmdX9KgTxQDPBwXrA8cLJfmS2nu67U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220603170301epcas5p15c5b73ad252644290ed3c33cba6db5e6~1Kw8HexTp1945019450epcas5p13;
        Fri,  3 Jun 2022 17:03:01 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LF8Mk5Jkkz4x9Pt; Fri,  3 Jun
        2022 17:02:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.4D.10063.2CE3A926; Sat,  4 Jun 2022 02:02:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220603170258epcas5p391acabed305c594cc9d06df3221dae63~1Kw46wap92632926329epcas5p3d;
        Fri,  3 Jun 2022 17:02:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220603170258epsmtrp1c3aad1e2a022966e96d2752e63962e6a~1Kw457Y3r0815508155epsmtrp1b;
        Fri,  3 Jun 2022 17:02:58 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-7a-629a3ec27816
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.9D.11276.2CE3A926; Sat,  4 Jun 2022 02:02:58 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220603170256epsmtip106e640dfbd2a878428e8191689c9927b~1Kw3Zirlw0591505915epsmtip1c;
        Fri,  3 Jun 2022 17:02:56 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220603094946.509919-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/3] ARM: dts: exynos: align MMC node name with dtschema
Date:   Fri, 3 Jun 2022 22:32:55 +0530
Message-ID: <012b01d8776b$c64ef920$52eceb60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJnTgxmo1hiaDX0AoRFzAPFxadt/AGMuNfTAYFy4rCsB8nZcA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmlu4hu1lJBg3r1C3mHznHanHjVxur
        Rd+Lh8wWe19vZbfY9Pgaq8XlXXPYLI7872e0mHF+H5NF694j7BbH14Y7cHlsWtXJ5nHn2h42
        j81L6j36tqxi9Pi8SS6ANSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8x
        N9VWycUnQNctMwfoJiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFp
        XrpeXmqJlaGBgZEpUGFCdsbME11sBZ/5K16sWs/cwLiOt4uRk0NCwETizIJZjF2MXBxCArsZ
        JbY+Xs4C4XxilDi5+Q0zhPONUWJh8wtGmJaG2/OhqvYyShx51gJV9ZJR4vzCRnaQKjYBXYkd
        i9vYQBIiAsuZJa7fnwtUxcHBKeAqsfqEB0iNsICPxJWrC9lAwiwCKhJ/7huAhHkFLCVOP/jP
        DmELSpyc+YQFxGYWkJfY/nYOM8QRChI/ny5jBWkVEXCSeLrLAaJEXOLl0SPsECULOSTm/jSC
        sF0kJv16ygRhC0u8Or4FqkZK4mV/GzvIGAkBD4lFf6QgwhkSb5evh3rXXuLAlTksICXMApoS
        63fpQ2zik+j9/YQJopNXoqNNCKJaVaL53VUWCFtaYmJ3NyuE7SEx62MjEyScLjNK9B1exjiB
        UWEWkh9nIflxFpJnZiFsXsDIsopRMrWgODc9tdi0wDAvtRwe28n5uZsYwelVy3MH490HH/QO
        MTJxMB5ilOBgVhLhLZs3M0mINyWxsiq1KD++qDQntfgQoykw3CcyS4km5wMTfF5JvKGJpYGJ
        mZmZiaWxmaGSOK/A/8YkIYH0xJLU7NTUgtQimD4mDk6pBqbowy5v0hr8rm3awhSjPnFu2JMv
        mfo+Fnn6EtdZeJ/MLpZLc3K65srOVRB/7A6joxh7l9/WDzcFH9f2aS59/WHbk//3Sjh2N8qF
        1AdcX2neUsrIXGnXd+39cR+vY9MM/+hZzgxQrdY6LzjhypqNUrK9bTNFPzt/27mTvZL52/9r
        5xfYPm/KW/z0HffN81FBRUp3RMsKHp/N/VoezCee4rXNf9a0KO6NYp3XC9m3i9XsPVq+68v0
        A01PwkSkWG+LhO4W8Pl8XPafilRBZuObO7JCarY+qxMuX3D2y1v9a1Flq8AD3fnb96Z9Ur84
        6eDTML8TWVoTN/3QzrZlPdh7lyVpYqqii1eD6quXqqr6hkosxRmJhlrMRcWJAJly0ec4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJTveQ3awkgyOz2C3mHznHanHjVxur
        Rd+Lh8wWe19vZbfY9Pgaq8XlXXPYLI7872e0mHF+H5NF694j7BbH14Y7cHlsWtXJ5nHn2h42
        j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoErY+aJLraCz/wVL1atZ25gXMfbxcjJISFg
        ItFwez5LFyMXh5DAbkaJdzd2skMkpCWub5wAZQtLrPz3nB2i6DmjxLoTX5lBEmwCuhI7Frex
        gSREBNYzS1w+ep8Jouo8o0Rz40mgKg4OTgFXidUnPEAahAV8JK5cXcgGEmYRUJH4c98AJMwr
        YClx+sF/dghbUOLkzCcsICXMAnoSbRsZQcLMAvIS29/OYYa4R0Hi59NlrCAlIgJOEk93OUCU
        iEu8PHqEfQKj0Cwkg2YhDJqFZNAsJB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefn
        bmIEx5KW5g7G7as+6B1iZOJgPMQowcGsJMJbNm9mkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        C10n44UE0hNLUrNTUwtSi2CyTBycUg1MLbwabhrxtyOUYuf4V7++sEFom3Oxa1OF4w+ptUzP
        BdTrth14OG1nu3uA7XI+hWbNtJ3TK/7PO75WeO6RBJtD2b1imx0+nv5iVai5XYprjv/vhadL
        hA4JvX1lF6wv4J8sZeew4sVr1ZQjG+7tfN/71XBhYqX7bSnLZJd81ip/3l/vzlUrHon8lyls
        07jPcbPw64NnL3wpmMcj0HF5Q8KNmcpbvvk/FXG7sPfaFreN9V9fpH15dO8g6+H29sUzuQxn
        PF5qt2LprFTBa83lnef/hQRw6TK/yItzZkvX4nFWCiuJnCIm4mXS4/lw9cST2+S46+qOdHul
        zcp4b+99P2viIcnEbg5utaplgYtl/1xVYinOSDTUYi4qTgQACzkqZRQDAAA=
X-CMS-MailID: 20220603170258epcas5p391acabed305c594cc9d06df3221dae63
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603094954epcas5p2b059d91dcdaec949f800bf4f037a23a5
References: <20220603094946.509919-1-krzysztof.kozlowski@linaro.org>
        <CGME20220603094954epcas5p2b059d91dcdaec949f800bf4f037a23a5@epcas5p2.samsung.com>
        <20220603094946.509919-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Friday, June 3, 2022 3:20 PM
>To: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
><robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 1/3] ARM: dts: exynos: align MMC node name with dtschema
>
>The node names should be generic and MMC controller dtschema expects
>"mmc".
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> arch/arm/boot/dts/exynos3250.dtsi | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm/boot/dts/exynos3250.dtsi
>b/arch/arm/boot/dts/exynos3250.dtsi
>index 78dad233ff34..326b9e0ed8d3 100644
>--- a/arch/arm/boot/dts/exynos3250.dtsi
>+++ b/arch/arm/boot/dts/exynos3250.dtsi
>@@ -376,7 +376,7 @@ hsotg: hsotg@12480000 {
> 			status = "disabled";
> 		};
>
>-		mshc_0: mshc@12510000 {
>+		mshc_0: mmc@12510000 {
> 			compatible = "samsung,exynos5420-dw-mshc";
> 			reg = <0x12510000 0x1000>;
> 			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
>@@ -388,7 +388,7 @@ mshc_0: mshc@12510000 {
> 			status = "disabled";
> 		};
>
>-		mshc_1: mshc@12520000 {
>+		mshc_1: mmc@12520000 {
> 			compatible = "samsung,exynos5420-dw-mshc";
> 			reg = <0x12520000 0x1000>;
> 			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
>@@ -400,7 +400,7 @@ mshc_1: mshc@12520000 {
> 			status = "disabled";
> 		};
>
>-		mshc_2: mshc@12530000 {
>+		mshc_2: mmc@12530000 {
> 			compatible = "samsung,exynos5250-dw-mshc";
> 			reg = <0x12530000 0x1000>;
> 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
>--
>2.34.1


