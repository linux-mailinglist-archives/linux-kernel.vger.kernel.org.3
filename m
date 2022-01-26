Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F3A49D005
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbiAZQuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:50:54 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37482 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiAZQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:50:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E0A1CE1ECB;
        Wed, 26 Jan 2022 16:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC97C340E3;
        Wed, 26 Jan 2022 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643215849;
        bh=1cgmbcZ0e/AT2PqQvRKm/v2aOJwVfwwesAq0tfOOHcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDzMRyNrEJENcowk1xqt+k2IrEi6qh5BxqxnclOJKO2dqh3/A0N5SiuPxnIirhf7I
         SIATo2hAoQQu19QHkddDteWUjlIncQe+vLBQYY6f+J8UW/2r2ZGmJVXSgMRbpljhW9
         cIxAxfkI/rQr8zo393UmHUnX9+C2zNqys3E3xcjkjOwsaLyuL/k5xQ9Ol3OOeB9Dh3
         Gzad1+9sXSD2LqH3KQkRYFTX8UbWE5bG/Y0uBj1GoFibNiP5YWTL/9enFLh9tH2F0y
         z9J7UtmtUs2mp8CdBJpzJZZexZkk1qW5rEWfCeuWbIuJKiAEae/HFElejXVln+OxKG
         /v0regaxaCcsg==
Date:   Wed, 26 Jan 2022 16:50:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkumard@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/5] ASoC: tegra: Update AHUB driver for Tegra234
Message-ID: <YfF75N97CzLNDRMs@sirena.org.uk>
References: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
 <1643100491-5398-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7G6rfQCsm0QlA7PU"
Content-Disposition: inline
In-Reply-To: <1643100491-5398-2-git-send-email-spujar@nvidia.com>
X-Cookie: Falling rock.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7G6rfQCsm0QlA7PU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 25, 2022 at 02:18:07PM +0530, Sameer Pujar wrote:
> From: Mohan Kumar <mkumard@nvidia.com>
>=20
> The register offsets of switches connecting various AHUB internal
> modules have changed from previous chip. Address this variation by
> making use of Tegra234 based compatible.

This doesn't apply against current code, please check and resend.

--7G6rfQCsm0QlA7PU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxe+MACgkQJNaLcl1U
h9C39gf7Bgac0Z427RTs2ThXzH7ngg9dB03iZ+TD9vFLhe4Prs/g68DP3xec+gCI
yG2D688DuGSW6QSIcGggWJHgrTYqzD0+IC1bE1JmamwUB4ulq2ftBIqk4ot0l9t4
UQu4CYuL52Tohok1/1RKQYRVKAD+Evw5fFrygVCRPXqU4bhTOiEA+z+6MxL1zfcO
YZEAvcm3WYjzqK5+so6kcCJL2aVIc7u2TNekGm343hvnwDthhZPjENNrlM1xwlYG
XpsHUKxvWEBXRn2wE+eB5mY81VvmhVd4W1/002WeVICx1w34pxFQVtvTk4DZFsB2
bPMLsH0d6SXkpRPOXSVXi5fvC1WwRQ==
=udiP
-----END PGP SIGNATURE-----

--7G6rfQCsm0QlA7PU--
