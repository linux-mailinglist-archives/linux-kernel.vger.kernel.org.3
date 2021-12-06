Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761AE46918D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhLFIeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:34:24 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:40363 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239422AbhLFIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:34:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J6xTR3Hyrz4xgY;
        Mon,  6 Dec 2021 19:30:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638779451;
        bh=GQQEZgQkyb1HIPHJ1FiAYjERN4arHO6oXJ+tEPDQ5v0=;
        h=Date:From:To:Cc:Subject:From;
        b=RfbmScdnhbnubm+MhS287auOOr7GIhsUeVBIjq783JFngIzDP3+H9FNboeTyClm5R
         Wp9E71pPix/2KS3SXWUUoOIA8im1SOXYIVXNfa69E/XSWBaJNVMmUr7Mz98zwEHKze
         6BKwqeFoilJbzlZ12HlHHFN84kpkGV4Sj/toSQ6VFXFKRIguEypxVg5xLLzZZUSHOI
         G2L3RRvl0LkiFFFGUynN6ZaV+FJPcjSAE9FaCIYHQje+emPKlN4bD8SdV/PZp4A8nn
         hV7sda4UkPcJocW46HsZCbTPmki39ECc+M2rKXXuPXTb0qFyGTDPpmBuWC5YxUsj39
         v8oap3EodOlfw==
Date:   Mon, 6 Dec 2021 19:30:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the driver-core tree
Message-ID: <20211206193050.17ad78aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Rl0EKpYksTrl.yDU+j2TB=c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Rl0EKpYksTrl.yDU+j2TB=c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/cputopology.rst:49: WARNING: Block quote ends wit=
hout a blank line; unexpected unindent.

Introduced by commit

  f1045056c726 ("topology/sysfs: rework book and drawer topology ifdefery")

--=20
Cheers,
Stephen Rothwell

--Sig_/Rl0EKpYksTrl.yDU+j2TB=c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGtyjoACgkQAVBC80lX
0Gw2Zwf/WUoFllcjx1799MzQdpBbGfAIeY2G7bank78EPR3Fnovt5z+4TfQDoS1n
K+xztGwD1sRVWm6JoprebQGgDaRegUiIItWn9/u5D1mYuvIJCpQbbJljtRtcklg7
4m5ZU1OSqthCItBkR32c7EG4njngTbAh14pbR+IwAANmNPNNmX+bUqPnh3l75bOW
Uda7+xOP5dySR4UuvlQOq8y5X0xF/3Uq3YJQlzCtJG7CKbC+TPPtRW66pQFvYo5a
sdpR/PSSiJvmRGs1BD1yFv5OcwFSnqMmQMHOGkm4BFb64xjlm6RnfXS0NptB0x9F
4x5Th0Vi75/jV06smscCrA0ZkptG/A==
=Pgjj
-----END PGP SIGNATURE-----

--Sig_/Rl0EKpYksTrl.yDU+j2TB=c--
