Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE270580892
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 01:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiGYXzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 19:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiGYXzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:55:53 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1840E25EA7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 16:55:51 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220725235548epoutp026c60055b9fecef9534caa416c34ea8be~FN8LsLsNb0689706897epoutp02s
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 23:55:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220725235548epoutp026c60055b9fecef9534caa416c34ea8be~FN8LsLsNb0689706897epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658793348;
        bh=3xwAgp50ecgZArnBgwpisGExOCAdAj0p8Ecjq1iHcGk=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=EbOVLPkuHz2pPnqz21ki3FncyGYBrbO8+MMuXXutRHjlHnS6LcOch8sLbM0Mpdy2j
         th2z3l3H7oUjvxBWkixc8NApoT8KmeQvKZTDP9bo14/SwhsQO42BB18BtR9b/M4xSD
         SP0AJYe5cRLKPbbjPz/jIysqdWxWsA7eixFDSYeY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220725235547epcas1p2796f4133d825da6be650f19f35352120~FN8LOeS_10183301833epcas1p2B;
        Mon, 25 Jul 2022 23:55:47 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.99]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LsH430Pjlz4x9Q2; Mon, 25 Jul
        2022 23:55:47 +0000 (GMT)
X-AuditID: b6c32a38-dbbc7a80000027db-59-62df2d825eec
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.95.10203.28D2FD26; Tue, 26 Jul 2022 08:55:46 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 1/4] dt-bindings: firmware: Add bindings for Samsung smc
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
In-Reply-To: <c403edcf-0c33-225c-8bbd-3a49e90a9a73@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220725235546epcms1p309bd81139c4cf3b6ff5b0376ad1c74bc@epcms1p3>
Date:   Tue, 26 Jul 2022 08:55:46 +0900
X-CMS-MailID: 20220725235546epcms1p309bd81139c4cf3b6ff5b0376ad1c74bc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmvm6T7v0kg0195han979jsXh5SNNi
        /pFzrBYzp55htlg4bTmjxfNDs5gtXs66x2Zx/vwGdosjbz4yW9z/epTRYv/xlUwWl3fNYbM4
        tzjTonXvEXaLO4fPsjjwe1xfF+CxaVUnm8eda3vYPN7vu8rm0bdlFaPH501yAWxR2TYZqYkp
        qUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QAcrKZQl5pQChQIS
        i4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IzJu65zVqw
        R69i1+cXrA2MU3W7GDk5JARMJLra9jKD2EICOxglejeJdjFycPAKCEr83SEMEhYW8JGYMecA
        O0hYSEBe4vPESoiwjkTH26csIGE2AS2J2f2JXYxcHCICs5gkVtw5xwbiMAvMYZZYNecVG8Qq
        XokZ7SANILa0xPblWxlBbE4BO4kbPY8ZIeIaEj+W9TJD2KISN1e/ZYex3x+bD1UjItF67yxU
        jaDEg5+7oeJSEo+aD0DZ1RLn2nvZQY6QEGhglDj4eSMbyKUSAvoSO64bg9TwCvhKrOjYwQRi
        swioStw8tJEJotdFYu+Zp2A3MwtoSyxb+JoZpJVZQFNi/S59iCnKEkduscB81bDxNzs6m1mA
        T+Ld1x5WmPiOeU+gpitLfG5+zTKBUXkWIpxnIdk1C2HXAkbmVYxiqQXFuempxYYFJvCYTc7P
        3cQITrhaFjsY5779oHeIkYmD8RCjBAezkghvV9rtJCHelMTKqtSi/Pii0pzU4kOMpkBfTmSW
        Ek3OB6b8vJJ4QxNLAxMzI1NTQwMLEyVx3t6ppxOFBNITS1KzU1MLUotg+pg4OKUamBgSV8rd
        YTxXPkXiR7CY9+5XDN6Bt5ZO88rdcXj+1EqWM16vF2xlq1+8MM6+Wzvks93P66t+XpR9Hbty
        jkT8AvmFdm+9eK5+nbwtTatM5OJCveVfb4hXyn7Kb1VwSnupdSxyYk9HV9iuDWsSC1WVss0+
        +kp98mLbKaI993pgEcfHghl/t80UOa6z+3lt/HqV9un/q3QrIj5dODrn8Z+ZgkopD97NPdF/
        dv7pIge1/GwjgZVes6WEFR50SL9eytm2rljyzZ5Dm5sZ9u5ZI5h1+9Mkzs5y7U6Hp/HLY9gs
        Dv/OqXmz8d1D/v471g2px82Lq9pPxB/WOW/byWJ65ymf6Js9PIIOnMVBn8567q51LlJiKc5I
        NNRiLipOBADoBvhWQQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71
