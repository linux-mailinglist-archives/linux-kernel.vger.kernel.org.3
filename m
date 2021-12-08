Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F8746CFD6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhLHJQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:16:54 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:61474 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhLHJQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:16:50 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211208091317epoutp01fb04fd50f3d7b77a2267fd8a16ab40a9~_vLRQeEVD2959429594epoutp01p
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 09:13:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211208091317epoutp01fb04fd50f3d7b77a2267fd8a16ab40a9~_vLRQeEVD2959429594epoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1638954797;
        bh=6VBnbLr5EcNm6LxO+sVCmqE04fcqtx6aOeVwvJwiwo8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=EGtv/VVVcvPjyfPx4KMD0+7ggab3lVYCrkIlTo4dywIjxGKKNEWFvPVX1pAjf94im
         gSKwHIMd27UPcQDUjp+UmC3bGZa1QWzVwuYI1qnyXLylDdOK0edltQhKx8i15uTc0r
         DKwpVBaTgbsbtqR0dSL5pkyR2o+04zXKmWRAXiJw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20211208091316epcas2p22926dee4e50f22573355d7eb9f3a7689~_vLQxGED01695116951epcas2p2h;
        Wed,  8 Dec 2021 09:13:16 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4J8BKL1Gltz4x9Q3; Wed,  8 Dec
        2021 09:13:10 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.17.10018.02770B16; Wed,  8 Dec 2021 18:13:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20211208091303epcas2p4e0d9eca2b9976015fa840d4c0561eee5~_vLE3vKSj0915709157epcas2p4H;
        Wed,  8 Dec 2021 09:13:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211208091303epsmtrp1b72fa62a647758466809abfef070a12d~_vLE2m2Nk1209712097epsmtrp1r;
        Wed,  8 Dec 2021 09:13:03 +0000 (GMT)
X-AuditID: b6c32a46-a25ff70000002722-32-61b07720616b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6E.F0.29871.F1770B16; Wed,  8 Dec 2021 18:13:03 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211208091303epsmtip1e6fec0e7e52f195257aff196e1ea0a57~_vLEoperi3197831978epsmtip1t;
        Wed,  8 Dec 2021 09:13:03 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>,
        "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Olof Johansson'" <olof@lixom.net>
Cc:     "'Jaewon Kim'" <jaewon02.kim@samsung.com>,
        "'David Virag'" <virag.david003@gmail.com>,
        "'Youngmin Nam'" <youngmin.nam@samsung.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>
