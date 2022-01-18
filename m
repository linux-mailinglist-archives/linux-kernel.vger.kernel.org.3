Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A0F492904
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiARO6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:58:50 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:44709 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiARO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:58:48 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220118145846epoutp02dbe474b8999a9d5f384bcfd796b93cb9~LZVoKSWjg1521415214epoutp02H
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 14:58:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220118145846epoutp02dbe474b8999a9d5f384bcfd796b93cb9~LZVoKSWjg1521415214epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642517926;
        bh=Ylg0WEtaGPUko2HnNeH/2l42ssyOWCRP7SXhWjcIBCI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=vf98O4cVRJu66uDSVgNUVBpwRyci/LpP5XEXpXuXLdtOx9svGEYDK5qp0taQnxVIB
         4F9CLht/mwluAZE86C1vcQbExY64JmQOAKsld3JwtN5ZcazYHIq7X5q23D1sqnVN24
         zx/fV1vd+lBaX1QfugJB76iQD37966tuaAzd8D0o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220118145845epcas5p34a7c1141a3120245ba46d074f0d29f7a~LZVm3AXtM2789827898epcas5p3I;
        Tue, 18 Jan 2022 14:58:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JdX360ND1z4x9Pp; Tue, 18 Jan
        2022 14:58:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.58.05590.2A5D6E16; Tue, 18 Jan 2022 23:58:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220118145841epcas5p2fe64a99bc7698802f9cc4fb0bf5d5a32~LZVjPMJ0H3245132451epcas5p25;
        Tue, 18 Jan 2022 14:58:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220118145841epsmtrp161165c22075efbe8cb1f2bb29d64661a~LZVjOL2JZ1656016560epsmtrp1U;
        Tue, 18 Jan 2022 14:58:41 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-31-61e6d5a2f3c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.D0.08738.0A5D6E16; Tue, 18 Jan 2022 23:58:41 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220118145838epsmtip12e7842009f9befb8d78339274dce5a40~LZVg8C29q0468004680epsmtip1G;
        Tue, 18 Jan 2022 14:58:38 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <soc@kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <olof@lixom.net>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <robh+dt@kernel.org>, <s.nawrocki@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>,
        "'Shashank Prashar'" <s.prashar@samsung.com>,
        "'Aswani Reddy'" <aswani.reddy@samsung.com>
