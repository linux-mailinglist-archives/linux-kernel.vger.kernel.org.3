Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF748E4D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiANHSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:18:10 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:36369 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiANHSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:18:09 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220114071808epoutp0388374bdb90ffe89b7cff4a494ca2239f~KEeS4cHcf1752517525epoutp03O
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:18:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220114071808epoutp0388374bdb90ffe89b7cff4a494ca2239f~KEeS4cHcf1752517525epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642144688;
        bh=mwZyVBy5+IyHPv6G4VinFVblfQAbSUs/xjxl5mYuZvM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=THB4cCg0DGyPlX5/zcKp4swLchZ6iiPeq+xY5S/hOswoG+APRue41Avr8hU/Y1ocU
         ODRJYLBZF01Y4aJ/N0wYtpDS54QJjB905rAeZtQmVy3iIGnMNkgUTIFwMIP+5ge1ia
         uQsnmFu81UTk4wdvayHHJeVzf2Gea7Hwzl43FQgA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220114071807epcas5p3abd7aa9ba172fb2b76e4d84a3d54d85d~KEeSRrHfV1740217402epcas5p3l;
        Fri, 14 Jan 2022 07:18:07 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZt1P2STFz4x9Q1; Fri, 14 Jan
        2022 07:18:01 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.86.06423.8A321E16; Fri, 14 Jan 2022 16:18:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220114071800epcas5p1d8fdc4d774d79ed975118845c9b6f21e~KEeLfT0Sx1617316173epcas5p1S;
        Fri, 14 Jan 2022 07:18:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220114071800epsmtrp241117dd35de37bdf82caca7978c43a42~KEeLeOIkU1957519575epsmtrp2i;
        Fri, 14 Jan 2022 07:18:00 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-fa-61e123a83bc1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.B2.29871.8A321E16; Fri, 14 Jan 2022 16:18:00 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114071757epsmtip144c17b781bed1022921fabe39ecabf7c~KEeI78SIV0483204832epsmtip1Z;
        Fri, 14 Jan 2022 07:17:57 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>, "'Adithya K V'" <adithya.kv@samsung.com>
In-Reply-To: <0d4c7a40-5eec-2cc5-82bc-d0ba4910d665@canonical.com>
Subject: RE: [PATCH 17/23] Documentation: bindings: Add fsd spi compatible
 in dt-bindings document
