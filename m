Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35419566A35
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiGELwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGELwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:52:04 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8127917A89
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:52:02 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220705115158epoutp0184bab201f43160cf8ab0d0bd030415d7~_7Ke8YXol0481604816epoutp01U
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:51:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220705115158epoutp0184bab201f43160cf8ab0d0bd030415d7~_7Ke8YXol0481604816epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657021918;
        bh=aQM5uBlL93e9lf6ifFCxyJH0VnwhkEMvGGNnJbLQnWg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=GvRc1vRBeQbRFBQLUJZaiIr1LQSmWoevTJ/KgnuFgEvIHPJkg536B9FzKUu7vpkQ4
         qlo4aKtLmwaRmx5JvTCrj4Cp5RvhmwLIEwEfbusoKxcns5ejN8p6SN0s5UYwAnvT+c
         wdDIRE8BEiktHK+TJC+SA5sCuMueKUbSq+Pz+wd8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220705115156epcas5p141f6035de45fec44c0a4cda7c44b2880~_7KdsvBzB1357613576epcas5p1a;
        Tue,  5 Jul 2022 11:51:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lcgy06Q4Tz4x9Pq; Tue,  5 Jul
        2022 11:51:52 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.8C.09662.5D524C26; Tue,  5 Jul 2022 20:51:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220705114450epcas5p1875db9d8984faa262283a1d0ebb24c2d~_7EQVoSi01630316303epcas5p1U;
        Tue,  5 Jul 2022 11:44:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220705114450epsmtrp1571c225588a93740433d29fa0fc6f416~_7EQUUPin2495724957epsmtrp1R;
        Tue,  5 Jul 2022 11:44:50 +0000 (GMT)
X-AuditID: b6c32a49-86fff700000025be-dd-62c425d5caff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.02.08802.13424C26; Tue,  5 Jul 2022 20:44:49 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220705114446epsmtip1d6e82f1c89a8114897695df6713ae732~_7ENWbc5n0196301963epsmtip1I;
        Tue,  5 Jul 2022 11:44:46 +0000 (GMT)
From:   "Smitha T Murthy" <smitha.t@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <dillon.minfei@gmail.com>, <david.plowman@raspberrypi.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <andi@etezian.org>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <linux-fsd@tesla.com>
In-Reply-To: <6c2ea5f7-3cc0-d43c-c667-18c25b64ff72@linaro.org>
Subject: RE: [PATCH 02/20] dt-bindings: media: s5p-mfc: Convert s5p-mfc.txt
 to new DT schema
