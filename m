Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15EB4A3C56
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357212AbiAaAlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:41:07 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:52193 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiAaAlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:41:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jn8PX3zkHz4xQp;
        Mon, 31 Jan 2022 11:41:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643589664;
        bh=Yxo7k2w/X6yIbGMhJDGzoffxUsGOJUMwuc3MHzhuyQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZFPExoGJvGU7EOuwu1+r7IuCkK33n4LRZbP+L6uZevLu83iB4tForr9MYsFC24A9D
         9IqkWOnBxoIbZRKGn4GqWmSSeJpG0Q329GJCAVwqHRPQTZxpjsajImdQJBZpBIDIjB
         Dg9SGUV5tKl5na4CAEtxwub3XxteIGa3qzUPE9Fw7T+1oudIPw+4IrH5Gzic3Og4nb
         5YFNtGWxIryCz+1OMkW/6c51z0MdFFeCkh254jSN8oHt4oRb3V8MyHM8gbtj1MiM6O
         Uf6HTQXISyKA9T9T5y775vR3QcHWTtobOGKCF/sBLfb4ja4fe/n/NXcqPWNOjDhrX3
         eWh2LK5Wd5Abg==
Date:   Mon, 31 Jan 2022 11:41:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Shijith Thotton <sthotton@marvell.com>,
        Srujana Challa <schalla@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20220131114103.5baca549@canb.auug.org.au>
In-Reply-To: <YfcrMYJOK17xW04s@gondor.apana.org.au>
References: <20220131093406.4200546c@canb.auug.org.au>
        <YfceGSj+h+Iir0nU@gondor.apana.org.au>
        <20220131111111.36510e25@elm.ozlabs.ibm.com>
        <YfcrMYJOK17xW04s@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_78QDTRES5MefhmkjJG3kew";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_78QDTRES5MefhmkjJG3kew
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Mon, 31 Jan 2022 11:20:01 +1100 Herbert Xu <herbert@gondor.apana.org.au>=
 wrote:
>
> On Mon, Jan 31, 2022 at 11:15:31AM +1100, Stephen Rothwell wrote:
> >
> > Are you intending to send that to Linus soon (as it fixes a commit that
> > was merged in v5.17-rc1)?  I would have expected to see it in the
> > crypto-current tree
> > (git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git#m=
aster)
> > in which case it would have been merged before the kspp tree. =20
>=20
> You're right Stephen.  I will push this to the crypto tree.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/_78QDTRES5MefhmkjJG3kew
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH3MB8ACgkQAVBC80lX
0GwgLggAjJvZqHJVm7+Y+KS4sjHODv9SzEuMa7JAruNe8K6xjKr3FdZ8nWXXLaRn
lIQsyJsZjUex7L539kokyru8XD7v8PRVN/Ng9QkJmJImm6sJCbkv0hMtq3xE0Bd1
y25ORPMdkEMD49enr8ct0Ze2uWGRmStRx6x4dwFYdJ2z/BR7dZEAURgEAwPB4VKR
Mjo81R9KYbfDv29Gwia9VSkg6kP6NPB7FGydwUdRpwZ6m3N9SLnCRnCEEJmwpg0W
wb/D/jeLswOuuI8BULsKi38v1MSy1RYUtnqpqe3Xo6oY7kuaLJhrTn8Gx2x925ux
uCvnfoiuJJcwpjmwHT2eBK8I0DjVBg==
=6eV9
-----END PGP SIGNATURE-----

--Sig_/_78QDTRES5MefhmkjJG3kew--
