Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED6B47AB02
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhLTOFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhLTOFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:05:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C766C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:05:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A5F76115F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCD7C36AE8;
        Mon, 20 Dec 2021 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640009108;
        bh=fABHDkAQAudJrFvbcGh6ywt+PHRfKA0RISa1TKkARIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9L780xRek3uPtLSXLz9hUCWAPVYqOrbRHdhjvkmIvmo/j5X6xNG8reqSzcbIKGCI
         IezGj6SEUcyzQMi6199QIG245STbcKOGpSQ2tDlutaXgVhcGDVPg7DBAFdSm69EFk2
         gys63+m8nP8cc32GLKVjYPm6ePXYZjIlNBj6GWFOG7r5IsLIGOqaSo1lvudBS+eHfF
         Bbn8Bkuy2grpNjp5EA8kj+2OZUaOijyAcQN70Qwl5eYMUgJqgGgCkRBQBx+8vfRjWM
         s1H13BLuoKmwKUqRilIYgb0e+kin5DGr5fga1VG8ypXMj1GJlfpmDQZh2Y/XA05+bl
         jJKD0TY8Jgvqg==
Date:   Mon, 20 Dec 2021 14:05:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     linuxkernel@fbautosys.co.uk
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] regmap: Add Parity bit Calculation to regmaps
Message-ID: <YcCNkCPzhyWm5YE3@sirena.org.uk>
References: <20211217224104.1747758-1-linuxkernel@fbautosys.co.uk>
 <20211217224104.1747758-2-linuxkernel@fbautosys.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P4t9RYAfABgox3G4"
Content-Disposition: inline
In-Reply-To: <20211217224104.1747758-2-linuxkernel@fbautosys.co.uk>
X-Cookie: Christ was born in 4 B.C.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P4t9RYAfABgox3G4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 17, 2021 at 10:41:00PM +0000, linuxkernel@fbautosys.co.uk wrote:
> From: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>
>=20
> regmap.h
>=20
> Added parity_read_mask to regmap_config
> Added parity_write_mask to regmap_config
> Added (*parity_calc)() to regmap_config
>=20
> Added regmap_parity_calc_even() Added regmap_parity_calc_odd()
>=20
> internal.h
>=20
> Added parity_read_mask to regmap
> Added parity_write_mask to regmap
> Added (*parity_calc) to regmap
>=20
> regmap.c
> Altered _regmap_raw_write_impl() to calculate parity
> Altered _regmap_raw_read() to calculate parity
> Added regmap_set_work_buf_parity_mask()
> Added regmap_parity_calc_even()
> Added regmap_parity_calc_odd()
> Added parity_even()
> Added parity16_even(u16 v)
> Added parity32_even(u32 v)
> Added parity64_even(u64 v)

This isn't a good changelog, the changelog needs to describe what is
being changed in the code and why in a way that provides information to
the human reader.  Instead this is essentially a list of code level
changes in the diff.  There's some advice on changelogs in
submitting-patches.rst.  Without a clear changelog it's hard to review
things as it's not clear what the goals are.

--P4t9RYAfABgox3G4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHAjY8ACgkQJNaLcl1U
h9Dfpgf+JAyBMHf5zF1fGqbuNCk45NsINZQGR0OknfYCv99phi/7gWlBihCAh92H
X3LjAK5v3xSJMSYcFngAKTgRrJGPjT0fVGasnCif7zF/5NBEA49jyetw9M6i9uTY
jPOXft5xZr96OX7ojF6G4AH3NqLHbp3wBSSJhEQjKA/1PmUxlbsHoKYdu7THtqy+
gdxEclKEmEAJBiPUuy8hX0x+sMFNwsLGa+R9+SvGtvUVgbZoaLztZIde5DGeYHRU
7F37B1zoK/D9tZsL2TQ5Gnuu6oZpIZdxWkIkoyp1vd0fQ4Rc9dtABsMA7K8cx/lU
BCyAqJijNWJaNWyHN9HGDclMgBK3Yg==
=1FBI
-----END PGP SIGNATURE-----

--P4t9RYAfABgox3G4--
