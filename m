Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E54492C00
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346397AbiARRLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiARRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D80C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:11:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B31B81238
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 17:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C70FC340E0;
        Tue, 18 Jan 2022 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642525860;
        bh=9Oiq6z0NhX/tzLVnd+VfU3zd3DlXHBDOmoHeXqvmIik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZSz15dqy7JLztDN0MIhWS0xoD/DVspHNJtE5Ot0Gf0c8sI9DkdUNhWxSgKcfDdmn
         mi34k1CvopHdAisO9jdc1O495rvsnJn5vFg/Bg6Gi6j2LOH+15p2rjCWiz8l6tY/TJ
         nK73s1klZDmx9/oQOpCm7GCbWOVNs3OOAxtKk1eOgiJlmS6rdvAqXNgCfzRfdBHS+N
         3eTRk91Yhjs1GvNWbN5xA7o0DQAnuUQ5TjHVXzXPKUX4Pp8XeYJK3vWzOkdGMh85bK
         zsqb0Dqk0KRemFCEmQBJGdAtwdUcYmLdgEEeaZAZbpmxJdGRxxaT+XxDzuTxfh/94Y
         2/HNi66h9sN0Q==
Date:   Tue, 18 Jan 2022 17:10:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Julian Braha <julianbraha@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        Vijendar.Mukunda@amd.com, AjitKumar.Pandey@amd.com,
        pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
        tanureal@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, fazilyildiran@gmail.com
Subject: Re: [PATCH] ASoC: amd: fix unmet dependency on GPIOLIB for
 SND_SOC_DMIC
Message-ID: <Yeb0n9AVXeVzBHrT@sirena.org.uk>
References: <20220117041528.59958-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CS/byuj3seJkHJeR"
Content-Disposition: inline
In-Reply-To: <20220117041528.59958-1-julianbraha@gmail.com>
X-Cookie: Do YOU have redeeming social value?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CS/byuj3seJkHJeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 16, 2022 at 11:15:28PM -0500, Julian Braha wrote:
> When SND_SOC_AMD_YC_MACH is selected,
> and GPIOLIB is not selected,
> Kbuild gives the following warning:
>=20
> WARNING: unmet direct dependencies detected for SND_SOC_DMIC
>   Depends on [n]: SOUND [=3Dy] && !UML && SND [=3Dy] && SND_SOC [=3Dy] &&=
 GPIOLIB [=3Dn]
>   Selected by [y]:
>   - SND_SOC_AMD_YC_MACH [=3Dy] && SOUND [=3Dy] && !UML && SND [=3Dy] && S=
ND_SOC [=3Dy] && SND_SOC_AMD_ACP6x [=3Dy]

Why is this a good fix and not removing the dependency on gpiolib from
DMIC?  While a DMIC *can* use a GPIO it's not something that's an
intrinsic requirement and it's entirely optional in the code.

--CS/byuj3seJkHJeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHm9J4ACgkQJNaLcl1U
h9BKuwf/Z8fB1aPDyhYaL2XXxpKPsXuHvvGt5D8UkgJbTPWxZ7fSxW/y7c1N06wl
kxUICkVKHTKHyml19J8jfBoMIiGtOsRj4FupD0ofYuyrBGt6kdMaVg+XVmkwtaDz
MgivjuU+iWO3sX0N490JUfsKlAoZv2RpkrlkD7hHmYIl/ks1a2D695ZJ2vs3unJG
nR8s5zDbf6Zjn6PedxL4uQ7XySc3WJvpcW8Y53ixZLsOiZc4gmA7LBKOXIaWyz4m
bKq9QzokLmwVkB6o7KCVmRj2W9/s0m1X+LMmaAUhgdtBKjX6fyy6TvcFX02RoUUi
LGU7wQKllI2X4535+htPG0KYmDChAg==
=gjhz
-----END PGP SIGNATURE-----

--CS/byuj3seJkHJeR--
