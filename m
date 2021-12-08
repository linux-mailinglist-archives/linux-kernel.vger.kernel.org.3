Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC80A46CB91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 04:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbhLHDfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 22:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbhLHDfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 22:35:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822EAC061574;
        Tue,  7 Dec 2021 19:32:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J82lp2rSJz4xhB;
        Wed,  8 Dec 2021 14:32:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638934326;
        bh=pgXm+oBmNIdfXfVaf/1BLCJgW3c/bK7txdMwL5L0+kI=;
        h=Date:From:To:Cc:Subject:From;
        b=CPAT5RfRasdsm+z3ryt4KraRxFxLyyAroDbMWzZ25GnO0rYClzQL19k9FzgF35iwZ
         T6OHJLn7OUTbul48bN62upcEh70WyqJmcCEdUZGgq4dGN7ijb48XJjpv2v2YopFyhF
         HsqXmGWFgAv4zEXBauQgExmr7QIuo0E+NNprtzDqvUGSSoRMJKYGw0spqf2UyGophT
         nzZ7vCd4KbvkJHoEAv+zPMUZpQTfB5oNUPZeh+xY3XCuzHrqlEFHISLnEfJzouCq9c
         jUEnHDcIBNy2jEbcrPPaOMxXhRb9N2vnNeLF++SeVNzNA1/S5axlBfYkbFzWTyJSP6
         PMHstp8HPZ00Q==
Date:   Wed, 8 Dec 2021 14:32:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20211208143203.76fce709@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OSejKm0VSPV+HK_LdnzWhoY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OSejKm0VSPV+HK_LdnzWhoY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/ufs/ufshcd.c

between commit:

  3ff1f6b6ba6f ("scsi: ufs: core: Improve SCSI abort handling")

from Linus' tree and commit:

  1fbaa02dfd05 ("scsi: ufs: Improve SCSI abort handling further")

from the scsi-mkp tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/OSejKm0VSPV+HK_LdnzWhoY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGwJzMACgkQAVBC80lX
0GwjUAf+JHee72DHqHj47MyocZOToUKcqqBk+nPV+q9agbt+EvNtBKhH9n1uBdkQ
yEy0XEfMEutWNUCDj6n1h3C0lriJcRFOWfom1mPutd5cDWML3f+QBBFMkiqeKbEW
qXE9O/sqDqTU9VWZbLKxtRFUgXh9xCbhdeZ7L9sqqSzThsnDb+KzjoYmsa0ouNLJ
LrsRmFCMNF1DdREOVjHMAAOPAhPOf3GcAlP8Cvpj7PAx6IZd8Z/S0sOIz9uinuzc
aG0f8OT28MGU+OQJJh/mj7qGGh40H5hV+cvcFMC/smEMvWsWZ3rg5IGBtrNWe/3l
sffCs3LyU6H+2ql6qlk3rKay0G10Zw==
=EmAp
-----END PGP SIGNATURE-----

--Sig_/OSejKm0VSPV+HK_LdnzWhoY--
