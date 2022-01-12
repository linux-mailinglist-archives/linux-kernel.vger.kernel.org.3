Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31EE48BE20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 06:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350843AbiALFVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 00:21:34 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31227 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350831AbiALFVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 00:21:33 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220112052130epoutp03904feb6ad98383f3cddb4e0287d05256~Jbl5iIkcc1391813918epoutp03s
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 05:21:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220112052130epoutp03904feb6ad98383f3cddb4e0287d05256~Jbl5iIkcc1391813918epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1641964890;
        bh=vXx8F+bxejZSmUBTLeFqry1cVLZQZVqDuYVqJYtXOSY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=bxJYs2JGbFbTlvCsmgrymaW5r9iHkWXGl82UH66k8wobwHwRZuxdzu/hmju4brXlZ
         5IXmiU+zaYiVL9pY50wdeP7OqMP57tMz6Ntx1QoUZvGGK+73o/avghRzhCwOa455vT
         mXPjEDxMVcE0ki42OQ1CPrspdUkfjF71YMJXvp9g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220112052130epcas2p2fd27a356d7739b57fc0e424b336f6d9f~Jbl5Dk0Nu1959819598epcas2p2v;
        Wed, 12 Jan 2022 05:21:30 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JYbWq4w88z4x9Pw; Wed, 12 Jan
        2022 05:21:27 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.8D.12141.6556ED16; Wed, 12 Jan 2022 14:21:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220112052125epcas2p3b2570cab838b56f52661aad253f032ed~Jbl0vYZE22057820578epcas2p3j;
        Wed, 12 Jan 2022 05:21:25 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220112052125epsmtrp2a25186414f2f52f81c7eff2f5b3f5e1a~Jbl0uikMK0162601626epsmtrp25;
        Wed, 12 Jan 2022 05:21:25 +0000 (GMT)
X-AuditID: b6c32a48-d73ff70000002f6d-59-61de6556a262
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.D7.29871.5556ED16; Wed, 12 Jan 2022 14:21:25 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220112052125epsmtip27fb4d28767d2fcf9a0ff86d819be761e~Jbl0iAL2C2845128451epsmtip2h;
        Wed, 12 Jan 2022 05:21:25 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Tomasz Figa'" <tomasz.figa@gmail.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@gmail.com>
In-Reply-To: <20220111201722.327219-14-krzysztof.kozlowski@canonical.com>
Subject: RE: [PATCH v2 20/28] arm64: dts: exynos: align pinctrl with
 dtschema in ExynosAutov9
