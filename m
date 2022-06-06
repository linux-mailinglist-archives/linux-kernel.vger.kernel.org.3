Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47953EA94
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbiFFQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiFFQSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3961C4B13
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EEBA60EA3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 16:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD1EC385A9;
        Mon,  6 Jun 2022 16:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532318;
        bh=3oCBnEMhW8iOscqIU/v0ccC1Gno4VX5ZfFY5AQN/GQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DOaXzseA3IdedKlDd/0SMXSAH2XsHX4047LtvaxgprVkZ5ylLldFVhtYPLNg8vz9m
         F5tlfOrpFSXLtIlvFugShdJZDaeWfjPDjYGLkuuI6HnCYnUd9p3vqEb01M1cumxi6r
         Vp94/VbeioAXEbIrImwBWcY2VPF2TTN+tEeLcfNx2nqcN7ooPVgJVUuBcX+CvFfpnC
         zqOgDZKC/jgC4z8htUqsmPHnaNg71zIxbjHnrnIuCNgHUcQoK7xESnbV5rUTG+iDzU
         GZEjKHVoPV2DBIv292LdXxIyoq3ixFVXvrFEhNPh1tBAe13KkotFQCTOGMChd3/mqg
         WRjq4l6jJp8qg==
Date:   Mon, 6 Jun 2022 17:18:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 2/3] ASoC: wm8940: Rewrite code to set proper clocks
Message-ID: <Yp4o2bQammYjv7Kt@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
 <20220606154441.20848-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3nyy0JRAQdDxWcrH"
Content-Disposition: inline
In-Reply-To: <20220606154441.20848-2-lukma@denx.de>
X-Cookie: Bedfellows make strange politicians.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3nyy0JRAQdDxWcrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 06, 2022 at 05:44:40PM +0200, Lukasz Majewski wrote:
> Without this change, the wm8940 driver is not working when
> set_sysclk callback (wm8940_set_dai_sysclk) is called with
> freqency not listed in the switch clause.

> This change adjusts this driver to allow non-standard frequency
> set (just after the boot) being adjusted afterwards by the sound
> system core code.

I don't entirely follow the above - in what way might the core adjust
the clocking, and why would we want to allow the use of invalid clocks?
Surely that just makes error checking worse.

> Code in this commit is based on previous change done for wm8974
> (SHA1: 51b2bb3f2568e6d9d81a001d38b8d70c2ba4af99).

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--3nyy0JRAQdDxWcrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKeKNkACgkQJNaLcl1U
h9CBzwf7Bsk4iYWK7ta6JUCjk6j2ZHCbZQHOMiN6efdBy834xrJCPOHTbaCz3KvO
Kye4CEAZP8dHX8/L8dHyOFnPlzcDTL2lbSoMJNOA9rP4IUjCGdCBIyPLQ/kzEi4t
Zcvy/aAB3tiR6rtlHP/3f/B+gqW+2b5vqJ2bjYMLL0QaK4xo8T4OZbUTtxPn+yOc
Wrm2qJGy1X2PFU+Rtoh/rE5wPyCzvhjW5GzJJ8i111MnFvLsVlfbB0ckZ1+zrYFY
JiP+ELOKT7USyUFugr3W12oV0RSGMQYa+uDqXSeMwZpos7U1WqbxSuEo3uRldgsB
gdAfowSaXfq1ayZwfjNAl4WtQWAakQ==
=RBse
-----END PGP SIGNATURE-----

--3nyy0JRAQdDxWcrH--
