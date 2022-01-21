Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC004962CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349517AbiAUQau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348692AbiAUQao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:30:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6BFC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:30:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E2461908
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 16:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D363C340E1;
        Fri, 21 Jan 2022 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642782643;
        bh=NNaFq9JVvvEKdGzSI3riUqkr8doOjGfR3fuYtiCt27k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qjOoh63aPcrgLQzUyL4kcwXsj3f4B3yXPfVJtbyoglWCsyTqFUmxA7M2yePReBifY
         StoObdgZGx81fcU32WgviMfa/AbHh5yc+RL/Ah9OFmWpskmOj63+EgYQCsElAVKuEd
         t70LHRIKsX3+yRyl6Pz+HwgNPwmCEA24C+WNMjbdQ3lDM9Cyv8a7LjCoxWe5XS4dNa
         acc5s6xycSiwjXOkVLR3ZgnZ4cUCLsGWFFR8FY8k91EQurz2MJ4XDbTSp/aU0nxh6t
         BJJZ9FM95/YRklGm8Sy/81CyEsp38xMshE3O+GFc6NSPw6FSA6Y43cplNVOsXX0HSQ
         dxXuBYgcVxPLw==
Date:   Fri, 21 Jan 2022 16:30:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 8/9] regulator/rpi-panel-attiny: Don't read the LCD
 power status
Message-ID: <Yerfr8Nj43TTPcAF@sirena.org.uk>
References: <20220121152056.2044551-1-detlev.casanova@collabora.com>
 <20220121152056.2044551-9-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="85hgKUAciUuFcJya"
Content-Disposition: inline
In-Reply-To: <20220121152056.2044551-9-detlev.casanova@collabora.com>
X-Cookie: Alimony is the high cost of leaving.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--85hgKUAciUuFcJya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 21, 2022 at 10:20:55AM -0500, Detlev Casanova wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>=20
> The I2C to the Atmel is very fussy, and locks up easily on
> Pi0-3 particularly on reads.
>=20
> The LCD power status is controlled solely by this driver, so
> rather than reading it back from the Atmel, use the cached
> status last set.

If that's the case since you're using regmap would it not make sense to
enable caching in order to minimise reads in general.

--85hgKUAciUuFcJya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHq364ACgkQJNaLcl1U
h9D5Xgf/c5V0aHcwjdzV/GNB+4/G+ydNlB03YSE3Sc1QKmkNjfEJrzA9hNk0Wz4V
rSukjVajHSNsXNAHvNqDMeq2ROqfhkmFCAnNRWKLh6ml7zHgHSuaD/4wXlo0a+Yp
Qv2LaDQwONDH8+R2ORXcIvwd3l/dUgA3JHqVKmRnNz6PXDqe8oQOAg4CvgX0S2gP
lm+pO+guhqpuiqsBo3kF+ZIlrxzI0e4x60c596ajG0hstrLXunL9YcqcWdqOTSk6
rzoFhf7XhS5a+qncwQ3Cy7+knuK53rQDwDQoqmIEHt5zg9SDjY1GDTUghc62iN84
47i+LEm+mQSRbu9VYJWi/IUztus8EA==
=juuu
-----END PGP SIGNATURE-----

--85hgKUAciUuFcJya--