Date:   Tue, 5 Jul 2022 17:14:45 +0530
Message-ID: <01e601d89064$a212a590$e637f0b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJFyDoizuFNEw0PhIpG3eTqugJ4BwKJmPtNAYJVPjoBxmyvY6xmoZ7w
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUdRTH/d27LyTwumD8IrXtJgxgPNYW+FGglsDcMhRzHMdKcIHrwgB3
        t92lNEfZSWRGNJAaQlZYg+UxbTxiZZE3QosQOBUTiKYbTyUgRmRTlnCYdlko//ucc77ndx6/
        OTycn8915yUxSlrOiFNIznpW/Y/eXr6DHsa4gKcZAjSiqecgrWUSQ8NaMwt1XjNwUd3AFRxV
        dN9go6vGn9noescYC9X+aY32F5hYaPJqNUBT6j84qHXGKtaP32aj0enD6LemQg66+IOBjaqM
        Ji4qG+rHULn+GYZKDH9z0blWIxdlZBqx3W5UpaYSUA2mUkANlc7jVKPaxKW0LVMYpded51D3
        b7dwqGul6dS5rn9YVHadDlDLXxRxqSzjEIcy67dSvU/M3GjnD5NDE2lxAi0X0Ey8NCGJkYSR
        ew/G7okNDAoQ+gpDUDApYMSpdBgZ/n60b2RSinUDpOBTcUqa1RUtVihI/52hcmmakhYkShXK
        MJKWJaTIRDI/hThVkcZI/Bha+aYwIGBHoFV4LDnReDZZ1nb4RM6IFqjA6NtZwIEHCRHMuvmI
        lQXW8/hEM4DZMzUcuzEPYHGJCtgNM4B9I9+DtZS/ruSsBpoA7LE0cm0BPjEJ4GjPJzbmEH5w
        2qhl20SuRBeAI3WjuM3AiQUcPmif4NhUDsRO2NNQs8IuRAysNRStlGAR2+Dv9Rrcxk5ECDTo
        ejE7b4Q/FUywbIwT22F58Qxub0kAFx+Us+1+NzjVZVzpyJWIhC3tzzBbYUj0OkDz/NoM4TC7
        aoxlZxc43V3HtbM7nMrJXGUJHDafXdXLYJGqDrPzLnhjoNCay7MW84Y1Tf529xaY11uN2Xtw
        hl8uTazKnWCDZo1JWHKrZ/V5CAdnDexLgFQ/N5r6udHUz42j/r/at4ClAy/RMkWqhFYEyoQM
        /dl/Px4vTdWDlQvxebcBmEbm/DoBxgOdAPJw0tVJ91VHHN8pQXzyc1oujZWnpdCKThBo3Xcu
        7r4pXmo9MUYZKxSFBIiCgoJEIW8ECUk3p/cG9XF8QiJW0sk0LaPla3kYz8FdhR2aOzJU4lze
        IbGkxwSvuxxoIbX3X3jyzTHtgc0b8ovPiC4cff3e3erme8OefkstS9mssr5bmtmFsm7H7vHz
        wWZiXpiZ/es74l3bvw4XLXun75u4+3HUByK3x3uM6OKLEcsOpY/G6L6K+R6Xhy6HFoO9GGb2
        rc3tr7UsIuYk7hlpSSvKzd/fmHdzoP+Sf8RHd5r5p3zmovTHmcbTbftVtRceZxRsGWyN+O7o
        KwdCTy1EOYr8D27SVMYH3zme57HDa9IjOvKpSVe2wePVy2UPt+avg6qOml/ovSdEFl9ec/2R
        0c6Xx5mEqm2zy+4xOk5u48bk6+nc+rjWin1nYk7PFI4Tnm2OHiRLkSgW+uByhfhfDqJrsaoE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdlhJTtdQ5UiSwdNrlhYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVns
        fQ1UvOnxNVaLh6/CLS7vmsNm0bNhK6vF2iN32S2WXr/IZLFs0x8mi0Vbv7BbtO49wm7R0naE
        yUHcY828NYweO+4uYfS4vuQTs8fOWXfZPRbvecnksWlVJ5vHnWt72Dw2L6n3aD36i8Wjb8sq
        Ro9/TXPZPbqOXGfz+LxJzuPU18/sAXxRXDYpqTmZZalF+nYJXBm9M86yFewPrZh2PaeB8YF9
        FyMnh4SAicSb2f2MXYxcHEICOxglLm9bxgyRkJBY+XsSI4QtLLHy33N2iKKnjBInZkxnA0mw
        CehJvDqymBUkISJwklGi/0wLmMMs0M0i0fiqlQmi5TWjxOEl28DmcgrYSZzYsR6sXVggRuL/
        wTVgcRYBFYlb2+aB2bwClhJbV51igrAFJU7OfMICYjMLaEv0PmxlhLGXLXwNdauCxM+ny1gh
        4uISL48eYQexRQTcJPbs/8M0gVF4FpJRs5CMmoVk1Cwk7QsYWVYxSqYWFOem5xYbFhjlpZbr
        FSfmFpfmpesl5+duYgQnEi2tHYx7Vn3QO8TIxMF4iFGCg1lJhHfVpINJQrwpiZVVqUX58UWl
        OanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDpM9pLRi/PSOuJMr/BO0tbN/BU
        S9HZxW7nvk58pCxry+jWrlSqkeYkfK7mouP72FvGCZo3tWyP7QgNlF21beV2V1Gbjlt+Cft5
        AvjeZ+mvO/bgtkeio9vjXzvuf5yVtPKSbeXxNq17v6cfvNt53GzPkavlnLnJzlrz3fnzaj85
        VYi6Ltfc4si/6tinbIn/Iolrln6eLLGwzN5F59JJjg06ku9aj0TOcnY49bDJqeJz7qGkGbUP
        NmjtmfP57OalLNfPC6ueux95M+fIRo6lLJUqdqfu/phw7erKN/XN8ztWVzwTOqTXv5TfnXkJ
        83lzM8ees32CXle2NE8KaNiSFKqt9kj6lv3UuM5sIR17m3AlluKMREMt5qLiRACU9UBEkwMA
        AA==