In-Reply-To: <b8040d39-cd4d-e5b0-8aec-f03c5257d63e@canonical.com>
Subject: RE: [PATCH 15/23] arm64: dts: fsd: Add initial pinctrl support
Date:   Tue, 18 Jan 2022 20:28:37 +0530
Message-ID: <023d01d80c7b$e14d4d40$a3e7e7c0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgJL1gp6AanHgoQCI2LlggH1bO0EAd3QJpGqbSOWAA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmhu6iq88SDXZvZbM4tHkru8X7ZT2M
        FvOPnGO12Pj2B5PFlD/LmSw2Pb7GavGx5x6rxcNX4RaXd81hs5hxfh+Txanrn9ksFm39wm7R
        uvcIu8XhN+2sFvN2zGW0eHz9D5uDgMeaeWsYPWY19LJ5bFrVyeZx59oeNo/NS+o9rpxoYvXo
        27KK0eNf01x2j8+b5AI4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJz
        U22VXHwCdN0yc4C+UFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfm
        pevlpZZYGRoYGJkCFSZkZxz7+5q1oEOh4sTRFrYGxhnSXYycHBICJhLtHTtYQWwhgd2MEu93
        CHQxcgHZnxglLux7zwLhfGaUeNa/lBWm487qn2wQiV2MEk0Tl7FCOC8ZJU5tec8IUsUmoCux
        Y3EbWJWIQCejxOrvP5lAHGaBVmaJM03TmUGqOAUcJXpeT2bvYuTgEBZwl9i13wMkzCKgKnHs
        zX12EJtXwFJi2/WpLBC2oMTJmU/AbGYBbYllC18zQ5ykIPHz6TKw80QEwiR23r/BDFEjLvHy
        6BF2kL0SAj84JDYvXcACsktCwEVi1hIliF5hiVfHt7BD2FISL/vb2CFKsiV6dhlDhGskls47
        xgJh20scuDIHbAqzgKbE+l36EJv4JHp/P2GC6OSV6GgTgqhWlWh+dxWqU1piYnc3NAw9JO6u
        vco8gVFxFpK/ZiH5axaS+2chLFvAyLKKUTK1oDg3PbXYtMA4L7UcHt3J+bmbGMFJXMt7B+Oj
        Bx/0DjEycTAeYpTgYFYS4ZWqf5YoxJuSWFmVWpQfX1Sak1p8iNEUGNgTmaVEk/OBeSSvJN7Q
        xNLAxMzMzMTS2MxQSZz3VPqGRCGB9MSS1OzU1ILUIpg+Jg5OqQamZUL++mcudPia5N3nZM/h
        5uvPXPa3+PgLwSi70jUSdyfnZES3VC5kX9Qyr0qwOJRPaaW49SyrIydK1BwPJ2y0SD+9Q+du
        T/a/vZ/3vRTj82OTXJGY9O3jqw2nJohFR1yPnKdo8OnIvIj6y6oBkSuDw595PAgwfvjtsJue
        WIPAnrzTATEzV01/5NxZpHZpUcNOt5O6W45Uid/2l7nk2CV4MeV1a/3HTj3XGxrPptyKV+Qr
        sm2a+/0Lk1Kwvn/JxdvPDj75Zp++60haz58tLlqN/Zvrk67tuX5qx7L2UGdpty7dhzcfTnv/
        SLo55mvKlN7DpxRWPSx+fHVSm6AG22eZG4Zz33r7f4mZoNPEt1JLiaU4I9FQi7moOBEA72uG
        X2sEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCSnO7Cq88SDU79ZLI4tHkru8X7ZT2M
        FvOPnGO12Pj2B5PFlD/LmSw2Pb7GavGx5x6rxcNX4RaXd81hs5hxfh+Txanrn9ksFm39wm7R
        uvcIu8XhN+2sFvN2zGW0eHz9D5uDgMeaeWsYPWY19LJ5bFrVyeZx59oeNo/NS+o9rpxoYvXo
        27KK0eNf01x2j8+b5AI4o7hsUlJzMstSi/TtErgy2m9cZy1ola84tGsmSwPjbKkuRk4OCQET
        iTurf7J1MXJxCAnsYJTovtnIBJGQlri+cQI7hC0ssfLfczBbSOA5o8TPlzwgNpuArsSOxW1g
        zSIC3YwSV3pmMoI4zAKTmSVeXG5kgRh7g0lixc0FbCAtnAKOEj2vJwON4uAQFnCX2LXfAyTM
        IqAqcezNfbANvAKWEtuuT2WBsAUlTs58AmYzC2hL9D5sZYSxly18zQxxnYLEz6fLWEFsEYEw
        iZ33bzBD1IhLvDx6hH0Co/AsJKNmIRk1C8moWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswt
        Ls1L10vOz93ECI5nLa0djHtWfdA7xMjEwXiIUYKDWUmEV6r+WaIQb0piZVVqUX58UWlOavEh
        RmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTNyhrRzzfj2J51Bf8NU2/teszPZ5OvN6
        N2+dKT2b3/6/rdPLp/OXvjBZaqBqu+Br3lehw6uMvuqKrLn5+u7MG3vc5dZo/5/73LNj5vyG
        oJ5JxxpDgjna7PgbDVh7Pyxd4La7is94+fGUHf/96/LeXO5lX2kW+Ccl0udH0Clm+Z83N9/u
        mPGwo3NT/P4JvM/KVm196l5y9caEbhervshfbxwu5Jlq7rcoWf5dS/3+GXat204PnnUKXJaK
        b3sSz3D61MqLchsOe0jdastb+jFHfW/UXDs+lmdHew//CjRm/rI0O51D5LaNjMKKLSvOtfzo
        SPPjdWgo2HPKYHfPvlnMtxZKVckpru0T9b9aF8bevkKJpTgj0VCLuag4EQATUZ1GVgMAAA==
