Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6126750ED14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 01:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiDZACY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiDZACU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:02:20 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B011114D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:59:14 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220425235912epoutp028d13d94ad6f8a8be60db2aa13341c6bb~pSSLt-ieo1339113391epoutp02b
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:59:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220425235912epoutp028d13d94ad6f8a8be60db2aa13341c6bb~pSSLt-ieo1339113391epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650931152;
        bh=oYSz8Lwu+LwfHc+DQsdm0zMUlP7mJ7HJRFXHoC2iHFE=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=LtgvJ3htXn6hdTXquLideVVav0uz4fvc/+BXe2dA0Ljrr+N0Hr5Yqe/0bmwt8po9a
         kiAy3xFxcntsz9F9WFNdzOLzTWcrJW6dx+xIe/H6Ain0Gn63pSqr+SZKRVVezrH+Kn
         LS4zR+GdAMcLfPRtp3nUBLpzpDrVYWB0jyUgN7oU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220425235912epcas5p39413c591a04476bdb55a5f22a8bcceb3~pSSLSdNgt0107601076epcas5p3B;
        Mon, 25 Apr 2022 23:59:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KnMRw0TTfz4x9QG; Mon, 25 Apr
        2022 23:59:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.86.09762.BC537626; Tue, 26 Apr 2022 08:59:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220425235907epcas5p1ae2e373f7132bb9738b43893be8acf9d~pSSGz8GR-0831908319epcas5p1H;
        Mon, 25 Apr 2022 23:59:07 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220425235907epsmtrp154d709be8c9ad1f0e4a4ec1a6b1493bf~pSSGzInFY1134411344epsmtrp1A;
        Mon, 25 Apr 2022 23:59:07 +0000 (GMT)
X-AuditID: b6c32a4b-213ff70000002622-0d-626735cb408e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.C3.08924.BC537626; Tue, 26 Apr 2022 08:59:07 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220425235905epsmtip12864982ac8e321c18d1ef73221f6f8b0~pSSFSdAJ32486724867epsmtip1O;
        Mon, 25 Apr 2022 23:59:05 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Michal Simek'" <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20220424150333.75172-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 3/3] dt-bindings: timer: samsung,exynos4210-mct: define
 strict clock order
