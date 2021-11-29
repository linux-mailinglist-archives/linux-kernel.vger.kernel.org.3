Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BDE461D31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345466AbhK2SBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:01:30 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40268 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345452AbhK2R7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:59:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CDC9ACE13C3;
        Mon, 29 Nov 2021 17:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD2DC53FD0;
        Mon, 29 Nov 2021 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638208569;
        bh=lqJiiKekGdSFz0ooRlx6p12gniCHvJVjb280cnUkOVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTljZLxZHTdTwXKdiN3/LDqW+Iz2W21xldKn3X9Zw1ro+kM6cyQHo6KfQXP0mzevL
         icvxQiPoWjTxVDla7lGkOtiomftwA05ocmRKZTcYgp+rQ0gZvNh5kz14ClYj/dGkdS
         B2cKLDdhG4ne+f5oUElgvDxm3HxpKJgLtkZrNQeqW8+KJYBo9Tpuu7XGcP621DdP9b
         mLCSK+uk56SyEuuVOw4ErcjZ+9ZbAypZ+AT5Jz2vuA/zVbW8js7Avd4PiBniVR+Bbr
         Om+geqOaMnr43x/+ayitvhSlSfixG2oG9VsxvotvnTR1iptNrPOMD1ercEYp0+Vsrf
         HmZqW+37wozgA==
Date:   Mon, 29 Nov 2021 17:56:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     kernelci@groups.io, nathan@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tom Stellard <tstellar@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, cki-project@redhat.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Bump minimum supported version of LLVM to 11.0.0
Message-ID: <YaUUMn6noJQRXp1q@sirena.org.uk>
References: <20211129165803.470795-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wC5KaXERvAzkp9VU"
Content-Disposition: inline
In-Reply-To: <20211129165803.470795-1-nathan@kernel.org>
X-Cookie: Thank god!! ... It's HENNY YOUNGMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wC5KaXERvAzkp9VU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 29, 2021 at 09:57:57AM -0700, Nathan Chancellor wrote:
> This patch series raises the minimum supported version of LLVM to
> 11.0.0.
>=20
> Patch #1 outlines the issue, goes over the potential impact of the
> change, and does the actual bump. Subsequent patches clean up the
> various checks that are always true after the bump.

Reviewed-by: Mark Brown <broonie@kernel.org>

--wC5KaXERvAzkp9VU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGlFDEACgkQJNaLcl1U
h9BjEwgAhdF9+7Ne92+Um8gDokv0S14rpQ9x/g0wU3cO0ktDZp5NMlriwkIG0FgQ
jnV8PvO9oWWvkK9BFr7d1IXGV9ZK1tFyrU6UzuUrPejstZX7vi2NGI21SESCaitj
OivGUpyOIMi0nsLYlDrvNojRKOh+bZwugAkJh5wGVy+tllvQAWiX8318K0YHipKT
52IlJ15xt4S7A/RzqLBoGHklutUK0WnFZoEQ7INb4Sdja+KEUeCAIQyuIP7c5TG4
H0Ys5k8PKegJ7c7u3wCXbBjwOKjz+WjBqzS1gSyILKBHMsBBy8tswwdZznPBceWl
jMB8V10GZDzyA+N9cGCx/NlKyxZDiA==
=CplQ
-----END PGP SIGNATURE-----

--wC5KaXERvAzkp9VU--
