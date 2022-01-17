Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F724908DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiAQMnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:43:08 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:42225 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbiAQMnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:43:06 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220117124304epoutp03d23ccb0f686978319e77aa3f2166d1f8~LD13dI_aI2184421844epoutp03a
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:43:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220117124304epoutp03d23ccb0f686978319e77aa3f2166d1f8~LD13dI_aI2184421844epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642423384;
        bh=y/fg2d2Xcr3JPdo/TQ/fdeipX9YDMvYtY3RetiGHpu0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=A5PbKHFenvHimMZNjH4hyhkNK1BB/KRF/vpkAEYeC9kjk77s/S8pXT0i7xWZY9m4N
         OsvpluWoBQDFI2AoOAnvvoBjHuv7zU0nClkloSTNkdlOsfMh7TuxRHiNF+fK/xeeuC
         OHrcimfjgLFxJeBnDikR80OyM1H+TgXtlpix0WOY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220117124303epcas5p105edefeb35e132cc6983672399182cf4~LD12fhCE31151111511epcas5p1F;
        Mon, 17 Jan 2022 12:43:03 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Jcs4x5RXxz4x9Pp; Mon, 17 Jan
        2022 12:42:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.7A.06423.15465E16; Mon, 17 Jan 2022 21:42:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220117124256epcas5p31c0a87b82fa0b195caa4a1a8f2e905d1~LD1v1-8k90117401174epcas5p3F;
        Mon, 17 Jan 2022 12:42:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220117124256epsmtrp12fbb2a834055f83a023ae7abd22ed805~LD1v0tZbQ2520925209epsmtrp1n;
        Mon, 17 Jan 2022 12:42:56 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-2e-61e56451f7b9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.B7.29871.05465E16; Mon, 17 Jan 2022 21:42:56 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220117124253epsmtip26e666f9119d6cdd8e7b59036fd7f472f~LD1swO4sw0708607086epsmtip2e;
        Mon, 17 Jan 2022 12:42:53 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Jonathan Cameron'" <Jonathan.Cameron@Huawei.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <olof@lixom.net>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <s.nawrocki@samsung.com>, <linux-samsung-soc@vger.kernel.org>,
        <pankaj.dubey@samsung.com>, <linux-fsd@tesla.com>,
        "'Tamseel Shams'" <m.shams@samsung.com>
In-Reply-To: <20220117094728.000051b8@Huawei.com>
Subject: RE: [PATCH 20/23] dt-bindings: iio: adc: exynos-adc: Add ADC-V3
 variant
Date:   Mon, 17 Jan 2022 18:12:52 +0530
Message-ID: <00b301d80b9f$c06304d0$41290e70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgIwyL4qAholePgCN4X3HAEeB8w4qn3OlMA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJsWRmVeSWpSXmKPExsWy7bCmhm5gytNEg1mTtSzeL+thtJh/5Byr
        xaqF19gsNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcbd1MbvFqeuf2SwW
        bf3CbtG69wi7xeE37awWj6//YXMQ8Fgzbw2jx6yGXjaPliNvWT02repk87hzbQ+bx+Yl9R5X
        TjSxevRtWcXo8a9pLrvH501yAVxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
        Sgp5ibmptkouPgG6bpk5QK8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSK
        E3OLS/PS9fJSS6wMDQyMTIEKE7Izvu15xlpwXaRix9l9bA2MlwS7GDk5JARMJCad3crcxcjF
        ISSwm1Gi6cMaNgjnE6PE6QVNTBDON0aJP1M7mGFavm+ewgiR2MsosfnxN3YI5yWjxKEJM1lA
        qtgEdCV2LG5jA7FFBEol7rR9ARvFLDCbWWL9zdmMIAlOAUOJ0/uPsoLYwgJBEl9+3AJrYBFQ
        lXiw8ipYnFfAUuLCs5WMELagxMmZT8AWMAvIS2x/OwfqJAWJn0+XsUIs85M4c38lM0SNuMTL
        o0fArpMQ+M8hMePCbqAEB5DjInHxbTxEr7DEq+Nb2CFsKYmX/W3sECXZEj27jCHCNRJL5x1j
        gbDtJQ5cmcMCUsIsoCmxfpc+xCY+id7fT5ggOnklOtqEIKpVJZrfXYXqlJaY2N3NCmF7SMzb
        fYxtAqPiLCR/zULy1ywk989CWLaAkWUVo2RqQXFuemqxaYFhXmo5PL6T83M3MYITupbnDsa7
        Dz7oHWJk4mA8xCjBwawkwnuM+0miEG9KYmVValF+fFFpTmrxIUZTYGBPZJYSTc4H5pS8knhD
        E0sDEzMzMxNLYzNDJXHe0+kbEoUE0hNLUrNTUwtSi2D6mDg4pRqYrH6xG9l+uPTpx8G3K+w3
        XuNuOLFnq3CR6rnY+Wbqatwl5RMNLRbnXzpqc9h07/QHZ7Uaf20I63ywTCbNQLzg9+GdJwsP
        3+P7w/t4us3Lg2HJKjOOJ6yMzk/Kajpwzqbj9fe7xdP02Rh76u1urqrzPdK5SXC7p0LfCieO
        RkednbccF38ws9jbeWtT6lHn078PzdIW6XBZMskyuXUSR6SopUmCRuSrX6e0DTd1lymzBS/6
        UXb/wIF1v1/Esbf+nPBaUnqvBuc5XusDk05u1zq1cn3mhqUz+l6Hdh45sD19TXHAhNvbn7rX
        HeN6sMTY8/iulcc1Xzunx9d2iTf5t6zhvcvGoZL//vg6JROvquZts5VYijMSDbWYi4oTASJ3
        /hVxBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSvG5AytNEg97Xqhbvl/UwWsw/co7V
        YtXCa2wWG9/+YLKY8mc5k8Wmx9dYLT723GO1ePgq3OLyrjlsFjPO72OyuNu6mN3i1PXPbBaL
        tn5ht2jde4Td4vCbdlaLx9f/sDkIeKyZt4bRY1ZDL5tHy5G3rB6bVnWyedy5tofNY/OSeo8r
        J5pYPfq2rGL0+Nc0l93j8ya5AK4oLpuU1JzMstQifbsEroxve56xFlwXqdhxdh9bA+MlwS5G
        Tg4JAROJ75unMHYxcnEICexmlNjQMZkZIiEtcX3jBHYIW1hi5b/n7BBFzxklnrx6xgqSYBPQ
        ldixuI0NxBYRKJVoObUZbBKzwGpmiebPW5ghOmYxSfSsfM0EUsUpYChxev9RsG5hgQCJjzev
        gXWzCKhKPFh5FSzOK2ApceHZSkYIW1Di5MwnLF2MHEBT9STaNoKFmQXkJba/nQN1qYLEz6fL
        WCGO8JM4c38lM0SNuMTLo0fYJzAKz0IyaRbCpFlIJs1C0rGAkWUVo2RqQXFuem6xYYFhXmq5
        XnFibnFpXrpecn7uJkZwXGtp7mDcvuqD3iFGJg7GQ4wSHMxKIrzHuJ8kCvGmJFZWpRblxxeV
        5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cDUG/7msoLl4kmT3y6ZemuqX3GI
        Xr3v1tl30tgtQsJzN2+flaCuNK/1vGDbZlt9i7Id7Gan9infyb0beqH+3Iuzpzfk6ZW+USz/
        6beD0bdxn6Tl6/0+HuY6Du9KlRi32qVtcg/c4PtZ7JdK3vyHEyyWvpNOFSuzDhflCf7TXuS/
        9JVwQs3ixdn+8bJP+7mDnJY59015XTJb95aBzc9Umyl/dFsOFNZ1hx1a6nXFkmXW99Nrfs/e
        tyNJn6n5/CTV4/MUPjFYvHr1ULXb7WHv9t+n/qxjeLzp/cJpXmeNo0t3zK19euBd/CYeTWk+
        441/W3c1CRhJHdDrEGrp7v3Zxy2X0V4vW5bzRfq/e9osqcdKLMUZiYZazEXFiQAXSuOlWgMA
        AA==
