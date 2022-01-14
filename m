Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB048E3D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiANFl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:41:27 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32672 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiANFl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:41:26 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220114054124epoutp01118b112954c42c1f53d9a53df5ec5a24~KDJ1q5eGa2434924349epoutp01U
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:41:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220114054124epoutp01118b112954c42c1f53d9a53df5ec5a24~KDJ1q5eGa2434924349epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642138884;
        bh=/FXwud78es4MBfO4UlGQ8wrQ9YewPJ+B5Vg8EYAyvwg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=kho3NqH+6VDx9ihmSW6c9S5xd3O/10NwENSMDwKsspzD3STZxeVotrd0KbrV6n+40
         qsqBah7MbfXiiLq2fbSYkIwyVcr8QnySX6PHl0WSjciIv3qf5VSlWXJvZfvv9QQPtW
         Z4zF1pMtACxOd1aovJ1M/3fPa0wgAHLYupKL0w/I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220114054123epcas5p264312a7e9c511f6e74ded4f800d1ebc3~KDJ1CeeqH0611706117epcas5p2z;
        Fri, 14 Jan 2022 05:41:23 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZqsn0y3Gz4x9Pw; Fri, 14 Jan
        2022 05:41:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.5A.06423.2FC01E16; Fri, 14 Jan 2022 14:41:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220114054105epcas5p3299919dbc06f7f81c47823f9ec1f9fa5~KDJkfL9Y31145711457epcas5p3O;
        Fri, 14 Jan 2022 05:41:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220114054105epsmtrp108cc8d570ebc84bc8ce09faf10ac046d~KDJkeKdNy1627616276epsmtrp1E;
        Fri, 14 Jan 2022 05:41:05 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-02-61e10cf2f38c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.BA.08738.1FC01E16; Fri, 14 Jan 2022 14:41:05 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114054103epsmtip251180e9bce2eb4746163fc82b77ad6e4~KDJieLVaC2037520375epsmtip2d;
        Fri, 14 Jan 2022 05:41:03 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <arnd@arndb.de>
