Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2B4566A37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiGELwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiGELwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:52:19 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9917A8B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:52:16 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220705115214epoutp01eb403e75cd3699f81dbcd967f26a1192~_7KunrZcl0481604816epoutp01c
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:52:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220705115214epoutp01eb403e75cd3699f81dbcd967f26a1192~_7KunrZcl0481604816epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657021934;
        bh=wjriQhzcZfXBlRrZeCgQjj2Z4fqF32bEp4w0XU6NxTs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=bx++9BVMlKua7+6jdm49sfepsS5M3iH63VwlyHeXmHD4P3Ls1DtK0BoI4Vl5XzA87
         e7yrpMcOUZ1gzqVDXrxcRWtHNIjERCMcETSsE4jIXJDj0gcTYwtwj9oF8mO0CfZwBB
         2LBqsIdS8FnxAZHrZfziC4a509HNBxXMP/UevjBo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220705115213epcas5p374716d394b47976928e77521f6ea1f17~_7KtnkxjX2172921729epcas5p3s;
        Tue,  5 Jul 2022 11:52:13 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LcgyM1ngjz4x9Q5; Tue,  5 Jul
        2022 11:52:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.B4.09639.BE524C26; Tue,  5 Jul 2022 20:52:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220705112643epcas5p1609a1dbce1c09969cd963483bbedf8da~_60chN3E01135111351epcas5p1U;
        Tue,  5 Jul 2022 11:26:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220705112643epsmtrp149e0fe5db0aa122c2e1d3c53bd129190~_60cgGmOB1342313423epsmtrp1J;
        Tue,  5 Jul 2022 11:26:43 +0000 (GMT)
