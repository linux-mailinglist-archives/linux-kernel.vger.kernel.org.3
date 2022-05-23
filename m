Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1C530F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiEWLj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbiEWLj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C118E5007F;
        Mon, 23 May 2022 04:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC9E612AE;
        Mon, 23 May 2022 11:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB16C385A9;
        Mon, 23 May 2022 11:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653305993;
        bh=OC1izSFKp6WFdxo7syUD+g/hsAbJtBJQWFtDt3ICR70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyZt64kzOKZP6xetGUFTckdxsa62eMafXrgVAbDd//0jkqffQdTCZMoOkEHg6EI9m
         pLMh8yGUazKznWaEBqRwVD/I8TRxIV5W2R6G9F8NTitjr5klse8+M5rUDRgi/EjeY6
         AoBxu5RHQn/rNybEWNcRFjSI2KEu/SkXXyKkqV/stZm+iew5EJM4bf4lIPcOfCrCAr
         OhHF476tob9ywX43CovxJhDAaiJ2VomR6Wq9J3gA0o/r+MLcn9s4w7WyqO3AFpFIGn
         J1I5P2qxULTfPTL3gssVrOnznMvD9pM3Mx6O6lO5fQ+goiFfnBrWrFjSzFhf1GybYY
         lGOTAtSdySwsg==
Date:   Mon, 23 May 2022 12:39:46 +0100
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
Subject: Re: [PATCH v2 0/4] Add regmap_field helpers for simple bit operations
Message-ID: <YotygqDAkAXRRo9d@sirena.org.uk>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
 <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YPlGNYyWzcAMDZRd"
Content-Disposition: inline
In-Reply-To: <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
X-Cookie: Sales tax applies.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YPlGNYyWzcAMDZRd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 22, 2022 at 07:22:37PM -0700, Li Chen wrote:
> From: Li Chen <lchen@ambarella.com>
>=20
> This series proposes to add simple bit operations for setting, clearing
> and testing specific bits with regmap_field.

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

--YPlGNYyWzcAMDZRd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKLcoIACgkQJNaLcl1U
h9CGAwf6Aqcrn3Y6tb7EafFfurQwr3Crsu8tQbSSTQLVF1sEFNE103GaQAMmGrOV
/gS9YF2ov9GtVEf8S6GQL/kysxuDAx+9Y1bXsi0FSGksQoXsMiZ8uP74w+1vOf1n
cCrfT1LyFNFSX9K1dGsTa7PBKTVaSfn+gvpLciODmd/kLZ3r74PanNXwrOJ6d7su
PzsawtBIRto9stB5SYK976MqqPUGrhIazLZP75ovU8Zv5UdYg/Qgb9aMaVKiAVAW
6XRa/On++FFX3Ob8jcvfjp8krmplQJ43QvVW1ICd9cT4xAnjMKmYz1w241llIfg3
cxd6zy8OxcjQlcZXn3XVXkwHnAwU4A==
=mmNk
-----END PGP SIGNATURE-----

--YPlGNYyWzcAMDZRd--
