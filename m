Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3B490984
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiAQN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:26:19 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63995 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiAQN0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:26:18 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220117132616epoutp0264f4d50f5e0757d85afe7966a6e64d3c~LEbk49sTg2252522525epoutp02R
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:26:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220117132616epoutp0264f4d50f5e0757d85afe7966a6e64d3c~LEbk49sTg2252522525epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642425976;
        bh=jJYIuzuaNEFnNoUSu/2MnSA+EPnb7LgcjQMBnYhMUyk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=rGym4fpa6AvM9HP+Br0iWxrW30mvCdh7M9UPqDMtLl1ySxNHNmL7VzNeYkGgpV+HS
         RpMgAOVA8barhowucFxaGhKYNLnA3aOTwSCQH3qerqP9gDHP/oM4vuFYWG0fvsxmdI
         QIUqoSoxyATHJ7+ENFUwhXjDB2tjPzRw9ixv3/8o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220117132615epcas5p16624146221ce26631968fe9b6310c9ae~LEbkbTCDN0268702687epcas5p18;
        Mon, 17 Jan 2022 13:26:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Jct2p2tm0z4x9Pt; Mon, 17 Jan
        2022 13:26:10 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.57.46822.64E65E16; Mon, 17 Jan 2022 22:25:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220117132609epcas5p20eb1ddff0d0bf74393acfc37d16ad027~LEbeXe2c31268812688epcas5p2Z;
        Mon, 17 Jan 2022 13:26:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220117132609epsmtrp115d45856a6933f230ea84e93ed2b2dd1~LEbeWnVEE1765217652epsmtrp18;
        Mon, 17 Jan 2022 13:26:09 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-e6-61e56e466d5d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.2A.08738.17E65E16; Mon, 17 Jan 2022 22:26:09 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220117132607epsmtip1ed04742abc9fee9b50b79ca74fe17ee6~LEbcQmvjr2208722087epsmtip1E;
        Mon, 17 Jan 2022 13:26:06 +0000 (GMT)
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
In-Reply-To: <5ab62673-8d46-ec1d-1c80-696421ab69ca@canonical.com>
Subject: RE: [PATCH 13/23] dt-bindings: arm: add Tesla FSD ARM SoC
Date:   Mon, 17 Jan 2022 18:56:05 +0530
Message-ID: <00c901d80ba5$c9ae6ab0$5d0b4010$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgIR+KN8AmyCbh0CxU8U/wHDvG0jANpCFQOqa8cWwA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmuq5b3tNEg403WSzeL+thtJh/5Byr
        xca3P5gspvxZzmSx6fE1VouPPfdYLR6+Cre4vGsOm8WM8/uYLE5d/8xmsWjrF3aL1r1H2C0O
        v2lntXh8/Q+bA5/HmnlrGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/P
        m+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA
        bldSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZ
        AhUmZGdcW9vBXrBaseLmqvVMDYyrZLoYOTkkBEwkXj+dytjFyMUhJLCbUWLP4X1MEM4nRolF
        C46wQjifGSX2vlrOCtPSvOoyE4gtJLCLUeLgU3OIopeMErs/HAdLsAnoSuxY3MYGkhAR6GSU
        WP39J9hcZoEVTBLzT91lAaniFHCUuP9iJzuILSzgJPH35jmwFSwCqhItU68AxTk4eAUsJZ7/
        VwAJ8woISpyc+QSslVlAW2LZwtfMEBcpSPx8ugysVUQgTOLipJnsEDXiEi+PHmEH2Ssh8IJD
        YveSj0wQDS4S1x61QtnCEq+Ob2GHsKUkXva3ge2VEMiW6NllDBGukVg67xgLhG0vceDKHBaQ
        EmYBTYn1u/QhVvFJ9P5+wgTRySvR0SYEUa0q0fzuKlSntMTE7m5oGHpIvHrym3UCo+IsJI/N
        QvLYLCQPzEJYtoCRZRWjZGpBcW56arFpgVFeajk8vpPzczcxglO2ltcOxocPPugdYmTiYDzE
        KMHBrCTCe4z7SaIQb0piZVVqUX58UWlOavEhRlNgYE9klhJNzgdmjbySeEMTSwMTMzMzE0tj
        M0Mlcd7T6RsShQTSE0tSs1NTC1KLYPqYODilGpiKV57UE7JN7f357m/VVHsmtoym/yKzv4so
        vzZ8+X6vVcK1T88WqvFlfXlccdmpkVlHeInfzwteAl8jdLda/3aQPRG2dvKWw7fUNV9HyjOK
        tj5luiD5YvuCVL3FPL4F02/cWXi4tPn5urru715HUo7fNLV+lewiJjr3XOeFO/qc32zmq6mf
        1jJT9N7cd6+iXStcfG7Kx7tlfavtr30V+fgy8vmnT6sXxCvVnO5/e20VO/firmW/5d6tjDPc
        WRk2b4WKd8t/2wDJlqtWG5wazxlezp4kWG0e++30A4uri+O0zsUad37aJWKYuOtedYuvfIt2
        +54v/Zxc4rp7s9SCshxlamuNc86/k+V/5tcSYKbEUpyRaKjFXFScCABv5Y91YgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnG5h3tNEgw3PeSzeL+thtJh/5Byr
        xca3P5gspvxZzmSx6fE1VouPPfdYLR6+Cre4vGsOm8WM8/uYLE5d/8xmsWjrF3aL1r1H2C0O
        v2lntXh8/Q+bA5/HmnlrGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/P
        m+QCOKO4bFJSczLLUov07RK4Mo6fWMtWcEKh4tGFT+wNjEeluxg5OSQETCSaV11m6mLk4hAS
        2MEosbinhREiIS1xfeMEdghbWGLlv+fsEEXPGSVmLDnGApJgE9CV2LG4jQ0kISLQzShxpWcm
        I4jDLLCFSaLzxRlmiJYbTBLnV34Fm8Up4Chx/8VOMFtYwEni781zrCA2i4CqRMvUK0BxDg5e
        AUuJ5/8VQMK8AoISJ2c+AdvGLKAt0fuwlRHGXrbwNTPEeQoSP58uAxsjIhAmcXHSTHaIGnGJ
        l0ePsE9gFJ6FZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsY
        wdGrpbWDcc+qD3qHGJk4GA8xSnAwK4nwHuN+kijEm5JYWZValB9fVJqTWnyIUZqDRUmc90LX
        yXghgfTEktTs1NSC1CKYLBMHp1QDU3bqohM3/ZqfMqY83e/IIZ32+rJ4zZfDR93ikpdMljun
        p1N7Qlr155T7zBn6LI/DHq61ujqhb0+9QdaijSXfGBti7qQ87VlgnynepNOQcCIt6lZZ0pNr
        LQKu6vmme2qkGC5vOOe5+uC60/ZustlHmiLtL6spN93JNy3+5K50oo/bzXDT3eYfT3QLzod+
        Z1lxPavcKq/NYr14wDT30AxpjrZ1m5MOMb7SqjQ6wsEouzlnM4fHBat1mY8Mz+tKLDFcoNtT
        cMEq642Wt8ms3JzMp4suXHK3nJl+6tqsSUaxASpur89kuvAWXYg56L1/i175pUNtZ5X78h39
        19w9aTLd0GBelQE37wqnWWbVfXOVWIozEg21mIuKEwGJ2u9HTQMAAA==
