Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17A580A88
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 06:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiGZEok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 00:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiGZEoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 00:44:38 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C9DD8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 21:44:31 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220726044426epoutp045392e94e5e98b4df40f5ffc395e1aee8~FR4MQma4Y0125401254epoutp04c
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:44:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220726044426epoutp045392e94e5e98b4df40f5ffc395e1aee8~FR4MQma4Y0125401254epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658810666;
        bh=IBtE4L4O4Y7bfYzhsIcjIvm0mY1ivCATQ81XFiU8Lx0=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=H28xuf/BmAFsxWxF3MN2bZ1ybi+7kmcBeSPohJIIIYVVehmQ1N2Il68+YI2tMTrtP
         tB4MIjmlawnJn05Je9FTcVvBNa5RLcCSLddrTu+FY45C0gOp9/Ph1jtoY3WwsDpy33
         tQqf62tRC2IGBomaXGouPn/3c/BtV2vO7XFFzTso=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220726044425epcas1p441a00639b9eba26d34619262aea7274e~FR4LzQecU1563715637epcas1p4W;
        Tue, 26 Jul 2022 04:44:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.70]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LsPT470PWz4x9Pw; Tue, 26 Jul
        2022 04:44:24 +0000 (GMT)
X-AuditID: b6c32a37-2cfff700000025bd-2d-62df71287451
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.B3.09661.8217FD26; Tue, 26 Jul 2022 13:44:24 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 3/4] dt-bindings: mfd: Add bindings for Samsung SysMgr
Reply-To: dj76.yang@samsung.com
Sender: Dongjin Yang <dj76.yang@samsung.com>
From:   Dongjin Yang <dj76.yang@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <313e2dc6-e8cf-f6c9-20e2-d7c766b4ecee@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220726044424epcms1p15cb45ed5d388c15dd5bab18c082f5d9b@epcms1p1>
Date:   Tue, 26 Jul 2022 13:44:24 +0900
X-CMS-MailID: 20220726044424epcms1p15cb45ed5d388c15dd5bab18c082f5d9b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmrq5G4f0kg3vdZhan979jsXh5SNNi
        /pFzrBYzp55htlg4bTmjxfNDs5gtXs66x2Zx/vwGdosjbz4yW9z/epTRYv/xlUwWl3fNYbM4
        tzjTonXvEXaLO4fPsjjwe1xfF+CxaVUnm8eda3vYPN7vu8rm0bdlFaPH501yAWxR2TYZqYkp
        qUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QAcrKZQl5pQChQIS
        i4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IzXrTsZS3Y
        q1KxettxlgbGvcpdjBwcEgImEtMXlHQxcnEICexglDi7fwUzSJxXQFDi7w7hLkZODmEBL4kr
        tyeDhYUE5CU+T6yECOtIdLx9ygISZhPQkpjdnwgyRURgFpPEijvn2EAcZoE5zBKr5rxiA2mQ
        EOCVmNEO0gBiS0tsX76VEcTmFLCT+Ht0ChNEXEPix7JeZghbVOLm6rfsMPb7Y/MZIWwRidZ7
        Z6FqBCUe/NwNFZeSeNR8AMquljjX3ssOcoSEQAOjxMHPG9kg/tWX2HHdGKSGV8BXYsqsuUwg
        YRYBVYlVm9IhKlwkvjzzBKlgFtCWWLbwNdjnzAKaEut36UNUKEscucUC81PDxt/s6GxmAT6J
        d197WGHiO+Y9gfpPWeJz82uWCYzKsxChPAvJrlkIuxYwMq9iFEstKM5NTy02LDCGx2tyfu4m
        RnCy1TLfwTjt7Qe9Q4xMHIyHGCU4mJVEeBOi7ycJ8aYkVlalFuXHF5XmpBYfYjQF+nEis5Ro
        cj4w3eeVxBuaWBqYmBmZmhoaWJgoifOumnY6UUggPbEkNTs1tSC1CKaPiYNTqoFJKGT32Qrh
        D86mPacb761g37j9Wfevva/qJitMnbTriqfG88Wau3Y9rkz4Zp4xe63JvoX58y7pPuYKv7Ej
        3H9+/9EHNyQ/znOfuuizjcaNnp2XF6kdibIPdQvhWjhtzd8e9xcKYT1p+VuPt6ZzCOumRQWu
        f8b6aO1ju2c8/Wm/hL9F6HfvODRdJel1TuOr/vcuIttykuJK5PYnCKoX/7hzt/eABeOfa8yu
        d1YqRHq6pW7tu/Hb0rf3q9L57XwNAlGZvxd/YLxyeF7Ak41eMUvvT+A5Ob0hRLGj0n1Zf8aM
        9IVd2Vsu5nuvseu//Sfo3C/t6a09XLOL+jY98/Po2dFgt8HNef+korq+rxdzd5+5p8RSnJFo
        qMVcVJwIAPn6t5g/BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef
