Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84DB466D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377343AbhLBWpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377554AbhLBWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:45:06 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB661C06174A;
        Thu,  2 Dec 2021 14:41:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4rY11VwZz4xbC;
        Fri,  3 Dec 2021 09:41:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638484901;
        bh=iKoJ3e7Vln4wWSOXTdmE1OutZTVWQ38ma1K80CvNKN0=;
        h=Date:From:To:Cc:Subject:From;
        b=Vp/vMIr+Y7hvh08OQks8A7zCkz0uuEKVTEdqdw0Eh2iF41Y1nmYo2hljwUs/XAh8D
         70KIheflsJqlkbiUTaOopPhThUPOV88U5M2hIlVhUf7dAu3eXzJCDvCHUP1xDiX6Mw
         SAm84yaSM8+nf0480k4V1wJ3Q4Z5+LM79oMreybxV4Jsd2ffO7QkI7uTOwlS12jp4r
         j8Ts/NoAT5J5+npRc4ETCCsb21dfdfVthFQN1upKCqcyM4gnrOCUAGxtHY+DtEFP84
         L37tEaj97AzEMRLtrZOREXhlj0SBPrnBtjTK2xuNgU6wqTcZhXJLDrUCnLri57CbqM
         eEp7OlG8YnSiA==
Date:   Fri, 3 Dec 2021 09:41:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the cifs tree with the fscache tree
Message-ID: <20211203094139.059541cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/K_eCIX1EeiRLUj2YMHc5lM+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K_eCIX1EeiRLUj2YMHc5lM+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cifs tree got conflicts in:

  fs/cifs/connect.c
  fs/cifs/fscache.c

between commit:

  935b45107a80 ("cifs: Support fscache indexing rewrite (untested)")

from the fscache tree and commits:

  9d0245fc6a2e ("cifs: wait for tcon resource_id before getting fscache sup=
er")
  c148f8eb032f ("cifs: add server conn_id to fscache client cookie")
  b1f962ba272b ("cifs: avoid use of dstaddr as key for fscache client cooki=
e")

from the cifs tree.

I fixed it up (I just used the former versions) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/K_eCIX1EeiRLUj2YMHc5lM+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGpS6MACgkQAVBC80lX
0Gzzywf/S1ePVXdZnC0QO6fcU/w/irn0NN9Piu2lnsURSO7eLH0/ZFhv+6m2XmaW
NLBSoh5NjVZUPgwsOXKugOEkVBGh7OQFlnw5lbclr+EViD4na1d7ckqbPLjBbAEo
gmbeNWaQSe3Kx3igLNBL9AcTyGv5l59DkTcfSwA13nzNkSGIWQ0E1LQMVIjnMwTe
X5JylpmVpEU/T3WZGMyVY2cNSolCdJdQi25aniCvIWDdLGY7ZOu4kbXzaujrv3pE
HKnxcGXc1GMt7XOskaHqPtfWBd0GcENVyExVyFsLR5OY4pwtCTF5cURrTW6aIgNm
/VKa/9X9mAe1PpHhHftRC+qM5vkkjA==
=4SXJ
-----END PGP SIGNATURE-----

--Sig_/K_eCIX1EeiRLUj2YMHc5lM+--
