Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99F55808A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiGZAEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiGZAEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:04:35 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB78FA477
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:04:33 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220726000431epoutp0470f812ba058e956ae59da887a8a9c270~FODy4vBNe0291002910epoutp04Z
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:04:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220726000431epoutp0470f812ba058e956ae59da887a8a9c270~FODy4vBNe0291002910epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658793871;
        bh=LkXyHcMzUkWmPrWHK2VEhF3sEyyKNsFexo+tAX+yX6I=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=fW8fUqZbKpG9VWNzHNPOADdROYL5qCXI714n98LljbyhIamLX1QS99uipnte3DcBQ
         X4iLP3bDXnx2/61trCtIRkZJdjouoGq+DwfnKXDNHQ8IazmpCaqvC6lMLZ8ssdvDaG
         n3f+LTEZxRU4KDRHE41NQVlXL2xQXFkC0/d5JmYI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20220726000430epcas1p3ed838e123ca9381f0ee1e8a879ebe492~FODx-Sgqh3158431584epcas1p3p;
        Tue, 26 Jul 2022 00:04:30 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LsHG547sJz4x9Q4; Tue, 26 Jul
        2022 00:04:29 +0000 (GMT)
X-AuditID: b6c32a38-dbbc7a80000027db-0c-62df2f8dc426
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.FA.10203.D8F2FD26; Tue, 26 Jul 2022 09:04:29 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 2/4] firmware: Samsung: Add secure monitor driver
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
In-Reply-To: <aec4ffd0-368d-e71a-06e4-a084138fbab9@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220726000429epcms1p6c32018733b1cf87c9f138f76f5c1bdd4@epcms1p6>
Date:   Tue, 26 Jul 2022 09:04:29 +0900
X-CMS-MailID: 20220726000429epcms1p6c32018733b1cf87c9f138f76f5c1bdd4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIJsWRmVeSWpSXmKPExsWy7bCmvm6v/v0kg/t9chan979jsXh5SNNi
        /pFzrBYzp55htlg4bTmjxfNDs5gtXs66x2ax9/VWdosjbz4yW9z/epTRYv/xlUwWl3fNYbM4
        tzjTonXvEXaLO4fPsjjwe1xfF+CxaVUnm8eda3vYPN7vu8rm0bdlFaPH501yAWxR2TYZqYkp
        qUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QAcrKZQl5pQChQIS
        i4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IzvkxsYil4
        d5Kx4s/GPywNjKeOMHYxcnJICJhILO2fwtrFyMUhJLCDUWL1679ACQ4OXgFBib87hEFqhAVc
        JU7cus4OEhYSkJf4PLESIqwj0fH2KQtImE1AS2J2fyLIFBGB1UwSLxufM4M4zAJzmCVWzXnF
        BrGLV2JGO0gDiC0tsX35VrAbOAXsJH5O/McOEdeQ+LGslxnCFpW4ufotO4z9/th8qJtFJFrv
        nYWqEZR48HM3VFxK4lHzASi7WuJcey87yBESAg2MEgc/b2QDuVRCQF9ix3VjkBpeAV+JXVNn
        soLYLAKqEuf2r4Ga6SKxc+p2sDizgLbEsoWvmUFamQU0Jdbv0oeYoixx5BYLzFcNG3+zo7OZ
        Bfgk3n3tYYWJ75j3hAnCVpb43PyaZQKj8ixEOM9CsmsWwq4FjMyrGMVSC4pz01OLDQtM4JGb
        nJ+7iRGcdrUsdjDOfftB7xAjEwfjIUYJDmYlEd6utNtJQrwpiZVVqUX58UWlOanFhxhNgb6c
        yCwlmpwPTPx5JfGGJpYGJmZGpqaGBhYmSuK8vVNPJwoJpCeWpGanphakFsH0MXFwSjUwRbyw
        cXnYu86T9+6SV4stD57iWcTv7xJosI2hQdeGj1l7Vux5h437JLxCDUtXJGzLkr/7i/mZQBn3
        7pOTH/nYMO7/ovr40Y6KqJnT1qmuMVcoeVi2XWgiF8v3B+lWSpzz1my/Mf9u27zsL8umzVgk
        0rLvxiZvhlT/jJRJRsvcvCbE1jRP7VV9vXOh/4rwo2tKr3cwHwxn/q7ywzZi197GxVd27ozm
        WXo3+9e+qTn67fPqpD2+Pvhrpf785Ic/LxUCdNVEGdMlDj55ejn47p5fJ/NUk0SXh5/S/REc
        u3/9pS2pPB03FX7YX366cdMEtn9rPvHzVn8r/q0hciLv+LLijTZLjic01n77Mnt3kqhswEkl
        luKMREMt5qLiRAAfFQh5RAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220713045516epcms1p86b3f6a8795d767faac65eb947405f911
