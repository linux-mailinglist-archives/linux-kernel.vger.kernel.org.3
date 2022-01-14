Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404E848E546
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 09:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiANINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 03:13:37 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:50394 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiANINg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 03:13:36 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220114081334epoutp02e71115215bd198f258b84e0711323adc~KFOsimDRn1829118291epoutp02t
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:13:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220114081334epoutp02e71115215bd198f258b84e0711323adc~KFOsimDRn1829118291epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642148014;
        bh=mc5Hhi/4OGMShk/7UeMTmfoazh+0g9dVGSl2GEPL0o4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Nol4bwcyus2q4EF4iVNdsc+8XxeWhYgXGFmSTHhhH6B+n+sblabXL2q1alsY9gK+2
         u2dAFozugPe/IzvONwswAJo9DO57Jb8PFvG35yuZ2e15wypMhdn75lnjw8gBf2VJ4B
         L4PqYb1uiucBEiTN2qpaiqEIkOvKHUBRGBv6EwWo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220114081333epcas5p305b8d06c33a4a9729ecddfe1c2216d10~KFOrpuARw0282602826epcas5p3S;
        Fri, 14 Jan 2022 08:13:33 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JZvFL4fMpz4x9QN; Fri, 14 Jan
        2022 08:13:26 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.76.06423.5A031E16; Fri, 14 Jan 2022 17:13:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220114081325epcas5p19ffafd2eb6277d2b7dc1cd8b0fd1e1a9~KFOkdZYBv3205832058epcas5p1S;
        Fri, 14 Jan 2022 08:13:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220114081325epsmtrp2a3afdd170627c5168acba7662365e069~KFOkcQNNy2051820518epsmtrp2E;
        Fri, 14 Jan 2022 08:13:25 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-92-61e130a573fc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.0A.08738.5A031E16; Fri, 14 Jan 2022 17:13:25 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220114081322epsmtip28c05f7bde104a28cfa727e5ce4b74396~KFOhnAVUy1391013910epsmtip2z;
        Fri, 14 Jan 2022 08:13:22 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@canonical.com>
Cc:     "'Linux ARM'" <linux-arm-kernel@lists.infradead.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'SoC Team'" <soc@kernel.org>,
        "'linux-clk'" <linux-clk@vger.kernel.org>,
        "'DTML'" <devicetree@vger.kernel.org>,
        "'Olof Johansson'" <olof@lixom.net>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Catalin Marinas'" <catalin.marinas@arm.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES'" 
        <linux-samsung-soc@vger.kernel.org>,
        "'Pankaj Dubey'" <pankaj.dubey@samsung.com>, <linux-fsd@tesla.com>,
        "'Arjun K V'" <arjun.kv@samsung.com>,
        "'Aswani Reddy'" <aswani.reddy@samsung.com>,
        "'Ajay Kumar'" <ajaykumar.rs@samsung.com>,
        "'Sriranjani P'" <sriranjani.p@samsung.com>,
        "'Chandrasekar R'" <rcsekar@samsung.com>,
        "'Shashank Prashar'" <s.prashar@samsung.com>