X-CMS-MailID: 20220118145841epcas5p2fe64a99bc7698802f9cc4fb0bf5d5a32
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122417epcas5p47398a5190cdf4c574c6f1762918b549f
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122417epcas5p47398a5190cdf4c574c6f1762918b549f@epcas5p4.samsung.com>
        <20220113121143.22280-16-alim.akhtar@samsung.com>
        <2927c34e-3259-4e9a-a657-aeeebf9089d2@canonical.com>
        <00ca01d80ba8$6b9b9800$42d2c800$@samsung.com>
        <b8040d39-cd4d-e5b0-8aec-f03c5257d63e@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Monday, January 17, 2022 7:20 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; linus.walleij=40linaro.org; catalin.marinas=40arm.com;
>robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.com;
>'Shashank Prashar' <s.prashar=40samsung.com>; 'Aswani Reddy'
><aswani.reddy=40samsung.com>
>Subject: Re: =5BPATCH 15/23=5D arm64: dts: fsd: Add initial pinctrl suppor=
t
>
>On 17/01/2022 14:44, Alim Akhtar wrote:
>> Hi Krzysztof
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=
=5D
>>> Sent: Thursday, January 13, 2022 6:50 PM
>>> To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>>> kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>>> Cc: soc=40kernel.org; linux-clk=40vger.kernel.org;
>>> devicetree=40vger.kernel.org; olof=40lixom.net; linus.walleij=40linaro.=
org;
>>> catalin.marinas=40arm.com;
>>> robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>>> soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.co=
m;
>>> Shashank Prashar <s.prashar=40samsung.com>; Aswani Reddy
>>> <aswani.reddy=40samsung.com>
>>> Subject: Re: =5BPATCH 15/23=5D arm64: dts: fsd: Add initial pinctrl
>>> support
>>>
>>> On 13/01/2022 13:11, Alim Akhtar wrote:
>>>> Add initial pin configuration nodes for FSD SoC.
>>>>
>>>> Cc: linux-fsd=40tesla.com
>>>> Signed-off-by: Shashank Prashar <s.prashar=40samsung.com>
>>>> Signed-off-by: Aswani Reddy <aswani.reddy=40samsung.com>
>>>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>>>> ---
>>>>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 338
>>> +++++++++++++++++++++
>>>>  arch/arm64/boot/dts/tesla/fsd.dtsi         =7C  22 ++
>>>>  2 files changed, 360 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>>> b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>>> new file mode 100644
>>>> index 000000000000..ec8d944af636
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>>> =40=40 -0,0 +1,338 =40=40
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Tesla Full Self-Driving SoC device tree source
>>>> + *
>>>> + * Copyright (c) 2017-2021 Samsung Electronics Co., Ltd.
>>>> + *		https://www.samsung.com
>>>> + * Copyright (c) 2017-2021 Tesla, Inc.
>>>> + *		https://www.tesla.com
>>>> + */
>>>> +
>>>> +=23include <dt-bindings/pinctrl/samsung.h>
>>>> +
>>>> +&pinctrl_fsys0 =7B
>>>> +
>>>
>>> No need for empty line.
>>>
>> Noted
>>
>>>> +	gpf0: gpf0 =7B
>>>
>>> FYI:
>>> It's ok now, but the nodes will have to be renamed to =22xxx-gpio-bank=
=22
>later.
>>>
>> Have rebased my v2 on your pinmux schema update, so these and below
>comments are addressed.
>> Thanks
>>
>
>OK, but have in mind that -gpio-bank suffix is not needed now. This depend=
s
>on support in the pinctrl driver, which will be applied after the merge wi=
ndow
>to different tree or branches than DTS is going to.
>Therefore if I apply your DTS with =22-gpio-bank=22 to my next/dt64, the k=
ernel
>won't find GPIo banks and won't properly boot. The linux-next will be fine=
,
>just my next/dt64 won't be.
>
Thanks, got it, for now let me send v2 on linux-next (as of today).
As required I will rebase to your next/dt64 and send again.
Which also means that my v2 will not be based on your new pinmux schema.
Probably we will move to that after the merge window.

>If you're fine with it - use =22-gpio-bank=22 suffix. If you prefer my
>next/dt64 to have a fully working Tesla SoC DTS, then stick to old node na=
ming
>and let's replace it later.
>
>Best regards,
>Krzysztof