In-Reply-To: <14731ee8-bc9a-8973-2bcf-e7a771ac3c07@canonical.com>
Subject: RE: [PATCH v3 0/5] soc: samsung: Add USI driver
Date:   Wed, 8 Dec 2021 18:13:03 +0900
Message-ID: <02a001d7ec13$ce088e80$6a19ab80$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJqUxbh1QCt+OxulIgHHWgadF9h5gF5SxqWAadkv+QCbflt2arXCXkA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmha5C+YZEg9ZX3BZ/Jx1jt5h/5Byr
        RfPi9WwWOxqOsFpsfPuDyWLT42usFpd3zWGzmHF+H5PFmcW97Banrn9ms2jde4Td4nkfUOz4
        +8eMFosPfGJ34PP4/WsSo8eshl42j52z7rJ7bFrVyeZx59oeNo/9c9ewe2xeUu9x5UQTq0ff
        llWMHp83yQVwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
        6Lpl5gB9oKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2x
        MjQwMDIFKkzIzvix8RdTwQbDiqMXfrA1ME5X72Lk4JAQMJFYPT+ji5GLQ0hgB6PEh2OLmCCc
        T4wSkz79Z4dwvjFKrH1znLGLkROsY8rV2YwQib2MEjcbVkNVvWCUWNX7mh2kik1AX+JlxzZW
        EFtEoJNRYvKsGpAiZoETzBIXN39jAklwCjhKfLv5gQ3EFhawkJjXPJ0ZxGYRUJH4e28ZC4jN
        K2ApceDNPXYIW1Di5MwnYHFmAW2JZQtfM0OcpCDx8+kyqGVuEpMvPmSHqBGRmN3ZxgyyWELg
        DYfEse8QQyUEXCRePzrBCmELS7w6voUdwpaSeNnfxg7R0M0o0froP1RiNaNEZ6MPhG0v8Wv6
        FlZQ8DELaEqs36UPCUlliSO3oG7jk+g4/JcdIswr0dEmBNGoLnFg+3SoC2Qluud8Zp3AqDQL
        yWezkHw2C8kHsxB2LWBkWcUollpQnJueWmxUYASP7eT83E2M4NSt5baDccrbD3qHGJk4GA8x
        SnAwK4nwqj1cmyjEm5JYWZValB9fVJqTWnyI0RQY1hOZpUST84HZI68k3tDE0sDEzMzQ3MjU
        wFxJnNcrZUOikEB6YklqdmpqQWoRTB8TB6dUA1P6pjLP+RreG4yvG++4EyB6pp0jKnSqfyPH
        iV8PumQan045aaYoOe30Nq0/T9y+VHunX+m4qi/vIepqsURTTGKxdtKsii9lL9av+3GlqtlW
        qnS1/P786ar19c8zHP5a8yhpCjXVlwobqv5WqH6tqbBS0vGDscqbsuK8GSsUV04uZ9JnEjzX
        LBtttHp3sfwM1sS/0Wez3i9yY1zSrXNL4S1P712Z6ugPv+esfRBi03XnWsvGB5O/+zOLVMfx
        pbVUCKXtY/rFV7py6fJGpnPPjvEwRfDwzXh8cVHF/Ef5OYf+fH6txvl4oY9ZLrvzT/aD+767
        6IquSlZIeHivs1/g4e3ufWYtB525eheXvWOcrsRSnJFoqMVcVJwIABvMiZZmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnK58+YZEg3cn1C3+TjrGbjH/yDlW
        i+bF69ksdjQcYbXY+PYHk8Wmx9dYLS7vmsNmMeP8PiaLM4t72S1OXf/MZtG69wi7xfM+oNjx
        948ZLRYf+MTuwOfx+9ckRo9ZDb1sHjtn3WX32LSqk83jzrU9bB77565h99i8pN7jyokmVo++
        LasYPT5vkgvgiuKySUnNySxLLdK3S+DK2LW0lalgsWHFlTNd7A2Mb9S6GDk5JARMJKZcnc3Y
        xcjFISSwm1Fi744tTBAJWYln73awQ9jCEvdbjrBCFD1jlFjw5wYrSIJNQF/iZcc2sISIQDej
        xJu9+1lAHGaBC8wSdxsuMEO0/GKU6Ny0hw2khVPAUeLbzQ9gtrCAhcS85unMIDaLgIrE33vL
        WEBsXgFLiQNv7rFD2IISJ2c+AYszC2hLPL35FM5etvA1M8R9ChI/ny4DO0lEwE1i8sWH7BA1
        IhKzO9uYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95Pzc
        TYzgWNbS3MG4fdUHvUOMTByMhxglOJiVRHjVHq5NFOJNSaysSi3Kjy8qzUktPsQozcGiJM57
        oetkvJBAemJJanZqakFqEUyWiYNTqoFpYprfzQuBj1wO5s+vv6/a3pjRoCJc//C05qIZ3nuO
        RBxv6tb9Zmzg4rlb+O5EhsZloYu0s36/PLnwmfSmG51ZdxrUuXp5L7oU8Zdm+6txb2wxW3Uk
        SWHiZ6uP+QxRZZ17rnw+efrazqlbrrm4nHj8Pq54ZvrNycuTo5sitzNf3C8W+snk5LYAm7B/
        LRVrdM0T/6bYt9xKO+0k+Z5l8dnXCi+MWTQDI9RuqOSdmfpFWDJp6kP722VHumZyCH9iiHv0
        12aNa+KJNx+yuV+c9Xr8W0nUPO8C2/XohOokkeen9NTdZrU561m9frzj+49Ztn/nfrT8XFNn
        vdH085PyhKNdsybaiVea/LF4w/r5t76WEktxRqKhFnNRcSIAQOUudFQDAAA=
X-CMS-MailID: 20211208091303epcas2p4e0d9eca2b9976015fa840d4c0561eee5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211206182351epcas2p4b381b620bb0f7f7928857b7003f7e83c
References: <20211204195757.8600-1-semen.protsenko@linaro.org>
        <fb31a159-6d2e-6c9a-439f-f19ef4fd4732@canonical.com>
        <CGME20211206182351epcas2p4b381b620bb0f7f7928857b7003f7e83c@epcas2p4.samsung.com>
        <14731ee8-bc9a-8973-2bcf-e7a771ac3c07@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40canonical.com>
