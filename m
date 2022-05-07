Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8485751EA45
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 23:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387290AbiEGVRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 17:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbiEGVRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 17:17:00 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F51B12608;
        Sat,  7 May 2022 14:13:12 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2DF191C0BA6; Sat,  7 May 2022 23:13:11 +0200 (CEST)
Date:   Sat, 7 May 2022 23:13:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/2] Make AUX gpio pin optional for ktd2692
Message-ID: <20220507211310.GC11004@duo.ucw.cz>
References: <20220505152521.71019-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <20220505152521.71019-1-markuss.broks@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Some appliances of ktd2692 don't have the AUX pin connected to
> a GPIO. Specifically, Samsung Galaxy J5 (2015), which uses ktd2692
> for driving the front flash LED, has the pin not connected anywhere on
> schematics. Make specifying the AUX pin optional, since it is additional
> functionality and only affects the amount of current going through the LE=
D.
>=20
> Also convert the txt device-tree bindings to yaml.

Thank you, applied.

Best regards,
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnbg5gAKCRAw5/Bqldv6
8nZAAKCz84N8NIlsTi0vIfclmw0msp4OoQCgpVr9WzwLO0OBhb+vTkEIlCdbk04=
=ahrg
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
