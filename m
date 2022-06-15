Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1E54CF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355438AbiFORAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354614AbiFOQ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:59:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B52E084;
        Wed, 15 Jun 2022 09:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5270B82064;
        Wed, 15 Jun 2022 16:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC3EC34115;
        Wed, 15 Jun 2022 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655312379;
        bh=KWnr7zKayHkj/bptj3o4m8ElFwkJYwNaweEzW4q39qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2wTB4JQblWFkfakKnpJ2eoRfcr7H0w7Uu0reDePp/jUvg9kdvPzcr7cxKg7314kE
         QisQDdxPYHVMQj9JgNvlKt8zWvcV0cLZYMALPwO4DUKC5caWc9+vK172UKZhYkY1kI
         0SDOP88vmVxt7MqBRihPvYqkUB/vRffM00B0RqrPAHBUBJb+98a9RNjmuU8xdQIJ+4
         lTi6919QQZdi9ZDJcznHuV8jbouEHE6EnxEEvqwmAtz1sIRBc5wrofGSjofMf1mZcz
         qru12F3WCV7t4aaM4Ukr5cUGlo+HQ2hD+bpoVDwlaOc/EG4hDrlr8WB8rkB+AxwdEp
         pgVPT+jQ5zG6A==
Date:   Wed, 15 Jun 2022 17:59:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Li Chen <lchen.firstlove@zohomail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-sunxi <linux-sunxi@lists.linux.dev>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 0/4] Add regmap_field helpers for simple bit operations
Message-ID: <YqoP9TwprnV3QKKT@sirena.org.uk>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
 <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8vCp03ihxJubD2IF"
Content-Disposition: inline
In-Reply-To: <180eef39205.122d47c8260721.2430302798386025245@zohomail.com>
X-Cookie: byob, v:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8vCp03ihxJubD2IF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 22, 2022 at 08:26:21PM -0700, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
>=20
> This series proposes to add simple bit operations for setting, clearing
> and testing specific bits with regmap_field.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/r=
egmap-field-bit-helpers

for you to fetch changes up to f67be8b7ee90c292948c3ec6395673963cccaee6:

  regmap: provide regmap_field helpers for simple bit operations (2022-06-1=
5 11:17:45 +0100)

----------------------------------------------------------------
regmap: Add regmap_field helpers for simple bit operations

Add simple bit operations for setting, clearing and testing specific
bits with regmap_field.

----------------------------------------------------------------
Li Chen (1):
      regmap: provide regmap_field helpers for simple bit operations

 drivers/base/regmap/regmap.c | 22 ++++++++++++++++++++++
 include/linux/regmap.h       | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

--8vCp03ihxJubD2IF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKqD/QACgkQJNaLcl1U
h9BYTQf7ByrrGDk9xfzsyQSGRgkL7VEe23NCIXLyPoMeg//wswaCgsNiNWEiMoah
1Xv2W8g0Q8GGxCbdQAd1VdKYfNOUJqoymIp6o/IXUrlYWq5nd4Z5lFLfndUpK/WE
HhKYQGisytJvsv6CbVzevjwpq1Rhp5jt76BhLW1rUHTrAm9OW2nb5LjaKZTk1sfg
LJ7HYYdIsYVG+XRmxsONwbTWTi8S5Fpt8cF/mVZ77cPAx2XoD7E79ezUDDL+fxN4
T/2CTOrZ3UxHvXOScTMe7tWcDLyBQHaQQBk2FmwanrVAObSrQiDRB0kaSzOkIq3g
GdwousE4cr5Ig/D5jt/wkr8WecpqJA==
=mt42
-----END PGP SIGNATURE-----

--8vCp03ihxJubD2IF--
