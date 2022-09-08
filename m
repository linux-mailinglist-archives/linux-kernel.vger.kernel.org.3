Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD15B207F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiIHO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiIHO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:26:08 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B1D742B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:26:02 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220908142557epoutp04ba2b8fe2276c0063b5833c3313b20e9f~S6MfDdtcd0933509335epoutp04j
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:25:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220908142557epoutp04ba2b8fe2276c0063b5833c3313b20e9f~S6MfDdtcd0933509335epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1662647157;
        bh=JRBBdhsJc9pxqArFZVW+ByFBFhDD/2Gg3fD4Uyp6Qtg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=TCzzvzpzO/tsSbKb+c29smn0iVhEVB1B5Z1c0lb47rMlSvjDeklzTPWcmMVsmPlwp
         uRn9LR31bQwt9Ea4lOUaxgBxDF42/Hy+kLSk3BVLt/eCuS4qaQ/ONUIg6b5/qRE2h9
         hW/SD+E9g7VYNnFcBvzTc4FQtn8t33p/2Z7tPdnc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220908142556epcas5p2fd29e95b22164cb352c12c8bdb100cd2~S6MeQrAWr1190411904epcas5p2U;
        Thu,  8 Sep 2022 14:25:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MNhHj6GbVz4x9Pr; Thu,  8 Sep
        2022 14:25:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.AA.54060.17BF9136; Thu,  8 Sep 2022 23:25:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220908125649epcas5p4a85fd9170b09658d6bab84909a97141b~S4_qvBgsG0718707187epcas5p4i;
        Thu,  8 Sep 2022 12:56:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220908125649epsmtrp26ff688e633c2ecd60d358b1aec74b703~S4_qtvrBc2418524185epsmtrp2O;
        Thu,  8 Sep 2022 12:56:49 +0000 (GMT)
X-AuditID: b6c32a4b-be1ff7000000d32c-fa-6319fb7196fe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.96.18644.196E9136; Thu,  8 Sep 2022 21:56:49 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220908125645epsmtip25fe12db723d1b3c5955d49f7ce9a8981~S4_nHfiQb0313803138epsmtip2X;
        Thu,  8 Sep 2022 12:56:45 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Smitha T Murthy'" <smitha.t@samsung.com>,
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
        <linux-fsd@tesla.com>, <aakarsh.jain@samsung.com>