Date:   Tue, 26 Apr 2022 05:29:04 +0530
Message-ID: <000101d85900$730c07f0$592417d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHaU87sAxE9nZdTqWTdS25GH65v5wJ4IAy0AmJKuuSs1oWioA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmhu5p0/Qkg0m3rSzmfZa1mH/kHKtF
        34uHzBZ7X29lt9j0+BqrxeVdc9gsZpzfx2Tx7mWEReveI+wWmzdNZXbg8ti0qpPN4861PWwe
        786dY/fYvKTe4/MmOY+9n3+zBLBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAN2lpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdAr
        TswtLs1L18tLLbEyNDAwMgUqTMjOWP7pNGvBbd6KlnvzmRsYH3J3MXJySAiYSKxa8YGli5GL
        Q0hgN6PEp/X32CGcT4wSrxbPZIVwPjNKPGhfwg7TsmzrKiaIxC5GiV/bvzGDJIQEXjJKNJ7X
        ArHZBHQldixuYwMpEhHYwyzxfR1IBwcHp4CLREdLJEiNsECCxMOtB9lAwiwCqhIHnpWChHkF
        LCVeLnnDAmELSpyc+QTMZhaQl9j+dg4zxA0KEj+fLmMFsUUEnCQ+f17LClEjLvHy6BGwDyQE
        VnJILGk+zALR4CIx+8dOKFtY4tXxLVDPSEm87G9jB7lBQsBDYtEfKYhwhsTb5esZIWx7iQNX
        5rCAlDALaEqs36UPsYpPovf3EyaITl6JjjYhiGpVieZ3V6EWSUtM7O5mhbA9JJYvmAwN24uM
        Es8e7GOfwKgwC8mXs5B8OQvJN7MQNi9gZFnFKJlaUJybnlpsWmCcl1oOj+7k/NxNjOBEq+W9
        g/HRgw96hxiZOBgPMUpwMCuJ8E5VTUsS4k1JrKxKLcqPLyrNSS0+xGgKDPmJzFKiyfnAVJ9X
        Em9oYmlgYmZmZmJpbGaoJM57Kn1DopBAemJJanZqakFqEUwfEwenVAPTdQ8uu9vL1j4o99kR
        s+xZamm3vMaO1H11jR5Hv1W8Nbv0uKVf7WBlaFqrdJKHr8I1+345vc1zpu5pVFp1IpC/a1ef
        pE72+oN7e/W+Pdvg25lmc/bxhvj/fD5igo9/PnLk5glLyNi0ta+GKyn6+ry/m2dZS/1e13T1
        y5zCus1irlc/hwrPa8kNj2WdsEuu4VMk1/cDJUWF8051rimX68t6Zh3Pval4s+pv82mRQp9k
        9/i21p1pcPS+z8LFG8G5IrNYOmx6dOHzbWeCDu71sf18IkL33qRn+vY+r736NzHZCQqtOck3
        2fzHvKMcEY+X3Z31a3Mh063PVoE9JYtP9Ojwh8cazwtbmDHr3C4u224lluKMREMt5qLiRACc
        sT/oPQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJTve0aXqSwfa7YhbzPstazD9yjtWi
        78VDZou9r7eyW2x6fI3V4vKuOWwWM87vY7J49zLConXvEXaLzZumMjtweWxa1cnmcefaHjaP
        d+fOsXtsXlLv8XmTnMfez79ZAtiiuGxSUnMyy1KL9O0SuDKWfzrNWnCbt6Ll3nzmBsaH3F2M
        nBwSAiYSy7auYupi5OIQEtjBKPFp23ZGiIS0xPWNE9ghbGGJlf+es0MUPWeUmPRkIlgRm4Cu
        xI7FbWwgCRGBQ8wSjT8mMYMkhATOMkrc/RrVxcjBwSngItHREgkSFhaIk2havYIdJMwioCpx
        4FkpSJhXwFLi5ZI3LBC2oMTJmU9YQEqYBfQk2jaCbWIWkJfY/nYOM8Q5ChI/ny5jBbFFBJwk
        Pn9eywpRIy7x8ugR9gmMQrOQTJqFMGkWkkmzkHQsYGRZxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHFNaWjsY96z6oHeIkYmD8RCjBAezkgjvVNW0JCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYkt8+9OVIejbZsv28UNydhrf1/T231nBN
        ucG9ny33Te4umddhrKvTg6/FJ7zN957ikSz0J6b6NOuUiame27Zn/g3a/283q9qrk3b66vLm
        Sxcvk7Z9apC+PPD7xRsszffbTm/nX9H5ZcamP9eznTMXixy35NzPE1ywYevcBxNDjE/MvntE
        7X6hyepz3UZSjT9qf1vt2ZRpcPSKb8+zza3CfJW665cvWO52TG31nqLnTAICtx6/iAk/O7OW
        yTybee3xwkT5t28aX19ZMKtY4lJ7W7fk3Y+h++xbrFM+iuien2382CFle0M3D2/i5HeH9/3W
        Ohv1/+nzy2WxQlP91NRW3H/K1vDG4h2H5OeMQk2VTCWW4oxEQy3mouJEAG4agJsYAwAA
X-CMS-MailID: 20220425235907epcas5p1ae2e373f7132bb9738b43893be8acf9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220424150343epcas5p1eb76108d6a10cf39306d4783d70f2488
References: <20220424150333.75172-1-krzysztof.kozlowski@linaro.org>
        <CGME20220424150343epcas5p1eb76108d6a10cf39306d4783d70f2488@epcas5p1.samsung.com>
        <20220424150333.75172-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Sunday, April 24, 2022 8:34 PM
>To: Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
><tglx@linutronix.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; Michal Simek <michal.simek@xilinx.com>;
>linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Subject: [PATCH 3/3] dt-bindings: timer: samsung,exynos4210-mct: define
>strict clock order
>
>The DTS should always have fixed clock order, even if it comes with clock-
>names property.  Drop the pattern to make the order strict.
>Existing DTS already match this.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml     | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yaml
>b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
>index 0e28d9bdb8cb..9c81d00b12e0 100644
>--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yaml
>+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-
>mct.yam
>+++ l
>@@ -39,8 +39,8 @@ properties:
>
>   clock-names:
>     items:
>-      - pattern: "^(fin_pll|mct)$"
>-      - pattern: "^(fin_pll|mct)$"
>+      - const: fin_pll
>+      - const: mct
>
>   reg:
>     maxItems: 1
>--
>2.32.0


