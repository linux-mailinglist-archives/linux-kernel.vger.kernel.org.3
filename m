Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2104A34F7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 08:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354349AbiA3HjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 02:39:16 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:24937 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354278AbiA3HjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 02:39:15 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220130073914epoutp04c7482297be02701f3eefb9c9c1f69c9a~O-FStfgdR2398323983epoutp04b
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 07:39:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220130073914epoutp04c7482297be02701f3eefb9c9c1f69c9a~O-FStfgdR2398323983epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643528354;
        bh=ao+rcWomYdEqGl023a7DOT+HqdMuPkk8+vq62A4Cmd0=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=lLMaVu/ZNnhOggjfKySdCr2vPOjbCbFZkgpR3evZx+pGdl1gMT86sg1B9EJkBKlIZ
         6L95+ZbNhEpnJcU0r779E4CrbvVzNLvRoFBeXH/qRPR5zw3m8Qig430nsKe+D7Cq6E
         X//IzQL+5aXFgEZk4G4WMlnkw/Yf1tWMcuosPhKY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220130073914epcas5p185e90f443783a56d42260432c1572e26~O-FSTTZw02335223352epcas5p1M;
        Sun, 30 Jan 2022 07:39:14 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JmjkQ1kPRz4x9Pp; Sun, 30 Jan
        2022 07:39:10 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.C4.06423.D9046F16; Sun, 30 Jan 2022 16:39:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220130073909epcas5p2103bbedd00fe87d36c62a3796765aff3~O-FN7Sn5i1016910169epcas5p2v;
        Sun, 30 Jan 2022 07:39:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220130073909epsmtrp13d97a7e5048d6e9da9c7233e1c22261c~O-FN7bQ5K3004430044epsmtrp1o;
        Sun, 30 Jan 2022 07:39:09 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-39-61f6409da6d5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.F0.29871.C9046F16; Sun, 30 Jan 2022 16:39:08 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220130073906epsmtip14cfbac836495c77d7aaf30ba3764ff06~O-FKvAWy91200912009epsmtip1Y;
        Sun, 30 Jan 2022 07:39:05 +0000 (GMT)
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
In-Reply-To: <20220129175332.298666-5-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH 5/5] dt-bindings: serial: samsung_uart: Document
 Exynos5433 compatible
