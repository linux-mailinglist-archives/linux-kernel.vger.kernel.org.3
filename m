Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD5149CFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbiAZQrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:47:18 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:29061 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243267AbiAZQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:47:14 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220126164712epoutp026aac15888a1f1e4107f87ecb89ebd845~N3_l4Klzn1355313553epoutp02a
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:47:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220126164712epoutp026aac15888a1f1e4107f87ecb89ebd845~N3_l4Klzn1355313553epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643215632;
        bh=ZtgZPXdL+8x4QpMXp+vZXFLyV/9tqK5mOhEfGc4FZjY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=bWHcJQI2qS+2YcemvekO6Bt81cKnUIWGamic6IBCkNCTCQ4DHJfrye4CCqxClY9b1
         g+uebeEiKts1ZkQ5I/QLaf4d/+jhaWLZXG6WVHle5k+/tPdvXY3PBdeNhg0XrGxsTV
         3IQ6lGxWCpXZI+BTNWULl1ol+cli58BfSIaiqqWA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220126164712epcas5p400b35bf4c2a37a677564921d4e7b8e13~N3_lHXZr11109511095epcas5p4R;
        Wed, 26 Jan 2022 16:47:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JkV4W0xy6z4x9Pw; Wed, 26 Jan
        2022 16:47:07 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.61.05590.B0B71F16; Thu, 27 Jan 2022 01:47:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220126164706epcas5p422e2fd79a3054926f2ff123e764ce1e5~N3_gCgtjW1109511095epcas5p4Q;
        Wed, 26 Jan 2022 16:47:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220126164706epsmtrp1c9e0e9a1c97c963a92d5036f9136c5ad~N3_gBjBc33079530795epsmtrp1O;
        Wed, 26 Jan 2022 16:47:06 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-89-61f17b0b5358
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.D5.08738.A0B71F16; Thu, 27 Jan 2022 01:47:06 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220126164703epsmtip2115a528a41bfdf1db9fd02f53aea60f1~N3_dMsc0b0140201402epsmtip22;
        Wed, 26 Jan 2022 16:47:03 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>, <arnd@arndb.de>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <sboyd@kernel.org>
In-Reply-To: <4c029f92-ece7-78c1-e64b-cbe438b45a5f@canonical.com>
Subject: RE: [PATCH v5 00/16] Add support for Tesla Full Self-Driving (FSD)
 SoC