In-Reply-To: <08168057-853c-5b17-7d88-dc6c30e82f14@linaro.org>
Subject: RE: [Patch v2 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Date:   Thu, 8 Sep 2022 18:26:44 +0530
Message-ID: <000101d8c382$75750e00$605f2a00$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIwYET59QqMDNmfP0SYfUTdtmHMHgGIcczBAeDI2w8CVnGc/6z4Ncag
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1DTdRjH++z73b6b1/QbzPxAabSSDj1gE5gfjF+ped+QPIrEzs5gt30P
        kLGtbYBYd3Lo1BYSlnht0fgpcKD8GLAQRicwwIAsL4IrGYhCAyQjRh6Gh20Miv9ez4/383me
        53MPG/MwEt7sFLmGVsnFMj5rA27u8vPz/2jJSyL4sSQQTbbomeiu0cxCZYt2Bhorc+Cos7GZ
        QE2DX2OosvcGExVZbzHRtx33cNQw5Yze1ttwZC+qBWjaMMpC7Q+cyab7Q0w0PnME/dxayEK5
        9c1MdM1qI9CV4dsMVGF6wkClzQsE0rZbCWSzmAE6c9bKiPKirhqvAqrFVg6o4fJ5jLpusBFU
        mWWaQZmqP2VRI0MWFtVYforSdv+DU3lN1YBazvmGoHTWYRblMG2j+v52ELEbj6aGJdNiKa3y
        oeUShTRFnhTOPxiXsC8hRCQQ+gtD0W6+j1ycRofz98fE+h9IkTl3wffJEMvSna5YsVrND4wI
        UynSNbRPskKtCefTSqlMGawMUIvT1OnypAA5rdkjFAh2hTgTE1OTs001LKX10Im62l5mNpgN
        0wEOG5LBUNufi7vYg2wD0NbrqQMbnDwP4CN9M8NtOADUti0y1hSGX2aZ7kArgOeb+lcNO4AD
        T1pWarHIQDjWl7sS4LnkZxvMK3KMLMBhx5CXizlkBKy63LXi9yTjYdVUJaYDbDZOvgoN1kiX
        m0uGwpIePeHm5+D3+gncXWYnrCh5gLk78oGPJyuYLimPPADtE5g7ZQvsfpyLuVqA5G8cOGCe
        Ilw5kNwPz8285ZZ6wpneJsLN3tDxsJ3lZgm8Xzq9Wl4G6yyXcDdHwhuDhbirDEb6wbrWQLd7
        Kyzoq10dcCO8sDSxuisubDGusS8sHFlkuvlF2FVzBeQDvmHdYIZ1gxnWTWD4/7VigFcDL1qp
        Tkui1SHKIDmd+d93SxRpJrByKDsOtoB7d+cCOgGDDToBZGN8HnfzNSjx4ErFWSdplSJBlS6j
        1Z0gxLnsi5j3ZonCeWlyTYIwOFQQLBKJgkODREL+Fu6lnUDiQSaJNXQqTStp1ZqOweZ4ZzPq
        6acxxk26zI9/+G5h63FR1HsgNy+U5xgnWFSOpP9pSeesQGTqMRbNSbCsEbt07wuEo30p/oO8
        mcEu9ErqzQnLQLQ6J4/+krc8Pnza4y8tuN5KcRYfZiX2TMycfFnVcPiLLuoNwZ1530OLiXfO
        vMP11i/H1x4G9QGb/Jbjqn5v3nvhSOa7w6c7jkerIiPYdu5Pn1WYi01/7Mk/ul3x+c2CU93F
        28biyjL0iphju4yDlem+J+Ias9s4IecbS3+dzUqt8Xz2+dHdl18/1rDUF3lun1ltz557hvWh
        LmMySTv6ybx0+3Jd09uPzG9GWy7eeu2r2HreQpBwMIfKfz/KZPlz8iUezsfVyWLhDkylFv8L
        wDmVDLEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHd+6bEpa7gukB5zSdC7ODgszFwyZsMc4cM4Nkc3FbNFjw8pC2
        sF7cZMkQDZDZEIPZNHLZahEsUMBAeQimimJFQcPsUOqMBZ3tEDoTFImCptjauPDf53xf+f1x
        OFL+Cx3D5emLBINeo1UyMqr7onJ5/OF/o7MSPVVRyNtTTaO7pm4G1T2bINB43QyF+ju6WNR5
        o4ZEDZfP0+i4Y5hGpy/8Q6H2BwHXWe2m0MTxUwBNSmMMOusLhG33R2l0b2obGjnzO4Mq27po
        1Opws+iky0kgi+0FgU50PWFR+VkHi9z2boDKKhzEZ9G4xdQCcI+7HmBX/WMS90puFtfZJwls
        sx5k8J1RO4M76vfh8kvzFD7UaQXYf+APFhsdLgbP2N7BQ7MzbPqb38nW7RK0eT8IhoTUnbLc
        5rY6qvDu5r2emjKqFJR9YgRhHOTXQOnmf3SQ5XwPgC2N+pD+NlyoGGBDHAmb/BMBlgUyXgAl
        52+vCgyfAMeHKumgEcU/BXD/8C0q+CD5Jgq6bxupUMUH4Nx0HxOshPGpsPHoRSLIkfxWeMVl
        DugcR/EroeT4NChH8MmwdqCaDfFbcLDaQwWZ5D+A3r+9/7Ol1keGzlsB57wWOjgTxW+EEx4y
        FFHAS3OVZBWIlBYtSYuWpEVL0qKKGVBWEC0Uirocnbi6MEkv/KgWNTpxjz5HnVWgs4FXn0Wl
        6gF267S6HxAc6AeQI5VREUtaYZY8Ypem+CfBUJBh2KMVxH6wlKOUiojrxsEMOZ+jKRLyBaFQ
        MLx2CS4sppQYWrJhKi15fU22aYxuHX7ImOneq77nl18k/qywJq1rzy7RZZrkGTcOztY+/atx
        x2y4qsQ0tsCknPnysVkZdyByTJt7LJllG7T4q8xD5paaI++5zKyYPX+4NCHm2xnFGyl4U1za
        +0xezPf3NzimP1J7Ep48oraftvh3F3/c67/2vLPJOHhb8TUf21H055Fv+patOhntqrJb25q3
        xPeKj0a83o3z2tjRBvmKhQcn1sjMienXfnUOnZNS09QDHudU0towXJ4//mzpVl/rqS/K15Zc
        rxUrRvY3j767/PP8C8adqnZLerEpfAv2x01q1/tuqjP7Pix4uLcxSZYS74jdnhF+ZVpJibma
        1SrSIGpeAgy0gAGbAwAA
X-CMS-MailID: 20220908125649epcas5p4a85fd9170b09658d6bab84909a97141b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7
References: <20220907064715.55778-1-smitha.t@samsung.com>
        <CGME20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7@epcas5p1.samsung.com>
        <20220907064715.55778-2-smitha.t@samsung.com>
        <08168057-853c-5b17-7d88-dc6c30e82f14@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 07 September 2022 16:52
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
> pankaj.dubey=40samsung.com; linux-fsd=40tesla.com;
> aakarsh.jain=40samsung.com
> Subject: Re: =5BPatch v2 01/15=5D dt-bindings: media: s5p-mfc: Add new DT
> schema for MFC
>=20
> On 07/09/2022 08:47, Smitha T Murthy wrote:
> > Adds DT schema for s5p-mfc in yaml format
>=20
> s/Adds/Convert/
> (as convert to DT schema)
>=20
ok, I will change.

> Please mention here changes to original binding (I see at least adding
> iommus and dropping some properties).
>=20
ok. I will make this changes.=20
> >
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > Signed-off-by: Smitha T Murthy <smitha.t=40samsung.com>
> > ---
> >  .../devicetree/bindings/media/s5p-mfc.txt     =7C  77 +------------
> >  .../bindings/media/samsung,s5p-mfc.yaml       =7C 109
> ++++++++++++++++++
> >  2 files changed, 110 insertions(+), 76 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> > index aa54c8159d9f..0b7c4dd40095 100644
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
>=20
> When did they become obsolete? Is it enough of time to remove them?

these properties were there earlier, we didn't added them in obsolete prope=
rties.
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
> > +This file has moved to samsung,s5p-mfc.yaml
>=20
> Just drop the TXT completely. Nothing references it.

Okay. will remove this text .
>=20
> > diff --git
> > a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > new file mode 100644
> > index 000000000000..7cd26d4acbe4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> > =40=40 -0,0 +1,109 =40=40
> > +=23 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > +---
> > +=24id:
> > +https://protect2.fireeye.com/v1/url?k=3Da9dc6a19-c8577f3c-a9dde156-74f=
e
> > +485cbff6-58df42a60c876b34&q=3D1&e=3Dedb5d5a1-11b4-42cd-9005-
> acaa7257669a&
> >
> +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Fmedia%2Fsamsung%2Cs
> 5p-mfc.y
> > +aml%23
> > +=24schema:
> > +https://protect2.fireeye.com/v1/url?k=3D1ad7b405-7b5ca120-1ad63f4a-
> 74fe
> > +485cbff6-5f46417fdb588b6c&q=3D1&e=3Dedb5d5a1-11b4-42cd-9005-
> acaa7257669a&
> > +u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: Samsung Exynos Multi Format Codec (MFC)
> > +
> > +maintainers:
> > +  - Marek Szyprowski <m.szyprowski=40samsung.com>
> > +  - Aakarsh Jain <aakarsh.jain=40samsung.com>
>=20
> and maybe you as well?
>=20
okay. will update the list.
> > +
> > +description:
> > +  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> > +  supports high resolution decoding and encoding functionalities.
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
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 3
>=20
> You need to list the items. If this varies per compatible, do it in AllOf=
.
>=20
okay. we will do the changes.
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  iommus:
> > +    maxItems: 2
> > +
> > +  iommu-names:
> > +    maxItems: 2
>=20
> You need to list the items.
>=20
Okay. We will do the changes.
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  memory-region:
> > +    maxItems: 1
>=20
> This misses the description and old binding allowed it only for MFCv5, no=
t for
> others, right?
>=20
Okay. will add the description. Yes it is for MFCv5 only.
> > +
> > +allOf:
> > +  - if:
>=20
> allOf goes after required section.
>=20
ok. we will change.
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - samsung,mfc-v5
> > +    then:
> > +      properties:
> > +        memory-region:
> > +          maxItems: 2
>=20
> Does not look like you tested the bindings. Please run =60make
> dt_binding_check=60 (see Documentation/devicetree/bindings/writing-
> schema.rst for instructions).
>=20
> This won't work. Test it and you will see it.
>=20
Okay .we will check.
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - =7C
> > +    =23 SoC specific DT entry
> > +    mfc: mfc=4012880000 =7B
> > +        compatible =3D =22samsung,fsd-mfc=22;
>=20
> Does not look like you tested the bindings. Please run =60make
> dt_binding_check=60 (see Documentation/devicetree/bindings/writing-
> schema.rst for instructions).

we didn't got any errors while running dt_binding_check with path to the ya=
ml file but we are seeing errors while running  dt_binding_check without pa=
th.
we will fix it in next series.
>=20
> > +        reg =3D <0x0 0x12880000 0x0 0x10000>;
> > +        interrupts =3D <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> > +        clock-names =3D =22mfc=22;
> > +        clocks =3D <&clock_mfc MFC_MFC_IPCLKPORT_ACLK>;
> > +        iommus =3D <&smmu_isp 0x1000 0x0>, <&smmu_isp 0x1400 0x0>;
> > +        iommu-names =3D =22left=22, =22right=22;
> > +        power-domains =3D <&pd_mfc>;
> > +        memory-region =3D <&mfc_left>, <&mfc_right>;
> > +    =7D;
> > +
> > +  - =7C
> > +    =23 Reserved memory specific DT entry for given board
> > +    =23 (see reserved memory binding for more information)
> > +    reserved-memory =7B
> > +        =23address-cells =3D <1>;
> > +        =23size-cells =3D <1>;
>=20
> Drop this example, not really related to MFC.
>=20
> > +        ranges;
>
Okay. will remove this.

Thanks for the review.=20

>=20
> Best regards,
> Krzysztof

