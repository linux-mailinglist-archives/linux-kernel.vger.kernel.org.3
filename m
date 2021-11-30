Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72515463BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244038AbhK3Qkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhK3Qkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:40:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47B3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:37:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B37ECE1A2E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0C2C53FC1;
        Tue, 30 Nov 2021 16:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638290246;
        bh=XZVRKFmSETjefhPpu5bQxSVyU35juJLlT5lRP+0/n+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZyNng5jAAcHVLsHMvRUbt97yJmdcTtGzDSZ6OXSobePScLVtfysWzDEU/rLBHI51m
         zFf2PoG35hcx5LhGGH3A1XrvdHWrbohq8bsZox//Zk4O8cl9A0W27NTPXemgEHuJ8J
         HFHh7/bms6H9DNyhYs5BG1bNen2QDmACf+rEVmgkB6eHm6WgeEMLJiH5qAYmGxPEyc
         rxzzrq/0s9mukSQGvqXQ5WI2JoUDmzRc8nysmki/FMegVuAfu5m9Wh+IP2H8Qx5Ei0
         FTmKr77lUaKwvIYNIewRHKLqnsePSQPNoBk9Le8P16lsuYtfbSuoPEIqOVNWy6zCLz
         06P9YFx+g2fnw==
Date:   Tue, 30 Nov 2021 16:37:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: remove redundant ret variable
Message-ID: <YaZTQVP6YMFZcSVI@sirena.org.uk>
References: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
 <20211130160507.22180-3-srinivas.kandagatla@linaro.org>
 <YaZR56MLanjnQH1p@sirena.org.uk>
 <8279f250-59cc-368d-13aa-b46cc3cb108e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="03VrqDkxPp6THSgC"
Content-Disposition: inline
In-Reply-To: <8279f250-59cc-368d-13aa-b46cc3cb108e@linaro.org>
X-Cookie: Check your local listings.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--03VrqDkxPp6THSgC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2021 at 04:33:38PM +0000, Srinivas Kandagatla wrote:
>=20
>=20
> On 30/11/2021 16:31, Mark Brown wrote:
> > On Tue, Nov 30, 2021 at 04:05:05PM +0000, Srinivas Kandagatla wrote:
> > > return value form snd_soc_dapm_put_enum_double() directly instead
> > > of taking this in another redundant variable.

> > Cleanups like this should come after any fixes in a series.

> Noted, do you want me to resend a v2 fixing the order?

It should be fine, I'll let you know if it's needed.

--03VrqDkxPp6THSgC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGmU0AACgkQJNaLcl1U
h9DoyQf9HI5h5I7DW0vLk/TIjjAbCkQDq7F2wZ0ti34lgQtG4+VA6tT1y6ikFvhK
hH59Q6bLC4WNm6KnJURgtbsH+lcsZghttcMVnyUXuBEFpxt9IwqC0XY1jJbQPfVT
p+cP6wIaEQZvEpEm6vN6D4Lk7mFXvi87HVRV9e1FXqWqfcWYNBeF5ydHkIf5s4NC
CRfrYIiLjSWVIOkel3Zkl4H13RpCdx7hJkKjx1JcGdT25CR9q66e3AVkaHWzB3En
9FG/db6hmROhB92dgubXMHk/Oq/X9CT9asmBUGhvnDW2njcq3l+R/mcZKyixH3J8
Zrm6aE3K03y/ZcNwDzMNRBNWVzSnOA==
=4l9I
-----END PGP SIGNATURE-----

--03VrqDkxPp6THSgC--
