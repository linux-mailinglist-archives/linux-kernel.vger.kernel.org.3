Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340E64D929A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbiCOCbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344432AbiCOCbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:31:44 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA06C473A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:30:29 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220315023023epoutp011130baf82484eb2d2502b44a906c5706~cbQMN5Jwg1466914669epoutp01H
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:30:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220315023023epoutp011130baf82484eb2d2502b44a906c5706~cbQMN5Jwg1466914669epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647311423;
        bh=yyfDUVLYE4ZIcb9/V6mlxmuF8mgCuNom8jgKs5yo6Sg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=NJynkPhL7fW0gW2MmJhiChHSDOrO682gw9x1l/yx/4DEt0rSyuWPITSyEblJ90UBV
         IySZA7OxXKNhFVZLV46S2+t+O/q5rIIky5cvdbK8SblMo0l13hRpI6hOH8uSzz5WDN
         lKXrtxWheTa4EattvRuBjaQyCv5ICzUa5DbQGxTs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220315023023epcas5p422bfcd5dce2ad03f7d1dd49d8bc906cd~cbQLr_Rk72011420114epcas5p4C;
        Tue, 15 Mar 2022 02:30:23 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KHcnf683kz4x9QG; Tue, 15 Mar
        2022 02:30:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.20.06423.23AFF226; Tue, 15 Mar 2022 11:30:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220315023010epcas5p4a3bfcfef8714019f03283da047275b89~cbQADCX3O2229122291epcas5p4e;
        Tue, 15 Mar 2022 02:30:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220315023010epsmtrp1a7dd37f8cf989c6a4a64ded48118b935~cbQACW1YR2342423424epsmtrp1k;
        Tue, 15 Mar 2022 02:30:10 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-4c-622ffa32921d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.88.03370.23AFF226; Tue, 15 Mar 2022 11:30:10 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220315023009epsmtip1b885ff1858d1d1222e04692d764f5f96~cbP_v6hoL0325103251epsmtip1B;
        Tue, 15 Mar 2022 02:30:08 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Sylwester Nawrocki'" <snawrocki@kernel.org>
In-Reply-To: <20220314184113.251013-1-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH] ARM: dts: exynos: drop deprecated SFR region from MIPI
 phy
Date:   Tue, 15 Mar 2022 08:00:07 +0530
Message-ID: <045f01d83814$97bf07d0$c73d1770$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE1z8DeFgUpeTWUYelE+VGwjWiPDQIRWkk3rfP+BrA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmlq7RL/0kg/+XzS3mHznHavFy1j02
        i41vfzBZbHp8jdXi8q45bBYzzu9jslh75C67ReveI+wW7U9fMjtwesxq6GXz2LSqk81j85J6
        j74tqxg9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy
        8QnQdcvMAbpHSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeX
        WmJlaGBgZApUmJCdce3sQvaCtSIVM3fJNzBOFOxi5OSQEDCR+Lx/JnMXIxeHkMBuRom1bT9Z
        IZxPjBKrr91mgXA+M0p07HjL2MXIAdby6pYbRHwXo8S0CzeYIJyXjBJP7x1jBJnLJqArsWNx
        GxuILSKwjEnixe5CkGZmgRSJQ+tDQMKcAh4Sz/sfMoHYwgKBEmeWvmICKWERUJVYuVoTJMwr
        YClx6f0+FghbUOLkzCdgNrOAvMT2t3OYIT5QkPj5dBkrxCYriXmv2pkhasQlXh49wg5ymoTA
        Ug6J2yf+skI0uEhc33ybDcIWlnh1fAs7hC0l8bK/jR3ix2yJnl3GEOEaiaXzjrFA2PYSB67M
        YYH4RFNi/S59iFV8Er2/nzBBdPJKdLQJQVSrSjS/uwrVKS0xsbsb6gAPiQf3rjBPYFScheSx
        WUgem4XkgVkIyxYwsqxilEwtKM5NTy02LTDMSy2Hx3Vyfu4mRnBK1fLcwXj3wQe9Q4xMHIyH
        GCU4mJVEeM+80E8S4k1JrKxKLcqPLyrNSS0+xGgKDOyJzFKiyfnApJ5XEm9oYmlgYmZmZmJp
        bGaoJM57On1DopBAemJJanZqakFqEUwfEwenVAOT/ZGjgfLV2RvFtklV9sxXc3ly/wtn1cID
        qqoSC/v3mAeIXRLqu7XMdZGZKuN+qZKcyOpkddva0I9ON/4WJTKZSHe7GWi9Ob9UT+9L9pWj
        Ky9ufp8YtOfllM+pLmnnf5yIkFc9vn2G7HtmU4PLMgWGE2JNF3q9VumsP7Rw+xXBnLNGXhzn
        JqdnzZS3rDnw27ScI8ov8tkj046q29e7u1qkzL4qtqsIsSU8qchPmpBxaFJEwtqteV9Ovyqq
        /BFq8vno6YkPeHUkD/tk7K6tvKnx8VTj6/DUnnn/105RNNjV+M1r16GkfLcINuf3RVPuNlTa
        T9HN+f5j3/H00y57G38LRxxzqPzbOeGa/Z3fL8yUWIozEg21mIuKEwHSoVv4MgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTtfol36SwYOXMhbzj5xjtXg56x6b
        xca3P5gsNj2+xmpxedccNosZ5/cxWaw9cpfdonXvEXaL9qcvmR04PWY19LJ5bFrVyeaxeUm9
        R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGVcO7uQvWCtSMXMXfINjBMFuxg5OCQETCRe3XLr
        YuTiEBLYwSjRfXw/YxcjJ1BcWuL6xgnsELawxMp/z9khip4zSsyce40FJMEmoCuxY3EbG4gt
        IrCKSeJhlxGIzSyQItF8dCUbRMNMRol7l/aCTeIU8JB43v+QCcQWFvCXOPTxHyPIFSwCqhIr
        V2uChHkFLCUuvd/HAmELSpyc+YQFpIRZQE+ibSMjxHh5ie1v5zBD3KYg8fPpMlaIE6wk5r1q
        Z4aoEZd4efQI+wRG4VlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvX
        S87P3cQIjiwtrR2Me1Z90DvEyMTBeIhRgoNZSYT3zAv9JCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYLhloMsh9sll5ouVxok78tN7zB8pfndo4g6su
        +NiluRUWrFfnbrO3mXvr6EV3K42LzzfqiovMDDs3xXmjh+Hnvkgl86CjhbYTint5NjwtY+gQ
        nPvH/ILsE+mjf9dbCwZdiz5Wmr1OVEHDTsu2VWe17PIta7ztt7YGZfOt3nPviuP2w1cuu06z
        fmh1eXnsPD9tltWrfNYb2+/cpRCpMDFHg1nidPEK/3vTGf89cgzX2MXZaR6apvJ4/apCm8DZ
        F11Drm/N4Yp3b1qkeixKwLdZZc3uqsnhBXLH7q9etIatbpn/nBf5EzzKrPTvN67dXlay7FQ1
        Z/uySU9WeCSstCg9c6NvVVzOZ96zIVNXalU3KbEUZyQaajEXFScCACRrA+YbAwAA
