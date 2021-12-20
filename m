Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A470747A8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhLTLqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:46:50 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:41369 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhLTLqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:46:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHd934q3Nz4xPw;
        Mon, 20 Dec 2021 22:46:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640000807;
        bh=qNFnj0bq7onqHsEqGBwKE5fOmLU6n9O5bEhW7zKupxQ=;
        h=Date:From:To:Cc:Subject:From;
        b=kQyMHlzViTJDWhfkXkf43ZpC7lDjDhOPR0wRAQmrHGy1OVD3oVgGz0C/Tiu0ffx/n
         z0komZdRDFyfpYgGPVuNUaq1CZ8+5tciOVVFQvUJoBMK0CoPWbAXUxxH4tENrkGOTC
         iGKOpzgDAXjhAI1OTwuLKOG7kE3QbgIyOkiRsjETHhOPm/k1OkaH49KC/BqRkZbYcA
         N1/f1lb7lDGefjj+VlgJbvSvKt/sZhKbbmqTlFX9Yxd5iHonRrpeFGivfPkH3gCC3M
         +ghf1RlYB5jHjs4s9EWkOxbugg8JEdH70P99kvkgwaAP6xvLxm6FB+zxDGEeVJadaz
         MW8NtfghwBM0A==
Date:   Mon, 20 Dec 2021 22:46:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the fscache tree
Message-ID: <20211220224646.30e8205c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ozWsX8JPnw=_A0+_HAlFkDO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ozWsX8JPnw=_A0+_HAlFkDO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fscache tree, today's linux-next build (htmldocs)
produced this warning:

include/linux/fscache.h:221: warning: Excess function parameter 'coherency_=
len' description in 'fscache_relinquish_volume'

Introduced by commit

  9a1e50028157 ("fscache: Implement volume registration")

--=20
Cheers,
Stephen Rothwell

--Sig_/ozWsX8JPnw=_A0+_HAlFkDO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHAbSYACgkQAVBC80lX
0Gz08wf9FxEV7pH7jxbrAIhHiiQnJL9QFzxzvM/DGfTSNQ6Hw1n2Jyl6fiA1NKSb
pw2p4odzaASikVe93Fz6q/khFxH8LgPiou9yfiYLvfGIO92sWKul1wQuCnPMA0K8
mwGWz2SipXWs2zxfixNU8I7tPi5jNX9JhMhY+gYWfeUTU8b38ULtDUJ59/RLenGV
HYPqf/ff3uDgucZhTkwTxnYSXkXSm3Gcv5kOcpJA8sIVmF7N7AtK8/o9bX3CMza4
lGLjtboTV1r2B2xLxDdFkhcf6YyFSxV12mD8p2/0WvfWIKsIvSmZwFrmUtJ7kE+L
sZwsYhDCQ2Uc0aAKYaL7e5saNyZwAg==
=ST1Z
-----END PGP SIGNATURE-----

--Sig_/ozWsX8JPnw=_A0+_HAlFkDO--