X-AuditID: b6c32a4b-e83ff700000025a7-cf-62c425eb65da
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.11.08802.3FF14C26; Tue,  5 Jul 2022 20:26:43 +0900 (KST)
Received: from smithat07 (unknown [107.122.12.13]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220705112640epsmtip1ccdc0c5d55a15aec9824917eb2a59dc1~_60Zg1DtE2670226702epsmtip1O;
        Tue,  5 Jul 2022 11:26:40 +0000 (GMT)
From:   "Smitha T Murthy" <smitha.t@samsung.com>
To:     "'Nicolas Dufresne'" <nicolas@ndufresne.ca>,
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
In-Reply-To: <44a151e1cdbba8dcf3dfe7dfe00b6ee49c99bcfb.camel@ndufresne.ca>
Subject: RE: [PATCH 06/20] Documention: v4l: Documentation for VP9 CIDs.
Date:   Tue, 5 Jul 2022 16:56:38 +0530
Message-ID: <01e401d89062$1a7e4ff0$4f7aefd0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQJFyDoizuFNEw0PhIpG3eTqugJ4BwHIOArfAW1wjA4CGbX466xqtrXw
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbZRT3673tLZC6uwLygS+8kTgwMDoKXghsGAi7DjYJZDL8AyxwUx6l
        rS3gGETQDRLKEDZCJh0vKY8IjM1Cec7Jo1jAbY73RHAPYF2pGkLFMbcRSwvKf79zfuf8zvmd
        Lx8b4VZhLuwUcQYtEwtEBMsW7Rp2d/c0umkTvFsv2ZD3a7pYpGpTzyDvqUwoOdShwcjO6csI
        2awbYJK12ttMsnvwIUp+99jMTlQuoqS+th2QBuVvLFK9NMskH6zGkFN9VSzy/DUNk7yiXcTI
        xrkJBtmkfs4g18d7EbJe8xdGFnyvxchzhVpGsBPVVtMGqJ7FBkDNNawjVK9yEaNU1w0MSt1S
        xKIWZq+zqI6GPKrjcTFCFYz8g1JfdbYAauvLaoxSaOdYlEn9BjW+YcIi932cFphMC5JomSst
        TpQkpYiFQUR4dHxIvK+fN8+T50++R7iKBel0EBEaEekZliIyn4FwzRKIMs2pSIFcThw8HCiT
        ZGbQrskSeUYQQUuTRFK+1EsuSJdnioVeYjojgOftfcjXXPhJWvJPf6+iUkXi6YslZSAfbMQr
        gA0b4ny4Mj6CKIAtm4v3A9gxWgSswTqA+vOXGNbABOCtjhes3ZaWhXLUSvSZicmvd/r1AE6V
        dKPbVSzcC65qVcxtwgHvAdDUr8G2AwR/gsCVH5YtWjb4MdhcUG/B9jgFCxfbzVJsNoq/DR9N
        hGynObg/vP3tHGbF++FY5bJlAIK/C5u+MSLWlVzh05UmpjXvBA0jWku9Ax4GqwYaLR4gPm8D
        z9VtWvQhHgp/3Thg7bWHq7pOzIpdoKG0cAcL4T3TWWDFUlid38mw4iNwYLoK3ZZBcHd4te+g
        Nf06rBhvZ1hXeBmWPFveKefAnppdTMD6m6M78hDO/KFhlgFCuceZco8z5R43yv+n1QG0BTjT
        Unm6kJb7Sn3E9Gf/vXiiJF0NLN/EI7wHPLy/5jUEGGwwBCAbIRw4LRcHE7icJEH2GVomiZdl
        imj5EPA1X/sC4uKYKDH/M3FGPI/v78338/Pj+/v48QgnzrEZdQIXFwoy6DSaltKy3T4G28Yl
        nxGnH9Ybw4o+Lc26YrsaWpEXd7e/demlwwHPFd2vzEK+YDB1XW3QHkA0P6PLze2/V7FucJ/c
        LTy5JW91OHVjOaZJ9L4dM/zI6bKJM4HddXYnChwVuVQl4eyUc+vys5HXPGPnTulejck5u6WR
        Feub9i9FbY5FSNjt+7K59va1Pr06bvVo2PE7fZ+zFp6GpLohFQluXUbnrOmPSgLyVHrbC8YZ
        x3ItR/oWcgdLUF27OYXGHt3Hn3xH8OJBxFhWY65tBA84FU9Eh9hFf1F7Asv581Dcj8G64aux
        a8b58uC20mjmfCqG/mJYK9n6IHcpO0pY3qprPnm8Uwdd8oM+fBTl8eYkgcqTBTwPRCYX/AvX
        W8n4rwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZdlhJTvez/JEkg1M35SwezNvGZrH4x3Mm
        i/uLP7NYHNq8ld1iy5XZzBbLjx9gtZh/5ByrxfaDj1gsNr4Ayl6ceZfF4vn8dYwWL2fdY7PY
        9Pgaq8XDV+EWl3fNYbPo2bCV1WLtkbvsFkuvX2SyWLbpD5PFp1M7mS0Wbf3CbtG69wi7RUvb
        ESYHcY8189Yweuy4u4TR4/qST8weO2fdZfdYvOclk8emVZ1sHneu7WHz2Lyk3mPzi25mj9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAfxWWTkpqTWZZapG+XwJXx89R5loJJzhVX
        +w8wNzC+N+li5OSQEDCRWHVnMksXIxeHkMAORok3Pc+YIRISEit/T2KEsIUlVv57zg5R9JRR
        4uvsY2BFbAJ6Eq+OLGYFSYgI7GGUWL59FxuIwyzQzSLR+KqVCaRKSOA7o8TJXaEgNqeAl8Ty
        1kVsILawgIdE2911QJM4OFgEVCSeXXQGCfMKWEqcW3mdHcIWlDg58wkLiM0soC3R+7CVEcZe
        tvA11KUKEj+fLmOFiItLvDx6BKxXRMBNYs6BpUwTGIVnIRk1C8moWUhGzULSvoCRZRWjZGpB
        cW56brFhgVFearlecWJucWleul5yfu4mRnBC0dLawbhn1Qe9Q4xMHIyHGCU4mJVEeFdNOpgk
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUAxODFHNonuhT
        rYbNp9tmSpW3eOf4JGu3pUlLFAnucv1sunD99g9JQRZ/eVauP+i27MESH+bXPBEPr9za0XZR
        q3HSoY9MB7m6Q15zXZtVf/nT1tNrcnOe/F5xf9as/78slT6vlDKrWrZKJ6Gf5+AVxmOv10SG
        egVYxe1SZNK5UL50mWK387Qz892u3kjaYWPQOOPgXak1+w/O+H96PUdV5+al/ru5G3nPRSR4
        SRUYvv25RfXCpAa57gU7D8ubutkKx6wN8WC8O1GR3/OfWa63tJ77BrON/8yD/mbckZ5/zGOy
        xZIlcYf7LwkXxC+rCdJp5MvR/yD3X08xVcZeemHm1Kv/lZJ5f65p7Q7ZpnzrxkklluKMREMt
        5qLiRAAy1dailwMAAA==
X-CMS-MailID: 20220705112643epcas5p1609a1dbce1c09969cd963483bbedf8da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125608epcas5p48b5d2f91c711e5728f993169b1d4b9a1
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125608epcas5p48b5d2f91c711e5728f993169b1d4b9a1@epcas5p4.samsung.com>
        <20220517125548.14746-7-smitha.t@samsung.com>
        <44a151e1cdbba8dcf3dfe7dfe00b6ee49c99bcfb.camel@ndufresne.ca>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Nicolas Dufresne =5Bmailto:nicolas=40ndufresne.ca=5D
> Sent: Tuesday, May 17, 2022 6:44 PM
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
> Subject: Re: =5BPATCH 06/20=5D Documention: v4l: Documentation for VP9 CI=
Ds.
>=20
> Hi Smitha,
>=20
> Le mardi 17 mai 2022 =C3=A0=2018:25=20+0530,=20Smitha=20T=20Murthy=20a=20=
=C3=A9crit=20:=0D=0A>=20>=20Adds=20V4l2=20controls=20for=20VP9=20encoder=20=
documention.=0D=0A>=20>=0D=0A>=20>=20Cc:=20linux-fsd=40tesla.com=0D=0A>=20>=
=20Signed-off-by:=20Smitha=20T=20Murthy=20<smitha.t=40samsung.com>=0D=0A>=
=20>=20---=0D=0A>=20>=20=20.../media/v4l/ext-ctrls-codec.rst=20=20=20=20=20=
=20=20=20=20=20=20=20=20=7C=20167=20++++++++++++++++++=0D=0A>=20>=20=201=20=
file=20changed,=20167=20insertions(+)=0D=0A>=20>=0D=0A>=20>=20diff=20--git=
=20a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst=0D=0A>=20>=
=20b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst=0D=0A>=20>=
=20index=204cd7c541fc30..1b617a08f973=20100644=0D=0A>=20>=20---=20a/Documen=
tation/userspace-api/media/v4l/ext-ctrls-codec.rst=0D=0A>=20>=20+++=20b/Doc=
umentation/userspace-api/media/v4l/ext-ctrls-codec.rst=0D=0A>=20>=20=40=40=
=20-2165,6=20+2165,16=20=40=40=20enum=20v4l2_mpeg_video_vp8_profile=20-=0D=
=0A>=20>=20=20=20=20=20=20*=20-=20=60=60V4L2_MPEG_VIDEO_VP8_PROFILE_3=60=60=
=0D=0A>=20>=20=20=20=20=20=20=20=20-=20Profile=203=0D=0A>=20>=0D=0A>=20>=20=
+VP9=20Control=20Reference=0D=0A>=20>=20+---------------------=0D=0A>=20>=
=20+=0D=0A>=20>=20+The=20VP9=20controls=20include=20controls=20for=20encodi=
ng=20parameters=20of=20VP9=0D=0A>=20>=20+video=20codec.=0D=0A>=20>=20+=0D=
=0A>=20>=20+..=20_vp9-control-id:=0D=0A>=20>=20+=0D=0A>=20>=20+VP9=20Contro=
l=20IDs=0D=0A>=20>=20+=0D=0A>=20>=20=20..=20_v4l2-mpeg-video-vp9-profile:=
=0D=0A>=20>=0D=0A>=20>=20=20=60=60V4L2_CID_MPEG_VIDEO_VP9_PROFILE=60=60=0D=
=0A>=20>=20=40=40=20-2231,6=20+2241,163=20=40=40=20enum=20v4l2_mpeg_video_v=
p9_level=20-=0D=0A>=20>=20=20=20=20=20=20*=20-=20=60=60V4L2_MPEG_VIDEO_VP9_=
LEVEL_6_2=60=60=0D=0A>=20>=20=20=20=20=20=20=20=20-=20Level=206.2=0D=0A>=20=
>=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_I_FRAME_QP=60=60=0D=0A>=20=0D=
=0A>=20The=20class=20was=20recently=20renamed=20V4L2_CID_CODEC...=20for=20a=
=20reason,=20can=20you=0D=0A>=20rename=20MPEG_VIDEO=20with=20CODEC,=20speci=
ally=20for=20VP9=20CODEC=20were=20MPEG=0D=0A>=20makes=20no=20sense.=20This=
=20applies=20all=20the=20doc=20and=20the=20defines=20in=20the=20other=20pat=
ch.=0D=0A>=20=0D=0A>=20thanks,=0D=0A>=20Nicolas=0D=0A>=20=0D=0AHi=20Nichola=
s,=0D=0A=0D=0AThank=20you=20the=20review.=20I=20will=20make=20the=20change=
=20and=20push=20in=20the=20next=20series.=0D=0A=0D=0ARegards,=0D=0ASmitha=
=0D=0A>=20>=20+=20=20=20=20Quantization=20parameter=20for=20an=20I=20frame=
=20for=20VP9.=20Valid=20range:=20from=201=20to=0D=0A>=20255.=0D=0A>=20>=20+=
=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_P_FRAME_QP=60=60=0D=0A>=20>=20=
+=20=20=20=20Quantization=20parameter=20for=20an=20P=20frame=20for=20VP9.=
=20Valid=20range:=20from=201=20to=0D=0A>=20255.=0D=0A>=20>=20+=0D=0A>=20>=
=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_MAX_QP=60=60=0D=0A>=20>=20+=20=20=20=20Ma=
ximum=20quantization=20parameter=20for=20VP9.=20Valid=20range:=20from=201=
=20to=20255.=0D=0A>=20>=20+=20=20=20=20Recommended=20range=20for=20MFC=20is=
=20from=20230=20to=20255.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_=
VIDEO_VP9_MIN_QP=60=60=0D=0A>=20>=20+=20=20=20=20Minimum=20quantization=20p=
arameter=20for=20VP9.=20Valid=20range:=20from=201=20to=20255.=0D=0A>=20>=20=
+=20=20=20=20Recommended=20range=20for=20MFC=20is=20from=201=20to=2024.=0D=
=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_RC_FRAME_RATE=60=
=60=0D=0A>=20>=20+=20=20=20=20Indicates=20the=20number=20of=20evenly=20spac=
ed=20subintervals,=20called=20ticks,=20within=0D=0A>=20>=20+=20=20=20=20one=
=20second.=20This=20is=20a=2016=20bit=20unsigned=20integer=20and=20has=20a=
=20maximum=20value=0D=0A>=20up=20to=0D=0A>=20>=20+=20=20=20=200xffff=20and=
=20a=20minimum=20value=20of=201.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CI=
D_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD=60=60=0D=0A>=20>=20+=20=20=20=20Indicate=
s=20the=20refresh=20period=20of=20the=20golden=20frame=20for=20VP9=20encode=
r.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20_v4l2-vp9-golden-frame-sel:=0D=0A>=20>=
=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAMESEL=60=60=0D=
=0A>=20>=20+=20=20=20=20(enum)=0D=0A>=20>=20+=0D=0A>=20>=20+enum=20v4l2_mpe=
g_vp9_golden_framesel=20-=0D=0A>=20>=20+=20=20=20=20Selects=20the=20golden=
=20frame=20for=20encoding.=20Valid=20when=20NUM_OF_REF=20is=202.=0D=0A>=20>=
=20+=20=20=20=20Possible=20values=20are:=0D=0A>=20>=20+=0D=0A>=20>=20+..=20=
raw::=20latex=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=5Cfootnotesize=0D=
=0A>=20>=20+=0D=0A>=20>=20+..=20tabularcolumns::=20=7Cp=7B9.0cm=7D=7Cp=7B8.=
0cm=7D=7C=0D=0A>=20>=20+=0D=0A>=20>=20+..=20flat-table::=0D=0A>=20>=20+=20=
=20=20=20:header-rows:=20=200=0D=0A>=20>=20+=20=20=20=20:stub-columns:=200=
=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_MPEG_VIDEO=
_VP9_GOLDEN_FRAME_USE_PREV=60=60=0D=0A>=20>=20+=20=20=20=20=20=20-=20Use=20=
the=20(n-2)th=20frame=20as=20a=20golden=20frame,=20current=20frame=20index=
=20being=0D=0A>=20>=20+=20=20=20=20=20=20=20=20'n'.=0D=0A>=20>=20+=20=20=20=
=20*=20-=0D=0A>=20=60=60V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_REF_PERIOD=
=60=60=0D=0A>=20>=20+=20=20=20=20=20=20-=20Use=20the=20previous=20specific=
=20frame=20indicated=20by=0D=0A>=20>=20+=20=20=20=20=20=20=20=20=60=60V4L2_=
CID_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD=60=60=20as=20a=0D=0A>=20>=20+=20=20=20=
=20=20=20=20=20golden=20frame.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20raw::=20la=
tex=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=5Cnormalsize=0D=0A>=20>=20+=
=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_QP_EN=
ABLE=60=60=0D=0A>=20>=20+=20=20=20=20Allows=20host=20to=20specify=20the=20q=
uantization=20parameter=20values=20for=20each=0D=0A>=20>=20+=20=20=20=20tem=
poral=20layer=20through=20HIERARCHICAL_QP_LAYER.=20This=20is=20valid=20only=
=0D=0A>=20>=20+=20=20=20=20if=20HIERARCHICAL_CODING_LAYER=20is=20greater=20=
than=201.=20Setting=20the=20control=0D=0A>=20>=20+=20=20=20=20value=20to=20=
1=20enables=20setting=20of=20the=20QP=20values=20for=20the=20layers.=0D=0A>=
=20>=20+=0D=0A>=20>=20+..=20_v4l2-vp9-ref-number-of-pframes:=0D=0A>=20>=20+=
=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_REF_NUMBER_FOR_PFRAMES=60=60=
=0D=0A>=20>=20+=20=20=20=20(enum)=0D=0A>=20>=20+=0D=0A>=20>=20+enum=20v4l2_=
mpeg_vp9_ref_num_for_pframes=20-=0D=0A>=20>=20+=20=20=20=20Number=20of=20re=
ference=20pictures=20for=20encoding=20P=20frames.=0D=0A>=20>=20+=0D=0A>=20>=
=20+..=20raw::=20latex=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=5Cfootnote=
size=0D=0A>=20>=20+=0D=0A>=20>=20+..=20tabularcolumns::=20=7Cp=7B9.0cm=7D=
=7Cp=7B8.0cm=7D=7C=0D=0A>=20>=20+=0D=0A>=20>=20+..=20flat-table::=0D=0A>=20=
>=20+=20=20=20=20:header-rows:=20=200=0D=0A>=20>=20+=20=20=20=20:stub-colum=
ns:=200=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_MPE=
G_VIDEO_VP9_1_REF_PFRAME=60=60=0D=0A>=20>=20+=20=20=20=20=20=20-=20Indicate=
s=20one=20reference=20frame,=20last=20encoded=20frame=20will=20be=20searche=
d.=0D=0A>=20>=20+=20=20=20=20*=20-=0D=0A>=20=60=60V4L2_CID_MPEG_VIDEO_VP9_G=
OLDEN_FRAME_USE_REF_PERIOD=60=60=0D=0A>=20>=20+=20=20=20=20=20=20-=20Indica=
tes=202=20reference=20frames,=20last=20encoded=20frame=20and=20golden=20fra=
me=0D=0A>=20>=20+=20=20=20=20=20=20=20=20will=20be=20searched.=0D=0A>=20>=
=20+=0D=0A>=20>=20+..=20raw::=20latex=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=
=20=20=5Cnormalsize=0D=0A>=20>=20+=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_=
CID_MPEG_VIDEO_VP9_HIERARCHICAL_CODING_LAYER=60=60=0D=0A>=20>=20+=20=20=20=
=20Indicates=20the=20number=20of=20hierarchial=20coding=20layer.=0D=0A>=20>=
=20+=20=20=20=20In=20normal=20encoding=20(non-hierarchial=20coding),=20it=
=20should=20be=20zero.=0D=0A>=20>=20+=20=20=20=20VP9=20has=20upto=203=20lay=
er=20of=20encoder.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_V=
P9_HIERARCHY_RC_ENABLE=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20enabling=
=20of=20bit=20rate=20for=20hierarchical=20coding=20layers=20VP9=20encoder.=
=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_=
BR=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20bit=20rate=20for=20hierarchi=
cal=20coding=20layer=200=20for=20VP9=20encoder.=0D=0A>=20>=20+=0D=0A>=20>=
=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_BR=60=60=0D=0A>=20>=20+=20=
=20=20=20Indicates=20bit=20rate=20for=20hierarchical=20coding=20layer=201=
=20for=20VP9=20encoder.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VI=
DEO_VP9_HIER_CODING_L2_BR=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20bit=
=20rate=20for=20hierarchical=20coding=20layer=202=20for=20VP9=20encoder.=0D=
=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_QP=
=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20quantization=20parameter=20for=
=20hierarchical=20coding=20layer=200.=0D=0A>=20>=20+=20=20=20=20Valid=20ran=
ge:=20=5BV4L2_CID_MPEG_VIDEO_VP9_MIN_QP,=0D=0A>=20>=20+=20=20=20=20V4L2_CID=
_MPEG_VIDEO_VP9_MAX_QP=5D.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG=
_VIDEO_VP9_HIER_CODING_L1_QP=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=20qu=
antization=20parameter=20for=20hierarchical=20coding=20layer=201.=0D=0A>=20=
>=20+=20=20=20=20Valid=20range:=20=5BV4L2_CID_MPEG_VIDEO_VP9_MIN_QP,=0D=0A>=
=20>=20+=20=20=20=20V4L2_CID_MPEG_VIDEO_VP9_MAX_QP=5D.=0D=0A>=20>=20+=0D=0A=
>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_QP=60=60=0D=0A>=20>=
=20+=20=20=20=20Indicates=20quantization=20parameter=20for=20hierarchical=
=20coding=20layer=202.=0D=0A>=20>=20+=20=20=20=20Valid=20range:=20=5BV4L2_C=
ID_MPEG_VIDEO_VP9_MIN_QP,=0D=0A>=20>=20+=20=20=20=20V4L2_CID_MPEG_VIDEO_VP9=
_MAX_QP=5D.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20_v4l2-vp9-max-partition-depth=
:=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_MAX_PARTITION_=
DEPTH=60=60=0D=0A>=20>=20+=20=20=20=20(enum)=0D=0A>=20>=20+=0D=0A>=20>=20+e=
num=20v4l2_mpeg_vp9_num_partitions=20-=0D=0A>=20>=20+=20=20=20=20Indicate=
=20maximum=20coding=20unit=20depth.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20raw::=
=20latex=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=5Cfootnotesize=0D=0A>=20=
>=20+=0D=0A>=20>=20+..=20tabularcolumns::=20=7Cp=7B9.0cm=7D=7Cp=7B8.0cm=7D=
=7C=0D=0A>=20>=20+=0D=0A>=20>=20+..=20flat-table::=0D=0A>=20>=20+=20=20=20=
=20:header-rows:=20=200=0D=0A>=20>=20+=20=20=20=20:stub-columns:=200=0D=0A>=
=20>=20+=0D=0A>=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_MPEG_VIDEO_VP9_0_=
PARTITION=60=60=0D=0A>=20>=20+=20=20=20=20=20=20-=20No=20coding=20unit=20pa=
rtition=20depth.=0D=0A>=20>=20+=20=20=20=20*=20-=20=60=60V4L2_CID_MPEG_VIDE=
O_VP9_1_PARTITION=60=60=0D=0A>=20>=20+=20=20=20=20=20=20-=20Allows=20one=20=
coding=20unit=20partition=20depth.=0D=0A>=20>=20+=0D=0A>=20>=20+..=20raw::=
=20latex=0D=0A>=20>=20+=0D=0A>=20>=20+=20=20=20=20=5Cnormalsize=0D=0A>=20>=
=20+=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MPEG_VIDEO_VP9_DISABLE_INT=
RA_PU_SPLIT=60=60=0D=0A>=20>=20+=20=20=20=20Zero=20indicates=20enable=20int=
ra=20NxN=20PU=20split.=0D=0A>=20>=20+=20=20=20=20One=20indicates=20disable=
=20intra=20NxN=20PU=20split.=0D=0A>=20>=20+=0D=0A>=20>=20+=60=60V4L2_CID_MP=
EG_VIDEO_VP9_DISABLE_IVF_HEADER=60=60=0D=0A>=20>=20+=20=20=20=20Indicates=
=20IVF=20header=20generation.=20Zero=20indicates=20enable=20IVF=20format.=
=0D=0A>=20>=20+=20=20=20=20One=20indicates=20disable=20IVF=20format.=0D=0A>=
=20>=20+=0D=0A>=20>=0D=0A>=20>=20=20High=20Efficiency=20Video=20Coding=20(H=
EVC/H.265)=20Control=20Reference=0D=0A>=20>=0D=0A>=20=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=0D=0A>=20=3D=0D=0A=0D=0A=0D=0A
