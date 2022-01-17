Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895A549118C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbiAQWCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:02:48 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:58595 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiAQWCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:02:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jd5Vn3pPGz4y3V;
        Tue, 18 Jan 2022 09:02:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642456961;
        bh=1eoYy/BOqilAQSyAUyNLW4IuNDEj1AkUsUlzcywZheI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XvKZuyRvp8gXYxj7t2XtT2VDFz0fZz2DAnQvnMFr1cnPRDeo2WxjvATwZ4SuxMtCD
         AsoGlmxD8NKO9WJcRuNCV4t/n6UhSGBtU8DClNfWNatD0bkkS+teE8PrRgWQQc3qu0
         kyEn22BTyFUfSc+DbmohXXx7LHfMefkjYyGwVNKtsWFw7QNMOOLCNMhmxRBxjaDzfY
         V+c/ZiDv7+gEItjFJEuywJ+C8gaaDwffk0MI204p235XeTzAQODSBNkrCHmO6gvSZ+
         WA9CItg/2i/znsVshYI/tuqyUOtrXFytDzQ5wEhp/WCUB+mlpMrzV8uV/t3q5GRkBD
         Nndj/wy1rv7Zg==
Date:   Tue, 18 Jan 2022 09:02:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the pm tree
Message-ID: <20220118090240.3429ff1f@canb.auug.org.au>
In-Reply-To: <20211013172846.55fb665a@canb.auug.org.au>
References: <20211013172846.55fb665a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JgqXXKnVfTU/CDXcSze3hs_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JgqXXKnVfTU/CDXcSze3hs_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 13 Oct 2021 17:28:46 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the pm tree, today's linux-next build (htmldocs) produced
> this warning:
>=20
> Documentation/ABI/testing/sysfs-class-thermal:201: WARNING: Bullet list e=
nds without a blank line; unexpected unindent.
>=20
> Introduced by commit
>=20
>   80da1b508f29 ("thermal: Move ABI documentation to Documentation/ABI")

I am still seeing this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/JgqXXKnVfTU/CDXcSze3hs_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHl54AACgkQAVBC80lX
0Gy2DwgAnWY9NHbKO9/YyqCCE96fR79uRYIoVycl5CU7D26phUcANbMTuNn7ytYM
9SaMiji/SOuFFaHcr9q5me7A+m7uNt/spQ3v8l1dg96F/YwaTCXYoisb00QZCCcD
Gcw95EIvhhYo1N4pqPTW8LFeh+odFUALvRhbyKTgU+2c+v56MR3dO33oU+EWM+YY
WG5h7wQoBtMv/imK4Cgn95YXjWYPyByPFEn8eC1g0/biS7LVdqQaVoLOqKour3ps
Bi1PjXLcKT1dnckArcjQXMTzUzIYhHzi0+Vq64TqUqcwuMq5ztvZwdGi4FyCu32K
UJQVnowUNp9fohhnv/0ah1q1CXN0NA==
=1f2h
-----END PGP SIGNATURE-----

--Sig_/JgqXXKnVfTU/CDXcSze3hs_--