Date:   Wed, 12 Jan 2022 14:21:25 +0900
Message-ID: <000001d80774$3e971880$bbc54980$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEPsg0rhN1RyLWOER/EMv1WEdO3IgC43HigAZC5mMOt3Tcw8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmhW5Y6r1Eg95LUhZLb1VbzD9yjtVi
        49sfTBZT/ixnstj0+Bqrxeb5fxgtLu+aw2Yx4/w+Jou1R+6yW7TuPcJucfhNO6vF8z6g2Kpd
        fxgdeD1mNfSyeeycdZfdY9OqTjaPO9f2sHlsXlLv0bdlFaPH501yAexR2TYZqYkpqUUKqXnJ
        +SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QMcqKZQl5pQChQISi4uV9O1s
        ivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IzTkw/yFbQzFmxsvcN
        YwPje/YuRk4OCQETia72TyxdjFwcQgI7GCVOXmtlhnA+MUrMOLWaEcL5xiix+MZ7ti5GDrCW
        HW3mEPG9jBLPl0xjgnBeMEocXPuYGWQum4C+xMuObawgCRGBRcwSq/ecBhvFLNDHKNHadAVs
        O6eAp8SPGwvBbGGBeIme669YQGwWAVWJH2dXsYHYvAKWEld+t7BA2IISJ2c+AbOZBeQltr+d
        wwzxhYLEz6fLWEFsEQEniWk7djJD1IhIzO5sA3tIQuAGh0RP9xaoBheJhYcusELYwhKvjm+B
        BoeUxOd3e9kgGroZJSa9vAuVmMEo8e5mDoRtLDHrWTsjKDCYBTQl1u/Sh4SLssSRW1C38Ul0
        HP7LDhHmlehoE4JoVJc4sH06C4QtK9E95zPrBEalWUg+m4Xks1lIPpiFsGsBI8sqRrHUguLc
        9NRiowITeHQn5+duYgSnZC2PHYyz337QO8TIxMF4iFGCg1lJhLcs5m6iEG9KYmVValF+fFFp
        TmrxIUZTYFhPZJYSTc4HZoW8knhDE0sDEzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9
        TBycUg1Mm07+ehm6Xo4pQ3uaDWfu+hI3o7C8g4W3pDsel3iVd50WPnPL8NqbpBtz6g/8v9qW
        /ETtQM1crpKc26fDfeKNfzW8fuh8+6VAnlpRTcTUjkjGi6oHRFj7H51I//eG1cjwyNKn750O
        SrG/uHG+riD/YLnUKUW1WMHPNgIR0W+P/kiavHvK5qu6jTfOWMor/G7ZnxCmHvHyyAPWlIOe
        Gb9Put/8Ov1ZUC7rsajjE61vN/bNjPc66ybxL6/f5XpUSOKliTfYGWSf5nRVOx1OfrZBfN/+
        L7J9qqxZG5lqGW9kG2qb1p9UTFtp8Hxj1G7LEKNtglqPBB7VJ3KkB120umMpxS9+z/bH+Y6N
        Rt/+3b6txFKckWioxVxUnAgAsB4gHVIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvG5o6r1Eg1/vVSyW3qq2mH/kHKvF
        xrc/mCym/FnOZLHp8TVWi83z/zBaXN41h81ixvl9TBZrj9xlt2jde4Td4vCbdlaL531AsVW7
        /jA68HrMauhl89g56y67x6ZVnWwed67tYfPYvKTeo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0S
        uDJOTD/IVtDMWbGy9w1jA+N79i5GDg4JAROJHW3mXYxcHEICuxklHi05ydLFyAkUl5V49m4H
        O4QtLHG/5QgrRNEzRon9ty6BFbEJ6Eu87NgGlhARWMEs8f3JVTYQh1lgAqNE94mtzCBVQgLX
        GCVmTnMDsTkFPCV+3FgINJadQ1ggVuJVNUiURUBV4sfZVWwgNq+ApcSV3y0sELagxMmZT1hA
        DmUW0JNo28gIEmYWkJfY/nYOM8RtChI/ny5jBbFFBJwkpu3YyQxRIyIxu7ONeQKj8Cwkk2Yh
        TJqFZNIsJB0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIER6WW5g7G7as+6B1i
        ZOJgPMQowcGsJMJbFnM3UYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWp
        RTBZJg5OqQYmtZa/EUKGdvcEDJynWkrPc1AT+ivfYzDtxd5UvQnTBO/MmCNz9sX/Xybu5psy
        +pf8uj2nwn7/ZnW9UuknNYEMdd6LP0nJ3Jgc8+LIvpZ3k6yn7Q29fOfVh45kya87bsQ8O7rg
        X4xjxeRfK5uTnl06wDv1qY/oQutvhqZMUcbzU0+aTy/r1U35F8mT7BV7efHGLQl+fZJMxjzx
        1if+1j2cW+pxTWL6ebttcknHfFa9NamvzljpsHu/fpbqfoHwo+lts2yeMU2+83i+1MYjgXse
        /lQ8m/Lt4ERZrtqnE1Y1L3DeuDfUXdYihl1s2vL8F5Y7PRJmrHt99QyTapvHR6ujP2bNdeaM
        Kk5bdPOdUErIZSWW4oxEQy3mouJEAIUic1Y5AwAA
X-CMS-MailID: 20220112052125epcas2p3b2570cab838b56f52661aad253f032ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220111201852epcas2p2bb09ed439ccca57c51ece984727e87be
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
        <CGME20220111201852epcas2p2bb09ed439ccca57c51ece984727e87be@epcas2p2.samsung.com>
        <20220111201722.327219-14-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Sent: Wednesday, January 12, 2022 5:17 AM
> To: Tomasz Figa <tomasz.figa@gmail.com>; Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com>; Sylwester Nawrocki
> <s.nawrocki@samsung.com>; Linus Walleij <linus.walleij@linaro.org>; Rob
> Herring <robh+dt@kernel.org>; linux-arm-kernel@lists.infradead.org; linux-
> samsung-soc@vger.kernel.org; linux-gpio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>; Sam Protsenko
> <semen.protsenko@linaro.org>; Chanho Park <chanho61.park@samsung.com>;
> Alim Akhtar <alim.akhtar@gmail.com>
> Subject: [PATCH v2 20/28] arm64: dts: exynos: align pinctrl with dtschema
> in ExynosAutov9
> 
> Align the pin controller related nodes with dtschema.  No functional
> change expected.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Great.
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
And you can also put
Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

