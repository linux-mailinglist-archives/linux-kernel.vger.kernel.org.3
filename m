Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E06948E3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbiANFpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:45:10 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:12458 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiANFpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:45:04 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220114054502epoutp042ccd726574f5fdb88ee2b5bd93ce18a2~KDNAt1-EN0475104751epoutp04C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:45:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220114054502epoutp042ccd726574f5fdb88ee2b5bd93ce18a2~KDNAt1-EN0475104751epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642139102;
        bh=w47xkFujfC1ZtjvVcAlZUxxUPRzZ9XLi8/PhdkNW0dU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Ra++L0KTQkLlfxU5EwhapTZvBH6BoY7/5jf6vUXfjrfA/fnRgNch/WkivgvqB5m5D
         Y5SfGv5ecnNkXZ3qzk0Zyf5+M72vd11r0a4Q6ZA3U/qoup3pB8q7sUcD3EJ53DepPo
         dShBrl89p/KbjpoXoVE6hMZHCvZ7w54J1rCh/H8c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220114054501epcas5p2ed4f0a645cdb5246410e5d4aeb380118~KDNAMnWzz1615416154epcas5p2G;
        Fri, 14 Jan 2022 05:45:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JZqxy0ZP7z4x9Q3; Fri, 14 Jan
        2022 05:44:54 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.36.46822.DCD01E16; Fri, 14 Jan 2022 14:44:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220114054445epcas5p47f19a2afcff3ad5f01d66a47586c6f56~KDMwz_PzY1547315473epcas5p4z;
        Fri, 14 Jan 2022 05:44:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220114054445epsmtrp132fe461cb0578c60aab4aa97c9556c80~KDMwzJsKc1830318303epsmtrp1J;
        Fri, 14 Jan 2022 05:44:45 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-b3-61e10dcdf66f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.FA.08738.DCD01E16; Fri, 14 Jan 2022 14:44:45 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114054443epsmtip14d9ec385250ecc599f85ac6f880ebd47~KDMutVFPP1319713197epsmtip13;
        Fri, 14 Jan 2022 05:44:42 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>
In-Reply-To: <849c7772-0f7e-32ff-6ea6-c46aa6837bb4@canonical.com>
Subject: RE: [PATCH 10/23] dt-bindings: pinctrl: samsung: Add compatible for
 Tesla FSD SoC