References: <c403edcf-0c33-225c-8bbd-3a49e90a9a73@kernel.org>
        <20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71@epcms1p8>
        <CGME20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71@epcms1p3>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for late response.=20

On 14/07/2022 04:28, Krzysztof Kozlowski wrote:
> On=C2=A013/07/2022=C2=A006:53,=C2=A0Dongjin=C2=A0Yang=C2=A0wrote:=0D=0A>=
=20>=C2=A0Add=C2=A0an=C2=A0devicetree=C2=A0bindings=C2=A0for=C2=A0Samsung=
=C2=A0secure=C2=A0monitor=C2=A0call=C2=A0service.=0D=0A>=20>=C2=A0This=C2=
=A0driver=C2=A0is=C2=A0used=C2=A0for=C2=A0SoCs=C2=A0produced=C2=A0by=C2=A0S=
amsung=C2=A0Foundry=C2=A0to=C2=A0provide=0D=0A>=20>=C2=A0SMC=C2=A0call.=C2=
=A0This=C2=A0patch=C2=A0supports=C2=A0register=C2=A0read/write=C2=A0request=
=C2=A0to=C2=A0secure=0D=0A>=20>=C2=A0monitor.=C2=A0Also,=C2=A0SMC=C2=A0call=
=C2=A0request=C2=A0which=C2=A0uses=C2=A0shared=C2=A0memory=C2=A0to=C2=A0exc=
hange=0D=0A>=20>=C2=A0the=C2=A0data=C2=A0between=C2=A0kernel=C2=A0and=C2=A0=
secure=C2=A0monitor.=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0Signed-off-by:=C2=A0D=
ongjin=C2=A0Yang=C2=A0<dj76.yang=40samsung.com>=0D=0A>=20>=C2=A0---=0D=0A>=
=20>=C2=A0=C2=A0.../bindings/firmware/samsung,smccc-svc.yaml=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A031=C2=A0++++++++++++++++++++++=0D=0A>=
=20>=C2=A0=C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A01=C2=A0+=0D=0A>=20=
>=C2=A0=C2=A02=C2=A0files=C2=A0changed,=C2=A032=C2=A0insertions(+)=0D=0A>=
=20>=C2=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=A0Documentation/devicetree/=
bindings/firmware/samsung,smccc-svc.yaml=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0d=
iff=C2=A0--git=C2=A0a/Documentation/devicetree/bindings/firmware/samsung,sm=
ccc-svc.yaml=C2=A0b/Documentation/devicetree/bindings/firmware/samsung,smcc=
c-svc.yaml=0D=0A>=20>=C2=A0new=C2=A0file=C2=A0mode=C2=A0100644=0D=0A>=20>=
=C2=A0index=C2=A0000000000000..427c42a6cd75=0D=0A>=20>=C2=A0---=C2=A0/dev/n=
ull=0D=0A>=20>=C2=A0+++=C2=A0b/Documentation/devicetree/bindings/firmware/s=
amsung,smccc-svc.yaml=0D=0A>=20>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,31=C2=A0=40=
=40=0D=0A>=20>=C2=A0+=23=C2=A0SPDX-License-Identifier:=C2=A0GPL-2.0-only=C2=
=A0OR=C2=A0BSD-2-Clause=0D=0A>=20>=C2=A0+%YAML=C2=A01.2=0D=0A>=20>=C2=A0+--=
-=0D=0A>=20>=C2=A0+=24id:=C2=A0https://protect2.fireeye.com/v1/url?k=3Dc747=
301e-a63ad862-c746bb51-74fe485cc33c-a6f2ff257e059cb8&q=3D1&e=3D90225601-120=
2-479c-b95c-fc00645c40ab&u=3Dhttp%3A%2F%2Fdevicetree.org%2Fschemas%2Ffirmwa=
re%2Fsamsung%2Csmccc-svc.yaml%23=0D=0A>=20>=C2=A0+=24schema:=C2=A0https://p=
rotect2.fireeye.com/v1/url?k=3Dec4217dc-8d3fffa0-ec439c93-74fe485cc33c-3c5e=
ca7d394c9eea&q=3D1&e=3D90225601-1202-479c-b95c-fc00645c40ab&u=3Dhttp%3A%2F%=
2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23=0D=0A>=20>=C2=A0+=0D=0A>=20>=
=C2=A0+title:=C2=A0Samsung=C2=A0Secure=C2=A0Monitor=C2=A0call=C2=A0service=
=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+maintainers:=0D=0A>=20>=C2=A0+=C2=A0=C2=
=A0-=C2=A0Jesper=C2=A0Nilsson=C2=A0<jesper.nilsson=40axis.com>=0D=0A>=20>=
=C2=A0+=0D=0A>=20>=C2=A0+description:=C2=A0=7C=0D=0A>=20>=C2=A0+=C2=A0=C2=
=A0The=C2=A0file=C2=A0documents=C2=A0device=C2=A0tree=C2=A0bindings=C2=A0of=
=C2=A0Samsung=C2=A0secure=C2=A0monitor=0D=0A>=20>=C2=A0+=C2=A0=C2=A0call=C2=
=A0service.=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+properties:=0D=0A>=20>=C2=A0=
+=C2=A0=C2=A0compatible:=0D=0A>=20=0D=0A>=20Please=C2=A0add=C2=A0SoC=C2=A0c=
omaptible=C2=A0followed=C2=A0by=C2=A0generic=C2=A0samsung,smccc-svc=C2=A0(s=
o=C2=A0you=0D=0A>=20need=C2=A0items=C2=A0with=C2=A0an=C2=A0enum=C2=A0and=C2=
=A0const).=0D=0A>=20=0D=0A=0D=0AThis=20patch=20is=20for=20artpec8=20soc=20p=
roduct.=20I=20will=20add=20that.=0D=0A=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0const:=C2=A0samsung,smccc-svc=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+requ=
ired:=0D=0A>=20>=C2=A0+=C2=A0=C2=A0-=C2=A0compatible=0D=0A>=20>=C2=A0+=0D=
=0A>=20>=C2=A0+additionalProperties:=C2=A0false=0D=0A>=20>=C2=A0+=0D=0A>=20=
>=C2=A0+examples:=0D=0A>=20>=C2=A0+=C2=A0=C2=A0-=C2=A0=7C=0D=0A>=20>=C2=A0+=
=0D=0A>=20=0D=0A>=20No=C2=A0need=C2=A0for=C2=A0blank=C2=A0line.=0D=0A>=20=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0samsung-svc=C2=A0=7B=0D=0A>=20=0D=
=0A>=20Generic=C2=A0node=C2=A0names,=C2=A0e.g.=C2=A0smc.=0D=0A>=20=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible=C2=A0=
=3D=C2=A0=22samsung,smccc-svc=22;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=7D;=0D=0A>=20>=C2=A0+...=0D=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/MAINTAINER=
S=C2=A0b/MAINTAINERS=0D=0A>=20>=C2=A0index=C2=A020133dcd8ce9..6763746c349f=
=C2=A0100644=0D=0A>=20>=C2=A0---=C2=A0a/MAINTAINERS=0D=0A>=20>=C2=A0+++=C2=
=A0b/MAINTAINERS=0D=0A>=20>=C2=A0=40=40=C2=A0-1862,6=C2=A0+1862,7=C2=A0=40=
=40=C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Jesper=C2=A0Nils=
son=C2=A0<jesper.nilsson=40axis.com>=0D=0A>=20>=C2=A0=C2=A0M:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Lars=C2=A0Persson=C2=A0<lars.persson=40=
axis.com>=0D=0A>=20>=C2=A0=C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0linux-arm-kernel=40axis.com=0D=0A>=20>=C2=A0=C2=A0S:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maintained=0D=0A>=20>=C2=A0+F:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/devicetree/bindings/fi=
rmware/samsung,smccc-svc.yaml=0D=0A>=20=0D=0A>=20Does=C2=A0not=C2=A0look=C2=
=A0related=C2=A0to=C2=A0Artpec.=C2=A0Shouldn't=C2=A0this=C2=A0be=C2=A0under=
=C2=A0Samsung=C2=A0Exynos?=0D=0A=0D=0AThis=20patch=20is=20for=20artpec8=20s=
oc.=20=0D=0A=0D=0A>=20=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0Documentation/devicetree/bindings/pinctrl/axis,artpec6=
-pinctrl.txt=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0arch/arm/boot/dts/artpec6*=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/arm/mach-artpec=0D=0A>=20=0D=0A>=
=20=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Krzysztof=0D=0A
