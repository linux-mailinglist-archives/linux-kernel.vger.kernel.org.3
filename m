Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EDC49C3D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiAZGvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:51:08 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:55253 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236928AbiAZGvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:51:07 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220126065104epoutp024c4db3bb46a284d5a30ddcf0f62b581e~Nv2Ff4aYf1181611816epoutp02h
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:51:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220126065104epoutp024c4db3bb46a284d5a30ddcf0f62b581e~Nv2Ff4aYf1181611816epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643179864;
        bh=KOM4qp0cMXcmjT0NTKgWlGigeOqpKL84mcUtIE7P5rw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=SHFNtV3IvVMBueO26oVEs4sPiOek+M0FT3N/SGXGQfS3dsDoMu6WWLK9NGFdBj7fj
         3I1oFeeU36mad9BLWY5fJlADpjzb4UAYsxC+yDgNrOcJ/gmj1Lx55w61ScflkRkqeu
         lmJSGgcv7PWNk6G4exPCQx5pchwx/uTTaFZwfwlM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220126065103epcas5p308768ae4abbe3591cac8885c5ebbcc64~Nv2E4Qm9W1467814678epcas5p33;
        Wed, 26 Jan 2022 06:51:03 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JkDrc3mzCz4x9Q8; Wed, 26 Jan
        2022 06:50:56 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.5C.46822.AADE0F16; Wed, 26 Jan 2022 15:43:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220126065055epcas5p48315c2def7273e9705ca9ea8efb8e2ca~Nv199N5_H1828218282epcas5p4S;
        Wed, 26 Jan 2022 06:50:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220126065055epsmtrp18b68ab41b301334b0a8aa21276788cb4~Nv199e_Cq0473204732epsmtrp1j;
        Wed, 26 Jan 2022 06:50:55 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-87-61f0edaaf6bd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.73.29871.F4FE0F16; Wed, 26 Jan 2022 15:50:55 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220126065053epsmtip1fa1ffa9070fd85f14d001332efc1f697~Nv178wL3x2771627716epsmtip13;
        Wed, 26 Jan 2022 06:50:53 +0000 (GMT)
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
In-Reply-To: <4cfcde38-50cb-646a-0d17-c2cb2977a2e4@canonical.com>
Subject: RE: [PATCH v5 00/16] Add support for Tesla Full Self-Driving (FSD)
 SoC
Date:   Wed, 26 Jan 2022 12:20:51 +0530
Message-ID: <063501d81281$10e5b3c0$32b11b40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH3x/DHpHRz6vxyIYATeg+eWAbDkwGsWw0jAU7CzZABPsnnMqwTomtQ
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmlu6qtx8SDeZcVLD4O+kYu8X7ZT2M
        FvOPnGO12Pj2B5PFlD/LmSw2Pb7GavGx5x6rxeVdc9gsZpzfx2Rx6vpnNotFW7+wW7TuPcJu
        cfhNO6vFv2sbWSweX//D5sDvsWbeGkaP378mMXrMauhl89i0qpPN4861PWwem5fUe1w50cTq
        0bdlFaPH501yAZxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkou
        PgG6bpk5QB8oKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJS
        S6wMDQyMTIEKE7Izrp2exFrwSqxiyYGfbA2MU4W7GDk5JARMJPYtvMHaxcjFISSwm1Hi6v5F
        zBDOJ0aJDQ/msUM43xglXvW/Z4Zpmb5iDgtEYi+jxKFDc8ESQgIvGSUmPFIGsdkEdCV2LG5j
        AykSEehklFj9/ScTSIJZYBuTxO6J2iA2p4CjxM+fvawgtrBAoMSNS3fBbBYBVYljV86xgNi8
        ApYSfeemsEPYghInZz5hgZijLbFs4WuoixQkfj5dBtYrIuAmsXbqY6gacYmXR4+AvSAh8IJD
        omXbcjaIBheJfZ/eQNnCEq+Ob2GHsKUkXva3AdkcQHa2RM8uY4hwjcTSecdYIGx7iQNXQL7n
        AJqvKbF+lz7EKj6J3t9PmCA6eSU62oQgqlUlmt9dheqUlpjY3c0KUeIh8W07ywRGxVlI/pqF
        5K9ZSO6fhbBrASPLKkbJ1ILi3PTUYtMCo7zUcnh0J+fnbmIEJ28trx2MDx980DvEyMTBeIhR
        goNZSYT3v/f7RCHelMTKqtSi/Pii0pzU4kOMpsDAnsgsJZqcD8wfeSXxhiaWBiZmZmYmlsZm
        hkrivKfTNyQKCaQnlqRmp6YWpBbB9DFxcEo1MFnl3CjJssi+XtdZL3t68j8uqd3KhWnff1+N
        vekT1ido+royhZXhi5Ja1iyX06457W7yHveve+qtqT78vGVK/daX/mriD7P/W/bEG/q4+7Dp
        7wuTck9Om2s6X+su3wNeBtHl7qVVHI1XjiTttcxsPv67/vHjiHATY/47yR7NRuFv59lMV4qI
        OGMUd2Ly4VMF4mkr673mPNps4p0jOPub3DbWqx7vfPRkf8xiyH2vYLJaQzlo5sv9KSsznE8G
        HBdo4fGcxnjZ8ohOf+bFBU3Kl9avSm74aMDD4hO/WfqeH8Oxc5treJ/vPNiud2i3D2u5wfS3
        ca6rHk/P36rMyrhHU3n/M+UnVvp/FabUzvJXYinOSDTUYi4qTgQAmQM+F2cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnK7/+w+JBt8mWFr8nXSM3eL9sh5G
        i/lHzrFabHz7g8liyp/lTBabHl9jtfjYc4/V4vKuOWwWM87vY7I4df0zm8WirV/YLVr3HmG3
        OPymndXi37WNLBaPr/9hc+D3WDNvDaPH71+TGD1mNfSyeWxa1cnmcefaHjaPzUvqPa6caGL1
        6NuyitHj8ya5AM4oLpuU1JzMstQifbsEroynv/ezFewRq2hvnc3ewPhYqIuRk0NCwERi+oo5
        LF2MXBxCArsZJdbvnMoKkZCWuL5xAjuELSyx8t9zdoii54wSU9dvYQNJsAnoSuxY3MYGkhAR
        6GaUuNIzkxHEYRY4wiTxc/8mZoiWH0CZYxNYQFo4BRwlfv7sBdshLOAvsfbBe7A4i4CqxLEr
        58BsXgFLib5zU9ghbEGJkzOfgMWZBbQlnt58CmcvW/iaGeI+BYmfT5eBzRQRcJNYO/UxVI24
        xMujR9gnMArPQjJqFpJRs5CMmoWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxN
        jOBY1tLcwbh91Qe9Q4xMHIyHGCU4mJVEeP97v08U4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh
        62S8kEB6YklqdmpqQWoRTJaJg1OqgYnnoA9jYaj7uy+p3Am9DYHXFe6Lr/h09OIWpR3XpdoZ
        O3tuxhp5hm1IenY9Ps527YOVzjeEribd/h7EqfqRReD6ceupii+ScibP3WS7T+yUxX4ufiOT
        lP0XdrHuZHDh2PZF2f+sEStra60yt9uRbz02z93qVmzjnL5kTUr/9pSN3QFOORPc7xjyn5ga
        8S1/h9wc6bDdnB/kmb6fS9gfF277Kkr8BXO/Aeu6gHapJRcKDJqfqd2v+fhz/RLDLZ9EGU2m
        KC/ZHnhQateOmDTjM+mhOueOe3NvMO0P5XVUmtJfun75poelhw5Ge+W5/ZZn0pP4Op9dqtvX
        UZt5q5LhuSL558UpDqfiLup2ql4LVWIpzkg01GIuKk4EAAp3OmJUAwAA