X-CMS-MailID: 20220117132609epcas5p20eb1ddff0d0bf74393acfc37d16ad027
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122408epcas5p45053d1bf0acf2d8233a98b6c1abab6eb@epcas5p4.samsung.com>
        <20220113121143.22280-14-alim.akhtar@samsung.com>
        <53c17ddc-a049-72ed-7237-de23db7889da@canonical.com>
        <085801d80967$e4b8fe00$ae2afa00$@samsung.com>
        <5ab62673-8d46-ec1d-1c80-696421ab69ca@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Friday, January 14, 2022 11:00 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; linus.walleij=40linaro.org; catalin.marinas=40arm.com;
>robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.com
>Subject: Re: =5BPATCH 13/23=5D dt-bindings: arm: add Tesla FSD ARM SoC
>
>On 14/01/2022 17:57, Alim Akhtar wrote:
>>
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=
=5D
>>> Sent: Thursday, January 13, 2022 6:03 PM
>>> To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>>> kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>>> Cc: soc=40kernel.org; linux-clk=40vger.kernel.org;
>>> devicetree=40vger.kernel.org; olof=40lixom.net; linus.walleij=40linaro.=
org;
>>> catalin.marinas=40arm.com;
>>> robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>>> soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.co=
m
>>> Subject: Re: =5BPATCH 13/23=5D dt-bindings: arm: add Tesla FSD ARM SoC
>>>
>>> On 13/01/2022 13:11, Alim Akhtar wrote:
>>>> Add device tree bindings for the Tesla FSD ARM SoC.
>>>>
>>>> Cc: linux-fsd=40tesla.com
>>>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>>>> ---
>>>>  .../devicetree/bindings/arm/tesla.yaml        =7C 25 ++++++++++++++++=
+++
>>>>  1 file changed, 25 insertions(+)
>>>>  create mode 100644
>Documentation/devicetree/bindings/arm/tesla.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/tesla.yaml
>>>> b/Documentation/devicetree/bindings/arm/tesla.yaml
>>>> new file mode 100644
>>>> index 000000000000..9f89cde76c85
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/arm/tesla.yaml
>>>> =40=40 -0,0 +1,25 =40=40
>>>> +=23 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
>>>> +---
>>>> +=24id:
>>>> +https://protect2.fireeye.com/v1/url?k=3D2f0fac44-70949546-2f0e270b-0c
>>>> +c4
>>>> +7a312ab0-50c826f7b1999a5f&q=3D1&e=3Dbcbf277f-4e93-4705-8f6a-
>>> 2beaa7eb31e2&
>>>>
>+u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Farm%2Ftesla.yaml%23
>>>> +=24schema:
>>>> +https://protect2.fireeye.com/v1/url?k=3Dd8493fe2-87d206e0-d848b4ad-
>0c
>>>> +c4
>>>> +7a312ab0-f4e5046adc7da972&q=3D1&e=3Dbcbf277f-4e93-4705-8f6a-
>>> 2beaa7eb31e2&
>>>> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>>>> +
>>>> +title: Tesla Full Self Driving(FSD) platforms device tree bindings
>>>> +
>>>> +maintainers:
>>>> +  - Alim Akhtar <alim.akhtar=40samsung.com>
>>>> +  - linux-fsd=40tesla.com
>>>> +
>>>> +properties:
>>>> +  =24nodename:
>>>> +    const: '/'
>>>> +  compatible:
>>>> +    oneOf:
>>>> +
>>>> +      - description: FSD SoC board
>>>> +        items:
>>>> +          - const: tesla,fsd
>>>
>>> Either this is a SoC or a board compatible... Cannot be both.
>>>
>> Actually we call this as fsd board, so let me add accordingly compatible=
 (fsd-
>baord) for board.
>> Thanks
>
>It's confusing and probably not accurate. In your series fsd is three thin=
gs in
>the same time: an architecture, a SoC and a board (DTS). The last two shou=
ld
>definitely be different. You probably have some eval board (how it is call=
ed
>also in Tesla open source git) or some specific product board.
>
Understood, let me clear this confusion in the patchset-2 where fsd board w=
ill have its own compatible and=20
of course SoC will have its own (shared with fsd architecture) compatible.

>I cannot judge how different this is from Exynos subarchitecture - looking=
 at
>patches it is not different - so I could understand a FSD sub-arch with on=
ly one
>SoC.
>
I understand, it is a bit difficult to visualize it with the current patch =
set.
As discuss on the other thread, FSD is different, more over the vendor is d=
ifferent, internal design is different.
>
>Best regards,
>Krzysztof

