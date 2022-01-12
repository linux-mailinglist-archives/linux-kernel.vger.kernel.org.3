Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F41848BE85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 07:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350967AbiALGRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 01:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348303AbiALGRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:17:02 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6D6C06173F;
        Tue, 11 Jan 2022 22:17:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JYclv6r89z4xtf;
        Wed, 12 Jan 2022 17:16:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641968220;
        bh=yFi+3KXhMq7UG+Oe03QV8m3EOvDsRHxHoOi6GM6dX30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V14is3/hiYMJkQeGu/t+nG5lJGMIZHG2KO4CwoVvIjs3T2/cRc1D2wha8ilUmu36n
         gNnxQudDtE8BsR7VlM4adDXeWA5ZyFVkawjY3fvav+LRUyuBuUsrCKOuaDRB0OlDH4
         oYRYVlIG1fAma6h4cUhbO85/H2ivveUkIuU5qNAm2hXYv5nvJxgiRcO163D3zVcbed
         T7Y1VeAC9xrUyYuUntw+h/O50cvWHglW2pVxIASZMwl6dfn/XglBZkMn2ELQ/1s/Ld
         X43tXPP6ajT9dtTpSxcwDJOOvQH2GypCLPWcXiqMXMTrjeMAwhNXf4hLMZqnetbF24
         W02kgYej+uv9A==
Date:   Wed, 12 Jan 2022 17:16:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kajoljain <kjain@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20220112171659.531d22ce@canb.auug.org.au>
In-Reply-To: <Yd3+M+efH6bTEpP9@kernel.org>
References: <20220106091921.3fa617bc@canb.auug.org.au>
        <6623bc13-d99c-74c1-29c8-b4ae7a570d99@linux.ibm.com>
        <20220112084553.2aa71f08@canb.auug.org.au>
        <Yd3+M+efH6bTEpP9@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T3JOs1KmPuGJiVn25L_X9u1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T3JOs1KmPuGJiVn25L_X9u1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Tue, 11 Jan 2022 19:01:23 -0300 Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>
> Yeah, this patch shouldn't have been merged thru the perf _tools_ tree,
> my bad, it should have gone thru Michael PPC kernel tree.
>=20
> It was a single series mixing up tools/ with kernel bits, I thought I
> had picked just the tools part but made a mistake.
>=20
> This should get resolved when the rest of the kernel bits go via
> Michael's powerpc tree, right?

I just re merged the perf tree on top of the reste of linux-next and it
builds fine.  So I guess you need to wait until after the powerpc tree
has been merged before sending your pull request (or revert the
offending commit(s)).

--=20
Cheers,
Stephen Rothwell

--Sig_/T3JOs1KmPuGJiVn25L_X9u1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHeclsACgkQAVBC80lX
0GzXkQf1EdG0TaroyZNyzbSgam1A7k8ERp13NZSY5Alpr06WhD+0kyAMXTIDEhXx
Hgl4Eep5tLg9AWv9rpgF3vHqQZGCuQ1kRBJfY1viNaXzq+p0T1Q+Elne3uvaF6+g
BiURYXeYViW6zWPk4QvKIwBZIH6zCdqummAtH059rOnr4yoqOnqq4NVeo1rG1l1D
ybO7ZNNoxn5TVh7ieSMO+cQCJ4YOOZM5zobKzQUODWg9Gl9245S/Xj0/qNEpKXRs
LmuXBuFEuWx1jydc6Do3NhP+koEbIpmWhMvNkr5lOz+ia87ynIEpUzhv93YGMkv1
M2J9CtfJGdH9xSDT+HjxDXl+fRrS
=cVRW
-----END PGP SIGNATURE-----

--Sig_/T3JOs1KmPuGJiVn25L_X9u1--
