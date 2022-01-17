Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482994909B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbiAQNpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:45:12 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:53794 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiAQNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:45:06 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220117134505epoutp047b6ce01dfe5e13c82e0a793908316830~LEsAJxRkC0561705617epoutp04G
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:45:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220117134505epoutp047b6ce01dfe5e13c82e0a793908316830~LEsAJxRkC0561705617epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642427105;
        bh=P9imqKvslcA+cZOU0mvTMWnovqPbsTO5Tpzlt9qvTYE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=O+UcqK/3ojBidTUsXZHidqxlnS0Cb8akjN6nNRCuPeUAKSYaNMAPk96y8FdEa8pME
         ZrxDy1bwFSMw0rOGQ7K2ezpo8P1ARdj71uGe2xybJJc3/q+uwrrlVzUyKbsgBIpUcU
         QrIOPQsTTudPhJoU3+Rhnd2Hj1a/bP1/FVd374BY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220117134504epcas5p4d08d61bbc64bba85647bc65cfff27f41~LEr-fzVKy3152631526epcas5p4x;
        Mon, 17 Jan 2022 13:45:04 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JctSX6LJpz4x9Q1; Mon, 17 Jan
        2022 13:45:00 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.49.46822.FA275E16; Mon, 17 Jan 2022 22:44:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220117134459epcas5p2f356d000f3a790c65926167cd6ddd7f5~LEr7Q97pr0193501935epcas5p2F;
        Mon, 17 Jan 2022 13:44:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220117134459epsmtrp102d38f3fdbbb8f2b49831a85a9274104~LEr7P-Nps2968729687epsmtrp1a;
        Mon, 17 Jan 2022 13:44:59 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-65-61e572af5bb8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.BA.08738.BD275E16; Mon, 17 Jan 2022 22:44:59 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220117134456epsmtip2096fdabe7eff909cc7028861c76650cf~LEr4IDtRX1286912869epsmtip2_;
        Mon, 17 Jan 2022 13:44:56 +0000 (GMT)
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
In-Reply-To: <2927c34e-3259-4e9a-a657-aeeebf9089d2@canonical.com>
Subject: RE: [PATCH 15/23] arm64: dts: fsd: Add initial pinctrl support
Date:   Mon, 17 Jan 2022 19:14:53 +0530
Message-ID: <00ca01d80ba8$6b9b9800$42d2c800$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgJL1gp6AanHgoQCI2LlgqqKGQKQ
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxzN19veXnDFa4H4CXOrd8PXArY8ulsnwrYGrzImgSXE/TG4gZtC
        KL1dH0yNmyiTl4DDMB8NomPCJmMbFhAsDg2t5eVgOp6JskEhBlxRXgEmc2u5bOO/8zs55/xy
        vgeGiAdRPyxNY2B0GlpNoJ78G9Yd2wJrdeO01LqZbK1rEJJPqwoBednWLSCvOxd5ZOnyNzzS
        7OgXkNOFwwJyZDKB/NVShpIXelp4ZOfALEpWNMwJyVM/2YSk9Y9cAVnedAmQjoFlNBKnaspr
        AGXKKkIpc3U+Sj3sv4VSdVePU73tJwVUcX01oF6cvCSkZs2vxHp8mL4nlaFTGJ2E0SSzKWka
        VTgRHZ/4bmKYXCoLlCnINwmJhs5gwgnle7GBUWlqVwlCkkmrjS4qltbriV179+hYo4GRpLJ6
        QzjBaFPU2lBtkJ7O0Bs1qiANY9gtk0qDw1zCpPTUvhedQm1p/GGbbQRkgfF3CoAHBvFQmD9/
        Hi0AnpgYbwZwsPkhjxtmAJzKLRBwwyyATmejS4atWIYe8zneAuBF6+cIN0wAWNrchrhzUTwQ
        Nn2ds5Lrg+cD+N3C0kougp9C4P2WIb5b5YG/Dc/0FwN3rDe+D1puU26ajwfA3gdNQjcW4QrY
        lX8f4fAG2HFxbMWK4G/Aqq+eIFwJCVwarxK4sQ8eBStv/ryq2Qgn7tqE7r0Qf4bBoW/NfM6g
        hLMjc6vYG0621Qs57AcnzuQIuZrpsNASwtHHYGW5fVUeAe/0lvHdEgTfAX+07OJWecGi52M8
        zimCeTliTh0As6f6Vp3+sOT0aQGHKfjo+z7kC7DFtKaYaU0x05oCpv+XXQH8arCJ0eozVIw+
        TBusYT75776T2QwzWHniOw80gZHfnwW1Ah4GWgHEEMJHZF83RotFKfSRo4yOTdQZ1Yy+FYS5
        TrsE8fNNZl1/RGNIlIUqpKFyuTxUESKXERtFXapaWoyraAOTzjBaRvevj4d5+GXxotdfT1pa
        FxfDJtT+svdc93nPuGuR9rmaOwicf2urytntuNcT3PPysb+H7V7k4uvqUeWBEwdFdmq6eaa+
        sXd7m+/63Qmx2+bhVPvBpufDn1rOsosf3Z1sDCiOwLwev1bhfIlpr5XqwrytC49y8zZZszqv
        dj543yEu+/LyXzeVy+zy5jTU/4PtM6PK+bqI9Ns3DkllnYd9+5Js7LWt51izrTLybLzR/6ii
        JfXQgjbbmfc0oLVjVJc2SjYwJySCwg0xkuhbRdoBx5Ut3iX5IeIgnk/HZ0P75QPiaZNfR2b2
        YF9VlXH/n9EVrzriFL8dcdR33RvGTD9ExVyA+54ct8URmR8TfH0qLduJ6PT0PwUiASprBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvO7toqeJBld/6lkc2ryV3eL9sh5G
        i/lHzrFabHz7g8liyp/lTBabHl9jtfjYc4/V4uGrcIvLu+awWcw4v4/J4tT1z2wWi7Z+Ybdo
        3XuE3eLwm3ZWi3k75jJaPL7+h81BwGPNvDWMHrMaetk8Nq3qZPO4c20Pm8fmJfUeV040sXr0
        bVnF6PGvaS67x+dNcgGcUVw2Kak5mWWpRfp2CVwZk/9sZyzY6F/RuKiPsYGxxb6LkYNDQsBE
        4uZzli5GLg4hgR2MEu1ne1m7GDmB4tIS1zdOYIewhSVW/nvODlH0nFFix9TnYEVsAroSOxa3
        sYEkRAS6GSWu9MxkBEkwC0xmlmibpA/R8ZVR4tWu+2CjOAUcJfqv9TGCrBYWcJfYtd8DJMwi
        oCpx5dIOsBJeAUuJ050XmSFsQYmTM5+wQMzUluh92MoIYy9b+JoZ4joFiZ9Pl4EdJCLgJrF0
        51moenGJl0ePsE9gFJ6FZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnp
        esn5uZsYwdGspbWDcc+qD3qHGJk4GA8xSnAwK4nwHuN+kijEm5JYWZValB9fVJqTWnyIUZqD
        RUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD04x7XbqOaya9Kijt9YiS3TGhVK4j+0uc6+dQ
        efuEF4bvrR4Xrt2RqXWgwvZNyf6CRck/Xj6497Ppq89znloGRs9LIlLBOntdlwZyVy38KrxR
        IyXXd9mqqNDl6wotNp4JMFrwYaXVN6fJv9cWmTLeP/1mk+T50CwFpkUzNTacYxBVMPpvxZE2
        Y9eiDSlGWzbGb2v9MDEvsimRWeXbWhnJ2ecCfBP+zfue36c4YVXAt9VZNSGn6vPPxCdx5rNN
        +L80KoDpsqLG9pe6cUzXfN9KyV99bh9gdUS8Z+er3DR3i2YprQ1rlxTl9dcmhTlOldwiXFZw
        rPv11+uJiWnVcQmmxfstN9QrfZl+95+60IHZSizFGYmGWsxFxYkAhodyOFUDAAA=
