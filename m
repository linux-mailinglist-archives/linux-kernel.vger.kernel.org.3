Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2CE4911B8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiAQWaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiAQWao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:30:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBE9C061574;
        Mon, 17 Jan 2022 14:30:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jd6756MYFz4y3q;
        Tue, 18 Jan 2022 09:30:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642458642;
        bh=S/vRHnr813JVAuZLgX3lfRw7+YkXFFaRXlxnMiBOuxg=;
        h=Date:From:To:Cc:Subject:From;
        b=Lz7qo8VovCNS5QA0Uwm7QFlaFA7yJsSRnm8jUvXC1KgjUzKQmARbgWFcjSKV6bvQl
         Ku1Ro3chQqKq4ZXBh87dfMq5ewpRZLmUevQK0GPUEo8oFQ/IvRdndyQMPUfEc+jf8g
         o8ZnFGEAHE3iYTynyjS4voLO/VF3w0zCaZ/TKhRLNMkmoSwpzrgtNLQJNnD22bwVTo
         O4l7u0YLJRJDiIvlc/6ZJTcFVGHytnzWwC7iEXfWCdNPTRfeNdHsPbT9fhcO/+WiyX
         14A7a0YaXFo77h+lvFJTlW0N7i780DSiUIndIycsTCiR2akjZzPtT27jNq8gmrViat
         D8uKZmHz/xWBw==
Date:   Tue, 18 Jan 2022 09:30:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20220118093041.7d964a13@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qiycWsTUvJ/nKIuquKX8fev";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qiycWsTUvJ/nKIuquKX8fev
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xfs tree got a conflict in:

  fs/xfs/xfs_ioctl.c

between commit:

  983d8e60f508 ("xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP just l=
ike fallocate")

from Linus' tree and commit:

  4d1b97f9ce7c ("xfs: kill the XFS_IOC_{ALLOC,FREE}SP* ioctls")

from the xfs tree.

I fixed it up (the latter removed the code modified by the former, so I
did that) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/qiycWsTUvJ/nKIuquKX8fev
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHl7hEACgkQAVBC80lX
0GziMQgAnbFf6fxZhkFBqTytHndz1NVTZ2aG2gVMMBPORWgwLM6x37m4odw4hhsu
M4vSRkX11ZctaGELZ3FZjLNEGlskTZ15C7TJ2ITTZ2hh/+g1R+rPii/60LGGfcS8
WVMQxLER1bl01OfkJndqW2e6Mi+3Wokzlxuz/9A2MiZBCcKEMIsT0DrbjxnTrVaD
M0FthzAvoKZ42gwHD0yJmZe8FtqbQ0pnMSVcUpg2RX1QMZ5pDG74INN6djLb1YRw
jQNu3VtOVNLiWidAvdxWs1EbHQTbh3YPMyHF1ON0OIo/ukrCas3coX9tHXN3K5VR
JJSN7da8lW8MyMnpvOt9a+lWIcTqiw==
=g3xX
-----END PGP SIGNATURE-----

--Sig_/qiycWsTUvJ/nKIuquKX8fev--