Date:   Fri, 14 Jan 2022 12:47:55 +0530
Message-ID: <078e01d80916$dc613c00$9523b400$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgK0XCMbAlGXYJEBtKo/4qp/69Aw
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmhu4K5YeJBhNa1C0OTHjFavF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdq8fBVuMXlXXPYLGac38dkcer6ZzaLRVu/sFu0
        7j3CbnH4TTurxePrf9gc+D3WzFvD6DGroZfNY9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/
        muaye3zeJBfAGZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
        oOuWmQP0gJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XE
        ytDAwMgUqDAhO2PHnvVsBVMFKp7/28PSwPiNt4uRk0NCwETi2bSvrF2MXBxCArsZJb6vuc4E
        khAS+MQo8XerOUTiG6PE7S2/WWE6eh4fZ4JI7GWUmLn3ADNEx0tGiSdfYkFsNgFdiR2L29hA
        ikQEOhklVn//CdbBLHCJSeJtwyNGkCpOAUeJhf/vsYHYwgIpEjsPPwNbwSKgKjHp9SewO3gF
        LCU+btrOCGELSpyc+YQFxGYW0JZYtvA1M8RJChI/ny4D6uUA2uYmcfFxNUSJuMTLo0fYQfZK
        CHzhkPj0+QATRL2LxKbpT6F6hSVeHd/CDmFLSXx+t5cNZI6EQLZEzy5jiHCNxNJ5x1ggbHuJ
        A1fmsICUMAtoSqzfpQ+xik+i9/cTJohOXomONiGIalWJ5ndXoTqlJSZ2d0PD0EPi3IIvzBMY
        FWch+WsWkr9mIXlgFsKyBYwsqxglUwuKc9NTi00LDPNSy+HRnZyfu4kRnLq1PHcw3n3wQe8Q
        IxMH4yFGCQ5mJRHe/qL7iUK8KYmVValF+fFFpTmpxYcYTYGBPZFZSjQ5H5g98kriDU0sDUzM
        zMxMLI3NDJXEeU+nb0gUEkhPLEnNTk0tSC2C6WPi4JRqYFpuHf2sjkX/eyZbWZfzSYfg3zvU
        ebj8tNalruR7/We5h9OcvLOLF2/fu2Dzx4orWRaVv36GG7CIPD/9pkNHhuGgxFat5oUzipxF
        E5iXu6zgPXhiw5TM0s+uwlVmLYZ6+34f0XbZs+/Kzd6l81JC7afcbGMWkrz79uLeS7KrD0zy
        vT7pl5hN4ZYL2iWsevO1jvBO7ljKf/RFV7unmISYU+PGvOi9u37uu/RRbtIlwXMeD0r1WSsN
        xUtvJ13cGK1eljgn3//BspOC4rafH0/wPRHw+tj/ZT8lON6t+bxEw3j6Abu9GkcydiY1yp2r
        XOI8y/INy6LJ1XvXHIv6vC6DTfPl9/R/YWtTQjetP2Q7WdFDiaU4I9FQi7moOBEAXh7XTGYE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnO4K5YeJBocucFocmPCK1eL9sh5G
        i/lHzrFabHz7g8liyp/lTBabHl9jtfjYc4/V4uGrcIvLu+awWcw4v4/J4tT1z2wWi7Z+Ybdo
        3XuE3eLwm3ZWi8fX/7A58HusmbeG0WNWQy+bx6ZVnWwed67tYfPYvKTe48qJJlaPvi2rGD3+
        Nc1l9/i8SS6AM4rLJiU1J7MstUjfLoEro6GhmbXgLn/F8jsTWRoY9/F2MXJySAiYSPQ8Ps7U
        xcjFISSwm1Fi8bXFjBAJaYnrGyewQ9jCEiv/PWeHKHrOKDF36XZWkASbgK7EjsVtbCAJEYFu
        RokrPTMZQRxmgQdMEmvOLGeDaPnKKLH221ImkBZOAUeJhf/vASU4OIQFkiT+z4sHCbMIqEpM
        ev0JrIRXwFLi46btjBC2oMTJmU9YQGxmAW2J3oetjDD2soWvmSHOU5D4+XQZK8hIEQE3iYuP
        qyFKxCVeHj3CPoFReBaSSbOQTJqFZNIsJC0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXr
        JefnbmIER7GW5g7G7as+6B1iZOJgPMQowcGsJMLbX3Q/UYg3JbGyKrUoP76oNCe1+BCjNAeL
        kjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYm677/sjqbtlUsvtGw5mqY44vs1Ze38jMK+sr+
        NEj2XS/emrbh2cmA+Qov3/5c8ct1S2G9y+TkmLtq8ySPvN2YcfyU8P8yrSdeczMqRcK/TlG3
        L398j33m10e7jhTMCa4UdX9eHsl1ienEvwmTEnvVd315Hse6bBLPFu+98RWrZ5qGfAt1slyn
        dslIc55Tf++S+eVqsgvYXC4bH4u/UvDkwIVkWeYzm2VPLp7o3PKtso7nh2DTw99/Zb6rHDuk
        uDXzUN/2bbMzX7fYbLg+Z+66NUZftj79MPGEik/QS+tpj3bttopbfuC5z8/LDxIPpyr/3F8i
        VLT6wuOSP3KChgEyt+rffD0+QWOXpKVXoqEBq7QSS3FGoqEWc1FxIgBiVJmLUQMAAA==
X-CMS-MailID: 20220114071800epcas5p1d8fdc4d774d79ed975118845c9b6f21e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122427epcas5p1885d8b3b735e8f127b6694a309796e5a
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122427epcas5p1885d8b3b735e8f127b6694a309796e5a@epcas5p1.samsung.com>
        <20220113121143.22280-18-alim.akhtar@samsung.com>
        <0d4c7a40-5eec-2cc5-82bc-d0ba4910d665@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Thursday, January 13, 2022 6:55 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; linus.walleij=40linaro.org; catalin.marinas=40arm.com;
>robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.com;
>Adithya K V <adithya.kv=40samsung.com>
>Subject: Re: =5BPATCH 17/23=5D Documentation: bindings: Add fsd spi compat=
ible
>in dt-bindings document
>
>On 13/01/2022 13:11, Alim Akhtar wrote:
>> This patch adds spi controller dt-binding compatible information for
>> Tesla Full Self-Driving SoC.
>>
>> Cc: linux-fsd=40tesla.com
>> Signed-off-by: Adithya K V <adithya.kv=40samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-samsung.txt =7C 1 +
>>  1 file changed, 1 insertion(+)
>>
>
>Also: subject prefix:
>spi: dt-bindings: samsung:
>
Ok, will update and rebase on your upcoming dt schema patch set.

>> diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> b/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> index 49028a4f5df1..3af2408454b4 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
>> =40=40 -11,6 +11,7 =40=40 Required SoC Specific Properties:
>>      - samsung,s5pv210-spi: for s5pv210 and s5pc110 platforms
>>      - samsung,exynos5433-spi: for exynos5433 compatible controllers
>>      - samsung,exynos7-spi: for exynos7 platforms <DEPRECATED>
>> +    - tesla,fsd-spi: spi controller support for Tesla Full
>> + Self-Driving SoC
>>
>>  - reg: physical base address of the controller and length of memory map=
ped
>>    region.
>>
>
>
>Best regards,
>Krzysztof

