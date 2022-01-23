Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0249758F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 21:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbiAWUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 15:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiAWUpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 15:45:35 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B94FC06173B;
        Sun, 23 Jan 2022 12:45:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JhlW04JnJz4xQp;
        Mon, 24 Jan 2022 07:45:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642970734;
        bh=qiyfm1azNSvAEXaq4aON2MORVGGRsZYMBHwJMRL2WaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rD8++OR813ogicFXUYz0PJY/aSUyntHXxkV2/FaYYkgUaEOP9OUtkA6rn5xAhdMdL
         KFKXn/7LywkkzqraA3QKK0wEEnqVTG+jogZ7iX7zrPfL+WitP3Orr92scgbenTCUHU
         0tltYYxG/NNnQNK7vc0kf91BFovN7bGvflKGfyyQEnWZeM2L8zI9KFp6YFNk8nVeq8
         oWRqusi9FcTRaf30LEo4IW17FoXk+VbKTMy8j69nNnfFH5+ZXhnKt/aRJGdsr27udM
         CiDxWEv+B2AtBVpLNwMUh9pNMy5dRSv8xkm8DHwA2jVqsa4H0gsFFfjgc+4d8oGr9s
         c/N9AwxptHQ3A==
Date:   Mon, 24 Jan 2022 07:45:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error fetching the arm-soc-fixes tree
Message-ID: <20220124074531.39c35687@canb.auug.org.au>
In-Reply-To: <20220112074147.7d38bc43@canb.auug.org.au>
References: <20220112074147.7d38bc43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nby96u_7VQxZnht3+TUDGaf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nby96u_7VQxZnht3+TUDGaf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 12 Jan 2022 07:41:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> Fetching the arm-soc-fixes tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git#arm/fixes)
> produces this error:
>=20
> fatal: couldn't find remote ref refs/heads/arm/fixes

ping?
--=20
Cheers,
Stephen Rothwell

--Sig_/Nby96u_7VQxZnht3+TUDGaf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHtvmsACgkQAVBC80lX
0Gz2+wgAlGbgbG0rhQahC28niyES/OSLEHrhzW0T7p0G/VE+Qssm0WXn4N79TaAd
43WhouVFGxrrMw2YNN0S8ugjEoEy1OMKZkd+Jd9hpJLc+BFb0pPQwlZhesNv5h5D
MBMmpOAZ+P6xejlhSFtQp6w6ehnND2codI2biJzs/U2LQSlFO9YNNi/HNMcHGVF8
RK+y6DcRbQdB281lDOAFSUrB6EBbvnCoqVcprwowg7BGj6iYG7tL72aMVT6F/1V8
1mQHQfhS5mXn8Tq7NR9AoZNg6NGl3MyLLOKRa+iVwYxCmqIRSco2dCZuD4vXCC4S
/OfyAyjdS8wh2h0LTvtcg7eJObNQCA==
=gOXx
-----END PGP SIGNATURE-----

--Sig_/Nby96u_7VQxZnht3+TUDGaf--
