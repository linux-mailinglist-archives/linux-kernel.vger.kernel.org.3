Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425624856DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbiAEQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242017AbiAEQvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:51:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7C6C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 08:51:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8B6261807
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85951C36AE0;
        Wed,  5 Jan 2022 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641401473;
        bh=apkc2h6THvf/LSOTOxdYFJZ1zBcYo4vsMqYSSOYsaD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QISQWTN+/IO+qCUXJbL5aOS64t7jlANg/bUVO4rXVsPYLKiP8qMkNCB6dKEAY5YSq
         cPGaAV8a57n57k6Mh9IR9ifjvTfB4CfVzzQhb1kkeYbY8EaXVVu1pXSJlpvvPUFcxK
         KNGD2Y2e3SFG1ZIUGA+IeirR9HemnjMxY6kM2xwFtlNlkM368u68KUl255YuxXyLfC
         2l/g6w4h/wB76+fWwmSXyu3DstUljAnzKuqiuHsheuKJ5QvDo570RcUMDfia7Xl+Wm
         XDOkkSBQfg1NiCVhLGiGGuCyNVvh347pL1Z/U+FNf+YmavgY91yxIvGhpv9pys9nnA
         X6LAbhlrGQUFQ==
Date:   Wed, 5 Jan 2022 16:51:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     linuxkernel@fbautosys.co.uk
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/5] Add Parity bit Calculation to regmaps
Message-ID: <YdXMfX5xayAfRWXe@sirena.org.uk>
References: <20211222184340.1907240-1-linuxkernel@fbautosys.co.uk>
 <20211222184340.1907240-2-linuxkernel@fbautosys.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RhWxOnC0ocoXDMoB"
Content-Disposition: inline
In-Reply-To: <20211222184340.1907240-2-linuxkernel@fbautosys.co.uk>
X-Cookie: Byte your tongue.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RhWxOnC0ocoXDMoB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 22, 2021 at 06:43:36PM +0000, linuxkernel@fbautosys.co.uk wrote:
> From: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
>=20
> regmap.h
>=20
> Added bitmasks "parity_read_mask" and "parity_write_mask" for read
> and write operations to regmap_config bit mask defines location of
> the parity bit.
>=20
> Added optional callback "parity_calc" to regmap_config to
> calculate parity bit value

This is still more a list of changes in the code rather than a normal
changelog which is making it really hard to review - I'm getting lost
with the patch description trying to figure out what the idea here is or
how this is all supposed to fit together.  Like I said last time please
look at submitting-patches.rst.  It's probably also useful to look at
how other kernel changelogs are written and follow a similar style.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--RhWxOnC0ocoXDMoB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHVzHwACgkQJNaLcl1U
h9CnRwf/eb1GCYerSGfriZLHhRGNCF7iKdpLUqEV3M0Hxv28pkCPR09J1JbLFQvj
SrgqE2jktqCol/V1RUWTxGlQwZbCd7q7I+xs3DiGXsc6TtHMb94EJ5GlvGbao0qz
AVUtj8ICxbxMTxSm418aUSi40lN9f7O4TZ2bvXg/ZEkrDmJXg0xO7fgaFkk7OtzV
9zR9rVlztrW3RlFu+Rx8Pc5W51ziBZKUh8cmO8B2xPCuqDbVeOOq59wfjAs38QU9
cOWMaVj4ysIcCTRERRuK6R5rbKxOjGWCEEq9AN9m1HJCYHUaIHmSRfc15YuoY+at
pUHV2QgFTUJAVL+L5CDou6JY6GihpA==
=3SWT
-----END PGP SIGNATURE-----

--RhWxOnC0ocoXDMoB--