X-CMS-MailID: 20220705114450epcas5p1875db9d8984faa262283a1d0ebb24c2d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125554epcas5p4e87a71471525056281f1578f4f80f760
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125554epcas5p4e87a71471525056281f1578f4f80f760@epcas5p4.samsung.com>
        <20220517125548.14746-3-smitha.t@samsung.com>
        <6c2ea5f7-3cc0-d43c-c667-18c25b64ff72@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: Tuesday, May 17, 2022 7:26 PM
> To: Smitha T Murthy <smitha.t=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; stanimir.varbanov=40linaro.org;
> dillon.minfei=40gmail.com; david.plowman=40raspberrypi.com;
> mark.rutland=40arm.com; robh+dt=40kernel.org; krzk+dt=40kernel.org;
> andi=40etezian.org; alim.akhtar=40samsung.com; aswani.reddy=40samsung.com=
;
> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com
> Subject: Re: =5BPATCH 02/20=5D dt-bindings: media: s5p-mfc: Convert s5p-m=
fc.txt
> to new DT schema
>=20
> On 17/05/2022 14:55, Smitha T Murthy wrote:
> > Adds DT schema for s5p-mfc in yaml format.
> >
>=20
> Thank you for your patch. There is something to discuss/improve.
>=20

Thank you for the review.=20

> > Cc: linux-fsd=40tesla.com
> > Signed-off-by: Smitha T Murthy <smitha.t=40samsung.com>
> > ---
> >  .../devicetree/bindings/media/s5p-mfc.txt     =7C 77 +--------------
> >  .../devicetree/bindings/media/s5p-mfc.yaml    =7C 98
> +++++++++++++++++++
> >  2 files changed, 99 insertions(+), 76 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/media/s5p-mfc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > index aa54c8159d9f..f00241ed407f 100644
> > --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > =40=40 -1,76 +1 =40=40
> > -* Samsung Multi Format Codec (MFC)
> > -
> > -Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> > -supports high resolution decoding and encoding functionalities.
> > -The MFC device driver is a v4l2 driver which can encode/decode -video
> > raw/elementary streams and has support for all popular -video codecs.
> > -
> > -Required properties:
> > -  - compatible : value should be either one among the following
> > -	(a) =22samsung,mfc-v5=22 for MFC v5 present in Exynos4 SoCs
> > -	(b) =22samsung,mfc-v6=22 for MFC v6 present in Exynos5 SoCs
> > -	(c) =22samsung,mfc-v7=22 for MFC v7 present in Exynos5420 SoC
> > -	(d) =22samsung,mfc-v8=22 for MFC v8 present in Exynos5800 SoC
> > -	(e) =22samsung,exynos5433-mfc=22 for MFC v8 present in Exynos5433
> SoC
> > -	(f) =22samsung,mfc-v10=22 for MFC v10 present in Exynos7880 SoC
> > -
> > -  - reg : Physical base address of the IP registers and length of memo=
ry
> > -	  mapped region.
> > -
> > -  - interrupts : MFC interrupt number to the CPU.
> > -  - clocks : from common clock binding: handle to mfc clock.
> > -  - clock-names : from common clock binding: must contain =22mfc=22,
> > -		  corresponding to entry in the clocks property.
> > -
> > -Optional properties:
> > -  - power-domains : power-domain property defined with a phandle
> > -			   to respective power domain.
> > -  - memory-region : from reserved memory binding: phandles to two
> reserved
> > -	memory regions, first is for =22left=22 mfc memory bus interfaces,
> > -	second if for the =22right=22 mfc memory bus, used when no SYSMMU
> > -	support is available; used only by MFC v5 present in Exynos4 SoCs
> > -
> > -Obsolete properties:
> > -  - samsung,mfc-r, samsung,mfc-l : support removed, please use memory-
> region
> > -	property instead
> > -
> > -
> > -Example:
> > -SoC specific DT entry:
> > -
> > -mfc: codec=4013400000 =7B
> > -	compatible =3D =22samsung,mfc-v5=22;
> > -	reg =3D <0x13400000 0x10000>;
> > -	interrupts =3D <0 94 0>;
> > -	power-domains =3D <&pd_mfc>;
> > -	clocks =3D <&clock 273>;
> > -	clock-names =3D =22mfc=22;
> > -=7D;
> > -
> > -Reserved memory specific DT entry for given board (see reserved
> > memory binding -for more information):
> > -
> > -reserved-memory =7B
> > -	=23address-cells =3D <1>;
> > -	=23size-cells =3D <1>;
> > -	ranges;
> > -
> > -	mfc_left: region=4051000000 =7B
> > -		compatible =3D =22shared-dma-pool=22;
> > -		no-map;
> > -		reg =3D <0x51000000 0x800000>;
> > -	=7D;
> > -
> > -	mfc_right: region=4043000000 =7B
> > -		compatible =3D =22shared-dma-pool=22;
> > -		no-map;
> > -		reg =3D <0x43000000 0x800000>;
> > -	=7D;
> > -=7D;
> > -
> > -Board specific DT entry:
> > -
> > -codec=4013400000 =7B
> > -	memory-region =3D <&mfc_left>, <&mfc_right>;
> > -=7D;
> > +This file has moved to s5p-mfc.yaml
>=20
> Instead entirely remove the file.
>=20

