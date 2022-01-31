Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6014A3CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 05:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiAaE7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 23:59:47 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:60673 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiAaE7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:59:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JnG7p393Nz4xcT;
        Mon, 31 Jan 2022 15:59:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643605175;
        bh=ota3JHHSk/3k9imdU21YBa8OR1DqBfe5NzVdXn0BZm8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tkwj/z4SMCIwJMj7z2Sedh5eqQHzt8nVRBrgvT707iJID6F1BCAZAB9NZDDsW/fke
         eiirJcv9oYUTTxw83KtvdhDHGdtI8ESnTtgmtCKNcQr1Cvc4uEHA4yxkWInQJyzgPU
         fwYYrubMVwiry2rOr5kx8h3CyNsoCEpS8NOgh0UOLWUOtD6Apl0bhl2bLOsL6cEZcb
         bjABnB7tjdCBZYJeLQDph8OzF7SgKXqUqIdUxNrhHplfit2oZhAoi1r6WtTmIRFKF7
         D+XoA1G/OrNCe5lj1BNezpLlDuhYkkJ3RKHhPPS7l3QZbI39n+u/GVtAk2LwTKFuz2
         SFK1WZ5rBAegw==
Date:   Mon, 31 Jan 2022 15:59:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220131155932.3f88ec71@canb.auug.org.au>
In-Reply-To: <202201302002.41A8DDA2@keescook>
References: <20220131100954.74a2034f@canb.auug.org.au>
        <202201302002.41A8DDA2@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z0aNWtznNpxY=k8=wBTJoE1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z0aNWtznNpxY=k8=wBTJoE1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Sun, 30 Jan 2022 20:04:00 -0800 Kees Cook <keescook@chromium.org> wrote:
>
> This should be fixed by:
> https://lore.kernel.org/linux-hardening/20220124172242.2410996-1-keescook=
@chromium.org/
> (I was expecting this to be in netdev by now.)
>=20
> This should be fixed in:
> https://lore.kernel.org/linux-hardening/20220124172028.2410761-1-keescook=
@chromium.org/
> (Again, this was expected to be in netdev by now.)
>=20

yeah, neither has made it yet.  However, it would not have helped as I
am merging the kspp tree very early so that new bugs get fixed in the
trees that introduce them.  These 2 are in Linus tree (for a long time)
and so it would be better if these fixes went int the net tree and then
Linus' tree as bug fixes.

I will use these in the merge of the kspp tree from tomorrow until they
appear earlier (or you could put them back in your tree).  Cross tree
dependencies are a pain :-(   BTW Linus would have the same problem I
am having if he merges your tree during the merge window before he
merges the net-next tree ...

--=20
Cheers,
Stephen Rothwell

--Sig_/Z0aNWtznNpxY=k8=wBTJoE1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH3bLQACgkQAVBC80lX
0Gw+Xgf9EQUelKzttawwgm43csc5oxSZ+fns9IuA2DWVTzW3Ax1htYOSs8x5Zit+
B4NFwa+LbkakEkmu3cu4O/YTpKS9FcQBdSUB4VzQMXmdmNDCFAcvulLc+Vz1XiVp
laStYyzRKjUumMZZMqOWuHPME6FBFF/q7Qf/RsSJ037W7KI/YyK62umQCw2Otvx/
3oGrnXSqjmgYpVLnBWS0afWVyVUIVzF5tgRdAwYAPC+GVRfGLoUhIzKS+iEKBg/n
25e75BPm/WDWhlq0xNK/qZrZNW0+rdI2+uhd08r5XxKJnCtwMJ1PnkRKfgVzwK5o
U55DNoO99EN8Z3XRbjhSk+Qx2YEZDw==
=0wH/
-----END PGP SIGNATURE-----

--Sig_/Z0aNWtznNpxY=k8=wBTJoE1--
