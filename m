Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F2553CDB1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbiFCRDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244662AbiFCRD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:03:26 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACB4522DF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:03:25 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220603170320epoutp0358673ce31686b592c7b570cebf1bbbd5~1KxNQMbe91753817538epoutp03r
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 17:03:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220603170320epoutp0358673ce31686b592c7b570cebf1bbbd5~1KxNQMbe91753817538epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1654275800;
        bh=KBmvvzMnh2/52C5pNCCda5UPKYKmJcSnfpNu3ArKFdg=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=ukHlhsXxVjZRsrcvznffT5JcJxd/SCR1lE+dcoARecPXuhkrejejEvir4reSVpAH9
         qlZ8bqE+ewz8ojjhw07fV3MKGAKAYeMEBAuPuB2RhQXGu4CAND/qFkThGa5FVlykuU
         QntzHVygExfEDJV+fCNSP6IofakfbkfE5SYz2kMk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220603170319epcas5p4cd248f1dac3749386583bd44094cea31~1KxMrvFmM2130621306epcas5p4B;
        Fri,  3 Jun 2022 17:03:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4LF8N40MD6z4x9Pp; Fri,  3 Jun
        2022 17:03:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.4D.10063.3DE3A926; Sat,  4 Jun 2022 02:03:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220603170315epcas5p2c1f844687b229c436b48253c53f36952~1KxI5z5RT2045720457epcas5p2x;
        Fri,  3 Jun 2022 17:03:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220603170315epsmtrp28f221bfe7ac81eb634f2f6ea5874edeb~1KxI5Ejan1742117421epsmtrp2D;
        Fri,  3 Jun 2022 17:03:15 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-8f-629a3ed3cddc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.9D.11276.3DE3A926; Sat,  4 Jun 2022 02:03:15 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220603170313epsmtip2c645054fc04ceaa116d867ceb2b86c56~1KxHXyArB0497504975epsmtip2e;
        Fri,  3 Jun 2022 17:03:13 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20220603094946.509919-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/3] arm64: dts: exynos: align MMC node name with
 dtschema
