Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EB649461B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358339AbiATD0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:26:45 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:54069 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiATD0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:26:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfSbg5bpkz4y3h;
        Thu, 20 Jan 2022 14:26:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642649200;
        bh=FT3/xS+i3pKO1Rq5p3/rgHtAgCACk52OCkLLXm/hxl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pwBctDf9UXYvLw9avbNru0hoc+QC78quF5aL0hsg6kSxqN+ScdEb6wk2Og5Wdyybj
         GCd7sqiIHpG26yRbi5V5VzDcqEpemBZ8VoYRbOhvTjyLh1AmIHTiNqRR8BQ0NmeD3x
         qhSzp3ZRBcnk08HsHtGQR4LywBcisWKnyzVL1zikdq+0ca46OAXTHWgmgdM7Erh927
         Dtz5OYoYk0fzqaHe57VAoHsoiQYShuyhjLRz4K4Ffl1+UFJcmvO6o1aTsNlhtyPlLi
         VD7SrfDoTqX+hwIA/MLqaH9xt5/BdATjT0ddAamYlc4VCyN0UzMWCA+wHJbZU4vTE2
         i8JPQjhtTCXew==
Date:   Thu, 20 Jan 2022 14:26:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20220120142639.02c54ae9@canb.auug.org.au>
In-Reply-To: <20211117134926.1d339d71@canb.auug.org.au>
References: <20211117134926.1d339d71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Xhb9mvR1geFap9+==HkXU1D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xhb9mvR1geFap9+==HkXU1D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 17 Nov 2021 13:49:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the drm-misc tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> include/drm/gpu_scheduler.h:316: warning: Function parameter or member 'w=
ork' not described in 'drm_sched_job'
>=20
> Introduced by commit
>=20
>   542cff7893a3 ("drm/sched: Avoid lockdep spalt on killing a processes")

I am still seeing this warning.
--=20
Cheers,
Stephen Rothwell

--Sig_/Xhb9mvR1geFap9+==HkXU1D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHo1m8ACgkQAVBC80lX
0Gwe4wgAg1Avti7A8EJ2DCMxpGmXL4BjKZeX0jKKbDuPJTDrMgGR7S3duunC7waT
7QFTHTxnEwSeRt+sm8ZkofrBvLxkZg4WUCn8YkxcTU7S1H9SY/r86+zJMlPCc/xB
GyMv7oY+G1HkG7XA0Ou5FgBjTxHyqrWr9a462Fosim2CEr1klT4H+uP7DGoc/oKY
o0PKTBp0TEfd1i2RmqnlomxZlGZiiGpT6CvXJDfGX5kM8OghwpLc1YyJwANaDOC2
E2Kziy2wtE+ig2Sgr6liMEKyyb/qTRjhN4VcF8/BGB/SEkHMKsY5pywJQzk7Y8i1
gj28nDpwihp9p7PVvjawsreyD/pbVg==
=xwhi
-----END PGP SIGNATURE-----

--Sig_/Xhb9mvR1geFap9+==HkXU1D--
