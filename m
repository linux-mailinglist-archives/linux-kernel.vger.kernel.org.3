Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E07486866
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbiAFRY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:24:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46472 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbiAFRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:24:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77B82CE265A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 17:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9D7C36AEB;
        Thu,  6 Jan 2022 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641489893;
        bh=0VjfhkEHZxqQb4xcNy0DUo4M2fWvt9NCApIOOqLomcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+a7uGt3D5fQUc7mFMxSz7iRqrfw2hpnQGHawR+ghiQ2EtckY9oKF1Gkwz81VtA3a
         oySwUJdbV3e5KT9CwYlze0gnC8xuzfE/BALfOQ07EbXnfcFpk7u1hRjH8gtZKzvQdc
         8CbORnabNMplkmTFZSajdQP4MGin0fSTNIFlGVNOGMefkQqMBwTbb1+pCsFCZEbbk7
         FTlHUd5wGr4lEK1+pnjXmxJ2q3ZnvxKub8RD8HyONqnR+k8iZVd1qqVOT0e6vog02s
         s0aPk0Caw3ys/JIIXKrGgz2T3xC7sW6PkDCJfVCVvnb0I1gI2tljKmP6I2yxs3yhnS
         ILWIaMyeOY/Lw==
Date:   Thu, 6 Jan 2022 17:24:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: debugfs: Directory with parent 'regmap' already present!
Message-ID: <Ydcl4bkdxco1UeuI@sirena.org.uk>
References: <CAOMZO5A5H7HrCXoTAK98dkT0wEybcnuazPVxZeHvu78Nq7Qm4g@mail.gmail.com>
 <Ydbbktqvc8PXQQd0@sirena.org.uk>
 <CAOMZO5A4292S216dPE2CwKwa6tRoWaGfXfJh6rVJTNWk8r1ZdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1TlAi+t154exvSkD"
Content-Disposition: inline
In-Reply-To: <CAOMZO5A4292S216dPE2CwKwa6tRoWaGfXfJh6rVJTNWk8r1ZdA@mail.gmail.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1TlAi+t154exvSkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 06, 2022 at 01:57:15PM -0300, Fabio Estevam wrote:
> On Thu, Jan 6, 2022 at 9:07 AM Mark Brown <broonie@kernel.org> wrote:

> The duplicate "dummy-iomuxc-gpr@20e0000" comes from the lack of doing
> a kfree(map->debugfs_name);
>=20
> Calling 'kfree(map->debugfs_name);' like this:

That doesn't sound like a good idea - if this does anything we must be
looking at the data so only adding frees will only translate using the
wrong data into a dereference of a freed pointer which seems worse.

--1TlAi+t154exvSkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHXJeAACgkQJNaLcl1U
h9ACMgf+J1fhdNM1OoXmwPt3dkT3/VOkgXACQRoZJ7WIRC5xxIccSrje5wCQRs5u
dFtygvEsEg7HSg+0MJo7rGJ56ixEmnyyYAFMJ6K8SE7K4pnd4e/9nocABHIwk3yC
zQPiKVdN//VnMYW1oKmSBogqjz6ptx4OYyclh+MtHgO8STH0KmmJKXCZ4HfYk8Vz
1LPNzKtBNTF4SCxObDciVJ7u4hiK16DX+E8c6+MFZWwpFkkhJDDpXkzqjZmD2dlI
vFXwDR9b6KY57erXpPtEopDRfLunk2ZimCe8SPj/xzcJS5RN/Cy0FAMEt8ggu/wm
nQZyQ3fWpasAfdIFlJvrGW3/MzJUKg==
=v+6Q
-----END PGP SIGNATURE-----

--1TlAi+t154exvSkD--
