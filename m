Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A486A57F131
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbiGWT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbiGWT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:28:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BFC1B7BE;
        Sat, 23 Jul 2022 12:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4373B80D26;
        Sat, 23 Jul 2022 19:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFE2C341C0;
        Sat, 23 Jul 2022 19:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658604510;
        bh=YN31doChPv4onmW3vi81LWSiAGZ5uWlj7uyzF23Fxg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ApHRQc1DOQ35LdpyeyfYUY5gpxvh7JFc31BtLz2uD9wP7Rdm0nD2SL/2yGN58ycjP
         DJ2nQQgZdOUfdhuwLnsfUle54aqhrq01j7PKMWNK6oBdSGCeoTAqDZySMVDtGcd0k8
         Ds6ZZmOlk9u6QCtqJ+eJEdiH1RYxo0sPN/nyAPixMC+Z4Kq5twwacYq4KfiOwSuQL7
         K64z9KRjSmXf4nUmmSZECeogSHMXQwgT8CHld8oxVVQnlorR0l9rKW3jCrvMSsxDd1
         q4shvTRpOM2kfxABr9HKMwqr3bcqhv6LENeQYYdt3K8fOmnyHGh8i20e6vZWBJ1A55
         WCsr65UDAyN5w==
Date:   Sat, 23 Jul 2022 20:28:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, Noam <lnoam@marvell.com>
Subject: Re: [PATCH 4/7] spi: a3700: support BE for AC5 SPI driver
Message-ID: <YtxL2kjJhJ6IhVDA@sirena.org.uk>
References: <20220723102237.10281-1-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uMGvqMQmQc2NWCGD"
Content-Disposition: inline
In-Reply-To: <20220723102237.10281-1-vadym.kochan@plvision.eu>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uMGvqMQmQc2NWCGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 23, 2022 at 01:22:37PM +0300, Vadym Kochan wrote:
> From: Noam <lnoam@marvell.com>
>=20
> Tested-by: Raz Adashi <raza@marvell.com>
> Reviewed-by: Raz Adashi <raza@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---

There's no signoff here from Noam or anyone else at Marvell...

You've not copied me on the rest of the series so I've no idea what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--uMGvqMQmQc2NWCGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLcS9oACgkQJNaLcl1U
h9BZOgf9HpwTWvNoSTfRH6YzJr/DiNP4mPykQ/GtDdWNi1hZNilJ35hUGcdrT70q
ImZfHAFy/Gclnh6y7AES2U7Up3apuOz6LGQoaLr1Zu/snRkDUSuGxt0JH2gAgvRB
KKRLwU0NfYZgWZV6u4OhJClYVJ5kYxnNZhsDsSSNvb1Bk4+mzqcwT/vY8t2hktFb
hW89ygTtMQScnBX6iPfkpwaoyra1ShhqCcwxkiklEK1NuFmblQ6/UgaFq27kMmLI
pgC20MIsliTefRYl8CjcwmR5Es1ZdM8n8Ake2/vVgLdZmBQ4/FGYBzvr4j5HuLEg
xoLstB389moYysHm729Q8xX6u1jjWw==
=+Lsx
-----END PGP SIGNATURE-----

--uMGvqMQmQc2NWCGD--