Date:   Fri, 3 Jun 2022 22:33:12 +0530
Message-ID: <012c01d8776b$d08961a0$719c24e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJnTgxmo1hiaDX0AoRFzAPFxadt/AIGIl0cAkAMriir/gn/QA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmpu5lu1lJBqtmW1nMP3KO1eLGrzZW
        i74XD5kt9r7eym6x6fE1VovLu+awWRz5389oMeP8PiaL1r1H2C2Orw134PLYtKqTzePOtT1s
        HpuX1Hv0bVnF6PF5k1wAa1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5i
        bqqtkotPgK5bZg7QTUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLS
        vHS9vNQSK0MDAyNToMKE7Iwn7T/YCyYLVJzZtpCpgfECbxcjJ4eEgInEl77ZLCC2kMBuRonV
        jb5djFxA9idGicsHHzJBON8YJVrOLmGG6Wh8cI8dIrEXqOP6ZkYI5yWjxOItt9hBqtgEdCV2
        LG5jA0mICCxnlrh+fy5YO6eAq8STroeMILawQIDEv33tYA0sAioSu3d1soLYvAKWErPu/oKy
        BSVOznwCdiCzgLzE9rdzoM5QkPj5dBlYjYiAk8TnvxOgasQlXh49AnaehMBCDonJew6zQzS4
        SCx+38oGYQtLvDq+BSouJfH53V6gOAeQ7SGx6I8URDhD4u3y9YwQtr3EgStzWEBKmAU0Jdbv
        0odYxSfR+/sJE0Qnr0RHmxBEtapE87urLBC2tMTE7m5WCNtD4v+mK9CAu8wo8fXEGpYJjAqz
        kHw5C8mXs5B8Mwth8wJGllWMkqkFxbnpqcWmBYZ5qeXwCE/Oz93ECE6yWp47GO8++KB3iJGJ
        g/EQowQHs5IIb9m8mUlCvCmJlVWpRfnxRaU5qcWHGE2BQT+RWUo0OR+Y5vNK4g1NLA1MzMzM
        TCyNzQyVxHkF/jcmCQmkJ5akZqemFqQWwfQxcXBKNTDtXClb7nXufu+Fb8sfBWWYcRWlPl8V
        FpRWpxY8Sdv1x5cjax9Mib0g1bJdy1/js3H9IqfNx2d7bZROYEmVnV1tEZZruronWH5h2Mxe
        3mW7j1/S3r48ZmHqowURRn78+SdT220OXX/2InOexnkZ5Yhr582jPqg1/JN3bfEs/1P/+ud2
        3sczi1oV9wvvPpXzSbT6QtwFe43WHfvk0m/ulTiw/7ROX6vXrf0J20+tbas+ffDzFjn+bGPX
        1/dcmLL1mQ38UyN+fJ/y+zWz4Meu6qavdzXtovmZ+ntY4go7T52ZNG/n9FrXQ0n9iRFT5S4d
        YtiXZ97/1+2ynMABtYQvXy//65K9sc3q4AehsIOl5v+UWIozEg21mIuKEwH4h49LOwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXvey3awkgx1XBSzmHznHanHjVxur
        Rd+Lh8wWe19vZbfY9Pgaq8XlXXPYLI7872e0mHF+H5NF694j7BbH14Y7cHlsWtXJ5nHn2h42
        j81L6j36tqxi9Pi8SS6ANYrLJiU1J7MstUjfLoEr40n7D/aCyQIVZ7YtZGpgvMDbxcjJISFg
        ItH44B57FyMXh5DAbkaJpW9amSAS0hLXN05gh7CFJVb+ew5V9JxR4vaSt6wgCTYBXYkdi9vY
        QBIiAuuZJS4fvc8EUXWeUeJD52xmkCpOAVeJJ10PGUFsYQE/iRVP/4F1swioSOze1Qlm8wpY
        Ssy6+wvKFpQ4OfMJSxcjBwezgJ5E20awVmYBeYntb+cwQ1ykIPHz6TKwchEBJ4nPfyewQNSI
        S7w8eoR9AqPQLCSTZiFMmoVk0iwkHQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+du
        YgRHlJbmDsbtqz7oHWJk4mA8xCjBwawkwls2b2aSEG9KYmVValF+fFFpTmrxIUZpDhYlcd4L
        XSfjhQTSE0tSs1NTC1KLYLJMHJxSDUyc+xZW3lgquLGKaV2O655Dt322Ta+cdDzo2PFqrT9S
        daaMiZV80/b6553i/9U553xxznaukLle2fvZP6RmmK3bzbohY/trkSVpOc2lB5JiwxPCebpk
        LVgf3FxVudxNVWrWl/aLH8MuLhJcIPH14O5FU10VNk38l9m9r/HAkVg7qb+f1s6P+iOztr1g
        bnOV3TzD2iuN/+/Jbd84Z49Kso5e6Yvvnkzd3SEnlnBwWuRrqbQ9YWTb9ebop+WqxU/4i56/
        TV/2VsnwEY/tG68Fbxh7LD+ujHyVseMfz58v5z7st9dvinwheqIj/KdO0npdu0n794T/YlC+
        4eu+bOXLC27nEjI1PGR8Qx8wtFeve6ujxFKckWioxVxUnAgASlspUxcDAAA=
X-CMS-MailID: 20220603170315epcas5p2c1f844687b229c436b48253c53f36952
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220603094957epcas5p301cd5956d180ee9be3bf8f8207cb1a7d
References: <20220603094946.509919-1-krzysztof.kozlowski@linaro.org>
        <CGME20220603094957epcas5p301cd5956d180ee9be3bf8f8207cb1a7d@epcas5p3.samsung.com>
        <20220603094946.509919-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>Sent: Friday, June 3, 2022 3:20 PM
>To: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring
><robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Jaehoon Chung <jh80.chung@samsung.com>;
>linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 2/3] arm64: dts: exynos: align MMC node name with
>dtschema
>
>The node names should be generic and MMC controller dtschema expects
>"mmc".
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>index 75b548e495a0..bd6a354b9cb5 100644
>--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>@@ -1820,7 +1820,7 @@ usbhost_dwc3: usb@15a00000 {
> 			};
> 		};
>
>-		mshc_0: mshc@15540000 {
>+		mshc_0: mmc@15540000 {
> 			compatible = "samsung,exynos7-dw-mshc-smu";
> 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> 			#address-cells = <1>;
>@@ -1833,7 +1833,7 @@ mshc_0: mshc@15540000 {
> 			status = "disabled";
> 		};
>
>-		mshc_1: mshc@15550000 {
>+		mshc_1: mmc@15550000 {
> 			compatible = "samsung,exynos7-dw-mshc-smu";
> 			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> 			#address-cells = <1>;
>@@ -1846,7 +1846,7 @@ mshc_1: mshc@15550000 {
> 			status = "disabled";
> 		};
>
>-		mshc_2: mshc@15560000 {
>+		mshc_2: mmc@15560000 {
> 			compatible = "samsung,exynos7-dw-mshc-smu";
> 			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> 			#address-cells = <1>;
>--
>2.34.1