X-CMS-MailID: 20220117124256epcas5p31c0a87b82fa0b195caa4a1a8f2e905d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122447epcas5p266d44c8df143229d22dfa700c285a786
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122447epcas5p266d44c8df143229d22dfa700c285a786@epcas5p2.samsung.com>
        <20220113121143.22280-21-alim.akhtar@samsung.com>
        <75ae8b8c-e416-5007-b995-f1317ef207d4@canonical.com>
        <20220117094728.000051b8@Huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Jonathan Cameron [mailto:Jonathan.Cameron@Huawei.com]
>Sent: Monday, January 17, 2022 3:17 PM
>To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>Cc: Alim Akhtar <alim.akhtar@samsung.com>; linux-arm-
>kernel@lists.infradead.org; linux-kernel@vger.kernel.org; soc@kernel.org;
>linux-clk@vger.kernel.org; devicetree@vger.kernel.org; olof@lixom.net;
>linus.walleij@linaro.org; catalin.marinas@arm.com; robh+dt@kernel.org;
>s.nawrocki@samsung.com; linux-samsung-soc@vger.kernel.org;
>pankaj.dubey@samsung.com; linux-fsd@tesla.com; Tamseel Shams
><m.shams@samsung.com>
>Subject: Re: [PATCH 20/23] dt-bindings: iio: adc: exynos-adc: Add ADC-V3
>variant
>
>On Thu, 13 Jan 2022 14:32:12 +0100
>Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
>
>> On 13/01/2022 13:11, Alim Akhtar wrote:
>> > This patch adds a new compatible string for exynos's ADC-V3 variant.
>> >
>> > Cc: linux-fsd@tesla.com
>> > Signed-off-by: Tamseel Shams <m.shams@samsung.com>
>> > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>
>Please cc linux-iio@vger.kernel.org for next version...
>
Noted, will separate out these patches from the original series and send.
Thanks

>> > ---
>> >  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git
>> > a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
>> > b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
>> > index 81c87295912c..9303053759ca 100644
>> > ---
>> > a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
>> > +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-
>adc.y
>> > +++ aml
>> > @@ -14,6 +14,7 @@ properties:
>> >      enum:
>> >        - samsung,exynos-adc-v1                 # Exynos5250
>> >        - samsung,exynos-adc-v2
>> > +      - samsung,exynos-adc-v3
>>
>> Please use SoC-specific compatible. IP block versions are tricky because:
>> 1. Documentation/datasheet mentioning which SoC has which block
>> version are not public.
>> 2. Neither are public the datasheets for ADC blocks.
>> 3. The versioning of IP blocks can be inaccurate.
>>
>>
>> Best regards,
>> Krzysztof
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> https://protect2.fireeye.com/v1/url?k=9dd88c77-fca326ff-9dd90738-74fe4
>> 860018a-343cb1b0388f1560&q=1&e=61045889-dd66-417f-b142-
>9e85b39f1676&u=
>> http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
>kern
>> el