X-CMS-MailID: 20220117134459epcas5p2f356d000f3a790c65926167cd6ddd7f5
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

>-----Original Message-----
>From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40canonical.com=5D
>Sent: Thursday, January 13, 2022 6:50 PM
>To: Alim Akhtar <alim.akhtar=40samsung.com>; linux-arm-
>kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
>Cc: soc=40kernel.org; linux-clk=40vger.kernel.org; devicetree=40vger.kerne=
l.org;
>olof=40lixom.net; linus.walleij=40linaro.org; catalin.marinas=40arm.com;
>robh+dt=40kernel.org; s.nawrocki=40samsung.com; linux-samsung-
>soc=40vger.kernel.org; pankaj.dubey=40samsung.com; linux-fsd=40tesla.com;
>Shashank Prashar <s.prashar=40samsung.com>; Aswani Reddy
><aswani.reddy=40samsung.com>
>Subject: Re: =5BPATCH 15/23=5D arm64: dts: fsd: Add initial pinctrl suppor=
t
>
>On 13/01/2022 13:11, Alim Akhtar wrote:
>> Add initial pin configuration nodes for FSD SoC.
>>
>> Cc: linux-fsd=40tesla.com
>> Signed-off-by: Shashank Prashar <s.prashar=40samsung.com>
>> Signed-off-by: Aswani Reddy <aswani.reddy=40samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>> ---
>>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 338
>+++++++++++++++++++++
>>  arch/arm64/boot/dts/tesla/fsd.dtsi         =7C  22 ++
>>  2 files changed, 360 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>> b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>> new file mode 100644
>> index 000000000000..ec8d944af636
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
>> =40=40 -0,0 +1,338 =40=40
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Tesla Full Self-Driving SoC device tree source
>> + *
>> + * Copyright (c) 2017-2021 Samsung Electronics Co., Ltd.
>> + *		https://www.samsung.com
>> + * Copyright (c) 2017-2021 Tesla, Inc.
>> + *		https://www.tesla.com
>> + */
>> +
>> +=23include <dt-bindings/pinctrl/samsung.h>
>> +
>> +&pinctrl_fsys0 =7B
>> +
>
>No need for empty line.
>
Noted