Ok, I will remove this file.

> > diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> > b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> > new file mode 100644
> > index 000000000000..fff7c7e0d575
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> > =40=40 -0,0 +1,98 =40=40
> > +=23 SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +=24id:
> > +https://protect2.fireeye.com/v1/url?k=3D8b32845f-ea492ed7-8b330f10-
> 74fe
> > +4860018a-302429095d2fce6e&q=3D1&e=3D73087855-3649-4be8-a878-
> d487e0ae58f4&
> > +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fmedia%2Fs5p-
> mfc.yaml%23
>=20
> Let's convert the name as well, so =22samsung,s5p-mfc.yaml=22
>=20

Ok, I will change the name in next series.

> > +=24schema:
> > +https://protect2.fireeye.com/v1/url?k=3Da01c09cc-c167a344-a01d8283-74f=
e
> > +4860018a-b8e3ca9e8a791d49&q=3D1&e=3D73087855-3649-4be8-a878-
> d487e0ae58f4&
> > +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: Samsung Exynos Multi Format Codec (MFC)
> > +
> > +maintainers:
> > +  - Mauro Carvalho Chehab <mchehab=40kernel.org>
> > +  - Rob Herring <robh+dt=40kernel.org>
> > +  - Mark Rutland <mark.rutland=40arm.com>
> > +  - Smitha T Murthy <smitha.t=40samsung.com>
>=20
> Only people with access to HW, so you can put here Marek and yourself.
>=20

Ok, I will change the authors list.

> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - samsung,mfc-v5                  =23 Exynos4
> > +      - samsung,mfc-v6                  =23 Exynos5
> > +      - samsung,mfc-v7                  =23 Exynos5420
> > +      - samsung,mfc-v8                  =23 Exynos5800
> > +      - samsung,exynos5433-mfc          =23 Exynos5433
> > +      - samsung,mfc-v10                 =23 Exynos7880
>=20
> Ugh, how MFCv10 appeared here? Since 5433 we moved from versions to
> Soc compatibles as recommended... eh, please follow this convention, don'=
t
> reverse it to other way.
>=20
> I propose to deprecated this in next patch and instead use SoC-based
> compatible.
>=20

