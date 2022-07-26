Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD98580E47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238583AbiGZHvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiGZHvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:51:13 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3631FCED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:51:08 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220726075102epoutp01612e92f4c5c38eb27a695517f7d1ace3~FUbIDfi0j2133021330epoutp01K
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:51:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220726075102epoutp01612e92f4c5c38eb27a695517f7d1ace3~FUbIDfi0j2133021330epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658821862;
        bh=7cbsrdxQhfSbOT/EfjMR10M11VPIPwvH4SWrqQ4Hx8Y=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=PasuC1/MhFnXyheX7qTrts3+jyxgbg4QO7Vz4rmdJJYGlVl5f34xLbkEMy/JyvdbL
         YTRmRHTeResrC8Y0F2stZT+wfVHBDy6U8EUSABzFiv17zVnFrusraMQOE2DUSrQp1+
         VBWvkDfz0jzxBN5Bl2DIjP5WrzhdghZZiW4Abgm4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220726075101epcas1p403f0ddba7b224d14ee815b0cfe4cb942~FUbHVRLmd0504805048epcas1p4E;
        Tue, 26 Jul 2022 07:51:01 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LsTcP2v1Vz4x9Q7; Tue, 26 Jul
        2022 07:51:01 +0000 (GMT)
X-AuditID: b6c32a39-e51ff700000025ce-f3-62df9ce5ef75
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.58.09678.5EC9FD26; Tue, 26 Jul 2022 16:51:01 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 4/4] mfd: Samsung: Add Samsung sysmgr driver
Reply-To: dj76.yang@samsung.com
Sender: Dongjin Yang <dj76.yang@samsung.com>
From:   Dongjin Yang <dj76.yang@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
In-Reply-To: <f0ab0036-54eb-f0e4-3169-740e7fca9c65@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220726075100epcms1p105e6df50e1efb6fc43786699d223c051@epcms1p1>
Date:   Tue, 26 Jul 2022 16:51:00 +0900
X-CMS-MailID: 20220726075100epcms1p105e6df50e1efb6fc43786699d223c051
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmru7TOfeTDFouCVuc3v+OxeLlIU2L
        +UfOsVrMnHqG2WLhtOWMFs8PzWK2eDnrHpvF3tdb2S2OvPnIbHH/61FGi/3HVzJZXN41h83i
        3OJMi9a9R9gt7hw+y+LA73F9XYDHplWdbB53ru1h83i/7yqbR9+WVYwenzfJBbBFZdtkpCam
        pBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAB2spFCWmFMKFApI
        LC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOmNT8iL2g
        6ShjxbHGE8wNjO/2M3YxcnJICJhI/LnZzN7FyMUhJLCDUWLpjW6gBAcHr4CgxN8dwiA1wgIO
        EvemnQMLCwnIS3yeWAkR1pHoePuUBSTMJqAlMbs/EWSKiMBqJomXjc+ZQRxmgTnMEqvmvGKD
        2MUrMaMdpAHElpbYvnwr2A2cAnYSkzbuZYaIa0j8WNYLZYtK3Fz9lh3Gfn9sPtTNIhKt985C
        1QhKPPi5GyouJfGo+QCUXS1xrr0X7C8JgQZGiYOfN7KBXCohoC+x47oxSA2vgK/E5hMrweaw
        CKhKTL/4Cuo2F4n/00+ygtjMAtoSyxa+ZgZpZRbQlFi/Sx9iirLEkVssMF81bPzNjs5mFuCT
        ePe1hxUmvmPeEyYIW1nic/NrlgmMyrMQ4TwLya5ZCLsWMDKvYhRLLSjOTU8tNiwwhUducn7u
        JkZw2tWy3ME4/e0HvUOMTByMhxglOJiVRHgTou8nCfGmJFZWpRblxxeV5qQWH2I0BfpyIrOU
        aHI+MPHnlcQbmlgamJgZmZoaGliYKInzrpp2OlFIID2xJDU7NbUgtQimj4mDU6qBafL1Ga0S
        emdYnkiW3JAR655oJ8jeb7yaY4a/CZ+LhP5SLoetfyTlEt6bG949WLA/YYHWvdcz4wuWe9x8
        ziQUzr9yZXvtmekfPsexGtgkzjjI1RDQEG+wxrx7WlzT1KMzE94xT1I9rf+N3ey+zhfmO7JO
        X0/Pb81U7T07w/6E5sP9z3cd+fS9Z5fAO8Ftua8m/S2ZWv84drvM/ZglJQ7y8//a/FSs3LrG
        bZ6W6taFE74elbnoqL8nrXHN9a65P5JnljNte6rDz2DxhaHgurrcyj7Vrmajg/Gx3QfubpvH
        9lPc2Nl5yTeRFN8tDCq9Xy/J/PN9anjAieFtOWOx/8cNKYlsqV8+/rFkcLxw5Gm3thJLcUai
        oRZzUXEiAK8i3OhEBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec
