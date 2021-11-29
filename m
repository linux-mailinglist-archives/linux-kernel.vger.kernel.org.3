Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB06462271
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhK2UuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:50:09 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:35405 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbhK2UsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:48:09 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J2y5Y6Lz2z4xQt;
        Tue, 30 Nov 2021 07:44:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638218690;
        bh=bFV44ZnzMYPy7FwEgQkBjPBxjIWh78N53LpypaKH1wQ=;
        h=Date:From:To:Cc:Subject:From;
        b=rnOUObs6LR0xySMlA5oOadM/Vea1rwGjXmPHnqdoOyqDZVqgbefl1FzcH9fyKVXXG
         hSyq/BMULxt7XA9fGYkE6+0XHe3QCIZ/zbVZFD8via6934JcZmDmQFShEJyFIHfdAU
         MOT45Fo2uGi63BX80R+KNFLCLx8n0OB/9tLnrFgAeUXFCRdjfnRTb2nKoqLJ7OGDcx
         wyJEyqw4u9f3eEczzayV2Cdg+D8oEevv9T3PWjouig6i8ibJ1s2wT181a81kWGEjiC
         9QXjQOkpX4C8htitUPUJY19/1jMoc2yeRbiPauFh2xsNV+You1ula8L+RR2hjPUAtf
         tzh3uu861CRHw==
Date:   Tue, 30 Nov 2021 07:44:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the fscache tree
Message-ID: <20211130074449.0ec314a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8QAJl04get1_jj2XnGTux4W";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8QAJl04get1_jj2XnGTux4W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f022918cb360 ("cachefiles: Add security derivation")

is missing a Signed-off-by from its author and committer.

It looks like the whole body of the commit message has gone missing?

--=20
Cheers,
Stephen Rothwell

--Sig_/8QAJl04get1_jj2XnGTux4W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGlO8EACgkQAVBC80lX
0GzOpQf+NqEqkE5cztuMil05/46ZqONbQg2a4m+4J2wKO0DTn8e1Vu60tWSSHZVV
Vm9H4P03wrzZ+vNXW034xVdRt1xsdWytsEJmtH2xldGQ5wv1EdgG9FDQbUyWZBOI
jzZM48+Aeo/oGf0PkgSjYAwj70XdQMDmG3Hs2dlqpG9n3aGRZ3O9gRL1WJwysnX0
HE2Vp4byeZx7D5KyVV+FeykgEKJa80whsizKGGC6xjZo9hon6lZHVQDLV1n4eSYW
OQICWT66jhF9BwBUddWaF11fRSstwmuLzGEhja9kLfzxolRiihqctXVfv2O6Obqs
3YnDM+oAOvkF9+XxB6onClg5LpncDw==
=po48
-----END PGP SIGNATURE-----

--Sig_/8QAJl04get1_jj2XnGTux4W--