X-CMS-MailID: 20220126065055epcas5p48315c2def7273e9705ca9ea8efb8e2ca
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Tuesday, January 25, 2022 10:56 PM
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
>On 25/01/2022 18:12, Krzysztof Kozlowski wrote:
>> On 24/01/2022 15:16, Alim Akhtar wrote:
>>> Adds basic support for the Tesla Full Self-Driving (FSD) SoC. This
>>> SoC contains three clusters of four Cortex-A72 CPUs, as well as
>>> several IPs.
>>>
>>> Patches 1 to 9 provide support for the clock controller (which is
>>> designed similarly to Exynos SoCs).
>>>
>>> The remaining changes provide pinmux support, initial device tree suppo=
rt.
>>>
>>> - Changes since v4
>>> * fixed 'make dtbs_check' warnings on patch 14/16
>>>
>>> - Changes since v3
>>> * Addressed Stefen's review comments on patch 14/16
>>> * Fixed kernel test robot warning on patch 04/16
>>> * rebsaed this series on Krzysztof's pinmux new binding schema work
>>> =5B1=5D
>>>
>>> - Changes since v2
>>> * Addressed Krzysztof's and Stephen's review comments
>>> * Added Reviewed-by and Acked-by tags
>>> * Rebased on next-20220120
>>>
>>> - Changes since v1
>>> * fixed make dt_binding_check error as pointed by Rob
>>> * Addressed Krzysztof's and Rob's review comments
>>> * Added Reviewed-by and Acked-by tags
>>> * Dropped SPI, MCT and ADC from this series (to be posted in small
>>> sets)
>>>
>>> NOTE: These patches are based on Krzysztof's pinmux for-next branch
>>> commit 832ae134ccc1 (=22pinctrl: samsung: add support for Exynos850 and
>>> ExynosAutov9 wake-ups=22) =5B1=5D
>>> https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git/l
>>> og/?h=3Dfor-next
>>>
>>>
>>
>> Thanks, applied DTS/soc and pinctrl patches.
>>
>> I expect Sylwester will pick up the clock ones. Otherwise please let
>> me know to pick it up as well.
>
>I forgot that clock macros are used in DTS. This does not compile and I ca=
nnot
>take drivers into DTS branch.
>
>Alim,
>DTS changes dropped. Please resend with the same trick we did for
>Exynos850 board - hard-coded clock IDs as defines. See:
>
>https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/diff/arch/a=
rm6
>4/boot/dts/exynos/exynos850.dtsi?h=3Dsamsung-dt64-5.17-
>2&id=3De3493220fd3e474abcdcefbe14fb60485097ce06
>
Ok, I will resend patch 14 and 15 (DTS changes) only as suggested above.

>
>Best regards,
>Krzysztof

