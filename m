Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B94C48E2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbiANC6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:58:14 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:44555 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiANC6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:58:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZmFZ0K0Nz4xcF;
        Fri, 14 Jan 2022 13:58:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642129091;
        bh=ExvOuVJGS7SgM9h2o/gDiugRq364buQ/K5sn89L0MNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L272IB73XEzsk5tJa2uly9rIR0tWGXyQagZHDLMzsPfKC2So21LPhINFOIPzc1i1T
         GzQmZt/mdrjZ3YnCy0CE3OLzExLlVWqvrvCODAEIHxbxeOyNaqoQHVnc6mWVDVKpk5
         P9LmJTL4o4xZLZGnb6/pHPFLIPO2aLHIB74Ufrnljt2rhaRTl0gjYSt+2IK4jD6l+3
         mFTR1pKr6c6iEOaKTkrvFx1gF+0UN4NLXq9VixG43T7+/HBrQhSQcH/Ny3RrviHP0m
         /17Uz23Y5OONiLkjhNDZa9rKNCU+X8sEblJ3e0SRGYd4JlJUIpGovoIWT9lAqF+R6t
         i9wi+6L264WKg==
Date:   Fri, 14 Jan 2022 13:58:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20220114135808.391398d0@canb.auug.org.au>
In-Reply-To: <20220113211633.4f9bea57@gandalf.local.home>
References: <20220112113103.7e03448f@canb.auug.org.au>
        <20220114120240.4b592480@canb.auug.org.au>
        <20220113211633.4f9bea57@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0qQ6vIRey.hJvnjFo9e4aD0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0qQ6vIRey.hJvnjFo9e4aD0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Thu, 13 Jan 2022 21:16:33 -0500 Steven Rostedt <rostedt@goodmis.org> wro=
te:
>
> What compiler are you using, because I built my branch against all archs
> and it didn't have an issue.

gcc (Debian 10.3.0-11) 10.3.0
GNU ld (GNU Binutils for Debian) 2.37

I am doing a native build on ppc64le.

> I can try to see if it is with linux-next and something my tree has with
> other updates.

Thanks.  There are some changes in the kbuild tree that may interact, I
guess.

--=20
Cheers,
Stephen Rothwell

--Sig_/0qQ6vIRey.hJvnjFo9e4aD0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHg5sAACgkQAVBC80lX
0GwujQf/YC0DvIpmXwrEdDqoXvQvs+8QsEzlVFOslrCGcwfBFUsPWjiL6Ac/HldX
L1JM75UuDg7D0sBdDoA+Q/ITDbfzy7gqINL6boS/cTy4aNpP0i7IEKoeykjGgCGH
SXruLJV7wiqzn5KHlSu0QUd3oFxLFyxDweRNUJArzB1koveDKvlifRUGu7wsPDXq
NiE+W5uSPebAIfSGkTJfDhEOjtpP3H0e76pFyYLlsGn8mE4W5s0VG7fjC9M5iNbP
65xyxOgaFHWFJXdG7OnBFWg8IhpfDHmfH/yaRaOCLgSDfz1BfIqC2L1GMRuw2Uuy
v9RavS/ERu9xogN86LAON6aO9WrJQg==
=sNXI
-----END PGP SIGNATURE-----

--Sig_/0qQ6vIRey.hJvnjFo9e4aD0--