Date:   Sun, 30 Jan 2022 13:09:03 +0530
Message-ID: <00db01d815ac$77248570$656d9050$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFgtqenDY7K+SNveA8HtgWqOAMTMQJGUk2cAqnLQMOtQmpeMA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmlu5ch2+JBvP/i1vMP3KO1aJ58Xo2
        i41vfzBZ3P96lNFi0+NrrBaXd81hs5hxfh+TxZnFvewWa4/cZbdo3XuE3eLwm3ZWB26PWQ29
        bB6bVnWyedy5tofNY//cNewem5fUe/RtWcXo8XmTXAB7VLZNRmpiSmqRQmpecn5KZl66rZJ3
        cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtCNSgpliTmlQKGAxOJiJX07m6L80pJUhYz8
        4hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjGuvpzMWvOer+L43vYFxGU8XIweH
        hICJxOX3+V2MXBxCArsZJea3f2OGcD4xSlydfp4JwvnGKLH9/0b2LkZOsI43R36yQCT2Mkoc
        2P6XFcJ5ySix7stpJpAqNgFdiR2L29hAEiICN5klVm1pYQFJcAp4SByasooNxBYWiJF42HyG
        CeQQFgFViZc7FEBMXgFLibV7+UAqeAUEJU7OfALWySwgL7H97RxmiCMUJH4+XcYKYosIOEk8
        ndHIDFEjLvHy6BF2kLUSAns4JP637oO62kXizb8fULawxKvjW6BsKYmX/W3skLDIlujZZQwR
        rpFYOu8YC4RtL3HgyhwWkBJmAU2J9bv0IVbxSfT+fsIE0ckr0dEmBFGtKtH87ipUp7TExO5u
        VgjbQ+Lggh5osN1klDj8aBLLBEaFWUi+nIXky1lIvpmFsHkBI8sqRsnUguLc9NRi0wLDvNRy
        eGwn5+duYgSnXy3PHYx3H3zQO8TIxMF4iFGCg1lJhHfGpk+JQrwpiZVVqUX58UWlOanFhxhN
        gQE/kVlKNDkfmAHySuINTSwNTMzMzEwsjc0MlcR5T6dvSBQSSE8sSc1OTS1ILYLpY+LglGpg
        MrtgLxs8oX7HJHOrx92u2pXpzX/n3t38fP7DtKXP+jumH93hz+Z3PnWN5GtNH2MvrhPP/Jwm
        rsk5ICv3cQHL6/D9r3qrsyu8X7Fm+nU4ny2vSj3+RvMe7+GdqR8juF8WNYbVP1m7YEGK38LK
        3ffXhgZrB3zt0kjqu3nlJ6/xO40FdqwSO9KbLv983L7wxs1AkU2PSw3436q2p9Wa/LWN3uPX
        MUHP0YF55bmGC+Ia0hcKGv8zOWTMWcAjeLNZw/Jt5hGDoD2XBYL2nayX1tA5UFTb++VSWtq8
        +V7bYj+dSfnhsMDl5+8jsd8N2T56X9kc8iNSsfBSisGNrtx/fec3Km+6lKklniJwwfBx6CML
        JZbijERDLeai4kQAtiDrZkgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO4ch2+JBrOmqlnMP3KO1aJ58Xo2
        i41vfzBZ3P96lNFi0+NrrBaXd81hs5hxfh+TxZnFvewWa4/cZbdo3XuE3eLwm3ZWB26PWQ29
        bB6bVnWyedy5tofNY//cNewem5fUe/RtWcXo8XmTXAB7FJdNSmpOZllqkb5dAlfGtdfTGQve
        81V835vewLiMp4uRk0NCwETizZGfLF2MXBxCArsZJZad+cwKkZCWuL5xAjuELSyx8t9zMFtI
        4DmjxMnbfiA2m4CuxI7FbWwgzSICD5kldv2YxAox6SqjxOTrf8E6OAU8JA5NWcUGYgsLREls
        b1oNFOfgYBFQlXi5QwHE5BWwlFi7lw+kgldAUOLkzCcsIGFmAT2Jto2MIGFmAXmJ7W/nMEOc
        oyDx8+kysDNFBJwkns5oZIaoEZd4efQI+wRGoVlIJs1CmDQLyaRZSDoWMLKsYpRMLSjOTc8t
        NiwwzEst1ytOzC0uzUvXS87P3cQIjjQtzR2M21d90DvEyMTBeIhRgoNZSYR3xqZPiUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwJX+ef7kzJmPtMT5p
        p6DnBju0XJ+3VqsclfW1Y9c+52/q4Ky054z8FvFLu/7/V/66Y17k7/JC+YMT7Feekm3LihM8
        aS3dorm9+5378xlyvJ7Zk6anxrCqFl9LeBT/+fju7S1MBRoVyfcmifC+DpVb/nO19TX3xXLr
        LjzuXbdp4Q0/M7a/rusj3a+otG5UmSUunu77/rWS1yeXyvtTEhTrCzIiOnJ/Ma949PfollqR
        Xw+3tJ7mN9y4wdHnevW3toysN3v/fm5WzjzItr+bRbzasd8iv56HxXbd2WulrReOFO3quqSl
        Ni/r8zHXt7N+Nga6vNFU4ThtUHCSo5BD/LzY0ezt84VaimfevXx494oPSizFGYmGWsxFxYkA
        GqZNZCMDAAA=
X-CMS-MailID: 20220130073909epcas5p2103bbedd00fe87d36c62a3796765aff3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220129175345epcas5p37b7f9b667292af3d085580696fe86c10
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
        <CGME20220129175345epcas5p37b7f9b667292af3d085580696fe86c10@epcas5p3.samsung.com>
        <20220129175332.298666-5-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@canonical.com]
>Sent: Saturday, January 29, 2022 11:24 PM
>To: Lee Jones <lee.jones@linaro.org>; Rob Herring <robh+dt@kernel.org>;
>Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>; Alim Akhtar
><alim.akhtar@samsung.com>; Greg Kroah-Hartman
><gregkh@linuxfoundation.org>; Sylwester Nawrocki
><s.nawrocki@samsung.com>; Marek Szyprowski
><m.szyprowski@samsung.com>; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-serial@vger.kernel.org
>Subject: [PATCH 5/5] dt-bindings: serial: samsung_uart: Document
>Exynos5433 compatible
>
>Document the Exynos5433 UART compatible, supported since commit
>31ec77aca72e ("serial: samsung: Add the support for Exynos5433 SoC").
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>---
Thanks

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


> Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>index 2940afb874b3..6aceba4a5f79 100644
>--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
>@@ -26,6 +26,7 @@ properties:
>           - samsung,s3c6400-uart
>           - samsung,s5pv210-uart
>           - samsung,exynos4210-uart
>+          - samsung,exynos5433-uart
>           - samsung,exynos850-uart
>
>   reg:
>@@ -111,6 +112,7 @@ allOf:
>             enum:
>               - apple,s5l-uart
>               - samsung,exynos4210-uart
>+              - samsung,exynos5433-uart
>     then:
>       properties:
>         clocks:
>--
>2.32.0