References: <313e2dc6-e8cf-f6c9-20e2-d7c766b4ecee@kernel.org>
        <20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p3>
        <CGME20220713045628epcms1p3b5b195e2f1adf6be2a5fbeb90e567fef@epcms1p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 04:28, Krzysztof Kozlowski wrote:
> On=C2=A013/07/2022=C2=A006:56,=C2=A0Dongjin=C2=A0Yang=C2=A0wrote:=0D=0A>=
=20>=C2=A0Add=C2=A0an=C2=A0devicetree=C2=A0binding=C2=A0for=C2=A0Samsung=C2=
=A0system=C2=A0manager.=0D=0A>=20>=C2=A0This=C2=A0driver=C2=A0is=C2=A0used=
=C2=A0for=C2=A0SoCs=C2=A0produced=C2=A0by=C2=A0Samsung=C2=A0Foundry=C2=A0to=
=C2=A0provide=0D=0A>=20>=C2=A0Samsung=C2=A0sysmgr=C2=A0API.=C2=A0The=C2=A0r=
ead/write=C2=A0request=C2=A0of=C2=A0sysmgr=C2=A0is=C2=A0delivered=C2=A0to=
=0D=0A>=20>=C2=A0Samsung=C2=A0secure=C2=A0monitor=C2=A0call.=0D=0A>=20=0D=
=0A>=20Nope.=C2=A0Second=C2=A0patch=C2=A0with=C2=A0the=C2=A0same=C2=A0-=C2=
=A0you=C2=A0need=C2=A0to=C2=A0describe=C2=A0the=C2=A0hardware=C2=A0or=0D=0A=
>=20underlying=C2=A0firmware,=C2=A0not=C2=A0the=C2=A0driver.=C2=A0=22This=
=C2=A0driver=22=C2=A0is=C2=A0not=C2=A0acceptable=C2=A0for=0D=0A>=20bindings=
.=0D=0A>=20=0D=0A=0D=0AYes,=20I=20will=20describe=20the=20hardware=20and=20=
underlying=20firmware.=20=0D=0A=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0Signed-off=
-by:=C2=A0Dongjin=C2=A0Yang=C2=A0<dj76.yang=40samsung.com>=0D=0A>=20>=C2=A0=
---=0D=0A>=20>=C2=A0=C2=A0.../devicetree/bindings/mfd/samsung,sys-mgr.yaml=
=C2=A0=C2=A0=C2=A0=7C=C2=A042=C2=A0++++++++++++++++++++++=0D=0A>=20>=C2=A0=
=C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A01=C2=A0+=0D=0A>=20>=C2=A0=
=C2=A02=C2=A0files=C2=A0changed,=C2=A043=C2=A0insertions(+)=0D=0A>=20>=C2=
=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=A0Documentation/devicetree/binding=
s/mfd/samsung,sys-mgr.yaml=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0diff=C2=A0--git=
=C2=A0a/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml=C2=A0b/D=
ocumentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml=0D=0A>=20>=C2=A0n=
ew=C2=A0file=C2=A0mode=C2=A0100644=0D=0A>=20>=C2=A0index=C2=A0000000000000.=
.83b9d73a5420=0D=0A>=20>=C2=A0---=C2=A0/dev/null=0D=0A>=20>=C2=A0+++=C2=A0b=
/Documentation/devicetree/bindings/mfd/samsung,sys-mgr.yaml=0D=0A>=20>=C2=
=A0=40=40=C2=A0-0,0=C2=A0+1,42=C2=A0=40=40=0D=0A>=20>=C2=A0+=23=C2=A0SPDX-L=
icense-Identifier:=C2=A0GPL-2.0-only=C2=A0OR=C2=A0BSD-2-Clause=0D=0A>=20>=
=C2=A0+%YAML=C2=A01.2=0D=0A>=20>=C2=A0+---=0D=0A>=20>=C2=A0+=24id:=C2=A0htt=
ps://protect2.fireeye.com/v1/url?k=3D4e490fd5-2fc21afa-4e48849a-74fe485cbfe=
7-58c60ac4380837bf&q=3D1&e=3Df2eeb6c4-6c9d-40cd-9437-933a16218ac5&u=3Dhttp%=
3A%2F%2Fdevicetree.org%2Fschemas%2Ffirmware%2Fsamsung%2Csys-mgr.yaml%23=0D=
=0A>=20>=C2=A0+=24schema:=C2=A0https://protect2.fireeye.com/v1/url?k=3D1c5b=
5e89-7dd04ba6-1c5ad5c6-74fe485cbfe7-8170c2ecb94e64e4&q=3D1&e=3Df2eeb6c4-6c9=
d-40cd-9437-933a16218ac5&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fc=
ore.yaml%23=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+title:=C2=A0Samsung=C2=A0Sys=
tem=C2=A0Manager=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+maintainers:=0D=0A>=20>=
=C2=A0+=C2=A0=C2=A0-=C2=A0Jesper=C2=A0Nilsson=C2=A0<jesper.nilsson=40axis.c=
om>=0D=0A>=20=0D=0A>=20How=C2=A0is=C2=A0this=C2=A0related=C2=A0to=C2=A0Axis=
=C2=A0platforms?=0D=0A>=20=0D=0A=0D=0AThis=20is=20for=20Artpec8=20SoC.=0D=
=0A=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+description:=C2=A0=7C=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0The=C2=A0file=C2=A0documents=C2=A0device=C2=A0tree=C2=A0bin=
dings=C2=A0of=C2=A0Samsung=C2=A0system=C2=A0manager.=0D=0A>=20=0D=0A>=20Use=
less=C2=A0description.=C2=A0Describe=C2=A0the=C2=A0hardw=0D=0A>=20=0D=0A=0D=
=0AYes,=20I=20will=20describe=20hardware=20(Artpec8).=0D=0A=0D=0A>=20>=C2=
=A0+=0D=0A>=20>=C2=A0+properties:=0D=0A>=20>=C2=A0+=C2=A0=C2=A0compatible:=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0enum:=0D=0A>=20>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0samsung,sys-mgr=0D=0A>=20>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-=C2=A0samsung,sys-mgr-smccc=0D=0A>=20=0D=0A>=
=20Sorry,=C2=A0this=C2=A0does=C2=A0not=C2=A0look=C2=A0like=C2=A0hardware.=
=C2=A0It=C2=A0could=C2=A0be=C2=A0description=C2=A0of=0D=0A>=20underlying=C2=
=A0firmware,=C2=A0but=C2=A0you=C2=A0would=C2=A0need=C2=A0to=C2=A0justify=C2=
=A0it.=C2=A0Look=C2=A0at=C2=A0Qualcomm=0D=0A>=20SCM=C2=A0for=C2=A0example.=
=C2=A0Or=C2=A0ARM=C2=A0SCMI,=C2=A0SCPI.=0D=0A>=20=0D=0A=0D=0AYes,=20Should=
=20it=20be=20like=20the=20below?=20=0D=0A=0D=0Aproperties:=0D=0A=20=20compa=
tible:=0D=0A=20=20=20=20enum:=0D=0A=20=20=20=20=20=20-=20axis,artpec8-sys-m=
gr=0D=0A=20=20=20=20=20=20-=20axis,artpec8-sys-mgr-smccc=0D=0A=0D=0A>=20=0D=
=0A>=20Best=C2=A0regards,=0D=0A>=20Krzysztof=0D=0A
