Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29DA4B34D9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 13:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiBLMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 07:00:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiBLMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 07:00:36 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAAD2613A;
        Sat, 12 Feb 2022 04:00:32 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AB7271C0B80; Sat, 12 Feb 2022 13:00:31 +0100 (CET)
Date:   Sat, 12 Feb 2022 13:00:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] leds: remove ide-disk trigger
Message-ID: <20220212120030.GH20866@duo.ucw.cz>
References: <20220208104601.3751852-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zq44+AAfm4giZpo5"
Content-Disposition: inline
In-Reply-To: <20220208104601.3751852-1-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zq44+AAfm4giZpo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> No user of ide-disk remains, so remove this deprecated trigger.
> Only a few platforms used this and were fixed in 2016.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Looks good to me but git refuses to apply it. Can I have an updated
version?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--zq44+AAfm4giZpo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYgehXgAKCRAw5/Bqldv6
8pL7AJ4hhTBR9yJgWATqGN7eakEA2qugrACgkKvEANTWHB9Q03dbDl1pZuGLrtc=
=0Rii
-----END PGP SIGNATURE-----

--zq44+AAfm4giZpo5--
