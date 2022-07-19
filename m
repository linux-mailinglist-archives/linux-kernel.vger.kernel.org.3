Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924CB57A43D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiGSQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiGSQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:37:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28CA326F8;
        Tue, 19 Jul 2022 09:37:52 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c30a:1501:8302:3eab:dcff:989c] (unknown [IPv6:2a00:23c6:c30a:1501:8302:3eab:dcff:989c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D153D6601955;
        Tue, 19 Jul 2022 17:37:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658248671;
        bh=11/5f3QiTrKxQeGlw8XCXzuwEMJEiL9GlI4UH76Eh1A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=U9qK059OU1UzCPkdqK4IU2O3ZAq+ElkbtBUVAzt1Mf2tJZQorzdXzH89bLB0n0SnN
         r1/TPY+7LZ0Ie7xYtr76uWSZ33DATOp13fjx1CsqsABcK+qpOruyVFfbYut0n/CMio
         9SyTz7ILy1ysZHGjMXvgNM9ZzLzo3KwZ7QRzQfRYUZKxVI0rzPo54iRx40M4PzYsS/
         8fU0FmM2XhoTlG1sM75go7xaTJ/wCoOw6eRvgbnbBozgd9SrKCve/iu8QcFSBilXfQ
         1s9cx7FAXtvVMWJiDmjCiHnlyh6BnIEWohsr9jgUvT/j4n7a+WWqtzMA451msl/VYe
         E2lqCVufxwe7w==
Message-ID: <abd2e9affdc3e4001f9fc6f036516ddfa6654bdd.camel@collabora.com>
Subject: Re: [PATCH] arm64: dts: Add device trees for MSC SM2S-IMX8PLUS SoM
 and carrier board
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Tue, 19 Jul 2022 17:37:48 +0100
In-Reply-To: <4473378f-1c14-3ec7-5380-12f49f3b1e3b@linaro.org>
References: <20220718152310.1937899-1-martyn.welch@collabora.com>
         <4473378f-1c14-3ec7-5380-12f49f3b1e3b@linaro.org>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-19 at 12:01 +0200, Krzysztof Kozlowski wrote:
> On 18/07/2022 17:23, Martyn Welch wrote:
> > Add device trees for one of a number of MSCs variants of the SM2S-
> > IMX8PLUS
> > system on module along with the compatible SM2S-SK-AL-EP1 carrier
> > board.
> > As the name suggests, this family of SoMs use the NXP i.MX8MP SoC
> > and
> > provide the SMARC module interface.
> >=20
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>=20
> Use subject prefix matching subsystem. I expect other folks in
> Collabora
> help you in that, so you do not need our advices for such trivial
> stuff. :)
>=20

Hi Krzysztof,

Thanks for the review.

I picked that based on the last 20-30 commits under
arch/arm64/boot/dts/. Would you prefer something starting "arm64: dts:
freescale: "? I see that "arm64: dts: imx8mp: " is typically being used
for changes to the more generic imx8mp device trees...

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0extcon_usb0: extcon_usb0 {
>=20
> No underscores, extcon is Linux term, so use node name describing
> device.
>=20

I note that the device binding file lists an example using
"extcon_usb1". I also note that existing users seem to broadly use a
variation of "extcon-XXXX", would "extcon-usb0" be acceptable in this
case?

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dsi_lvds_bridge: sn65dsi84@2=
d {
>=20
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation
>=20

My apologies - I thought I'd got all of these...


>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qspi_flash: qspi_flash@0 {
>=20
> You didn't test the bindings (dtbs_check), did you? There is no way
> this
> passess...
>=20

No, despite having written device tree bindings on and off for
something approaching 18 years (though admittedly more off than on), I
was unaware of this tool. I'll run this before resubmitting.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0reg =3D <0>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0#address-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0#size-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0compatible =3D "jedec,spi-nor";
>=20
> Eh? Now compatible in the middle? Sorry, this are trivial code
> quality
> comments. Please use internal review or base your work on some
> upstreamed existing board.
>=20

Sorry - I missed that one. I'd moved most of the compatible strings to
the top of nodes.

Martyn

> Best regards,
> Krzysztof

