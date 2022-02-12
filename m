Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8695D4B3475
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 12:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiBLLYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 06:24:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiBLLYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 06:24:11 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703812655A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 03:24:07 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 125321C0B7A; Sat, 12 Feb 2022 12:24:05 +0100 (CET)
Date:   Sat, 12 Feb 2022 12:24:03 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: common: fix unit address in
 max77693 example
Message-ID: <20220212112403.GA20866@duo.ucw.cz>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
 <20220111175430.224421-4-krzysztof.kozlowski@canonical.com>
 <783a67ad-ee7e-c75a-a52c-672cd355bd37@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <783a67ad-ee7e-c75a-a52c-672cd355bd37@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The max77693 LED device node should not take an unit address, because it
> > is instantiated from a max77693 I2C parent device node.  This also
> > splits all examples to separate DTS examples because they are actually
> > independent.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >  Documentation/devicetree/bindings/leds/common.yaml | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
>=20
> This should be part of my max77693 patchset:
> https://lore.kernel.org/lkml/20220111175017.223966-1-krzysztof.kozlowski@=
canonical.com/
>=20
> Nothing actually depends on this patch. It just fixes a warning which
> will be brought to eyes with mentioned max77693 patchset.
>=20
> Pavel, feel free to take it separately via leds tree. Other way is to
> take it with other max77693 patches (probably via MFD tree).

Ok, let me take it separately. Applied, thanks.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYgeY0wAKCRAw5/Bqldv6
8o0HAJ40rgvnPNaFETKSsK2EgQBHcFZeGgCcCDg/CAOJXwcQ+R3w9N3O8BGULgA=
=RmPe
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