> Sent: Tuesday, December 7, 2021 3:24 AM
> To: Arnd Bergmann <arnd=40arndb.de>; Olof Johansson <olof=40lixom.net>
> Cc: Jaewon Kim <jaewon02.kim=40samsung.com>; Chanho Park
> <chanho61.park=40samsung.com>; David Virag <virag.david003=40gmail.com>;
> Youngmin Nam <youngmin.nam=40samsung.com>; Sam Protsenko
> <semen.protsenko=40linaro.org>; devicetree=40vger.kernel.org; linux-
> serial=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; Greg Kr=
oah-
> Hartman <gregkh=40linuxfoundation.org>; linux-kernel=40vger.kernel.org; l=
inux-
> samsung-soc=40vger.kernel.org; Rob Herring <robh+dt=40kernel.org>
> Subject: Re: =5BPATCH v3 0/5=5D soc: samsung: Add USI driver
>=20
> On 05/12/2021 17:24, Krzysztof Kozlowski wrote:
> > On 04/12/2021 20:57, Sam Protsenko wrote:
> >> USIv2 IP-core provides selectable serial protocol (UART, SPI or
> >> High-Speed I2C); only one can be chosen at a time. This series
> >> implements USIv2 driver, which allows one to select particular USI
> >> function in device tree, and also performs USI block initialization.
> >>
> >> With that driver implemented, it's not needed to do USI
> >> initialization in protocol drivers anymore, so that code is removed
> >> from the serial driver.
> >>
> >> Because USI driver is tristate (can be built as a module), serial
> >> driver was reworked so it's possible to use its console part as a
> module too.
> >> This way we can load serial driver module from user space and still
> >> have serial console functional.
> >>
> >> Design features:
> >>   - =22reg=22 property contains USI registers start address (0xc0 offs=
et);
> >>     it's used in the driver to access USI_CON and USI_OPTION registers=
.
> >>     This way all USI initialization (reset, HWACG, etc) can be done in
> >>     USIv2 driver separately, rather than duplicating that code over
> >>     UART/SPI/I2C drivers
> >>   - System Register (system controller node) and its SW_CONF register
> >>     offset are provided in =22samsung,sysreg=22 property; it's used to
> >>     select USI function (protocol to be used)
> >>   - USI function is specified in =22samsung,mode=22 property; integer =
value
> >>     is used to simplify parsing
> >>   - there is =22samsung,clkreq-on=22 bool property, which makes driver
> >>     disable HWACG control (needed for UART to work properly)
> >>   - PCLK and IPCLK clocks are both provided to USI node; apparently
> both
> >>     need to be enabled to access USI registers
> >>   - protocol nodes are embedded (as a child nodes) in USI node; it
> >>     allows correct init order, and reflects HW properly
> >>   - USI driver is a tristate: can be also useful from Android GKI
> >>     requirements point of view
> >>   - driver functions are implemented with further development in mind:
> >>     - we might want to add some DebugFs interface later
> >>     - some functions might need to be revealed to serial drivers with
> >>       EXPORT_SYMBOL(), and provide somehow pointer to needed USI drive=
r
> >>       instance
> >>     - another USI revisions could be added (like USIv1)
> >>
> >> Changes in v3:
> >>   - Renamed compatible from samsung,exynos-usi-v2 to samsung,exynos850=
-
> usi
> >>   - Used clk_bulk API instead of handling each clock separately
> >>   - Spell check fixes and coding style fixes
> >>   - Improved dt-bindings doc
> >>
> >> Changes in v2:
> >>   - Renamed all 'usi_v2' wording to just 'usi' everywhere
> >>   - Removed patches adding dependency on EXYNOS_USI for UART/I2C/SPI
> >>     drivers
> >>   - Added patch: =22tty: serial: samsung: Fix console registration fro=
m
> >>     module=22
> >>   - Combined dt-bindings doc and dt-bindings header patches
> >>   - Reworked USI driver to be ready for USIv1 addition
> >>   - Improved dt-bindings
> >>   - Added USI_V2_NONE mode value
> >>
> >> Sam Protsenko (5):
> >>   dt-bindings: soc: samsung: Add Exynos USI bindings
> >>   soc: samsung: Add USI driver
> >>   tty: serial: samsung: Remove USI initialization
> >>   tty: serial: samsung: Enable console as module
> >>   tty: serial: samsung: Fix console registration from module
> >>
> >
> > All this looks good to me. The serial driver changes should come
> > together with this one (usi driver is now a dependency for them). If I
> > am correct, mention this please in future cover letter (if there is
> such).
> >
> > I will still need DTSI changes for Exynos Auto v9 and confirmation
> > that is not being used downstream and breaking DTB ABI is okay.
> > Because this will be a non-bisctable and also a DTB ABI break.
>=20
> +CC Arnd and Olof,
>=20
> Dear Arnd and Olof,
>=20
> The patchset discussed here reworks recently added USI code to Samsung
> Exynos UART driver in a non-bisectable and ABI-breaking way. The existing
> code in serial driver was added in v5.15-rc1, however first user - Exyons
> Auto v9 - appeared in v5.16-rc1.
>=20
> The bisectability and ABI break will affect only newly upstreamed Samsung
> Exynos SoC, so for now only Exynos Auto v9.
>=20
> The early code has some drawbacks and limitations which came up now when
> we want to extend the USI code to support more blocks (I2C, SPI) and
> devices (including older Exynos chipsets). Therefore I am planning to mak=
e
> an ABI break of this features because:
> 1. The code was added recently (v5.15-rc1) and users even later (v5.16-
> rc1).
> 2. Even though code was merged, I consider it still development phase.
> Kernel development goes very fast and we do not defer patches waiting for
> perfect solution.
> 3. There are no known out-of-tree users of this because this is fairly ne=
w.
> For this I am waiting for confirmation from Chanho (and/or other Samsung
> folks). I don't expect there are out of tree users because any mobile or
> automotive product will take Samsung vendor sources and recent kernels ar=
e
> not a base for Samsung vendor kernels.

This will be not an issue in my case. Please apply below patch with this se=
ries.
https://lore.kernel.org/linux-samsung-soc/20211208003946.139423-1-chanho61.=
park=40samsung.com/T/=23u

Best Regards,
Chanho Park

