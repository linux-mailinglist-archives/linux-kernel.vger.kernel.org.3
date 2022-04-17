Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9CD504955
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 21:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiDQTkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 15:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiDQTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 15:40:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B91192AD;
        Sun, 17 Apr 2022 12:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26F89B80D8B;
        Sun, 17 Apr 2022 19:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6BDC385A4;
        Sun, 17 Apr 2022 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650224270;
        bh=d493NgaHWpGeOOrg1HPPk4wwspwcEi67zAXBZYQCvzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCBcl470QWmMIDQHkr8+YOi7Ny1iJQZe7021EemkvZYgWh6+en6SI4n5RKKFvloPR
         pBcYJPi3C4V/3F7Yg3nesfuHqM+6CrHh8t6gIA841Y5WsvHeYe3pNEvNADRC49MYOh
         uBvB12JBaXrg3uqbvbsu/hzZXOgjY6FT4vinPepQJlX0ye2l7or+gIRaGKUMRmXoUr
         3sG9bFqV5hiGifWafuSaRi7ktENvLgNcviy4BYkOvnhY+F+Vq+Oqk/0RWP+qscfBxl
         uX8c9d3/kn2X3VtpHAI/6B8eQhlh033qqD5dweXp3Upd3sKBMfTlmSBmh9zMSRu+Mk
         lMxGmV2r9Lr0w==
Date:   Sun, 17 Apr 2022 20:37:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        paul.kocialkowski@bootlin.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] spi: initialize status to success
Message-ID: <YlxsiQL4ZnGTGQfF@sirena.org.uk>
References: <20220416205132.295779-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wOgWwyIImvA/vFHa"
Content-Disposition: inline
In-Reply-To: <20220416205132.295779-1-trix@redhat.com>
X-Cookie: Stay on the trail.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wOgWwyIImvA/vFHa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 16, 2022 at 04:51:32PM -0400, Tom Rix wrote:
> Clang static analysis reports this issue
> spi.c:3583:2: warning: 2nd function call argument

The same patch was sent and applied several days ago? =20
73f93db5c49b9f52c902e5dc6c750bf9832e0450

--wOgWwyIImvA/vFHa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJcbIkACgkQJNaLcl1U
h9DA/Af/exlZOq0myZjy4rldyHuk0wIzcRzo2U/s2eFa+LEi8F6SFTVTFS3AJ9NV
Z2x7iFQqO8eD2eroIQc0oDJmRhNwcdLgG/f+pDf3BQ0kEcyUXr3j8/81N3g8xSck
nUB4yC1xLnpssHK5lWpCIW+Thp9nbQ2dr7/gbvNUSaQVeAzdFh9huUWvUWhkJbXl
XBoKLIS2nK0N30tIBTvb2BOerFWHDxOl+ie6TiE4FAT8jGQdVDqwcSpw5dvP16x4
1ufAr/F+6g6rHcDMJz21axLrOyHmdPW/vsVZhYxyR5ibHuPrsUNmuyk3ibyYzkaO
XIu9ZxYDh+GjVimtSaVIuiXTxHxDZA==
=5fpU
-----END PGP SIGNATURE-----

--wOgWwyIImvA/vFHa--
