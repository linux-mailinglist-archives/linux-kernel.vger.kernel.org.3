Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70EA468D82
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 22:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbhLEWAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhLEWAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:00:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546AFC061714;
        Sun,  5 Dec 2021 13:56:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J6gPt64b0z4xgY;
        Mon,  6 Dec 2021 08:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638741411;
        bh=vNSoC4TnagwVZgyyg3N+IOkNZVLWyrUR517QIhyGaX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IpzNW/GfJLyDwW2hITQZtGr+kKaFoglozSU2e/cfzuHSA3Q8yfwtpQBeH7bdJOdYA
         ClEJUUtsVMTMrkkAyWpqo2SYtd1QDvTNZDMiwqXQEq3yqxETIrqibfo/2FvGksj0wc
         RdbWj+x0DcH6LnPLDbnz56aG9yvy2nDNbMNlqIUOdPoKI7XfumijePl/LxvsG2Uy9d
         bsOqeekES2T7qrXPWYlAAGmcroEY3PFZ5S7t/7ykSRBeHFMImCHDlzkdQk94tFvfE5
         e0glcggjb/lB9zGmwKyji4cmJZu6G/RDM+6MZaoCO+ISGyLK4zl5S5NLrtSJ1edQOG
         n9uUeFT5kHQyA==
Date:   Mon, 6 Dec 2021 08:56:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: linux-next: manual merge of the cifs tree with the fscache tree
Message-ID: <20211206085650.09dcb11e@canb.auug.org.au>
In-Reply-To: <20211203094139.059541cd@canb.auug.org.au>
References: <20211203094139.059541cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fras5=MuidKBp2oz2fvryqG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fras5=MuidKBp2oz2fvryqG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 3 Dec 2021 09:41:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi all,
>=20
> Today's linux-next merge of the cifs tree got conflicts in:
>=20
>   fs/cifs/connect.c
>   fs/cifs/fscache.c
>=20
> between commit:
>=20
>   935b45107a80 ("cifs: Support fscache indexing rewrite (untested)")
>=20
> from the fscache tree and commits:
>=20
>   9d0245fc6a2e ("cifs: wait for tcon resource_id before getting fscache s=
uper")
>   c148f8eb032f ("cifs: add server conn_id to fscache client cookie")
>   b1f962ba272b ("cifs: avoid use of dstaddr as key for fscache client coo=
kie")
>=20
> from the cifs tree.
>=20
> I fixed it up (I just used the former versions) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

These are now conflict between the fscache tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/fras5=MuidKBp2oz2fvryqG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGtNaIACgkQAVBC80lX
0GyvfAf+OaKQPepClKNIFWpCtDI1s7xYxOA9GQtTYwFwkwL8pFlueE0SnA1xld4Z
hRcuSd8hfJhoQSekHWjlqRtTC3r9T5d6XifnAQWIpX35ic8fUPU0ddmE9pxZ7w1y
k33zZ34TbIPgz/jZ3a1p8tEXQiWOj/i/QA98Hs8NkkRcE2bI7SfLjoppZgBNFQ1E
GtlU8kvB6tkC0LNRIqVpEoUW0n1HVoNMqpM/t68IDlJN2J0befOpAWk5gfQhFumd
DcduIagMObqFsMr877Sa1t5LQdjXckuU9fSrqpNSdHkBum3gLj+RGzJdUOGppm63
u7ERS/opi/KAhHBOKECJCs0ER35qaQ==
=iFhg
-----END PGP SIGNATURE-----

--Sig_/fras5=MuidKBp2oz2fvryqG--
