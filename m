Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB18D51EA48
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387434AbiEGVRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 17:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbiEGVRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 17:17:51 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3482413F1B;
        Sat,  7 May 2022 14:14:04 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 025AA1C0BA6; Sat,  7 May 2022 23:14:03 +0200 (CEST)
Date:   Sat, 7 May 2022 23:14:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] leds: ktd2692: Avoid duplicate error messages on
 probe deferral
Message-ID: <20220507211402.GD11004@duo.ucw.cz>
References: <20220505152521.71019-1-markuss.broks@gmail.com>
 <20220505152521.71019-2-markuss.broks@gmail.com>
 <CAHp75VfUA3qnZnkPQB3TRpPDwe+F+Q6rv9dQmq2xLfw9PmJ8LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline
In-Reply-To: <CAHp75VfUA3qnZnkPQB3TRpPDwe+F+Q6rv9dQmq2xLfw9PmJ8LA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Use dev_err_probe instead of dev_err to avoid duplicate error
> > messages if the GPIO allocation makes the probe defer.
>=20
> Thanks!
>=20
> There are two improvements we can make here.
> 1) adding a Fixes tag, so it can be backported to stable kernels;
> 2) see below.

I don't believe this is severe-enough error to be worth stable.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--UoPmpPX/dBe4BELn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnbhGgAKCRAw5/Bqldv6
8r6eAKCq76bMaEmsCf3nSCxX2EBaWPUfogCfb6L9TtqAL3O7BrTIh4qcAaf6uWs=
=E4MY
-----END PGP SIGNATURE-----

--UoPmpPX/dBe4BELn--