Date:   Wed, 26 Jan 2022 22:17:02 +0530
Message-ID: <067001d812d4$5a26ab40$0e7401c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH3x/DHpHRz6vxyIYATeg+eWAbDkwGsWw0jAU7CzZABPsnnMgNDCrFWAhwoLwSr6U+vMA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmhi539cdEgzW3WSz+TjrGbvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdqcXnXHDaLGef3MVmcuv6ZzWLR1i/sFq17j7Bb
        HH7Tzmrx79pGFovH1/+wOfB7rJm3htHj969JjB6zGnrZPDat6mTzuHNtD5vH5iX1HldONLF6
        9G1ZxejxeZNcAGdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMfztvshaskq84dPcNYwPjWakuRg4OCQETiceTOLoYOTmEBHYzSnz8Kw5h
        f2KU2PAnuouRC8j+zCjx+kEHO0gCpP7f9V9sEIldjBIN3S0sEM5LRonGDQuZQKrYBHQldixu
        A6sSEehklFj9/SdYgllgG5PE7onaIDangKNE78xNjCC2sECgxI1Ld1lBbBYBVYllM2ezgdi8
        ApYSly/MZYawBSVOznzCAjFHW2LZwtfMECcpSPx8ugysV0QgTGLD1eXsEDXiEi+PHmEHOUJC
        4AOHxJJNs6F+cJHYcGE5VLOwxKvjW6DiUhIv+9vYIeGSLdGzyxgiXCOxdN4xFgjbXuLAlTks
        ICXMApoS63fpQ6zik+j9/YQJopNXoqNNCKJaVaL53VWoTmmJid3drBAlHhLftrNMYFScheSv
        WUj+moXk/lkIuxYwsqxilEwtKM5NTy02LTDOSy2HR3Zyfu4mRnDi1vLewfjowQe9Q4xMHIyH
        GCU4mJVEeIW0PiYK8aYkVlalFuXHF5XmpBYfYjQFBvZEZinR5Hxg7sgriTc0sTQwMTMzM7E0
        NjNUEuc9lb4hUUggPbEkNTs1tSC1CKaPiYNTqoFJfGKD6F4T66qjDzN2ZCk3hMav0JM99azf
        Z8mWBwLuVn85dr9+Pyf83nmLm23y1maiCyT7/5yZo53jcUXQgj9VzcuzIuhr98noh3FzGg4F
        zb26/rbRxWm/9P5Xx3pd7LlnN4PttY5Kc/pXrZoji77EVUWYPohJStiUteB9juxJubmXVvD2
        NXhfebUwor5+Wk3i4vvtb+TC6u945WqelWNPPtvQoeFQsMDe6ZDorLuVV9fs8Q4+bGuhE/ql
        Qr210zhYIj/6eFPehlqTi6tC+i4qPZK/aTShc7/S8rs7X5qsMhQ395rwWF194b2dJ8rstuQd
        tk3h/7ZAbv30upsZHJHszH5lkuZzyrRK1urO9lRiKc5INNRiLipOBABdY6+MZQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvC5X9cdEgw0nZSz+TjrGbvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdqcXnXHDaLGef3MVmcuv6ZzWLR1i/sFq17j7Bb
        HH7Tzmrx79pGFovH1/+wOfB7rJm3htHj969JjB6zGnrZPDat6mTzuHNtD5vH5iX1HldONLF6
        9G1ZxejxeZNcAGcUl01Kak5mWWqRvl0CV0bfhCPsBQ/kKpbtmMjUwPhdsouRk0NCwETi3/Vf
        bF2MXBxCAjsYJVb8XsQEkZCWuL5xAjuELSyx8t9zMFtI4DmjxLXn9iA2m4CuxI7FbWDNIgLd
        jBJXemYygjjMAkeYJH7u38QMMfY2k8T85ptsIC2cAo4SvTM3MYLYwgL+EmsfvGcBsVkEVCWW
        zZwNVsMrYClx+cJcZghbUOLkzCdgNcwC2hJPbz6Fs5ctfM0McZ6CxM+ny1hBbBGBMIkNV5ez
        Q9SIS7w8eoR9AqPwLCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dL
        zs/dxAiOZC2tHYx7Vn3QO8TIxMF4iFGCg1lJhFdI62OiEG9KYmVValF+fFFpTmrxIUZpDhYl
        cd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzKfc+fbLFJV++ecDTy2/6KpQdnJ0eKVLdsE3/X
        bSl1RP/Ehq93F9zd3bQ7q86j53b69G+vXqksfBRiVF/cXWZyoqt37ROz+ZxOW222HWh/aNeU
        seS0wCJdPYlXL9pOioVWa8dJS1zwqH8orayyb3mFVUlJ6JOms2rpYbufiBWLdYS/e2ZUVrni
        9srvf9gXPz+99Hn22gAH21cb3sTs8Sr1Y3u/9d583qv9vbwWR384rotLWLpTJ5p9n+QK2ffn
        uEU+Si9OTXNcmfnz/FHZZQ67+r0uFphEbLc/8SpwM+NCrrvhrEVn/B5ZfHPpvM3/8p1xOU8o
        77f7pvb7l759tzHiV96q2y7JR91dH9xsvS6oxFKckWioxVxUnAgA6cN0GFMDAAA=
X-CMS-MailID: 20220126164706epcas5p422e2fd79a3054926f2ff123e764ce1e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b
References: <CGME20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b@epcas5p2.samsung.com>
        <20220124141644.71052-1-alim.akhtar@samsung.com>
        <d9682f16-13b7-b6dc-5afd-b2d319143de5@canonical.com>
        <4cfcde38-50cb-646a-0d17-c2cb2977a2e4@canonical.com>
        <063501d81281$10e5b3c0$32b11b40$@samsung.com>
        <4c029f92-ece7-78c1-e64b-cbe438b45a5f@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Wednesday, January 26, 2022 2:50 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; arnd=40arndb.de; linus.walleij=40linaro.org;