In-Reply-To: <CAK8P3a0etf+AybUe5O9uRLAbo4J145t0-ThkEccNtKzue+0-qA@mail.gmail.com>
Subject: RE: [PATCH 14/23] arm64: dts: fsd: Add initial device tree support
Date:   Fri, 14 Jan 2022 13:43:20 +0530
Message-ID: <07ce01d8091e$9a6fd9c0$cf4f8d40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuNmZ/+9PJHbdzezyQqzGEXzr0sgIO4TNYAcRhnYYCPaD7jACVm+o+qoCU36A=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1ATVxTGudnsJmFA1wDlSquTZnSm0gETCemGMQKtU9OKDsr0OdW4JWtg
        CElmE6zShwiDPFVCS9FIokWBiowtz6axtjYEqFqhldfYhiqCHXlICulUQWKbZG3Lf9859/fd
        c859cBG+B4viZmqNFK0lNUIsmN3Rue65mHrRKCk6v4W47P6eTTScs7MJb2U3h3C0tnMId305
        IE45e1Gi+f5DFvHJYgOLaBkbQonZ8t9QYnTyDaLfXoMRx/u+ZRFXhz0YUdv+J4cw/2RDicJL
        Tg7ROV2EElabBRBjw4sY8ev0BTQpQtFkbQKKRwuVQGHOO4IpWhpLMIVr6BtM0Xr2oGLgh3xU
        cbStESge51s4Ck/L6tTgt7M2ZlCkiqIFlDZdp8rUquXCrWnKl5TxUpE4RiwjXhAKtGQ2JRdu
        TkmNeTlT4xtRKNhHanJ8qVTSYBCu37SR1uUYKUGGzmCUCym9SqOX6GMNZLYhR6uO1VLGBLFI
        tCHeB+7JyhieOY/qrVH7q6peywPuiFLA5UJcAj+df78U8Lh8/CKA1d9RpSDYp+cA7FgoQ5nA
        A+DgwnXUT/kNx09c4zALdgAbv/4FY4IJAK8/OMXyUxgeA21nDmN+HY6rYGeHOwAh+CIGW0d6
        2f4FHr4Dlrd2BXQYvhUWTrUGSrDxtdDRXBPYKBSXwemCfsDoFfDKifEAj+DPw/rPphCmJQGc
        v1uPMsW2wx8n7qMMEwknupyBViFezYOu5iscZujNsO9iCuMNg5M9bRxGR0HPzCWMQbJguT2O
        SX8A66zdbEYnwssDNWw/guDr4Bf29UylZfDIo3EW4wyFxYf5DL0WFswMPnE+DU1lZU/OUAG7
        bvaiFeBZ85K5zEvmMi/p3/x/sdOA3QhWUnpDtpoyxOvFWuq9/y47XZfdAgKvP/oVGxi5/Ues
        A7C4wAEgFxGGhx6jb5H8UBV5IJeidUo6R0MZHCDed9gmJCoiXef7PlqjUiyRiSRSqVQii5OK
        hZGh19RfknxcTRqpLIrSU/S/PhaXF5XHUpN0yHZZz1PlY6mr2y9YNgwmnJGndGyK3J/+cymv
        mxf85r6GiL3dsrH5A65Dk94HdbeQbMvmlui/2Wv2zIVVuMTAXqQZQfrla1zed2fOJhY7TEkD
        y6VuyzZTwc05a0hdbm0XbY08VKOZ3vVOd+0OHb/voKUvInmX88NCL2s0caVyJmH3TpM37FX7
        x4Mh1SffqgSSnT0vCrmPxb/fiZn9azwoN2iqyPsQum7cKxnKvyFIjtUOxlnc26joZWm2cEFa
        tSeZorNKNPfmX98r/7y2eNX83QWwHD8ZlOS9fXXFbNwz5z7a3R6kaSqrONbW3zBnikWqelVb
        7jiVNsyZdvqrVUK2IYMURyO0gfwHTaPQHIYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGec/ObaPRcWq+Kt3WFU1zZvLOG0YUx4LMvhhF2MqTZputLUsj
        aCiaiZqFlq25LqaimLSpdRK7zSmmaZbhoMK1VMI0tRbd1Aq3Ar/94HmeH/8Pf1ogceB+9OH0
        45wmXaGUkiL8bpt0aVBViEMR0sAvRY8nn+CoprYFR7MXOyhkaWym0GR1IUDXrL0EMn36gaHS
        mRoMmYcGCPS5cJBAjo+JqL/FQKLy5w8x1GVzkuhm81cK6ft4AuU+sFKobfwsgYx8BUBDthkS
        vRlvIGK92XpjPWCnf10ErF5XRLLmunMk+3aglWQbb51hX3VmE2xxUx1gf2dXUKzTvGSnaI8o
        KplTHj7BadbH7BelTtXXYuo238zbpQt04JJ3ARDSkAmD5Ve6qQIgoiUMD6Bd/5h0B/7QZiqh
        3OwJa39/+Ff6AGCxvYyYC0gmCPKVea6BF5MMzflOV0nA5FPw+0M76V60YLCMn3GphEwCLGxs
        x+fYk9kOc8caXSacWQUtJgM2x2JGDsdz+oGbPeDTK8OuvoAJhEWOXPCfq2+MCdznLYM/R6oJ
        9xU74LPRT4S74wNH261UCfDUz1Pp56n081T6eZPrAK8Dvpxaq0pRaWXq0HTuZLBWodJmpKcE
        HzyqMgPXFwQE8KC1birYAjAaWACkBVIv8XmNXSERJyuyTnGao0maDCWntQB/Gpf6iPsKniZJ
        mBTFce4Ix6k5zf8Uo4V+OiwsaY0pzpzBD8SE3Tcsz9smE3K4gWjavFq4JUfn0aoeGFWSRuLY
        6y0d4e/0trUrLw9FVqm94qYFCRHWdydi+lZ8zcm+Da7uGbR2dm5l2nSj8R7rm6M3KGOzZt+X
        vDqwIqxjWL43YnidIfpCoL1n0zrJQjn6pmmvmSD3jfgWSVRRafEJkYXGG2S3uj/Ir7S3JMKQ
        GDEW2yOVNzhqZqs29r8MrCj+IvgjHzmdt+uecYI4kzGVkhba44wKEcO94bNUqazcWZYKzROJ
        d/wv71xg2zR5rWdcxgpfxG1OO5TLH8lvWkRPG3Y/jzY9+v6LygwfWr5rQ9pg1yHv0MWRbyp5
        Ka5NVcgCBBqt4i/yaAiJdAMAAA==
