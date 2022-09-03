Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860805ABC65
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 04:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiICCj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 22:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiICCjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:39:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E58237F9A;
        Fri,  2 Sep 2022 19:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 136D2B82D2C;
        Sat,  3 Sep 2022 02:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69B0C433D6;
        Sat,  3 Sep 2022 02:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662172788;
        bh=SSUXReG3Frnwc8xjOBleD7EMV7xvHl+a8PL7wB96E/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nRa0Nvy9Ca9eJ39FN7DRhQt2v+vVZ4wb6IpV3aIYSKDMlCpYKtOgEegMRyNINferI
         Kax8r0Qey9oHjBjIWTBNvCRm/IQvF6cCmyw1q42Q1KD9mYjEBx+Q9uVCZVJtzUzbxD
         gjgqHAqZBTg1ztDoJT2pdrQ3iihprjqZZVquUt5HcIuS6FgL2FkB5XYbUPEC8tajgS
         HRxF9ti7OWn6kFzz6jAhYO1Y61l/7OrrubK7wlAJXSiC7wyNRgbNuixTiAl+MliFD1
         DpGBnAaYRq1rKDNxewFR6Hr56mI2gs//tV0mNkqRn4SSoEKN08vP/aMRRTwomIRY72
         gb262LRUHW4Vg==
Date:   Sat, 3 Sep 2022 04:39:42 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Message-ID: <20220903043828.6afd3ab4@thinkpad>
In-Reply-To: <YxE2JqJutZ0ilghH@lunn.ch>
References: <20220819131152.6513-1-pali@kernel.org>
        <20220831142809.lcmnv3l4rnulo522@pali>
        <YxE2JqJutZ0ilghH@lunn.ch>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2022 00:45:58 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Aug 31, 2022 at 04:28:09PM +0200, Pali Roh=C3=A1r wrote:
> > PING?
> >=20
> > On Friday 19 August 2022 15:11:52 Pali Roh=C3=A1r wrote: =20
> > > At i2c address 0x2a is MCU command interface which provides access to=
 GPIOs
> > > connected to Turris Omnia MCU. So define mcu node in Turris Omnia DTS=
 file.
> > >=20
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > >=20
> > > ---
> > > Same change was already sent to U-Boot project together with driver. =
As
> > > Turris Omnia DTS file is shared between Linux kernel U-Boot, I'm send=
ing
> > > this change also in Linux. There is a plan to write also Linux driver=
 for
> > > Turris Omnia MCU, like there is already in U-Boot.
> > >=20
> > > https://source.denx.de/u-boot/u-boot/-/commit/832738974806e6264a3d0ac=
2aaa92d0f662fd128
> > > https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/turri=
s_omnia_mcu.c
> > > ---
> > >  arch/arm/boot/dts/armada-385-turris-omnia.dts | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm=
/boot/dts/armada-385-turris-omnia.dts
> > > index f4878df39753..f655e9229d68 100644
> > > --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > > +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > > @@ -184,7 +184,13 @@
> > >  			#size-cells =3D <0>;
> > >  			reg =3D <0>;
> > > =20
> > > -			/* STM32F0 command interface at address 0x2a */
> > > +			/* MCU command i2c API */
> > > +			mcu: mcu@2a {
> > > +				compatible =3D "cznic,turris-omnia-mcu";
> > > +				reg =3D <0x2a>;
> > > +				gpio-controller;
> > > +				#gpio-cells =3D <3>;
> > > +			}; =20
>=20
> Please document the binding, preferably in yaml.
>=20
> I'm also not sure what the DT people will say about the node name mcu.
> I don't see any examples of that in the binding documentation. They
> might request you rename it to gpio-controller, unless it does more
> than GPIO? And if it does do more than GPIO we are then into mfd
> territory, and the binding then becomes much more interesting. Then we
> start the questions, are you defining a ABI now, before there is even
> a driver for it?

Most probably mfd territory. It is at least a gpio-controller,
reset-controller and watchdog.

Marek