References: <aec4ffd0-368d-e71a-06e4-a084138fbab9@linaro.org>
        <20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p8>
        <CGME20220713045516epcms1p86b3f6a8795d767faac65eb947405f911@epcms1p6>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/07/2022 04:28, Krzysztof Kozlowski wrote:
> On=C2=A013/07/2022=C2=A006:55,=C2=A0Dongjin=C2=A0Yang=C2=A0wrote:=0D=0A>=
=20>=C2=A0Introduce=C2=A0a=C2=A0driver=C2=A0to=C2=A0provide=C2=A0calls=C2=
=A0into=C2=A0secure=C2=A0monitor=C2=A0mode.=0D=0A>=20>=C2=A0This=C2=A0drive=
r=C2=A0is=C2=A0used=C2=A0for=C2=A0SoCs=C2=A0produced=C2=A0by=C2=A0Samsung=
=C2=A0Foundry=C2=A0to=C2=A0provide=0D=0A>=20>=C2=A0SMC=C2=A0call.=C2=A0This=
=C2=A0patch=C2=A0supports=C2=A0register=C2=A0read/write=C2=A0request=C2=A0t=
o=C2=A0secure=0D=0A>=20>=C2=A0monitor.=C2=A0Also,=C2=A0SMC=C2=A0call=C2=A0r=
equest=C2=A0which=C2=A0uses=C2=A0shared=C2=A0memory=C2=A0to=C2=A0exchange=
=0D=0A>=20>=C2=A0the=C2=A0data=C2=A0between=C2=A0kernel=C2=A0and=C2=A0secur=
e=C2=A0monitor.=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0Signed-off-by:=C2=A0Dongji=
n=C2=A0Yang=C2=A0<dj76.yang=40samsung.com>=0D=0A>=20>=C2=A0---=0D=0A>=20>=
=C2=A0=C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A0=C2=A0=
2=C2=A0+=0D=0A>=20>=C2=A0=C2=A0drivers/firmware/Kconfig=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=7C=C2=A0=C2=A011=C2=A0+++=0D=0A>=20>=C2=A0=C2=A0drivers/firmware/=
Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=A0=C2=A0=C2=A01=C2=A0+=0D=0A>=20>=C2=
=A0=C2=A0drivers/firmware/samsung-smc-svc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=7C=C2=A0154=C2=A0+++++++++++++++++++++++++++++++=0D=0A>=20>=C2=
=A0=C2=A0include/linux/firmware/samsung-smc-svc.h=C2=A0=7C=C2=A0=C2=A059=C2=
=A0++++++++++++=0D=0A>=20>=C2=A0=C2=A05=C2=A0files=C2=A0changed,=C2=A0227=
=C2=A0insertions(+)=0D=0A>=20>=C2=A0=C2=A0create=C2=A0mode=C2=A0100644=C2=
=A0drivers/firmware/samsung-smc-svc.c=0D=0A>=20>=C2=A0=C2=A0create=C2=A0mod=
e=C2=A0100644=C2=A0include/linux/firmware/samsung-smc-svc.h=0D=0A>=20>=C2=
=A0=0D=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/MAINTAINERS=C2=A0b/MAINTAINERS=
=0D=0A>=20>=C2=A0index=C2=A06763746c349f..d173043ffb46=C2=A0100644=0D=0A>=
=20>=C2=A0---=C2=A0a/MAINTAINERS=0D=0A>=20>=C2=A0+++=C2=A0b/MAINTAINERS=0D=
=0A>=20>=C2=A0=40=40=C2=A0-1868,8=C2=A0+1868,10=C2=A0=40=40=C2=A0F:=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/arm/boot/dts/artpec6*=0D=0A>=
=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arch/arm/=
mach-artpec=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0drivers/clk/axis=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0drivers/crypto/axis=0D=0A>=20>=C2=A0+F:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/firmware/samsung-smc-svc.c=0D=
=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drive=
rs/mmc/host/usdhi6rol0.c=0D=0A>=20>=C2=A0=C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0drivers/pinctrl/pinctrl-artpec*=0D=0A>=20>=C2=A0+F:=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0include/linux/firmware/sams=
ung-smc-svc.h=0D=0A>=20=0D=0A>=20Same=C2=A0as=C2=A0for=C2=A0bindings=C2=A0-=
=C2=A0not=C2=A0related=C2=A0to=C2=A0Artpec=C2=A0platforms.=C2=A0Either=C2=
=A0add=0D=0A>=20dedicated=C2=A0entry=C2=A0or=C2=A0put=C2=A0it=C2=A0under=C2=
=A0Samsung=C2=A0SoC.=0D=0A>=20=0D=0A=0D=0AThis=20patch=20is=20for=20Artpec8=
=20SoC.=0D=0A=0D=0A>=20>=C2=A0=C2=A0=0D=0A>=20>=C2=A0=C2=A0ARM/ASPEED=C2=A0=
I2C=C2=A0DRIVER=0D=0A>=20>=C2=A0=C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Brendan=C2=A0Higgins=C2=A0<brendanhiggins=40google.com>=0D=
=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/drivers/firmware/Kconfig=C2=A0b/driver=
s/firmware/Kconfig=0D=0A>=20>=C2=A0index=C2=A0e5cfb01353d8..4b0f2d033f58=C2=
=A0100644=0D=0A>=20>=C2=A0---=C2=A0a/drivers/firmware/Kconfig=0D=0A>=20>=C2=
=A0+++=C2=A0b/drivers/firmware/Kconfig=0D=0A>=20>=C2=A0=40=40=C2=A0-217,6=
=C2=A0+217,17=C2=A0=40=40=C2=A0config=C2=A0QCOM_SCM_DOWNLOAD_MODE_DEFAULT=
=0D=0A>=20>=C2=A0=C2=A0=0D=0A>=20>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Say=C2=A0Y=C2=A0here=C2=A0to=C2=A0enable=
=C2=A0=22download=C2=A0mode=22=C2=A0by=C2=A0default.=0D=0A>=20>=C2=A0=C2=A0=
=0D=0A>=20>=C2=A0+config=C2=A0SAMSUNG_SECURE_SERVICE=0D=0A>=20>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=C2=A0=22Samsung=C2=A0Foun=
dry=C2=A0Secure=C2=A0Service=C2=A0Layer=22=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends=C2=A0on=C2=A0HAVE_ARM_SMCCC=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default=C2=A0n=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help=0D=
=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
Support=C2=A0secure=C2=A0service=C2=A0layer=C2=A0for=C2=A0SoCs=C2=A0which=
=C2=A0is=C2=A0manufactured=C2=A0by=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Samsung=C2=A0Foundry.=0D=0A>=20>=C2=
=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0This=C2=A0option=C2=A0provide=C2=A0support=C2=A0of=C2=A0secure=C2=
=A0monitor=C2=A0service=C2=A0call=C2=A0using=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Trusted=C2=A0Foundations.=
=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0=C2=A0config=C2=A0SYSFB=0D=0A>=20>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool=0D=0A>=20>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default=C2=A0y=0D=0A>=
=20>=C2=A0diff=C2=A0--git=C2=A0a/drivers/firmware/Makefile=C2=A0b/drivers/f=
irmware/Makefile=0D=0A>=20>=C2=A0index=C2=A04e58cb474a68..985e30a9665f=C2=
=A0100644=0D=0A>=20>=C2=A0---=C2=A0a/drivers/firmware/Makefile=0D=0A>=20>=
=C2=A0+++=C2=A0b/drivers/firmware/Makefile=0D=0A>=20>=C2=A0=40=40=C2=A0-19,=
6=C2=A0+19,7=C2=A0=40=40=C2=A0obj-=24(CONFIG_RASPBERRYPI_FIRMWARE)=C2=A0+=
=3D=C2=A0raspberrypi.o=0D=0A>=20>=C2=A0=C2=A0obj-=24(CONFIG_FW_CFG_SYSFS)=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=A0qemu_fw_cfg.o=0D=
=0A>=20>=C2=A0=C2=A0obj-=24(CONFIG_QCOM_SCM)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=
=A0qcom-scm.o=0D=0A>=20>=C2=A0=C2=A0qcom-scm-objs=C2=A0+=3D=C2=A0qcom_scm.o=
=C2=A0qcom_scm-smc.o=C2=A0qcom_scm-legacy.o=0D=0A>=20>=C2=A0+obj-=24(CONFIG=
_SAMSUNG_SECURE_SERVICE)=C2=A0+=3D=C2=A0samsung-smc-svc.o=0D=0A>=20>=C2=A0=
=C2=A0obj-=24(CONFIG_SYSFB)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=C2=A0sysfb.o=0D=0A>=20=
>=C2=A0=C2=A0obj-=24(CONFIG_SYSFB_SIMPLEFB)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0+=3D=C2=A0sysfb_simplefb.o=0D=0A>=20>=C2=A0=C2=A0obj-=24(=
CONFIG_TI_SCI_PROTOCOL)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+=3D=
=C2=A0ti_sci.o=0D=0A>=20>=C2=A0diff=C2=A0--git=C2=A0a/drivers/firmware/sams=
ung-smc-svc.c=C2=A0b/drivers/firmware/samsung-smc-svc.c=0D=0A>=20>=C2=A0new=
=C2=A0file=C2=A0mode=C2=A0100644=0D=0A>=20>=C2=A0index=C2=A0000000000000..e=
b3a5285cf2b=0D=0A>=20>=C2=A0---=C2=A0/dev/null=0D=0A>=20>=C2=A0+++=C2=A0b/d=
rivers/firmware/samsung-smc-svc.c=0D=0A>=20>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,=
154=C2=A0=40=40=0D=0A>=20>=C2=A0+//=C2=A0SPDX-License-Identifier:=C2=A0GPL-=
2.0=0D=0A>=20>=C2=A0+/*=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0Copyright=C2=A0(c)=C2=
=A02019=C2=A0Samsung=C2=A0Electronics=C2=A0Co.,=C2=A0Ltd.=0D=0A>=20>=C2=A0+=
=C2=A0*=C2=A0Author:=C2=A0Kihyun=C2=A0Yoon<kihyun.yoon=40samsung.com>=0D=0A=
>=20>=C2=A0+=C2=A0*=C2=A0Author:=C2=A0Dongjin=C2=A0Yang<dj76.yang=40samsung=
.com>=0D=0A>=20>=C2=A0+=C2=A0*=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0This=C2=A0prog=
ram=C2=A0is=C2=A0free=C2=A0software;=C2=A0you=C2=A0can=C2=A0redistribute=C2=
=A0it=C2=A0and/or=C2=A0modify=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0it=C2=A0under=
=C2=A0the=C2=A0terms=C2=A0of=C2=A0the=C2=A0GNU=C2=A0General=C2=A0Public=C2=
=A0License=C2=A0version=C2=A02=C2=A0as=0D=0A>=20>=C2=A0+=C2=A0*=C2=A0publis=
hed=C2=A0by=C2=A0the=C2=A0Free=C2=A0Software=C2=A0Foundation.=0D=0A>=20>=C2=
=A0+=C2=A0*=0D=0A>=20=0D=0A>=20Drop=C2=A0boiler=C2=A0plate=C2=A0with=C2=A0t=
railing=C2=A0empty=C2=A0'*'=C2=A0comment.=0D=0A>=20=0D=0A=0D=0AYes,=0D=0A=
=0D=0A>=20>=C2=A0+=C2=A0*/=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=23include=C2=
=A0<linux/types.h>=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/errno.h>=0D=0A>=
=20>=C2=A0+=23include=C2=A0<linux/module.h>=0D=0A>=20>=C2=A0+=23include=C2=
=A0<linux/io.h>=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/of.h>=0D=0A>=20>=C2=
=A0+=23include=C2=A0<linux/of_device.h>=0D=0A>=20>=C2=A0+=23include=C2=A0<l=
inux/platform_device.h>=0D=0A>=20>=C2=A0+=23include=C2=A0<linux/firmware/sa=
msung-smc-svc.h>=0D=0A>=20=0D=0A>=20Order=C2=A0the=C2=A0headers=C2=A0by=C2=
=A0name.=0D=0A>=20=0D=0A=0D=0AYes=20I=20will,=0D=0A=0D=0A>=20>=C2=A0+=0D=0A=
>=20>=C2=A0+struct=C2=A0samsung_smc_version=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32=C2=A0major;=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32=C2=A0minor;=0D=0A>=
=20>=C2=A0+=7D;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+struct=C2=A0samsung_smc_=
data=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0struct=C2=A0samsung_smc_version=C2=A0version;=0D=0A>=20>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32=C2=A0svc_cmd_list=5BSAMSUNG_S=
IP_NR_SIP=5D;=0D=0A>=20>=C2=A0+=7D;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+stru=
ct=C2=A0samsung_smc_data=C2=A0*svc_data;=0D=0A>=20=0D=0A>=20No,=C2=A0no=C2=
=A0globals.=C2=A0Even=C2=A0no=C2=A0static=C2=A0variables.=0D=0A>=20=0D=0A=
=0D=0AYes,=20let=20me=20change=20the=20driver=0D=0A=0D=0A>=20>=C2=A0+=0D=0A=
>=20>=C2=A0+static=C2=A0int=C2=A0samsung_smc_svc_init(void);=0D=0A>=20>=C2=
=A0+=0D=0A>=20>=C2=A0+static=C2=A0int=C2=A0__samsung_get_svc_cmd(u32=C2=A0c=
md_idx)=0D=0A>=20>=C2=A0+=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if=C2=A0(cmd_idx=C2=A0>=3D=C2=A0SAMSUNG_SIP_NR_SIP)=0D=
=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0SAMSUNG_SIP_NOT_SUPPORTED;=
=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0/*=C2=A0Initialize=C2=A0this=C2=A0driver=C2=A0if=C2=A0it=C2=A0is=
=C2=A0not=C2=A0ready=C2=A0*/=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if=C2=A0(=21svc_data=C2=A0&&=C2=A0samsung_smc_svc_init=
())=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err(=22samsung,smccc_=
service=C2=A0initialization=C2=A0is=C2=A0failed=5Cn=22);=0D=0A>=20>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return=C2=A0SAMSUNG_SIP_NOT_SUPPORTED;=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>=20>=C2=A0+=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=
=A0svc_data->svc_cmd_list=5Bcmd_idx=5D;=0D=0A>=20>=C2=A0+=7D=0D=0A>=20>=C2=
=A0+=0D=0A>=20>=C2=A0+int=C2=A0samsung_smc_call(u32=C2=A0cmd_idx,=0D=0A>=20=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned=C2=A0l=
ong=C2=A0a0,=C2=A0unsigned=C2=A0long=C2=A0a1,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned=C2=A0long=C2=A0a2,=C2=A0uns=
igned=C2=A0long=C2=A0a3,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0u32=C2=A0*val)=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=7B=0D=
=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0=
arm_smccc_res=C2=A0res;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0u32=C2=A0cmd=C2=A0=3D=C2=A0__samsung_get_svc_cmd(cmd_idx);=
=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0if=C2=A0(cmd=C2=A0=3D=3D=C2=A0SAMSUNG_SIP_NOT_SUPPORTED)=0D=0A>=20=
>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0-EOPNOTSUPP;=0D=0A>=20>=C2=A0+=0D=
=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arm_smccc_sm=
c(cmd,=C2=A0a0,=C2=A0a1,=C2=A0a2,=C2=A0a3,=C2=A00,=C2=A00,=C2=A00,=C2=A0&re=
s);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=
=A0(res.a0=C2=A0=3D=3D=C2=A0SMCCC_RET_NOT_SUPPORTED)=0D=0A>=20>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return=C2=A0-EINVAL;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(val)=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0*val=C2=A0=3D=C2=A0(u32)res.a1;=0D=0A>=20>=C2=A0=
+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
=C2=A00;=0D=0A>=20>=C2=A0+=7D=0D=0A>=20>=C2=A0+EXPORT_SYMBOL(samsung_smc_ca=
ll);=0D=0A>=20=0D=0A>=20EXPORT_SYMBOL_GPL=0D=0A>=20=0D=0A>=20You=C2=A0need=
=C2=A0kerneldoc=C2=A0for=C2=A0all=C2=A0these.=0D=0A>=20=0D=0A=0D=0AYes,=0D=
=0A=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+int=C2=A0samsung_smc_reg_read(void=
=C2=A0*base,=C2=A0u32=C2=A0reg,=C2=A0u32=C2=A0*val)=0D=0A>=20>=C2=A0+=7B=0D=
=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0=
samsung_smc_call(SAMSUNG_SIP_READ_REG,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0(unsigned=C2=A0long)base,=C2=A0reg,=C2=A00,=C2=A00,=
=C2=A0val);=0D=0A>=20>=C2=A0+=7D=0D=0A>=20>=C2=A0+EXPORT_SYMBOL(samsung_smc=
_reg_read);=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+int=C2=A0samsung_smc_reg_wri=
te(void=C2=A0*base,=C2=A0u32=C2=A0reg,=C2=A0u32=C2=A0val)=0D=0A>=20>=C2=A0+=
=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
=C2=A0samsung_smc_call(SAMSUNG_SIP_WRITE_REG,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(unsigned=C2=A0long)base,=C2=A0re=
g,=C2=A0val,=C2=A00,=C2=A0NULL);=0D=0A>=20>=C2=A0+=7D=0D=0A>=20>=C2=A0+EXPO=
RT_SYMBOL(samsung_smc_reg_write);=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+static=
=C2=A0int=C2=A0samsung_smc_check_version(struct=C2=A0samsung_smc_version=C2=
=A0*ver)=0D=0A>=20>=C2=A0+=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0struct=C2=A0arm_smccc_res=C2=A0res;=0D=0A>=20>=C2=A0+=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arm_smccc=
_smc(SAMSUNG_SIP_SVC_VERSION,=C2=A00,=C2=A00,=C2=A00,=C2=A00,=C2=A00,=C2=A0=
0,=C2=A00,=C2=A0&res);=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0((u32)res.a0=C2=A0=21=3D=C2=A0ver-=
>major=C2=A0=7C=7C=C2=A0(u32)res.a1=C2=A0=21=3D=C2=A0ver->minor)=0D=0A>=20>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0-EINVAL;=0D=0A>=20>=C2=A0+=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info(=22Samsu=
ng=C2=A0SVC=C2=A0version=C2=A0=5B%d.%d=5D=C2=A0is=C2=A0detected=5Cn=22,=0D=
=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ver->major,=C2=A0ver->minor);=0D=0A>=20=
>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
eturn=C2=A00;=0D=0A>=20>=C2=A0+=7D=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+stati=
c=C2=A0const=C2=A0struct=C2=A0samsung_smc_data=C2=A0svc_0_1=C2=A0=3D=C2=A0=
=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.versi=
on=C2=A0=3D=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.major=C2=A0=3D=
=C2=A00,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.minor=C2=A0=3D=C2=A01=0D=
=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D,=0D=0A>=
=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.svc_cmd_list=C2=
=A0=3D=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=5BSAMSUNG_SIP_READ_R=
EG=5D=C2=A0=3D=C2=A00x82000020,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=5B=
SAMSUNG_SIP_WRITE_REG=5D=C2=A0=3D=C2=A00x82000021,=0D=0A>=20>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0/*=C2=A0TODO:=C2=A0SMC=C2=A0call=C2=A0for=C2=A0clock=C2=A0dr=
iver=C2=A0should=C2=A0be=C2=A0added=C2=A0*/=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>=20>=C2=A0+=7D;=0D=0A>=20>=C2=
=A0+=0D=0A>=20>=C2=A0+static=C2=A0const=C2=A0struct=C2=A0of_device_id=C2=A0=
samsung_smc_of_match=5B=5D=C2=A0=3D=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7B=C2=A0.compatible=C2=A0=3D=C2=A0=22s=
amsung,smccc-svc=22,=C2=A0.data=C2=A0=3D=C2=A0&svc_0_1=C2=A0=7D,=0D=0A>=20>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7B=C2=A0/*=C2=A0sen=
tinel=C2=A0*/=C2=A0=7D=0D=0A>=20>=C2=A0+=7D;=0D=0A>=20>=C2=A0+=0D=0A>=20>=
=C2=A0+static=C2=A0int=C2=A0samsung_smc_svc_init(void)=0D=0A>=20>=C2=A0+=7B=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=
=A0device_node=C2=A0*fw_np;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0struct=C2=A0device_node=C2=A0*np;=0D=0A>=20>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const=C2=A0struct=C2=A0of_device_=
id=C2=A0*match;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0int=C2=A0ret;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=A0(svc_data)=C2=A0=7B=0D=0A>=20>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pr_info(=22samsung,smccc_service=C2=A0is=C2=A0already=
=C2=A0initialized=5Cn=22);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=
=A00;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=
=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0fw_np=C2=A0=3D=C2=A0of_find_node_by_name(NULL,=C2=A0=22firmware=22=
);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=C2=
=A0(=21fw_np)=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0-ENODEV;=
=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0np=C2=A0=3D=C2=A0of_find_matching_node_and_match(fw_np,=C2=A0samsu=
ng_smc_of_match,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0&match);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0if=C2=A0(=21np)=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0-EN=
ODEV;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0svc_data=C2=A0=3D=C2=A0(struct=C2=A0samsung_smc_data=C2=A0*)=
match->data;=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0if=C2=A0(=21svc_data)=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0=
-ENODEV;=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0ret=C2=A0=3D=C2=A0samsung_smc_check_version(&svc_data->ve=
rsion);=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if=
=C2=A0(ret)=C2=A0=7B=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err(=22samsu=
ng=C2=A0svc=C2=A0version=C2=A0is=C2=A0not=C2=A0matched=5Cn=22);=0D=0A>=20>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A0ret;=0D=0A>=20>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_info(=22samsung=C2=
=A0smc=C2=A0svc=C2=A0is=C2=A0initialized=5Cn=22);=0D=0A>=20=0D=0A>=20No=C2=
=A0useless=C2=A0success=C2=A0printks.=C2=A0We=C2=A0have=C2=A0tracing=C2=A0a=
nd=C2=A0sysfs=C2=A0for=C2=A0that.=0D=0A>=20=0D=0A=0D=0AOk,=0D=0A=0D=0A>=20>=
=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=C2=A00;=0D=0A=
>=20>=C2=A0+=7D=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+early_initcall(samsung_s=
mc_svc_init);=0D=0A>=20=0D=0A>=20No.=C2=A0Make=C2=A0it=C2=A0a=C2=A0platform=
=C2=A0driver.=0D=0A>=20=0D=0A=0D=0AOk,=20I=20will=20change,=0D=0A=0D=0A>=20=
>=C2=A0diff=C2=A0--git=C2=A0a/include/linux/firmware/samsung-smc-svc.h=C2=
=A0b/include/linux/firmware/samsung-smc-svc.h=0D=0A>=20>=C2=A0new=C2=A0file=
=C2=A0mode=C2=A0100644=0D=0A>=20>=C2=A0index=C2=A0000000000000..9c94fd3e10a=
2=0D=0A>=20>=C2=A0---=C2=A0/dev/null=0D=0A>=20>=C2=A0+++=C2=A0b/include/lin=
ux/firmware/samsung-smc-svc.h=0D=0A>=20>=C2=A0=40=40=C2=A0-0,0=C2=A0+1,59=
=C2=A0=40=40=0D=0A>=20>=C2=A0+/*=C2=A0SPDX-License-Identifier:=C2=A0GPL-2.0=
-only=C2=A0*/=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=23ifndef=C2=A0__SAMSUNG_S=
MC_H=0D=0A>=20>=C2=A0+=23define=C2=A0__SAMSUNG_SMC_H=0D=0A>=20=0D=0A>=20Ext=
end=C2=A0the=C2=A0header=C2=A0gaurd=C2=A0to=C2=A0match=C2=A0path.=0D=0A>=20=
=0D=0A=0D=0AYes,=0D=0A=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=23include=C2=A0<=
linux/arm-smccc.h>=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=23ifdef=C2=A0CONFIG_=
SAMSUNG_SECURE_SERVICE=0D=0A>=20=0D=0A>=20No=C2=A0ifdefs=C2=A0in=C2=A0heade=
rs.=C2=A0This=C2=A0is=C2=A0not=C2=A0a=C2=A0subsystem.=0D=0A>=20=0D=0A=0D=0A=
Yes,=20I=20will=20remove,=0D=0A=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+=23defin=
e=C2=A0SAMSUNG_SIP_CALL_VAL(x)=C2=A0=5C=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,=C2=A0=5C=0D=0A>=20>=C2=A0+=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0ARM_SMCCC_SMC_32,=C2=A0ARM_SMCCC_OWNER_SIP,=C2=A0x)=0D=0A>=
=20=0D=0A>=20Need=C2=A0kerneldoc.=0D=0A>=20=0D=0A=0D=0AYes,=20I=20will=20ad=
d=20kerneldoc.=0D=0A=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+/*=C2=A0Common=C2=
=A0SIP=C2=A0SVC=C2=A0number=C2=A0*/=0D=0A>=20>=C2=A0+=23define=C2=A0SAMSUIN=
G_SIP_SVC_CALL_COUNT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SAMSUNG=
_SIP_CALL_VAL(0xff00)=0D=0A>=20>=C2=A0+=23define=C2=A0SAMSUING_SIP_SVC_UID=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0SAMSUNG_SIP_CALL_VAL(0xff01)=0D=0A>=20>=C2=A0+=23defin=
e=C2=A0SAMSUNG_SIP_SVC_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SAMSUNG_SIP_CALL_VAL(0xf=
f03)=0D=0A>=20>=C2=A0+=23define=C2=A0SAMSUNG_SIP_NOT_SUPPORTED=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0=0D=0A>=20=0D=0A>=20Need=C2=A0kernel=
doc.=0D=0A>=20=0D=0A>=20=0D=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+enum=C2=A0=7B=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=C2=A0S=
IP=C2=A0enumeration=C2=A0for=C2=A0V0.1=C2=A0*/=0D=0A>=20>=C2=A0+=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SAMSUNG_SIP_READ_REG,=0D=0A>=20>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SAMSUNG_SIP_WRITE_REG,=
=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*=C2=A0A=
dd=C2=A0here=C2=A0for=C2=A0later=C2=A0version=C2=A0*/=0D=0A>=20>=C2=A0+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SAMSUNG_SIP_NR_SIP=0D=0A>=20>=
=C2=A0+=7D;=0D=0A>=20=0D=0A>=20Need=C2=A0kerneldoc.=0D=0A>=20=0D=0A>=20=0D=
=0A>=20>=C2=A0+=0D=0A>=20>=C2=A0+int=C2=A0samsung_smc_call(u32=C2=A0cmd_idx=
,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uns=
igned=C2=A0long=C2=A0a0,=C2=A0unsigned=C2=A0long=C2=A0a1,=0D=0A>=20>=C2=A0+=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned=C2=A0long=C2=A0=
a2,=C2=A0unsigned=C2=A0long=C2=A0a3,=0D=0A>=20>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32=C2=A0*val);=0D=0A>=20>=C2=A0+int=C2=A0sam=
sung_smc_reg_read(void=C2=A0*addr,=C2=A0unsigned=C2=A0int=C2=A0reg,=C2=A0u3=
2=C2=A0*val);=0D=0A>=20>=C2=A0+int=C2=A0samsung_smc_reg_write(void=C2=A0*ad=
dr,=C2=A0unsigned=C2=A0int=C2=A0reg,=C2=A0u32=C2=A0val);=0D=0A>=20>=C2=A0+=
=0D=0A>=20=0D=0A>=20Need=C2=A0kerneldoc=C2=A0in=C2=A0the=C2=A0driver.=0D=0A=
>=20=0D=0A>=20=0D=0A>=20>=C2=A0+=23else=0D=0A>=20>=C2=A0+=0D=0A>=20=0D=0A>=
=20No=C2=A0stubs,=C2=A0no=C2=A0ifdefs.=C2=A0It's=C2=A0not=C2=A0a=C2=A0subsy=
stem.=0D=0A>=20=0D=0A>=20=0D=0A>=20=0D=0A>=20Best=C2=A0regards,=0D=0A>=20Kr=
zysztof=0D=0A
