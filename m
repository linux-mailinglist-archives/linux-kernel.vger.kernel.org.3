Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1AA4B34AD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 12:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiBLL2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 06:28:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiBLL2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 06:28:42 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502F26AEA;
        Sat, 12 Feb 2022 03:28:39 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9EE661C0B80; Sat, 12 Feb 2022 12:28:38 +0100 (CET)
Date:   Sat, 12 Feb 2022 12:28:38 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/3] Add support for ocp8110 flash
Message-ID: <20220212112838.GC20866@duo.ucw.cz>
References: <20211117091405.7412-1-git@apitzsch.eu>
 <20220207230638.56730-1-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20220207230638.56730-1-git@apitzsch.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The led is used as front flash of BQ Aquaris M5.
>=20
> https://github.com/bq/aquaris-M5/blob/901d0b2ca05c0b0af49786fb548eb0fc289=
867ff/arch/arm/boot/dts/qcom/piccolo-msm8939-camera-sensor-qrd.dtsi#L16

Thanks for patches, I took 1 and 3/3, waiting for some kind of
changelog on 2/.

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYgeZ5gAKCRAw5/Bqldv6
8iP9AJ9X66xk2Tg9z/6xysk98CrX+rL9iQCdGONCiSyzNt3AtW+0Kv2GAxh4PzE=
=kAce
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