>catalin.marinas=40arm.com; robh+dt=40kernel.org; s.nawrocki=40samsung.com;
>linux-samsung-soc=40vger.kernel.org; pankaj.dubey=40samsung.com;
>sboyd=40kernel.org
>Subject: Re: =5BPATCH v5 00/16=5D Add support for Tesla Full Self-Driving =
(FSD) SoC
>
>On 26/01/2022 07:50, Alim Akhtar wrote:
>> Hi Krzysztof
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=
=5D
>>> Sent: Tuesday, January 25, 2022 10:56 PM
>>> To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>>> kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>>> Cc: soc=40kernel.org; linux-clk=40vger.kernel.org;
>>> devicetree=40vger.kernel.org; olof=40lixom.net; arnd=40arndb.de;
>>> linus.walleij=40linaro.org; catalin.marinas=40arm.com;
>>> robh+dt=40kernel.org; s.nawrocki=40samsung.com;
>>> linux-samsung-soc=40vger.kernel.org; pankaj.dubey=40samsung.com;
>>> sboyd=40kernel.org
>>> Subject: Re: =5BPATCH v5 00/16=5D Add support for Tesla Full Self-Drivi=
ng
>>> (FSD) SoC
>>>
>>> On 25/01/2022 18:12, Krzysztof Kozlowski wrote:
>>>> On 24/01/2022 15:16, Alim Akhtar wrote:
>>>>> Adds basic support for the Tesla Full Self-Driving (FSD) SoC. This
>>>>> SoC contains three clusters of four Cortex-A72 CPUs, as well as
>>>>> several IPs.
>>>>>
>>>>> Patches 1 to 9 provide support for the clock controller (which is
>>>>> designed similarly to Exynos SoCs).
>>>>>
>>>>> The remaining changes provide pinmux support, initial device tree
>support.
>>>>>
>>>>> - Changes since v4
>>>>> * fixed 'make dtbs_check' warnings on patch 14/16
>>>>>
>>>>> - Changes since v3
>>>>> * Addressed Stefen's review comments on patch 14/16
>>>>> * Fixed kernel test robot warning on patch 04/16
>>>>> * rebsaed this series on Krzysztof's pinmux new binding schema work
>>>>> =5B1=5D
>>>>>
>>>>> - Changes since v2
>>>>> * Addressed Krzysztof's and Stephen's review comments
>>>>> * Added Reviewed-by and Acked-by tags
>>>>> * Rebased on next-20220120
>>>>>
>>>>> - Changes since v1
>>>>> * fixed make dt_binding_check error as pointed by Rob
>>>>> * Addressed Krzysztof's and Rob's review comments
>>>>> * Added Reviewed-by and Acked-by tags
>>>>> * Dropped SPI, MCT and ADC from this series (to be posted in small
>>>>> sets)
>>>>>
>>>>> NOTE: These patches are based on Krzysztof's pinmux for-next branch
>>>>> commit 832ae134ccc1 (=22pinctrl: samsung: add support for Exynos850
>>>>> and
>>>>> ExynosAutov9 wake-ups=22) =5B1=5D
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git
>>>>> /l
>>>>> og/?h=3Dfor-next
>>>>>
>>>>>
>>>>
>>>> Thanks, applied DTS/soc and pinctrl patches.
>>>>
>>>> I expect Sylwester will pick up the clock ones. Otherwise please let
>>>> me know to pick it up as well.
>>>
>>> I forgot that clock macros are used in DTS. This does not compile and
>>> I cannot take drivers into DTS branch.
>>>
>>> Alim,
>>> DTS changes dropped. Please resend with the same trick we did for
>>> Exynos850 board - hard-coded clock IDs as defines. See:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/diff/a
>>> rch/arm6
>>> 4/boot/dts/exynos/exynos850.dtsi?h=3Dsamsung-dt64-5.17-
>>> 2&id=3De3493220fd3e474abcdcefbe14fb60485097ce06
>>>
>> Ok, I will resend patch 14 and 15 (DTS changes) only as suggested above.
>
>I see Sylwester acked clock patches, so I will take them. No need to resen=
d, I'll
>organize the patches so they will compile.
>
Awesome, thanks Krzysztof and Sylwester

>
>Best regards,
>Krzysztof