X-CMS-MailID: 20220315023010epcas5p4a3bfcfef8714019f03283da047275b89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220314184122epcas5p43627f2cf266da868679cd59cbbbea14a
References: <CGME20220314184122epcas5p43627f2cf266da868679cd59cbbbea14a@epcas5p4.samsung.com>
        <20220314184113.251013-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Tuesday, March 15, 2022 12:11 AM
>To: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
><krzk+dt@kernel.org>; Alim Akhtar <alim.akhtar@samsung.com>;
>devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: Marek Szyprowski <m.szyprowski@samsung.com>; Sylwester Nawrocki
><snawrocki@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski@canonical.com>
>Subject: [PATCH] ARM: dts: exynos: drop deprecated SFR region from MIPI
>phy
>
>Commit e4b3d38088df ("phy: exynos-video-mipi: Fix regression by adding
>support for PMU regmap") deprecated the usage of unit address in MIPI phy
>node, in favor of a syscon phandle.  Deprecating was a correct approach
>because that unit address was actually coming from Power Management Unit
>SFR range so its usage here caused overlapped memory mapping.
>
>In 2016 commit 26dbadba495f ("phy: exynos-mipi-video: Drop support for
>direct access to PMU") fully removed support for parsing that MIPI phy unit
>address (SFR range) but the address stayed in Exynos5250 DTSI for
>compatibility reasons.
>
>Remove that deprecated unit address from Exynos5250 MIPI phy, because it
>has been almost 6 years since it was deprecated and it causes now DT schema
>validation warnings:
>
>  video-phy@10040710: 'reg' does not match any of the regexes: 'pinctrl-[0-
>9]+'
>
>Any out-of-tree users of Exynos5250 DTSI, should update their code to use
>newer syscon property.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---

Reviewed-by: Alim Akhtar<alim.akhtar@samsung.com>

> arch/arm/boot/dts/exynos5250.dtsi | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm/boot/dts/exynos5250.dtsi
>b/arch/arm/boot/dts/exynos5250.dtsi
>index 5baaa7eb71a4..d8d401b5ca48 100644
>--- a/arch/arm/boot/dts/exynos5250.dtsi
>+++ b/arch/arm/boot/dts/exynos5250.dtsi
>@@ -817,15 +817,14 @@ mixer: mixer@14450000 {
> 			status = "disabled";
> 		};
>
>-		dp_phy: video-phy {
>+		dp_phy: video-phy-0 {
> 			compatible = "samsung,exynos5250-dp-video-phy";
> 			samsung,pmu-syscon = <&pmu_system_controller>;
> 			#phy-cells = <0>;
> 		};
>
>-		mipi_phy: video-phy@10040710 {
>+		mipi_phy: video-phy-1 {
> 			compatible = "samsung,s5pv210-mipi-video-phy";
>-			reg = <0x10040710 0x100>;
> 			#phy-cells = <1>;
> 			syscon = <&pmu_system_controller>;
> 		};
>--
>2.32.0