MFCv10 was already mainlined as mfc-v10, maybe for v10 I will add it post t=
his series.
For MFCv12 I will add SoC-based in the next series.

> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description:
> > +      Phandle to MFC IP clock.
>=20
> Here and other places: s/Phandle//
> Instead describe what is it, e.g. =22MFC IP clock=22
>=20
>=20

Ok noted.

> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    description:
> > +      Must contain clock name (mfc) matching phandle in clocks
> > +      property.
>=20
> Skip description, its obvious. Instead list the items.
>=20

Ok

> > +    maxItems: 1
>=20
> No need, list the items.
>=20
> > +
> > +  interrupts:
> > +    description:
> > +      MFC interrupt number to the CPU.
>=20
> Skip description, it's obvious.
>=20

Ok

> > +    maxItems: 1
> > +
> > +  memory-region:
> > +    description:
> > +      From reserved memory binding phandles to two reserved
> > +      memory regions, first is for =22left=22 mfc memory bus interface=
s,
> > +      second if for the =22right=22 mfc memory bus, used when no SYSMM=
U
> > +      support is available; used only by MFC v5 present in Exynos4 SoC=
s.
> > +    minItems: 1
> > +    maxItems: 2
>=20
> This needs allOf:if:then restricting two items to specific compatible.
>=20

Ok, I will make this change.

> > +
> > +  iommus:
> > +    description:
> > +      Include the IOMMU domain MFC belong to.
>=20
> Skip description, it's obvious.
>=20

Ok

> > +    maxItems: 2
> > +
>=20
> What happened to power domains? You also removed them from the
> example... Does this pass dtbs_check?
>=20

This file passed the dtbs_check. For MFCv10 and v12 power domains are not r=
equired.
I will add in the example.

> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - iommus
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - =7C
> > +        /* Reserved memory specific DT entry for given board */
> > +        reserved-memory =7B
>=20
> Wrong indentation. Four spaces. See example schema.
>=20

Ok

> > +                =23address-cells =3D <1>;
> > +                =23size-cells =3D <1>;
> > +                ranges;
> > +
> > +                mfc_left: region=4084000000 =7B
> > +                        compatible =3D =22shared-dma-pool=22;
> > +                        no-map;
> > +                        reg =3D <0x84000000 0x800000>;
> > +                =7D;
> > +
> > +                mfc_right: region=40A9000000 =7B
>=20
> lower case hex addresses, everywhere.
>=20

Ok

> > +                        compatible =3D =22shared-dma-pool=22;
> > +                        no-map;
> > +                        reg =3D <0xA9000000 0x800000>;
> > +                =7D;
> > +        =7D;
> > +
> > +        mfc_0: mfc0=4012880000 =7B
>=20
> Generic node names, so mfc.
>=20

Ok

> > +                compatible =3D =22samsung,mfc-v12=22;
>=20
> Does not look like you tested the bindings. Please run =60make
> dt_binding_check=60 (see Documentation/devicetree/bindings/writing-
> schema.rst for instructions).
> Be sure to test your bindings before sending them.
>=20

I did do make dtbs and dt_binding_check using v2022.3, I will recheck post =
these changes.

> > +                reg =3D <0x12880000 0x10000>;
> > +                clock-names =3D =22mfc=22;
> > +                interrupts =3D <0 137 4>;
>=20
> Use interrupt defines.
>=20

When I use interrupt defines I get errors as =221.	Syntax error: This was d=
ue to interrupts field has some macro reference and needed to give absolute=
 value.=22, hence I gave absolute values.

Regards,
Smitha

> > +                clocks =3D <&clock_mfc 1>;
> > +                memory-region =3D <&mfc_left>, <&mfc_right>;
> > +                /* If IOMMU is present use below instead of memory-reg=
ion
> property */
> > +                iommus =3D <&smmu_isp 0x1000 0x0>, <&smmu_isp 0x1400 0=
x0>;
> > +        =7D;
>=20
>=20
> Best regards,
> Krzysztof

