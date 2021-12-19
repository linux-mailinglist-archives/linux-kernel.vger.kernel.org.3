Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA647A23B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhLSVOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhLSVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:14:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB344C061574;
        Sun, 19 Dec 2021 13:14:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHFpY4szPz4xQs;
        Mon, 20 Dec 2021 08:14:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639948470;
        bh=r8KMglx+mt9pY6AphFbd2XBqKx9sh635jVDAqyMQi18=;
        h=Date:From:To:Cc:Subject:From;
        b=EMHqLRHnNq0PGOKmw/m3buIKEGr/9yeYPL6GfHCzJ/H3HiK+np0AjkwFwjILry5vf
         QXdPaJ0HydAJUht4PUkr/KFvs8RuOdCMn+WA/q3ESnr4oQNImchNJk+uLxBLGL3DvF
         ZSwCXSB3VieuIBPoEZiEVPa3I7X7EyRVjQQuanKvetk3FLdZ4Kg2lZVV4o4myuQcA+
         yfdnMNMXkzbi1o8w9wjDhVtZRiCOf8F4qZA/1VLTKlJNTR/lylPOjD0jFHS4uYFJF9
         w6/yMAdsRcBuom90pSMnjyHnlQpK3+uNJRbnc5tAhDk932Rft4nFwDMrWHdjan/X9y
         E+870iRafsoDQ==
Date:   Mon, 20 Dec 2021 08:14:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20211220081428.7184c271@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lfxBHGztvBGhz0fduGzys_Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lfxBHGztvBGhz0fduGzys_Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  aa1701e20a84 ("x86/pkey: Fix undefined behaviour with PKRU_WD_BIT")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/lfxBHGztvBGhz0fduGzys_Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG/oLQACgkQAVBC80lX
0Gx1ogf9EfdO11z5AdU6IYQADwcM0Cs0+xNQPVu2AcQJ+HVHA4ZGGxeEa1YYAbro
GCMbva9yEm9F5jAv0fB8VMDaBroknNkNMsED5B6bkzbSyCsxFuJBKuurxgVEtSu8
9vuLVJZqrWK8hqc5fJ9dGzFFamKEmG6nFd9TLGD/rHhiGmUSYJi3Bez7V5GGA2ct
5tqZ5pgYa8MkD4jKF85whbSMpIn7S2fRXSxmAlZJxO0hqXaH5JhgS4ereboO5Tbb
IlzI31jRmcWh29GQ9EmIoIKwAXGSKRoRsc5S4sEyrvR8YBc1kQcGSdU4FC1+GI4Z
pSLqSsW9g52E/0TtFkZWn7vX2meqYw==
=zg2u
-----END PGP SIGNATURE-----

--Sig_/lfxBHGztvBGhz0fduGzys_Z--
