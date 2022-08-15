Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C17592AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiHOHpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241138AbiHOHpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:45:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67C06358;
        Mon, 15 Aug 2022 00:45:33 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:3486:284d:25cf:55c7] (unknown [IPv6:2a00:23c6:c311:3401:3486:284d:25cf:55c7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F0776601B73;
        Mon, 15 Aug 2022 08:45:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660549531;
        bh=E5ZBpiuxusCD8NkZNtw1vu9faUutMAh/sb5xwpmbkBc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XNLE4LD8AJgsnyh+IvlZzJiy7vP5edKRv0yH5X0Dq0E665HAHMCFsGbHgbRkopn05
         TuKWOKraTHgYgaOMNeSuxNzKnYFv+7dNp2vaS4sS/pALRF4ImSC+gA9ovZhM+6/SFu
         T92jzayaemkcuhzZwlB7a5zJtK+Gj0HFbp6YCacnClmuE0iU3MMYL+x5jPLTc0yKz4
         zL8aUULG3juHj3m2UReEi/7BtddxwDpdwNX3KHsUhVqGijFzjbD5vt7j3W8au9M6pm
         1cKjjNzHaDnjXSnKOWfmYwp0CN1TYeJ0ChIR6l2Wlk1W2cSedWPKSLTrKnhJG7z31P
         fJkq2k/pncGpw==
Message-ID: <dc944acacf64f19b46e1d865d9608853b44a686a.camel@collabora.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: imx8mp-msc-sm2s: Add device trees
 for MSC SM2S-IMX8PLUS SoM and carrier board
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 15 Aug 2022 08:45:30 +0100
In-Reply-To: <993a4559-c9f4-c6e2-8854-d2018180fd6a@linaro.org>
References: <20220812084120.376042-1-martyn.welch@collabora.com>
         <20220812084120.376042-2-martyn.welch@collabora.com>
         <8962b7ed-a21c-0b7f-7a6d-5db3db84e4cb@linaro.org>
         <65a094d5d03ad8f7b35196c9dff6ffc6cf0ea151.camel@collabora.com>
         <15ddd798-873e-d90d-11e9-c6dd46ca03f4@linaro.org>
         <c874e1db8526bfa915baca1f0bb28d0c5f5a1feb.camel@collabora.com>
         <993a4559-c9f4-c6e2-8854-d2018180fd6a@linaro.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-12 at 20:31 +0300, Krzysztof Kozlowski wrote:
> On 12/08/2022 18:03, Martyn Welch wrote:
> > The tests threw quite a few errors that seemed to be related to the
> > imx8mp.dtsi. The only ones that seemed to be related to the files
> > I've
> > created seem to be the result of including optional pins in the pin
> > muxing, which need to be there AFAIK, but seem to be resulting in
> > warnings from the tool.
>=20
> Your DTS defined three compatibles which were not documented by the
> bindings change, therefore I expect the warning from schema.
>=20
> To be sure, I just run it and it is clearly visible:
>=20
> /home/krzk/dev/linux/linux/out/arch/arm64/boot/dts/freescale/imx8mp-
> msc-sm2s-14N0600E.dtb:
> /: compatible: 'oneOf' conditional failed, one must be fixed:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0['avnet,sm2s-imx8mp-14N06=
00E', 'avnet,sm2s-imx8mp',
> 'fsl,imx8mp'] is
> too long
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0['avnet,sm2s-imx8mp-14N06=
00E', 'avnet,sm2s-imx8mp',
> 'fsl,imx8mp'] is
> too short
>=20
>=20
> It's not possible to miss it, it's the biggest warning...
>=20

This is the sum total of what I'm getting when running it:

$ make dtbs_check
warning: python package 'yamllint' not installed, skipping
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC     arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
  CHECK   arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: ecspi1grp:fsl,pins:0: [488, 1096, 1372, 0, 0, 130,
484, 1092, 1376, 0, 0, 130, 480, 1088, 1368, 0, 0, 130, 492, 1100,
1380, 0, 0, 262144, 172, 780, 0, 5, 0, 262144] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: ecspi2grp:fsl,pins:0: [504, 1112, 1388, 0, 1, 130,
500, 1108, 1392, 0, 1, 130, 496, 1104, 1384, 0, 1, 130, 508, 1116,
1396, 0, 1, 262144, 176, 784, 0, 5, 0, 262144] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: eqosgrp:fsl,pins:0: [84, 692, 0, 0, 0, 3, 88, 696,
1424, 0, 1, 3, 124, 732, 0, 0, 0, 145, 128, 736, 0, 0, 0, 145, 132,
740, 0, 0, 0, 145, 136, 744, 0, 0, 0, 145, 120, 728, 0, 0, 0, 145, 116,
724, 0, 0, 0, 145, 104, 712, 0, 0, 0, 31, 100, 708, 0, 0, 0, 31, 96,
704, 0, 0, 0, 31, 92, 700, 0, 0, 0, 31, 108, 716, 0, 0, 0, 31, 112,
720, 0, 0, 0, 31] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: fecgrp:fsl,pins:0: [344, 952, 0, 4, 0, 3, 348, 956,
1404, 4, 1, 3, 352, 960, 1408, 4, 1, 145, 356, 964, 1412, 4, 1, 145,
360, 968, 0, 4, 0, 145, 364, 972, 0, 4, 0, 145, 372, 980, 0, 4, 0, 145,
368, 976, 1416, 4, 1, 145, 376, 984, 0, 4, 0, 31, 380, 988, 0, 4, 0,
31, 384, 992, 0, 4, 0, 31, 388, 996, 0, 4, 0, 31, 392, 1000, 0, 4, 0,
31, 396, 1004, 0, 4, 0, 31] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: flexcan1grp:fsl,pins:0: [312, 920, 0, 6, 0, 340, 316,
924, 1356, 6, 0, 340] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: flexcan2grp:fsl,pins:0: [324, 932, 1360, 6, 0, 340,
320, 928, 0, 6, 0, 340] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: flexspi0grp:fsl,pins:0: [224, 832, 0, 1, 0, 450, 228,
836, 0, 1, 0, 130, 248, 856, 0, 1, 0, 130, 252, 860, 0, 1, 0, 130, 256,
864, 0, 1, 0, 130, 260, 868, 0, 1, 0, 130, 280, 888, 0, 5, 0, 25] is
too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: i2c1grp:fsl,pins:0: [512, 1120, 1444, 0, 2,
1073742275, 516, 1124, 1448, 0, 2, 1073742275] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: i2c2grp:fsl,pins:0: [520, 1128, 1452, 0, 2,
1073742275, 524, 1132, 1456, 0, 2, 1073742275] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: i2c3grp:fsl,pins:0: [528, 1136, 1460, 0, 4,
1073742275, 532, 1140, 1464, 0, 4, 1073742275] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: i2c4grp:fsl,pins:0: [536, 1144, 1468, 0, 5,
1073742275, 540, 1148, 1472, 0, 5, 1073742275] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: i2c5grp:fsl,pins:0: [468, 1076, 1476, 2, 2,
1073742275, 472, 1080, 1480, 2, 2, 1073742275] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: i2c6grp:fsl,pins:0: [300, 908, 1484, 3, 1,
1073742275, 304, 912, 1488, 3, 1, 1073742275] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: uart1grp:fsl,pins:0: [544, 1152, 1512, 0, 4, 73, 548,
1156, 0, 0, 0, 73] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: uart2grp:fsl,pins:0: [164, 772, 0, 5, 0, 452, 168,
776, 0, 5, 0, 452, 552, 1160, 1520, 0, 6, 73, 556, 1164, 0, 0, 0, 73]
is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: uart3grp:fsl,pins:0: [180, 788, 0, 5, 0, 452, 184,
792, 0, 5, 0, 452, 560, 1168, 1528, 0, 6, 73, 564, 1172, 0, 0, 0, 73]
is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: uart4grp:fsl,pins:0: [568, 1176, 1536, 0, 8, 73, 572,
1180, 0, 0, 0, 73] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: usdhc2-gpiogrp:fsl,pins:0: [188, 796, 0, 5, 0, 452,
220, 828, 0, 5, 0, 452] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: usdhc2grp:fsl,pins:0: [192, 800, 0, 0, 0, 400, 196,
804, 0, 0, 0, 464, 200, 808, 0, 0, 0, 464, 204, 812, 0, 0, 0, 464, 208,
816, 0, 0, 0, 464, 212, 820, 0, 0, 0, 464, 36, 644, 0, 1, 0, 193] is
too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: usdhc2-100mhzgrp:fsl,pins:0: [192, 800, 0, 0, 0, 404,
196, 804, 0, 0, 0, 468, 200, 808, 0, 0, 0, 468, 204, 812, 0, 0, 0, 468,
208, 816, 0, 0, 0, 468, 212, 820, 0, 0, 0, 468, 36, 644, 0, 1, 0, 193]
is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: usdhc2-200mhzgrp:fsl,pins:0: [192, 800, 0, 0, 0, 406,
196, 804, 0, 0, 0, 470, 200, 808, 0, 0, 0, 470, 204, 812, 0, 0, 0, 470,
208, 816, 0, 0, 0, 470, 212, 820, 0, 0, 0, 470, 36, 644, 0, 1, 0, 193]
is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: usdhc3grp:fsl,pins:0: [292, 900, 1540, 2, 1, 400,
296, 904, 1548, 2, 1, 464, 264, 872, 1552, 2, 1, 464, 268, 876, 1556,
2, 1, 464, 272, 880, 1560, 2, 1, 464, 276, 884, 1564, 2, 1, 464, 284,
892, 1568, 2, 1, 464, 236, 844, 1572, 2, 1, 464, 240, 848, 1576, 2, 1,
464, 244, 852, 1580, 2, 1, 464, 232, 840, 1584, 2, 1, 400] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: usdhc3-100mhzgrp:fsl,pins:0: [292, 900, 1540, 2, 1,
404, 296, 904, 1548, 2, 1, 468, 264, 872, 1552, 2, 1, 468, 268, 876,
1556, 2, 1, 468, 272, 880, 1560, 2, 1, 468, 276, 884, 1564, 2, 1, 468,
284, 892, 1568, 2, 1, 468, 236, 844, 1572, 2, 1, 468, 240, 848, 1576,
2, 1, 468, 244, 852, 1580, 2, 1, 468, 232, 840, 1584, 2, 1, 404] is too
long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: usdhc3-200mhzgrp:fsl,pins:0: [292, 900, 1540, 2, 1,
406, 296, 904, 1548, 2, 1, 470, 264, 872, 1552, 2, 1, 470, 268, 876,
1556, 2, 1, 470, 272, 880, 1560, 2, 1, 470, 276, 884, 1564, 2, 1, 470,
284, 892, 1568, 2, 1, 470, 236, 844, 1572, 2, 1, 470, 240, 848, 1576,
2, 1, 470, 244, 852, 1580, 2, 1, 470, 232, 840, 1584, 2, 1, 406] is too
long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
pinctrl@30330000: smarcgpiosgrp:fsl,pins:0: [64, 672, 0, 0, 0, 25, 332,
940, 0, 5, 0, 25, 336, 944, 0, 5, 0, 25, 340, 948, 0, 5, 0, 25, 444,
1052, 0, 5, 0, 25, 464, 1072, 0, 5, 0, 25, 400, 1008, 0, 5, 0, 25, 60,
668, 0, 0, 0, 25, 408, 1016, 0, 5, 0, 25, 412, 1020, 0, 5, 0, 25, 416,
1024, 0, 5, 0, 25, 440, 1048, 0, 5, 0, 25, 404, 1012, 0, 5, 0, 25, 328,
936, 0, 5, 0, 25] is too long
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-
pinctrl.yaml
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30000000/iomuxc-gpr@30340000: failed to match any schema
with compatible: ['fsl,imx8mp-iomuxc-gpr', 'syscon']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30000000/anatop@30360000: failed to match any schema with
compatible: ['fsl,imx8mp-anatop', 'fsl,imx8mm-anatop', 'syscon']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30000000/anatop@30360000: failed to match any schema with
compatible: ['fsl,imx8mp-anatop', 'fsl,imx8mm-anatop', 'syscon']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30000000/snvs@30370000: failed to match any schema with
compatible: ['fsl,sec-v4.0-mon', 'syscon', 'simple-mfd']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30000000/snvs@30370000/snvs-rtc-lp: failed to match any
schema with compatible: ['fsl,sec-v4.0-mon-rtc-lp']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30000000/snvs@30370000/snvs-powerkey: failed to match any
schema with compatible: ['fsl,sec-v4.0-pwrkey']
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
gpc@303a0000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30800000/crypto@30900000: failed to match any schema with
compatible: ['fsl,sec-v4.0']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30800000/crypto@30900000/jr@1000: failed to match any schema
with compatible: ['fsl,sec-v4.0-job-ring']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30800000/crypto@30900000/jr@2000: failed to match any schema
with compatible: ['fsl,sec-v4.0-job-ring']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30800000/crypto@30900000/jr@3000: failed to match any schema
with compatible: ['fsl,sec-v4.0-job-ring']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30800000/dma-controller@30bd0000: failed to match any schema
with compatible: ['fsl,imx8mp-sdma', 'fsl,imx8mq-sdma']
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0:
/soc@0/bus@30800000/dma-controller@30bd0000: failed to match any schema
with compatible: ['fsl,imx8mp-sdma', 'fsl,imx8mq-sdma']
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
usb-phy@381f0040: 'power-domains' does not match any of the regexes:
'pinctrl-[0-9]+'
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
usb@32f10100: 'power-domains' does not match any of the regexes:
'^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
usb-phy@382f0040: 'power-domains' does not match any of the regexes:
'pinctrl-[0-9]+'
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml
/home/martyn/Documents/geh0003/linux-
upstream/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:
usb@32f10108: 'power-domains' does not match any of the regexes:
'^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /home/martyn/Documents/geh0003/linux-
upstream/Documentation/devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml
arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dtb:0:0: /extcon-
usb0: failed to match any schema with compatible: ['linux,extcon-usb-
gpio']


Unless I'm missing something, that's all from dtsi I'm including, not
from the files I'm trying to add (with the possible exception of the
tools not understanding that pinctrl nodes might have optional entities
in them.

Do you have patch 1 of the series in your tree?:

https://lore.kernel.org/linux-devicetree/20220812084120.376042-1-martyn.wel=
ch@collabora.com/

I thought that was exactly what that was doing...=20

Martyn

> Best regards,
> Krzysztof

