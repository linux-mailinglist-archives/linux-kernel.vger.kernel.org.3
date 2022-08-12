Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E3591299
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiHLPDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiHLPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:03:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39144A8951;
        Fri, 12 Aug 2022 08:03:50 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:fef:5a97:8fe5:76f7] (unknown [IPv6:2a00:23c6:c311:3401:fef:5a97:8fe5:76f7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F26176601B73;
        Fri, 12 Aug 2022 16:03:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660316628;
        bh=dul6JUV+8R9Il0SQB903G/KY1Z76+8VAvx5PJ+nj0gA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XTmEwcKEut+nE3WJmE963kM3yk9LdhWc1is2fdinOqovqync1qWH3MzOktCemsDxd
         MLnAMu++hiSlfh/tDt9UjlNYU6H1QCPe0D+KBd5VuEX03rqGuHvXVNMCXtEr+jYSOG
         WuoOwdzpQszgNni886Zu8XMzVYlJoXCsSyw52X/sSuvQL+sG2rGWtbMQZsbNLK0gqp
         XqaXyIWAht0sSyserbsU4T6euqj1KWdRPshFmeZE4ssD63oongh6gaGtXDEl4VPPwI
         ANuNeHDtRb1RHYCQ4YYMPYUxGKdGgDUZqStXXw1iRkUJvTSoHTn+wPIwTTOexUkm9P
         h3U4X5mmu+13Q==
Message-ID: <c874e1db8526bfa915baca1f0bb28d0c5f5a1feb.camel@collabora.com>
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
Date:   Fri, 12 Aug 2022 16:03:46 +0100
In-Reply-To: <15ddd798-873e-d90d-11e9-c6dd46ca03f4@linaro.org>
References: <20220812084120.376042-1-martyn.welch@collabora.com>
         <20220812084120.376042-2-martyn.welch@collabora.com>
         <8962b7ed-a21c-0b7f-7a6d-5db3db84e4cb@linaro.org>
         <65a094d5d03ad8f7b35196c9dff6ffc6cf0ea151.camel@collabora.com>
         <15ddd798-873e-d90d-11e9-c6dd46ca03f4@linaro.org>
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

On Fri, 2022-08-12 at 16:42 +0300, Krzysztof Kozlowski wrote:
> On 12/08/2022 14:35, Martyn Welch wrote:
> > On Fri, 2022-08-12 at 12:47 +0300, Krzysztof Kozlowski wrote:
> > > On 12/08/2022 11:41, Martyn Welch wrote:
> > > > Add device trees for one of a number of MSC's (parent company,
> > > > Avnet)
> > > > variants of the SM2S-IMX8PLUS system on module along with the
> > > > compatible
> > > > SM2S-SK-AL-EP1 carrier board. As the name suggests, this family
> > > > of
> > > > SoMs use
> > > > the NXP i.MX8MP SoC and provide the SMARC module interface.
> > > >=20
> > > > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > > > ---
> > > >=20
> > > > Changes in v2
> > > > =C2=A0 - Added compatibles
> > > > =C2=A0 - Removed underscores from node names
> > > > =C2=A0 - Make node names more generic
> > > > =C2=A0 - Reorder properties
> > > > =C2=A0 - Fix issues found by dtbs_check in these files
> > > >=20
> > > > Changes in v3:
> > > > =C2=A0 - Switched to avnet vendor string in compatibles
> > > > =C2=A0 - Corrected patch description
> > > >=20
> > > > Changes in v4:
> > > > =C2=A0 - Switched from phy-reset-gpios to reset-gpios, removing
> > > > duplication
> > > > =C2=A0 - Removed unneeded sdma1 node
> > > >=20
> > > > =C2=A0arch/arm64/boot/dts/freescale/Makefile=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > > =C2=A0.../freescale/imx8mp-msc-sm2s-14N0600E.dts=C2=A0=C2=A0=C2=A0 =
|=C2=A0 72 ++
> > > > =C2=A0.../dts/freescale/imx8mp-msc-sm2s-ep1.dts=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 53 ++
> > > > =C2=A0.../boot/dts/freescale/imx8mp-msc-sm2s.dtsi=C2=A0=C2=A0 | 812
> > > > ++++++++++++++++++
> > > > =C2=A04 files changed, 938 insertions(+)
> > > > =C2=A0create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-
> > > > sm2s-
> > > > 14N0600E.dts
> > > > =C2=A0create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-
> > > > sm2s-
> > > > ep1.dts
> > > > =C2=A0create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-
> > > > sm2s.dtsi
> > > >=20
> > > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > > b/arch/arm64/boot/dts/freescale/Makefile
> > > > index 8bf7f7ecebaa..139c8b95c9c9 100644
> > > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > > @@ -83,6 +83,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mn-venice-
> > > > gw7902.dtb
> > > > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-dhcom-pdk2.dtb
> > > > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-evk.dtb
> > > > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-icore-mx8mp-edimm2.2.dtb
> > > > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-msc-sm2s-ep1.dtb
> > > > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk.dtb
> > > > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-tqma8mpql-mba8mpxl.dtb
> > > > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-venice-gw74xx.dtb
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
> > > > 14N0600E.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
> > > > 14N0600E.dts
> > > > new file mode 100644
> > > > index 000000000000..9e976e8baaee
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
> > > > 14N0600E.dts
> > > > @@ -0,0 +1,72 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (C) 2022 Avnet Embedded GmbH
> > > > + */
> > > > +/dts-v1/;
> > > > +
> > > > +#include "imx8mp-msc-sm2s.dtsi"
> > > > +
> > > > +/ {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "MSC SM2S-IMX8=
PLUS-QC6-14N0600E SoM";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "avnet,sm=
2s-imx8mp-14N0600E", "avnet,sm2s-
> > > > imx8mp",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fsl,imx8mp";
> > >=20
> > > This does not match your bindings. Please test your DTS.
> > >=20
> >=20
> > Hi Krzysztof,
> >=20
> > I'm not sure I follow. This is the DTS for the SoM.=20
>=20
> SoMs usually do not have DTSes because they cannot be run on their
> own.
> SoMs almost always require a baseboard/carrier. Therefore this should
> not be DTS, but that was not my comment.
>=20

OK, so does making this as dtsi resolve the issue for you? I assume as
a dtsi I would also need to remove the model and compatible?

> > The only way I can
> > test the SoM at the moment is on combination with the "EP1" carrier
> > board.=20
>=20
> ... so you basically say it cannot be a DTS.
>=20
> > That has been tested. The strings match those specified in the
> > bindings unless I'm being blind to something.
>=20
> Test the DTS - make dtbs_check (there are several
> variations/arguments/helpers):
> Documentation/devicetree/bindings/writing-schema.rst
>=20

Yep, ran that.

> >=20
> > I guess I can build the DTB for just the SoM=20
>=20
> But you just did it, didn't you? This is a DTS.
>=20

As you can see from the patch, I didn't add that file directly to the
Makefile, so dtbs_check didn't check it directly.

> >=20
> > and boot with that or
> > thinking about it, rename this as a .dtsi, given that it's unlikely
> > that anyone is going to have a carrier barebones enough that it
> > could
> > be considered just the SoM?
>=20
> Anyway, I wanted DT bindings tests for DTS. Not actual tests on
> hardware, because the compatibles do not matter in that aspect.
>=20

The tests threw quite a few errors that seemed to be related to the
imx8mp.dtsi. The only ones that seemed to be related to the files I've
created seem to be the result of including optional pins in the pin
muxing, which need to be there AFAIK, but seem to be resulting in
warnings from the tool.

Martyn

> Best regards,
> Krzysztof