Date:   Fri, 14 Jan 2022 11:14:41 +0530
Message-ID: <076101d80909$d5849060$808db120$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgL8ryguAaBfAcEA6PFKo6qJdmUg
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAJsWRmVeSWpSXmKPExsWy7bCmuu5Z3oeJBjtvW1i8X9bDaDH/yDlW
        i41vfzBZTPmznMli0+NrrBYfe+6xWjx8FW5xedccNosZ5/cxWZy6/pnNYtHWL+wWrXuPsFsc
        ftPOavH4+h82Bz6PNfPWMHrMauhl89i0qpPN4861PWwem5fUe1w50cTq0bdlFaPHv6a57B6f
        N8kFcEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA
        3a6kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0MDAy
        BSpMyM64d3QxS8F9gYrXHycwNTAe5Oti5OSQEDCRWPf4GVsXIxeHkMBuRokNiy8yQzifGCUO
        N65ngXA+M0pMXbqaBabl36ZmRojELkaJn4dmQDkvGSXmNfQxg1SxCehK7FjcBjZYRKCTUWL1
        959MIA6zwAomifmn7oLN4hRwlPj0fD8biC0sECOx7es9dhCbRUBV4s/ZSUBxDg5eAUuJ97NL
        QMK8AoISJ2c+AWtlFtCWWLbwNTPESQoSP58uYwWxRQTcJC7Pu8cIUSMu8fLoEXaQvRICLzgk
        rqw+APWDi8Tac0uhbGGJV8e3sEPYUhIv+9vYQfZKCGRL9OwyhgjXSCyddwyq3F7iwJU5LCAl
        zAKaEut36UOs4pPo/f2ECaKTV6KjTQiiWlWi+d1VqE5piYnd3awQtofE0RvNbBMYFWcheWwW
        ksdmIXlgFsKyBYwsqxglUwuKc9NTi00LjPJSy+ERnpyfu4kRnLS1vHYwPnzwQe8QIxMH4yFG
        CQ5mJRHe/qL7iUK8KYmVValF+fFFpTmpxYcYTYGBPZFZSjQ5H5g38kriDU0sDUzMzMxMLI3N
        DJXEeU+nb0gUEkhPLEnNTk0tSC2C6WPi4JRqYAoL9Pyt/m59gUeorVaPUNRmkcm5h7tUPldl
        ndie8jBL1Vrw/G4Lg+lrWpv/pQg7vJ3sFjc94mQL588w63OnlXI+fPJZ4H/rmJbDlf18CzrC
        U/YInnR54fqtTPNGVvF1Fot/6V8XBOUlvzt5xkZnQ+mEB7aHK782qXovPGxms7l/waybrk6t
        s6N4wvtedfDsi1Wo3PeV98/ds3rzxJsm6M9d+PPyc3nHOo+izSsuLn9fv06TYYPtJ6FFDzp6
        pA+ud/bn+na/dP9qjm3mpWn3FswrV8jM+ceyjdtvlVnPUjOGc8zBnG2pSXbeKWbbtqQLlB7U
        Sftt3lHrz5X803ybWGZL2tdijq85C4zUVX+qK7EUZyQaajEXFScCAKgT4QZjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWy7bCSnO5Z3oeJBp2N3Bbvl/UwWsw/co7V
        YuPbH0wWU/4sZ7LY9Pgaq8XHnnusFg9fhVtc3jWHzWLG+X1MFqeuf2azWLT1C7tF694j7BaH
        37SzWjy+/ofNgc9jzbw1jB6zGnrZPDat6mTzuHNtD5vH5iX1HldONLF69G1Zxejxr2kuu8fn
        TXIBnFFcNimpOZllqUX6dglcGR3tn1kLZgtUnP84m72B8S9vFyMnh4SAicS/Tc2MXYxcHEIC
        Oxglep48YINISEtc3ziBHcIWllj57zk7RNFzRon5zR+ZQRJsAroSOxa3sYEkRAS6GSWu9MwE
        G8UssIVJovPFGbAqIYGvjBIzPpuD2JwCjhKfnu8HWyEsECVx+u0tJhCbRUBV4s/ZSUBxDg5e
        AUuJ97NLQMK8AoISJ2c+YQGxmQW0JXoftjLC2MsWvmaGuE5B4ufTZawgtoiAm8TlefegasQl
        Xh49wj6BUXgWklGzkIyahWTULCQtCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525i
        BMeultYOxj2rPugdYmTiYDzEKMHBrCTC2190P1GINyWxsiq1KD++qDQntfgQozQHi5I474Wu
        k/FCAumJJanZqakFqUUwWSYOTqkGptbl8g4fy+qVT0cn+pQWLnrlqRjy68WN3tmpW27sTzvd
        X7ekxZ7fRHfd7TI+tbqbvx7d9q6TyI5e55fs/l135ZPrMoYZjRr/3GMCpOWcr5/j+KZwZsss
        yQbBtori4DdxOW/PL1tWk28neDVE+t2K+Oyz339FzVkT2CzDvNXTW9/LTPuKpW+JsBwf+84n
        zg/4bBPtRL9Nqb3TUe88//VVk+2p7zI9CiS3qP+/8Pzc7ybhwkbJY9p3t1ou1s44/WXr9J+1
        tX+K+Vazu3QmnGv8J7/H8l4h17nteq3a+yIlw2fFrrZ2aL68wqnym+LJH779tjFajsk+gdrr
        PkdOO5TnnpQjuWiadt2VLTMfGcsrsRRnJBpqMRcVJwIAbZ6TTkwDAAA=
X-CMS-MailID: 20220114054445epcas5p47f19a2afcff3ad5f01d66a47586c6f56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122354epcas5p19e5cebe9e85e9ba1758fa0b9d7d1ef75
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122354epcas5p19e5cebe9e85e9ba1758fa0b9d7d1ef75@epcas5p1.samsung.com>
        <20220113121143.22280-11-alim.akhtar@samsung.com>
        <849c7772-0f7e-32ff-6ea6-c46aa6837bb4@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Thursday, January 13, 2022 5:57 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; linus.walleij=40linaro.org; catalin.marinas=40arm.com;
>robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.com
>Subject: Re: =5BPATCH 10/23=5D dt-bindings: pinctrl: samsung: Add compatib=
le for
>Tesla FSD SoC
>
>On 13/01/2022 13:11, Alim Akhtar wrote:
>> Add compatible for Tesla Full Self-Driving SoC. The pinctrl hardware
>> IP is similar to what found on most of the exynos series of SoC, so
>> this new compatible is added in samsung pinctrl binding.
>>
>> Cc: linux-fsd=40tesla.com
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> ---
>>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt =7C 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> index b8b475967ff9..ba972998a0e4 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> =40=40 -24,6 +24,7 =40=40 Required Properties:
>>    - =22samsung,exynos7-pinctrl=22: for Exynos7 compatible pin-controlle=
r.
>>    - =22samsung,exynos850-pinctrl=22: for Exynos850 compatible pin-contr=
oller.
>>    - =22samsung,exynosautov9-pinctrl=22: for ExynosAutov9 compatible pin=
-
>controller.
>> +  - =22tesla,fsd-pinctrl=22: for Tesla FSD SoC compatible pin-controlle=
r.
>>
>
>Please rebase this on my latest Samsung pinctrl dtschema patches. You also
>need a tesla vendor prefix patch (separate).
>
Sure will rebase when sending v2, your latest patches are in Linux-next or =
still in your tree?

>
>Best regards,
>Krzysztof

