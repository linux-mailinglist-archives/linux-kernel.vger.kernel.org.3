Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E3591027
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiHLLfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiHLLfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:35:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944E4E56;
        Fri, 12 Aug 2022 04:35:13 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:fef:5a97:8fe5:76f7] (unknown [IPv6:2a00:23c6:c311:3401:fef:5a97:8fe5:76f7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FCEC6601B04;
        Fri, 12 Aug 2022 12:35:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660304112;
        bh=5jsSqwmgaBJoXJIhLpg1hsJ98A6dREL+lVU6AW01xOY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SAOEZI4XWtG7gCmUggZGTqjqDQ41+XpnTqiTwU2viM+HCm2eVWv7lVzbfhCAvrzdc
         E/3vQkEd/gJRpweNQ3cEFvTE3ZbPDKaStNxnIm3+4Z74BKmfo5dmAsi/bHcwBaYXgS
         apzYQsbaGwaIaAnfb4H/nWW3JCZWAPgZ0OcYelmY+dmnzj1B8Xch7j7NMLDsQEyU22
         40j7yxUjCFbvmrOeGLx5nFzAvg32Fc9CZ7sDrZ2MeVchuIAFZGbWb7X9J4kD71XZjX
         9Gb1Jfz3bQVApkCGopmwXaDT8zrAJ+N/5PdN2q/mWGt6R5unPdhC+R9NHdyiraBGbg
         zeah7aRI0M/Vg==
Message-ID: <65a094d5d03ad8f7b35196c9dff6ffc6cf0ea151.camel@collabora.com>
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
Date:   Fri, 12 Aug 2022 12:35:09 +0100
In-Reply-To: <8962b7ed-a21c-0b7f-7a6d-5db3db84e4cb@linaro.org>
References: <20220812084120.376042-1-martyn.welch@collabora.com>
         <20220812084120.376042-2-martyn.welch@collabora.com>
         <8962b7ed-a21c-0b7f-7a6d-5db3db84e4cb@linaro.org>
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

On Fri, 2022-08-12 at 12:47 +0300, Krzysztof Kozlowski wrote:
> On 12/08/2022 11:41, Martyn Welch wrote:
> > Add device trees for one of a number of MSC's (parent company,
> > Avnet)
> > variants of the SM2S-IMX8PLUS system on module along with the
> > compatible
> > SM2S-SK-AL-EP1 carrier board. As the name suggests, this family of
> > SoMs use
> > the NXP i.MX8MP SoC and provide the SMARC module interface.
> >=20
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > ---
> >=20
> > Changes in v2
> > =C2=A0 - Added compatibles
> > =C2=A0 - Removed underscores from node names
> > =C2=A0 - Make node names more generic
> > =C2=A0 - Reorder properties
> > =C2=A0 - Fix issues found by dtbs_check in these files
> >=20
> > Changes in v3:
> > =C2=A0 - Switched to avnet vendor string in compatibles
> > =C2=A0 - Corrected patch description
> >=20
> > Changes in v4:
> > =C2=A0 - Switched from phy-reset-gpios to reset-gpios, removing
> > duplication
> > =C2=A0 - Removed unneeded sdma1 node
> >=20
> > =C2=A0arch/arm64/boot/dts/freescale/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0.../freescale/imx8mp-msc-sm2s-14N0600E.dts=C2=A0=C2=A0=C2=A0 |=C2=
=A0 72 ++
> > =C2=A0.../dts/freescale/imx8mp-msc-sm2s-ep1.dts=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 53 ++
> > =C2=A0.../boot/dts/freescale/imx8mp-msc-sm2s.dtsi=C2=A0=C2=A0 | 812
> > ++++++++++++++++++
> > =C2=A04 files changed, 938 insertions(+)
> > =C2=A0create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
> > 14N0600E.dts
> > =C2=A0create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
> > ep1.dts
> > =C2=A0create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-msc-
> > sm2s.dtsi
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > b/arch/arm64/boot/dts/freescale/Makefile
> > index 8bf7f7ecebaa..139c8b95c9c9 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -83,6 +83,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D imx8mn-venice-
> > gw7902.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-dhcom-pdk2.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-evk.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-icore-mx8mp-edimm2.2.dtb
> > +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-msc-sm2s-ep1.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-phyboard-pollux-rdk.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-tqma8mpql-mba8mpxl.dtb
> > =C2=A0dtb-$(CONFIG_ARCH_MXC) +=3D imx8mp-venice-gw74xx.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
> > 14N0600E.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-
> > 14N0600E.dts
> > new file mode 100644
> > index 000000000000..9e976e8baaee
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-14N0600E.dts
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2022 Avnet Embedded GmbH
> > + */
> > +/dts-v1/;
> > +
> > +#include "imx8mp-msc-sm2s.dtsi"
> > +
> > +/ {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D "MSC SM2S-IMX8PLUS=
-QC6-14N0600E SoM";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatible =3D "avnet,sm2s-i=
mx8mp-14N0600E", "avnet,sm2s-
> > imx8mp",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fsl,imx8mp";
>=20
> This does not match your bindings. Please test your DTS.
>=20

Hi Krzysztof,

I'm not sure I follow. This is the DTS for the SoM. The only way I can
test the SoM at the moment is on combination with the "EP1" carrier
board. That has been tested. The strings match those specified in the
bindings unless I'm being blind to something.

I guess I can build the DTB for just the SoM and boot with that or
thinking about it, rename this as a .dtsi, given that it's unlikely
that anyone is going to have a carrier barebones enough that it could
be considered just the SoM?

Martyn

> Best regards,
> Krzysztof

