Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4066547EBC7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 06:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351381AbhLXFdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 00:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbhLXFdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 00:33:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C091C061401;
        Thu, 23 Dec 2021 21:33:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JKwgs4nwwz4xR1;
        Fri, 24 Dec 2021 16:32:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640323978;
        bh=58WZofz/SUa9dqks/urIIsXcjYFI/D3LAvPglshBHak=;
        h=Date:From:To:Cc:Subject:From;
        b=nW5SKJyS2Jkmi2PsLR0P7wLiquF4hG01JkVg0NP+I9N6n/sqaRpcMl9TrFLxnwL87
         qLOjmj3hLt9uTCbNq0czQj8BT0CJuy7/RcXLkBf4SSra982aJo3DvNOan0uubucTB/
         MLmih+lyfC4eVA1RLI4GINDHDCKagwfxfeyp+0jHeBgKbL+7SYHDF+3wB3tTTsdPPc
         IhL63xiqKPiwBq3JwZQz/rZBX8Mdmpq9sNxn5Li6axNBFNKIXXs1Yr7dV0btiTtKuO
         G1p2M101eczLENEfngJY98eaEdoPEs1L5yURKmBBjj/s6zk1jun6IOcXbqqTzaS2s6
         MO7fThDWIYXdw==
Date:   Fri, 24 Dec 2021 16:32:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Harinder Singh <sharinder@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the kunit-next tree with the jc_docs
 tree
Message-ID: <20211224163256.2a0f01af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rq=Ie/Kk1awVI_Mw0eyZ99Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rq=Ie/Kk1awVI_Mw0eyZ99Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kunit-next tree got a conflict in:

  Documentation/dev-tools/kunit/index.rst

between commit:

  6c6213f4a29b ("Documentation: KUnit: Rewrite main page")

from the jc_docs tree and commit:

  58b391d74630 ("Documentation: kunit: remove claims that kunit is a mockin=
g framework")

from the kunit-next tree.

I fixed it up (I just used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/rq=Ie/Kk1awVI_Mw0eyZ99Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHFW4kACgkQAVBC80lX
0Gzj7Af+LTFnFFGi+l9ew3ly8ckP3MGw+PtW9dtkh2P/dcJRk2liXAKawL2j13Pg
xVjKT4UDB9fBAuYiGf37EO5VbgUIH6LjKj2qMcK312gJIejgp1VWsh2i46Pys625
nLAEOduzWmLCWFtLg98/jLu6mtfERSCUFvzURSjxGChdU0Ji8SWamq0/EzAT1d3r
siS9X4eUznTD5Z/AxtVFdJyEBNifOERuLeocBn+6if2aeC7FvNZj1E876emDRgpz
A5k0Di/nNwQbqwMhdFW9Rx4vw4Y/h1B1j3uqeEO8YpD6XuXoBI+6tP3y0gq593Oe
gqcEKQJl3ub9l12wNrjx7ZkBfXrsuA==
=F7iY
-----END PGP SIGNATURE-----

--Sig_/rq=Ie/Kk1awVI_Mw0eyZ99Q--