References: <f0ab0036-54eb-f0e4-3169-740e7fca9c65@linaro.org>
        <20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
        <CGME20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 04:28, Krzysztof Kozlowski wrote:
> On=C2=A013/07/2022=C2=A006:57,=C2=A0Dongjin=C2=A0Yang=C2=A0wrote:=0D=0A>=
=20>=C2=A0This=C2=A0driver=C2=A0is=C2=A0used=C2=A0for=C2=A0SoCs=C2=A0produc=
ed=C2=A0by=C2=A0Samsung=C2=A0Foundry=C2=A0to=C2=A0provide=0D=0A>=20>=C2=A0S=
amsung=C2=A0sysmgr=C2=A0API.=C2=A0The=C2=A0read/write=C2=A0request=C2=A0of=
=C2=A0sysmgr=C2=A0is=C2=A0delivered=C2=A0to=0D=0A>=20>=C2=A0Samsung=C2=A0se=
cure=C2=A0monitor=C2=A0call.=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0Signed-off-by=
:=C2=A0Dongjin=C2=A0Yang=C2=A0<dj76.yang=40samsung.com>=0D=0A>=20>=C2=A0---=
=0D=0A>=20>=C2=A0=C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A0=C2=A02=C2=A0+=0D=0A>=20>=C2=
=A0=C2=A0drivers/mfd/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A011=C2=A0+=
++=0D=0A>=20>=C2=A0=C2=A0drivers/mfd/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A0=
=C2=A01=C2=A0+=0D=0A>=20>=C2=A0=C2=A0drivers/mfd/samsung-sysmgr.c=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0167=C2=A0++++++++++++++++++++++++=
+++++++++++++=0D=0A>=20>=C2=A0=C2=A0include/linux/mfd/samsung-sysmgr.h=C2=
=A0=7C=C2=A0=C2=A030=C2=A0+++++++=0D=0A>=20>=C2=A0=C2=A05=C2=A0files=C2=A0c=
hanged,=C2=A0211=C2=A0insertions(+)=0D=0A>=20>=C2=A0=C2=A0create=C2=A0mode=
=C2=A0100644=C2=A0drivers/mfd/samsung-sysmgr.c=0D=0A>=20>=C2=A0=C2=A0create=
=C2=A0mode=C2=A0100644=C2=A0include/linux/mfd/samsung-sysmgr.h=0D=0A>=20>=
=C2=A0=0D=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/MAINTAINERS=C2=A0b/MAINTAINER=
S=0D=0A>=20>=C2=A0index=C2=A055cb8901ccdc..44ad4bd406a9=C2=A0100644=0D=0A>=
=20>=C2=A0---=C2=A0a/MAINTAINERS=0D=0A>=20>=C2=A0+++=C2=A0b/MAINTAINERS=0D=
=0A>=20>=C2=A0=40=40=C2=A0-1870,9=C2=A0+1870,11=C2=A0=40=40=C2=A0F:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/arm/mach-artpec=0D=0A>=20>=
=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/clk/a=
xis=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0drivers/crypto/axis=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0drivers/firmware/samsung-smc-svc.c=0D=0A>=20>=C2=A0+F:=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/mfd/samsung-sysmgr.=
c=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0d=
rivers/mmc/host/usdhi6rol0.c=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/pinctrl/pinctrl-artpec*=0D=0A>=20>=C2=A0=
=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/linux/firmw=
are/samsung-smc-svc.h=0D=0A>=20>=C2=A0+F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0include/linux/mfd/samsung-sysmgr.h=0D=0A>=20=0D=0A>=20Not=C2=
=A0related=C2=A0to=C2=A0Axis/Artpec=C2=A0SoC.=0D=0A>=20=0D=0A=0D=0AIt=20is=
=20Artpec8=20SoC.=0D=0A=0D=0A>=20>=C2=A0=C2=A0=0D=0A>=20>=C2=A0=C2=A0ARM/AS=
PEED=C2=A0I2C=C2=A0DRIVER=0D=0A>=20>=C2=A0=C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Brendan=C2=A0Higgins=C2=A0<brendanhiggins=40google.=
com>=0D=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/drivers/mfd/Kconfig=C2=A0b/driv=
ers/mfd/Kconfig=0D=0A>=20>=C2=A0index=C2=A03b59456f5545..ce6ab5842bf0=C2=A0=
100644=0D=0A>=20>=C2=A0---=C2=A0a/drivers/mfd/Kconfig=0D=0A>=20>=C2=A0+++=
=C2=A0b/drivers/mfd/Kconfig=0D=0A>=20>=C2=A0=40=40=C2=A0-51,6=C2=A0+51,17=
=C2=A0=40=40=C2=A0config=C2=A0MFD_ACT8945A=0D=0A>=20>=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linear=C2=A0regulators,=
=C2=A0along=C2=A0with=C2=A0a=C2=A0complete=C2=A0ActivePath=C2=A0battery=0D=
=0A>=20>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0charger.=0D=0A>=20>=C2=A0=C2=A0=0D=0A>=20>=C2=A0+config=C2=A0MFD_SAMS=
UNG_SYSMGR=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0bool=C2=A0=22System=C2=A0Manager=C2=A0for=C2=A0Samsung=C2=A0Foundry=C2=
=A0platforms=22=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0depends=C2=A0on=C2=A0ARCH_ARTPEC=C2=A0&&=C2=A0OF=0D=0A>=20=0D=0A>=20S=
amsung=C2=A0Foundry=C2=A0does=C2=A0not=C2=A0match=C2=A0ARTPEC...=C2=A0Artpe=
c=C2=A06=C2=A0is=C2=A0not=C2=A0Samsung=C2=A0Foundry=0D=0A>=20SoC,=C2=A0is=
=C2=A0it?=0D=0A>=20=0D=0A=0D=0AThis=20is=20for=20Artpec8.=20=0D=0A=0D=0A>=
=20Missing=C2=A0compile=C2=A0test.=0D=0A>=20=0D=0A=0D=0ASorry,=20I=20will=
=20run=20it.=0D=0A=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0select=C2=A0MFD_SYSCON=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0select=C2=A0SAMSUNG_SECURE_SERVICE=0D=0A>=20>=C2=A0=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help=0D=0A>=20>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Select=C2=A0this=
=C2=A0to=C2=A0get=C2=A0System=C2=A0Manager=C2=A0support=C2=A0for=C2=A0SoCs=
=C2=A0which=C2=A0use=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0Samsung=C2=A0Foundry=C2=A0platforms.=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0This=C2=A0S=
ystem=C2=A0Manager=C2=A0has=C2=A0depedency=C2=A0on=C2=A0Samsung=C2=A0Secure=
=C2=A0Service=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0for=C2=A0providing=C2=A0secure=C2=A0service=C2=A0call.=0D=
=0A>=20=0D=0A>=20Looking=C2=A0at=C2=A0the=C2=A0driver,=C2=A0it=C2=A0does=C2=
=A0literally=C2=A0nothing.=C2=A0Looks=C2=A0like=C2=A0workaround=0D=0A>=20fo=
r=C2=A0incomplete=C2=A0bindings=C2=A0and=C2=A0DTS.=C2=A0It's=C2=A0a=C2=A0no=
-go.=0D=0A>=20=0D=0A=0D=0AThis=20driver=20is=20for=20providing=20secure=20s=
mc=20read/write=20to=20other=20IP=20driver=20in=20Artpec8=20SoC.=0D=0A=0D=
=0A=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0=C2=A0config=C2=A0MFD_SUN4I_GPADC=0D=
=0A>=20>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristat=
e=C2=A0=22Allwinner=C2=A0sunxi=C2=A0platforms'=C2=A0GPADC=C2=A0MFD=C2=A0dri=
ver=22=0D=0A>=20>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0select=C2=A0MFD_CORE=0D=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/drivers/mfd/=
Makefile=C2=A0b/drivers/mfd/Makefile=0D=0A>=20>=C2=A0index=C2=A0858cacf659d=
6..490f041d1262=C2=A0100644=0D=0A>=20>=C2=A0---=C2=A0a/drivers/mfd/Makefile=
=0D=0A>=20>=C2=A0+++=C2=A0b/drivers/mfd/Makefile=0D=0A>=20>=C2=A0=40=40=C2=
=A0-248,6=C2=A0+248,7=C2=A0=40=40=C2=A0obj-=24(CONFIG_INTEL_SOC_PMIC_MRFLD)=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=A0intel_soc_pmic_mr=
fld.o=0D=0A>=20>=C2=A0=C2=A0=0D=0A>=20>=C2=A0=C2=A0obj-=24(CONFIG_MFD_ALTER=
A_A10SR)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=A0altera-a1=
0sr.o=0D=0A>=20>=C2=A0=C2=A0obj-=24(CONFIG_MFD_ALTERA_SYSMGR)=C2=A0+=3D=C2=
=A0altera-sysmgr.o=0D=0A>=20>=C2=A0+obj-=24(CONFIG_MFD_SAMSUNG_SYSMGR)=C2=
=A0+=3D=C2=A0samsung-sysmgr.o=0D=0A>=20>=C2=A0=C2=A0obj-=24(CONFIG_MFD_STPM=
IC1)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=A0stpmic1.o=0D=
=0A>=20>=C2=A0=C2=A0obj-=24(CONFIG_MFD_SUN4I_GPADC)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=A0sun4i-gpadc.o=0D=0A>=20>=C2=A0=C2=A0=0D=
=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/drivers/mfd/samsung-sysmgr.c=C2=A0b/dr=
ivers/mfd/samsung-sysmgr.c=0D=0A>=20>=C2=A0new=C2=A0file=C2=A0mode=C2=A0100=
644=0D=0A>=20>=C2=A0index=C2=A0000000000000..a202e8c4c4f2=0D=0A>=20>=C2=A0-=
--=C2=A0/dev/null=0D=0A>=20>=C2=A0+++=C2=A0b/drivers/mfd/samsung-sysmgr.c=
=0D=0A>=20>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,167=C2=A0=40=40=0D=0A>=20>=C2=A0+=
//=C2=A0SPDX-License-Identifier:=C2=A0GPL-2.0=0D=0A>=20>=C2=A0+/*=0D=0A>=20=
>=C2=A0+=C2=A0*=C2=A0Copyright=C2=A0(C)=C2=A02019=C2=A0Samsung=C2=A0Electro=
nics,=C2=A0Co.=C2=A0Ltd.=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0Copyright=C2=A0(C)=
=C2=A02018-2019,=C2=A0Intel=C2=A0Corporation.=0D=0A>=20>=C2=A0+=C2=A0*=C2=
=A0Copyright=C2=A0(C)=C2=A02012=C2=A0Freescale=C2=A0Semiconductor,=C2=A0Inc=
.=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0Copyright=C2=A0(C)=C2=A02012=C2=A0Linaro=C2=
=A0Ltd.=0D=0A>=20>=C2=A0+=C2=A0*=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0Inspired=C2=
=A0by=C2=A0drivers/mfd/altera-sysmgr.c=0D=0A>=20>=C2=A0+=C2=A0*/=0D=0A>=20>=
=C2=A0+=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/arm-smccc.h>=0D=0A>=20>=C2=
=A0+=23include=C2=A0<linux/err.h>=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/i=
o.h>=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/mfd/samsung-sysmgr.h>=0D=0A>=
=20>=C2=A0+=23include=C2=A0<linux/mfd/syscon.h>=0D=0A>=20>=C2=A0+=23include=
=C2=A0<linux/module.h>=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/of.h>=0D=0A>=
=20>=C2=A0+=23include=C2=A0<linux/of_address.h>=0D=0A>=20>=C2=A0+=23include=
=C2=A0<linux/of_platform.h>=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/regmap.=
h>=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/slab.h>=0D=0A>=20>=C2=A0+=0D=0A>=
=20>=C2=A0+/**=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0struct=C2=A0samsung_sysmgr=C2=
=A0-=C2=A0Samsung=C2=A0System=C2=A0Manager=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0=
=40regmap:=C2=A0the=C2=A0regmap=C2=A0used=C2=A0for=C2=A0System=C2=A0Manager=
=C2=A0accesses.=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0=40base=C2=A0=C2=A0:=C2=A0the=
=C2=A0base=C2=A0address=C2=A0for=C2=A0the=C2=A0System=C2=A0Manager=0D=0A>=
=20>=C2=A0+=C2=A0*/=0D=0A>=20>=C2=A0+struct=C2=A0samsung_sysmgr=C2=A0=7B=0D=
=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0=
regmap=C2=A0=C2=A0=C2=A0*regmap;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0resource_size_t=C2=A0*base;=0D=0A>=20>=C2=A0+=7D;=
=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+static=C2=A0struct=C2=A0platform_driver=
=C2=A0samsung_sysmgr_driver;=0D=0A>=20=0D=0A>=20No,=C2=A0no=C2=A0static=C2=
=A0variables.=0D=0A>=20=0D=0A=0D=0AOk,=20I=20will=20change=20this.=0D=0A=0D=
=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+static=C2=A0struct=C2=A0regmap_config=C2=
=A0mmio_regmap_cfg=C2=A0=3D=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=3D=C2=A0=22sysmgr_mmio=22,=0D=0A>=20=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.reg_bits=C2=A0=3D=
=C2=A032,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
.reg_stride=C2=A0=3D=C2=A04,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.val_bits=C2=A0=3D=C2=A032,=0D=0A>=20>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fast_io=C2=A0=3D=C2=A0true,=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.use_single_read=
=C2=A0=3D=C2=A0true,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0.use_single_write=C2=A0=3D=C2=A0true,=0D=0A>=20>=C2=A0+=7D;=0D=
=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+static=C2=A0struct=C2=A0regmap_config=C2=
=A0samsung_smccc_regmap_cfg=C2=A0=3D=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=3D=C2=A0=22samsung_sysmgr_s=
mccc=22,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.=
reg_bits=C2=A0=3D=C2=A032,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.reg_stride=C2=A0=3D=C2=A04,=0D=0A>=20>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.val_bits=C2=A0=3D=C2=A032,=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.fast_io=C2=A0=
=3D=C2=A0true,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0.use_single_read=C2=A0=3D=C2=A0true,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.use_single_write=C2=A0=3D=C2=A0true,=0D=
=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.reg_read=C2=
=A0=3D=C2=A0samsung_smc_reg_read,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.reg_write=C2=A0=3D=C2=A0samsung_smc_reg_write,=0D=
=0A>=20>=C2=A0+=7D;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+/**=0D=0A>=20>=C2=A0=
+=C2=A0*=C2=A0samsung_sysmgr_regmap_lookup_by_phandle=0D=0A>=20>=C2=A0+=C2=
=A0*=C2=A0Find=C2=A0the=C2=A0sysmgr=C2=A0previous=C2=A0configured=C2=A0in=
=C2=A0probe()=C2=A0and=C2=A0return=C2=A0regmap=C2=A0property.=0D=0A>=20>=C2=
=A0+=C2=A0*=C2=A0Return:=C2=A0regmap=C2=A0if=C2=A0found=C2=A0or=C2=A0error=
=C2=A0if=C2=A0not=C2=A0found.=0D=0A>=20>=C2=A0+=C2=A0*/=0D=0A>=20>=C2=A0+st=
ruct=C2=A0regmap=C2=A0*samsung_sysmgr_regmap_lookup_by_phandle(struct=C2=A0=
device_node=C2=A0*np,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const=
=C2=A0char=C2=A0*property)=0D=0A>=20>=C2=A0+=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0device=C2=A0*dev;=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0sams=
ung_sysmgr=C2=A0*sysmgr;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0struct=C2=A0device_node=C2=A0*sysmgr_np;=0D=0A>=20>=C2=A0+=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=
property)=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sysmgr_np=C2=A0=3D=C2=A0of_=
parse_phandle(np,=C2=A0property,=C2=A00);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0sysmgr_np=C2=A0=3D=C2=A0np;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21sysmgr_np)=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0ERR_PTR(-ENODEV);=0D=0A>=20>=C2=A0+=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev=C2=A0=
=3D=C2=A0driver_find_device_by_of_node(&samsung_sysmgr_driver.driver,=0D=0A=
>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(void=C2=A0*)sysmgr_np);=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0of_node_p=
ut(sysmgr_np);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if=C2=A0(=21dev)=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0=
ERR_PTR(-EPROBE_DEFER);=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sysmgr=C2=A0=3D=C2=A0dev_get_drvdata(dev);=
=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0return=C2=A0sysmgr->regmap;=0D=0A>=20>=C2=A0+=7D=0D=0A>=20>=C2=A0+=
EXPORT_SYMBOL_GPL(samsung_sysmgr_regmap_lookup_by_phandle);=0D=0A>=20=0D=0A=
>=20This=C2=A0breaks=C2=A0layers/encapsulation=C2=A0and=C2=A0looks=C2=A0lik=
e=C2=A0a=C2=A0hack=C2=A0for=C2=A0incomplete=0D=0A>=20bindings/DTS.=C2=A0No,=
=C2=A0no=C2=A0exporting=C2=A0regmaps.=0D=0A>=20=0D=0A=0D=0ASimilar=20with=
=20syscon=20(syscon_regmap_lookup_by_phandle),=20but=20needed=20additional=
=20secure=20smc=20call.=0D=0A=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+static=C2=
=A0int=C2=A0sysmgr_probe(struct=C2=A0platform_device=C2=A0*pdev)=0D=0A>=20>=
=C2=A0+=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0struct=C2=A0samsung_sysmgr=C2=A0*sysmgr;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0regmap=C2=A0*regmap;=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0reso=
urce=C2=A0*res;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0struct=C2=A0device=C2=A0*dev=C2=A0=3D=C2=A0&pdev->dev;=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0regmap_conf=
ig=C2=A0sysmgr_config=C2=A0=3D=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*((str=
uct=C2=A0regmap_config=C2=A0*)of_device_get_match_data(dev));=0D=0A>=20>=C2=
=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sysmg=
r=C2=A0=3D=C2=A0devm_kzalloc(dev,=C2=A0sizeof(*sysmgr),=C2=A0GFP_KERNEL);=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=
=21sysmgr)=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0-ENOMEM;=0D=
=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0res=C2=A0=3D=C2=A0platform_get_resource(pdev,=C2=A0IORESOURCE_MEM,=C2=
=A00);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=
=C2=A0(=21res)=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0-ENOENT;=
=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0sysmgr_config.max_register=C2=A0=3D=C2=A0resource_size(res)=C2=A0-=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0sysmgr_config.reg_stride;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(sysmgr_config.reg_read)=C2=A0=7B=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=C2=A0Need=C2=A0physical=C2=A0addr=
ess=C2=A0for=C2=A0SMCC=C2=A0call=C2=A0*/=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0sysmgr->base=C2=A0=3D=C2=A0(resource_size_t=C2=A0*)res->start;=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap=C2=A0=3D=C2=A0devm_regmap_init(dev,=
=C2=A0NULL,=C2=A0sysmgr->base,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
&sysmgr_config);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=7D=C2=A0else=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sys=
mgr->base=C2=A0=3D=C2=A0devm_ioremap(dev,=C2=A0res->start,=0D=0A>=20>=C2=A0=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0resource_size(res));=0D=0A>=20>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21sysmgr->base)=0D=0A>=20>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
=C2=A0-ENOMEM;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reg=
map=C2=A0=3D=C2=A0devm_regmap_init_mmio(dev,=C2=A0sysmgr->base,=0D=0A>=20>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&sysmgr_c=
onfig);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=7D=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0if=C2=A0(IS_ERR(regmap))=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0pr_err(=22regmap=C2=A0init=C2=A0failed=5Cn=22);=0D=0A>=20=0D=0A>=
=20dev_err=0D=0A=0D=0AWill=20change=20it.=0D=0A=0D=0A>=20=0D=0A>=20>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return=C2=A0PTR_ERR(regmap);=0D=0A>=20>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>=20>=C2=A0+=0D=0A>=20>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sysmgr->regmap=C2=A0=
=3D=C2=A0regmap;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0platform_set_drvdata(pdev,=C2=A0sysmgr);=0D=0A>=
=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0return=C2=A00;=0D=0A>=20>=C2=A0+=7D=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+s=
tatic=C2=A0const=C2=A0struct=C2=A0of_device_id=C2=A0samsung_sysmgr_of_match=
=5B=5D=C2=A0=3D=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=7B=C2=A0.compatible=C2=A0=3D=C2=A0=22samsung,sys-mgr=22,=C2=
=A0.data=C2=A0=3D=C2=A0&mmio_regmap_cfg=C2=A0=7D,=0D=0A>=20>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.compatible=C2=A0=3D=C2=A0=
=22samsung,sys-mgr-smccc=22,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.data=C2=A0=3D=C2=A0&samsung_smccc_regmap_=
cfg=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D,=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7B=7D,=
=0D=0A>=20>=C2=A0+=7D;=0D=0A>=20>=C2=A0+MODULE_DEVICE_TABLE(of,=C2=A0samsun=
g_sysmgr_of_match);=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+static=C2=A0struct=
=C2=A0platform_driver=C2=A0samsung_sysmgr_driver=C2=A0=3D=C2=A0=7B=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=C2=A0=3D=
=C2=A0=C2=A0sysmgr_probe,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0.driver=C2=A0=3D=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0.name=C2=A0=3D=C2=A0=22samsung,system_manager=22,=0D=0A>=20>=C2=A0=
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.of_match_table=C2=A0=3D=C2=A0samsung_sysmgr_of_mat=
ch,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D,=
=0D=0A>=20>=C2=A0+=7D;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+static=C2=A0int=
=C2=A0__init=C2=A0samsung_sysmgr_init(void)=0D=0A>=20>=C2=A0+=7B=0D=0A>=20>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0platform=
_driver_register(&samsung_sysmgr_driver);=0D=0A>=20>=C2=A0+=7D=0D=0A>=20>=
=C2=A0+core_initcall(samsung_sysmgr_init);=0D=0A>=20=0D=0A>=20module_platfo=
rm_driver()=C2=A0instead.=0D=0A=0D=0Aok,=20I=20will=20change=20it.=0D=0A=0D=
=0A>=20=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+static=C2=A0void=C2=A0__exit=C2=
=A0samsung_sysmgr_exit(void)=0D=0A>=20>=C2=A0+=7B=0D=0A>=20>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0platform_driver_unregister(&samsu=
ng_sysmgr_driver);=0D=0A>=20>=C2=A0+=7D=0D=0A>=20>=C2=A0+module_exit(samsun=
g_sysmgr_exit);=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+MODULE_AUTHOR(=22Dongjin=
=C2=A0Yang=C2=A0<dj76.yang=40samsung.com>=22);=0D=0A>=20>=C2=A0+MODULE_DESC=
RIPTION(=22Samsung=C2=A0System=C2=A0Manager=C2=A0driver=22);=0D=0A>=20>=C2=
=A0+MODULE_LICENSE(=22GPL=22);=0D=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/inclu=
de/linux/mfd/samsung-sysmgr.h=C2=A0b/include/linux/mfd/samsung-sysmgr.h=0D=
=0A>=20>=C2=A0new=C2=A0file=C2=A0mode=C2=A0100644=0D=0A>=20>=C2=A0index=C2=
=A0000000000000..d6887cb86ea8=0D=0A>=20>=C2=A0---=C2=A0/dev/null=0D=0A>=20>=
=C2=A0+++=C2=A0b/include/linux/mfd/samsung-sysmgr.h=0D=0A>=20>=C2=A0=40=40=
=C2=A0-0,0=C2=A0+1,30=C2=A0=40=40=0D=0A>=20>=C2=A0+/*=C2=A0SPDX-License-Ide=
ntifier:=C2=A0GPL-2.0=C2=A0*/=0D=0A>=20>=C2=A0+/*=0D=0A>=20>=C2=A0+=C2=A0*=
=C2=A0Copyright=C2=A0(C)=C2=A02019=C2=A0Samsung=C2=A0Electronics,=C2=A0Co.=
=C2=A0Ltd.=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0Copyright=C2=A0(C)=C2=A02018-2019=
=C2=A0Intel=C2=A0Corporation=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0Copyright=C2=A0(=
C)=C2=A02012=C2=A0Freescale=C2=A0Semiconductor,=C2=A0Inc.=0D=0A>=20>=C2=A0+=
=C2=A0*=C2=A0Copyright=C2=A0(C)=C2=A02012=C2=A0Linaro=C2=A0Ltd.=0D=0A>=20>=
=C2=A0+=C2=A0*/=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=23ifndef=C2=A0__LINUX_M=
FD_SAMSUNG_SYSMGR_H__=0D=0A>=20>=C2=A0+=23define=C2=A0__LINUX_MFD_SAMSUNG_S=
YSMGR_H__=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/err.h>=
=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/errno.h>=0D=0A>=20>=C2=A0+=23inclu=
de=C2=A0<linux/firmware/samsung-smc-svc.h>=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=
=A0+struct=C2=A0device_node;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=23if=C2=A0=
defined(CONFIG_MFD_SAMSUNG_SYSMGR)=0D=0A>=20=0D=0A>=20No=C2=A0ifdefs,=C2=A0=
no=C2=A0stubs.=0D=0A>=20=0D=0A=0D=0Ais=20it=20ok=20to=20move=20stub=20code=
=20into=20samsung-smc-svc.c=0D=0A=0D=0A>=20=0D=0A>=20=0D=0A>=20Best=C2=A0re=
gards,=0D=0A>=20Krzysztof=0D=0A