In-Reply-To: <d1a852e1-c4c2-b7c4-ddeb-7fbcfd9b4e58@canonical.com>
Subject: RE: [PATCH 00/23] Add support for Tesla Full Self-Driving (FSD) SoC
Date:   Fri, 14 Jan 2022 11:11:02 +0530
Message-ID: <076001d80909$52d201c0$f8760540$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkSwuX8HmyDmPKQ23UdXg863/rMwKuNmZ/AtfuwUqsnUcFMA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOd057WtSSQ2Hzk13smigTUqD2woHQ3WDbIZiAmb/mEnYGZwUp
        bXPaKm4zgotsBZRLcEJx1MukiGWyjttAnAF0ji5cBCosKgOUrKjgqApoXdb2sI1/z/t8z/O9
        z/td+KhwAAvn52iNNKOlNGJsHaetd1ukZHHDFBVrfxhCPK+8yiMW6ksBYe0b4BI/PFhGiCqv
        DSEcMy4u8VfpbS4x0nkCI6oHLyFE/w0PRpxufcQjDnf38Yje+19xiZkbXuytYNJeZwfks6eV
        gLQUHMFIR6MZI2+6LmLkj98dJEevHeKSR1saAelxvJoe9GFuYjZNZdGMiNZm6rJytGqVOPWD
        jKQMhTJWKpHGE3FikZbKo1Xi5B3pkvdyNL7wYtFeSmPyUemUwSCOeSOR0ZmMtChbZzCqxLQ+
        S6OX66MNVJ7BpFVHa2ljgjQ2drvCJ/w4N3vBOQ30NkF+k7MWKwDH1xcDPh/icnjWpigG6/hC
        vAvAc4s3EbZYBHCq6hGHLTwAPnY08YpBUMAxUTiKsQudAM46S1C2cANYN/098KswXAI7zhQF
        VGG4GcDzSyuBjVH8NAKHzA2IXxWEvw3dS5Mcf5JQfAecbX7dT3PwLfBYSw3qpwV4PBxw5ftp
        AR4Cf625w/FjFI+C9afuoWwiEVy5W8/14zD8Hfhk+ijCajZC95W+1dT3+fA3B5/FyfCk5x5g
        cSic+6VlVRMO3WVFPPZccmFpp4ylv4Bn665yWPwmvDx6IhAYxbfBC50xbKdgeOTZHYR1CuDX
        RUJWvQV+OT+26nwJVpSUcFlMwtbfrdxy8JplzVyWNXNZ1uS3/N/sJOA0gk203pCnpg0KvVRL
        7/vvtjN1eQ4QeNiRKR3g1h8Po3sAwgc9APJRcZigjJmkhIIsav9nNKPLYEwa2tADFL6zrkDD
        X8jU+X6G1pghlcfHypVKpTxeppSKNwqc6mZKiKspI51L03qa+deH8IPCC5CuMFuEMsLROzPX
        HffymYPP+11Pq4ZcB/CxivZdOfbZfNfxd5etyeM7VxSH0DlJc1b/Jy9aHpgqPQnWT/90jjkT
        W283XQlPddS9P64fb96tc0V7vlWkPbnA1IscE6rr3WnztT0Rqu17nPsbE9t0FcxS2d7yoaT8
        TeqUqHMhIybXhq3VYzXW+YTBV1IW5vbggtT1URcVl9DKhp+u75YdSB6MImTnlzUlDcGbucPt
        S5tDZT87LqeIQrlJ7iatMO6jql1/20MnhocPm7pFhd90rZR6q2XW9llL+bWiSVkMY/v81jEh
        2bJzZF9tZBrP2x5cyDHPdD0eGZpsy/FO3U0353eIOYZsShqJMgbqH/9TB+xhBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvO5HnoeJBleWmVj8nXSM3eL9sh5G
        i/lHzrFabHz7g8liyp/lTBabHl9jtfjYc4/V4vKuOWwWM87vY7I4df0zm8WirV/YLVr3HmG3
        OPymndXi8fU/bA58HmvmrWH0+P1rEqPHrIZeNo9NqzrZPO5c28PmsXlJvceVE02sHn1bVjF6
        fN4kF8AZxWWTkpqTWZZapG+XwJWxrH8DU0Ebb8XPuYsZGxi/cHUxcnJICJhI3Gy8wtbFyMUh
        JLCDUWLmkSfMEAlpiesbJ7BD2MISK/89Z4coes4osWvXXTaQBJuArsSOxW1g3SIC3YwSV3pm
        MoI4zALrmCRW7JjDBNFymFHiTNsKRpAWTgFHiZff77N0MXJwCAv4SDzboAESZhFQlZi6ZSYz
        SJhXwFLi3LUKkDCvgKDEyZlPWEBsZgFtid6HrYww9rKFr6EuVZD4+XQZK4gtIuAk8e1RHxNE
        jbjEy6NH2CcwCs9CMmoWklGzkIyahaRlASPLKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT8
        3E2M4OjV0trBuGfVB71DjEwcjIcYJTiYlUR4+4vuJwrxpiRWVqUW5ccXleakFh9ilOZgURLn
        vdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXA1P2udpLXih0/qhN+Spq+L9hWOiNnp0IXq0FG+Tn2
        /9px+jU8Swuf3jG6tXiDY/4DNqkLsQaR373enljxZOoU2SsH1ezaf3xUueTQlPj6bs99PuH6
        s/4G+7zSt8l+t5NtD7rc3rd9e9gprezePwH3O7r22on7W+iuiK3PUDl1OePqDYHmkulxwfa/
        NmvpvzuVO2uH9nxn09OsL+LDpxX7Rk7SNJhpX7RAZH/YdunkSxbeRib/mjbPfhDzo7bgWd3+
        zap98e79LseFAi8L1yx5dU3O9xzfgcnfXrD68Wwq3bKqcXbE0vIK4Szt1dsPVR8L5Z66+L2p
        0d4T9cpR+s43Lwu8+aujkj9f6sC8C+/dlViKMxINtZiLihMBzChR500DAAA=
X-CMS-MailID: 20220114054105epcas5p3299919dbc06f7f81c47823f9ec1f9fa5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4
References: <CGME20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4@epcas5p1.samsung.com>
        <20220113121143.22280-1-alim.akhtar@samsung.com>
        <d1a852e1-c4c2-b7c4-ddeb-7fbcfd9b4e58@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Thursday, January 13, 2022 6:02 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; linus.walleij=40linaro.org; catalin.marinas=40arm.com;
>robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>soc=40vger.kernel.org; pankaj.dubey=40samsung.com
>Subject: Re: =5BPATCH 00/23=5D Add support for Tesla Full Self-Driving (FS=
D) SoC
>
>On 13/01/2022 13:11, Alim Akhtar wrote:
>> This patch set adds basic support for the Tesla Full Self-Driving
>> (FSD) SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
>> as well as several IPs.
>>
>> Patches 1 to 8 provide support for the clock controller (which is
>> designed similarly to Exynos SoCs).
>>
>> The remaining changes provide pinmux support, initial device tree
>> support, and SPI, ADC, and MCT IP functionality.
>
>Does FSD have some version number? The FDS, especially in compatibles,
>looks quite generic, so what will happen if a newer SoC comes later? You
>would have:
> - tesla,fsd-pinctrl
> - tesla,fsd-xxxx-pinctrl (where xxxx could be some new version)
>
>This will be extra confusing, because fsd-pinctrl looks like the generic o=
ne,
>while it is specific...
>
AFAIK, there is no version for FSD SoC (like we see on Exynos or any other =
SoC)
In case something comes in future, may be just adopt as Olof suggested in t=
he other thread like fsd2 etc..
>Best regards,
>Krzysztof

