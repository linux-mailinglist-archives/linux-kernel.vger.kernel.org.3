Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65FD58A2A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbiHDVER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiHDVEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:04:15 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18A6FA2C;
        Thu,  4 Aug 2022 14:04:14 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 76E401C0012; Thu,  4 Aug 2022 23:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659647052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=apbvPcZdrY24unnKLxcPoLRdr/5M9ONA2WW5viWNMuc=;
        b=QsHb6iRA4LiHQCMtT2DPCECHEOo6CK/mnx6wRdbN6IeJ5GfMVaGxXVW7E7DcKURGSGWp8g
        /VU1sgjusMQyjPoIISxygRBG42qpCaOCrwnzEV9PQ1LY29TSmh8WY6rhsHjl1l2hB0eK3a
        S0GPBn5jbsVSUk93hR3A1QR8r7jSgpc=
Date:   Thu, 4 Aug 2022 23:04:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v6 2/3] leds: Add driver for the TLC5925 LED
 controller
Message-ID: <20220804210412.GA30210@duo.ucw.cz>
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
 <20220722081146.47262-3-jjhiblot@traphandler.com>
 <CAHp75Vdu-EJRRxkK7+TfuE=zEDkJye1QCXSB+cDLrqxuykJjkA@mail.gmail.com>
 <5ba34982-52c7-e41a-fba8-d88d93529e47@traphandler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <5ba34982-52c7-e41a-fba8-d88d93529e47@traphandler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-08-04 22:23:00, Jean-Jacques Hiblot wrote:
> On 31/07/2022 21:28, Andy Shevchenko wrote:
> > On Fri, Jul 22, 2022 at 10:14 AM Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:
> > > The TLC5925 is a 16-channels constant-current LED sink driver.
> > > It is controlled via SPI but doesn't offer a register-based interface.
> > > Instead it contains a shift register and latches that convert the
> > > serial input into a parallel output.
> > >=20
> > > Datasheet: https://www.ti.com/lit/ds/symlink/tlc5925.pdf
> > > Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sorry for my slowpokeness, but I just realized that this driver may
> > not be needed. What is the difference to existing gpio-74x164?
>=20
> It might work. However it might not be as practical and efficient as the
> dedicated LED driver.
>=20
> I'll give a try.

It is certainly preffered solution. If you decide to re-submit the
driver anyway, please mention that we already have GPIO driver for
compatible chip, and explain why this is superior.

Thanks,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuw0TAAKCRAw5/Bqldv6
8t6LAKCNs9iVBmbyakhMxJIBQTco5ueFrACaA136y2YheNzt5ourgnnwTqjjnjI=
=l7AO
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