>> +	gpf0: gpf0 =7B
>
>FYI:
>It's ok now, but the nodes will have to be renamed to =22xxx-gpio-bank=22 =
later.
>
Have rebased my v2 on your pinmux schema update, so these and below comment=
s are addressed.
Thanks

>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpf1: gpf1 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpf6: gpf6 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpf4: gpf4 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpf5: gpf5 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +=7D;
>> +
>> +&pinctrl_peric =7B
>> +
>
>No need for empty line.
>
>> +	gpc8: gpc8 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpf2: gpf2 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpf3: gpf3 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpd0: gpd0 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpb0: gpb0 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpb1: gpb1 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpb4: gpb4 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpb5: gpb5 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpb6: gpb6 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpb7: gpb7 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpd1: gpd1 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpd2: gpd2 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpd3: gpd3 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpg0: gpg0 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpg1: gpg1 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpg2: gpg2 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpg3: gpg3 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpg4: gpg4 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpg5: gpg5 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpg6: gpg6 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	gpg7: gpg7 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +
>> +		interrupt-controller;
>> +		=23interrupt-cells =3D <2>;
>> +	=7D;
>> +
>> +	pwm0_out: pwm0-out =7B
>
>All pin configuretion node names with =22-pins=22 suffix. Upcoming dtschem=
a will
>require this.
>
>> +		samsung,pins =3D =22gpb6-1=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV2>;
>> +	=7D;
>> +
>> +	pwm1_out: pwm1-out =7B
>> +		samsung,pins =3D =22gpb6-5=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV2>;
>> +	=7D;
>> +
>> +	hs_i2c0_bus: hs-i2c0-bus =7B
>> +		samsung,pins =3D =22gpb0-0=22, =22gpb0-1=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	hs_i2c1_bus: hs-i2c1-bus =7B
>> +		samsung,pins =3D =22gpb0-2=22, =22gpb0-3=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	hs_i2c2_bus: hs-i2c2-bus =7B
>> +		samsung,pins =3D =22gpb0-4=22, =22gpb0-5=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	hs_i2c3_bus: hs-i2c3-bus =7B
>> +		samsung,pins =3D =22gpb0-6=22, =22gpb0-7=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	hs_i2c4_bus: hs-i2c4-bus =7B
>> +		samsung,pins =3D =22gpb1-0=22, =22gpb1-1=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	hs_i2c5_bus: hs-i2c5-bus =7B
>> +		samsung,pins =3D =22gpb1-2=22, =22gpb1-3=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	hs_i2c6_bus: hs-i2c6-bus =7B
>> +		samsung,pins =3D =22gpb1-4=22, =22gpb1-5=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	hs_i2c7_bus: hs-i2c7-bus =7B
>> +		samsung,pins =3D =22gpb1-6=22, =22gpb1-7=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	uart0_data: uart0-data =7B
>> +		samsung,pins =3D =22gpb7-0=22, =22gpb7-1=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	uart1_data: uart1-data =7B
>> +		samsung,pins =3D =22gpb7-4=22, =22gpb7-5=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	spi0_bus: spi0-bus =7B
>> +		samsung,pins =3D =22gpb4-0=22, =22gpb4-2=22, =22gpb4-3=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	spi1_bus: spi1-bus =7B
>> +		samsung,pins =3D =22gpb4-4=22, =22gpb4-6=22, =22gpb4-7=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +
>> +	spi2_bus: spi2-bus =7B
>> +		samsung,pins =3D =22gpb5-0=22, =22gpb5-2=22, =22gpb5-3=22;
>> +		samsung,pin-function =3D <EXYNOS_PIN_FUNC_2>;
>> +		samsung,pin-pud =3D <EXYNOS_PIN_PULL_UP>;
>> +		samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
>> +	=7D;
>> +=7D;
>> +
>> +&pinctrl_pmu =7B
>> +
>
>No need for empty line.
>
>> +	gpq0: gpq0 =7B
>> +		gpio-controller;
>> +		=23gpio-cells =3D <2>;
>> +	=7D;
>
>
>
>
>Best regards,
>Krzysztof

