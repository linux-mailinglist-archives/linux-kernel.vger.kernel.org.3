Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4BA48E2C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiANDDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiANDDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:03:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AECC061574;
        Thu, 13 Jan 2022 19:03:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZmM70sTdz4y4h;
        Fri, 14 Jan 2022 14:02:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642129379;
        bh=j7/qsqEW50LRNv4aP7CPVk45/3LpOcH5cxTLImBZTq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B/E49f28lbulLqtmD6PZbjaIsVG23mLRQ+18DtP7cecZS+7iLQW4IDuTyPzDqzNWU
         13kUcQR3FNrt3AeFe7aAI5iDa3Sge5rZCUezwjM87JkOHEkBrHwWZuFlR/Q4Pv2RBE
         TFdMo8GmrmyhWPh70QLUWred82d2WOEgDLKp7jC3u6NbYJaIBMg4l3bmCKajIxDL/6
         88ZU+0RK6NI9vRHhISj82ELjbnKxVLof6p7nOhSHRUYTnYSGLGpbZau1bkVPT8jDGU
         24MvDjPNjEwtCEqhCVi09uIfxV8n0z0lPx5UIWJh9rhOsDXxZh16zBRHcY6nfvbBjH
         fGPvAbXaif1Og==
Date:   Fri, 14 Jan 2022 14:02:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20220114140258.2fe2f076@canb.auug.org.au>
In-Reply-To: <20220114135808.391398d0@canb.auug.org.au>
References: <20220112113103.7e03448f@canb.auug.org.au>
        <20220114120240.4b592480@canb.auug.org.au>
        <20220113211633.4f9bea57@gandalf.local.home>
        <20220114135808.391398d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hsP3AOLKPZS=WABsTokIw=H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hsP3AOLKPZS=WABsTokIw=H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Fri, 14 Jan 2022 13:58:08 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 13 Jan 2022 21:16:33 -0500 Steven Rostedt <rostedt@goodmis.org> w=
rote:
> >
> > What compiler are you using, because I built my branch against all archs
> > and it didn't have an issue. =20
>=20
> gcc (Debian 10.3.0-11) 10.3.0
> GNU ld (GNU Binutils for Debian) 2.37
>=20
> I am doing a native build on ppc64le.
>=20
> > I can try to see if it is with linux-next and something my tree has with
> > other updates. =20
>=20
> Thanks.  There are some changes in the kbuild tree that may interact, I
> guess.

It also presumably could depend on the actual kernel config being tested.

--=20
Cheers,
Stephen Rothwell

--Sig_/hsP3AOLKPZS=WABsTokIw=H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHg5+IACgkQAVBC80lX
0Gx7xwf8DVe3AHIN/GP4xRfCzOE8+2ECsJwopX1NjvIUCrKhzQGA2ZYkZ6y4t739
GMy82jMPFny3/Nhky2CDb9+lT7ixrf6EG3mQq2Ue7QWvyxfNyMqRMtx/iG/+BWHJ
zYuDpGUl+XnTrPvmUtB4OjuoUpbFmHUF6QIxmbTfpvaeZCv50u4yjyblSbRAT/Us
V63OUpY4cdNI/D1gbxZXq+Z3gnuwksTqx6nTefsaTDSuSP95nYfb7ACRfQIWl/Ix
lVP35W4dlpLyiZOURPhfunYTR8uXViYQRLOaQaMfdj5+8yxdA751bk8P3oLu6KHG
pNbXZaxS1naUF3VIlaBNIhTkhSZFmw==
=nGoO
-----END PGP SIGNATURE-----

--Sig_/hsP3AOLKPZS=WABsTokIw=H--