X-CMS-MailID: 20220114081325epcas5p19ffafd2eb6277d2b7dc1cd8b0fd1e1a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122413epcas5p46cb2cafb73936c423017240f98f72845
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122413epcas5p46cb2cafb73936c423017240f98f72845@epcas5p4.samsung.com>
        <20220113121143.22280-15-alim.akhtar@samsung.com>
        <55c22c3a-57ea-3320-ccb9-f03643563235@canonical.com>
        <CAK8P3a0etf+AybUe5O9uRLAbo4J145t0-ThkEccNtKzue+0-qA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Krzysztof

>-----Original Message-----
>From: Arnd Bergmann =5Bmailto:arnd=40arndb.de=5D
>Sent: Thursday, January 13, 2022 7:54 PM
>To: Krzysztof Kozlowski <krzysztof.kozlowski=40canonical.com>
>Cc: Alim Akhtar <alim.akhtar=40samsung.com>; Linux ARM <linux-arm-
>kernel=40lists.infradead.org>; Linux Kernel Mailing List <linux-
>kernel=40vger.kernel.org>; SoC Team <soc=40kernel.org>; linux-clk <linux-
>clk=40vger.kernel.org>; DTML <devicetree=40vger.kernel.org>; Olof Johansso=
n
><olof=40lixom.net>; Linus Walleij <linus.walleij=40linaro.org>; Catalin Ma=
rinas
><catalin.marinas=40arm.com>; Rob Herring <robh+dt=40kernel.org>; Sylwester
>Nawrocki <s.nawrocki=40samsung.com>; moderated list:ARM/SAMSUNG
>EXYNOS ARM ARCHITECTURES <linux-samsung-soc=40vger.kernel.org>; Pankaj
>Dubey <pankaj.dubey=40samsung.com>; linux-fsd=40tesla.com; Arjun K V
><arjun.kv=40samsung.com>; Aswani Reddy <aswani.reddy=40samsung.com>;
>Ajay Kumar <ajaykumar.rs=40samsung.com>; Sriranjani P
><sriranjani.p=40samsung.com>; Chandrasekar R <rcsekar=40samsung.com>;
>Shashank Prashar <s.prashar=40samsung.com>; Arnd Bergmann
><arnd=40arndb.de>
>Subject: Re: =5BPATCH 14/23=5D arm64: dts: fsd: Add initial device tree su=
pport
>
>On Thu, Jan 13, 2022 at 2:16 PM Krzysztof Kozlowski
><krzysztof.kozlowski=40canonical.com> wrote:
>> >  ARM/TETON BGA MACHINE SUPPORT
>> >  M:   =22Mark F. Brown=22 <mark.brown314=40gmail.com>
>> >  L:   linux-arm-kernel=40lists.infradead.org (moderated for non-subscr=
ibers)
>> > diff --git a/arch/arm64/Kconfig.platforms
>> > b/arch/arm64/Kconfig.platforms index 54e3910e8b9b..bb8a047c2359
>> > 100644
>> > --- a/arch/arm64/Kconfig.platforms
>> > +++ b/arch/arm64/Kconfig.platforms
>> > =40=40 -267,6 +267,12 =40=40 config ARCH_TEGRA
>> >       help
>> >         This enables support for the NVIDIA Tegra SoC family.
>> >
>> > +config ARCH_TESLA_FSD
>> > +     bool =22ARMv8 based Tesla platform=22
>> > +     select ARCH_EXYNOS
>>
>> How similar it is? I think it is better to duplicate Exynos
>> selections/options here, instead of selecting entire ARCH. If this
>> would require =22depends on ARCH_EXYNOS =7C=7C ARCH_TESLA_FSD=22
>everywhere in
>> the drivers, it's a hint that it is not a separate SoC but it is an
>> Exynos, so it might not need a new sub-architecture.
>
>Agreed, the SoC family options mainly exist so we can quickly enable or
>disable drivers based on what a kernel is built for. If most of the driver=
s for
>this SoC are shared with Exynos, I think having a single option is suffici=
ent, but
>it may be worth pointing out both in the help text.
>
>If we want to have a separate option (mainly to help users find it), maybe=
 a
>'depends on ARCH_EXYNOS' would be better. How many uses of
>ARCH_TESLA_FSD are there?
>
It is true that FSD shares few IPs with Exynos and it dose contains Telsa s=
pecific IPs/ PCIe/some of the PHYs/ GPUs (different then Exynos) etc. to na=
me a few.
And drivers for those will be posted in upcoming phases by Samsung, Telsa e=
tc.
AFA architecture is concerns both Exynos and FSD has completely different a=
rchitecture (at least at HW level).
In my opinion, it is make sense to have a separate option for FSD.
And as Arnd suggested =22'depends on ARCH_EXYNOS=22 may be the way forward.

>        Arnd

