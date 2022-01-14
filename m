Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13F348E2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239051AbiANDeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiANDeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:34:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84C1C061574;
        Thu, 13 Jan 2022 19:34:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZn3H1gpZz4xdl;
        Fri, 14 Jan 2022 14:34:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642131260;
        bh=Kgt+PfbwXmd/qoKyV7DiSFUfTl2IPCilmQpW/orj660=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aS+Kv5lAI+0kfGhZB5XulyL+h0dw2JsJyuilkKQ2PpEnhyfm14OhZVacfgCDjZ6bA
         CeLOiRu7o1LjF5YzmqPxcWf6dmMKePRrsbavIUPymqrJS+mJkcJPzJ25RN437IIlao
         6QNrEmNuAwLNH8Mk51ACyTqMrzNhGZWiD/yav36WGJ6zfM1nBM/NgRaxlc0DwoCJvy
         xRP8dvOY3kJeyVX/pEuNI3nhjQySfryu7wLx9nDY9uZw1jX92XCkYb+pqVM9tkXo/2
         5vEg87dHolJh/1B+dpZVMptcyZDPqIe4oo+iHpt8sPQJce2CdkSajgMicwxPdI/B9+
         kLldwAGYIMBOQ==
Date:   Fri, 14 Jan 2022 14:34:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20220114143418.06035a75@canb.auug.org.au>
In-Reply-To: <20220113222539.30202e01@rorschach.local.home>
References: <20220112113103.7e03448f@canb.auug.org.au>
        <20220114120240.4b592480@canb.auug.org.au>
        <20220113211633.4f9bea57@gandalf.local.home>
        <20220114135808.391398d0@canb.auug.org.au>
        <20220114140258.2fe2f076@canb.auug.org.au>
        <20220113222539.30202e01@rorschach.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DPs5q=uxPKLhyg+f6KK82bW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DPs5q=uxPKLhyg+f6KK82bW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Thu, 13 Jan 2022 22:25:39 -0500 Steven Rostedt <rostedt@goodmis.org> wro=
te:
>
> I can't reproduce it, and doing searches on this error, seems that it
> happens "randomly". I haven't found what can cause it yet.

rats :-(

> I don't have a way to build nativly, but if you send me your config, I
> can still try to cross compile it to see if it triggers.

I just use ppc64_defconfig (which may vary depending on what is merged
into my tree at the time).  I don't save actual .config files, sorry.

So:

$ make ARCH=3Dpowerpc ppc64_defconfig

> Does it fail on anything else?

This is the first build I do after merging each tree, so I don't know
about others.  I may be able to do some testing later today (after
linux-next is released).

--=20
Cheers,
Stephen Rothwell

--Sig_/DPs5q=uxPKLhyg+f6KK82bW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHg7zoACgkQAVBC80lX
0GzfQwgAjo5sETykoN0JaY1ImM9BNYSNoMffU4qxAUqSXu2e8ViiwMh81GKM13OO
VNRijaHnJXEk8j/Sm/CLsdgU0iaiyK9asRWvjbI3OUCzASann+Bkuc7WwTckb794
PntHfiO5OZgi+dLAusz7NWIG9Umkri2USlUPD2ajUWEv/p0TSE9J+Y0hKa8K5NyC
hcLn0tl+Fb42BXQiP8UEs/s5ArCDtAKUBCJDihbnKf9MUzQl95iIV6y0Y70d2n5P
bo9F5qyGB0cWlGZYBXz7AJa2dOKcF1bC025Idp2BWj3GmAb3RkCZzdjhAugIAWNg
eT6LDYDv72Js3Oiux36jZx7viQlE/w==
=vpzv
-----END PGP SIGNATURE-----

--Sig_/DPs5q=uxPKLhyg+f6KK82bW--
