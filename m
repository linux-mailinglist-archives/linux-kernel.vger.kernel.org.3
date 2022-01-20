Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99427495711
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378180AbiATXkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbiATXkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:40:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:40:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfzWq6VF1z4y3m;
        Fri, 21 Jan 2022 10:40:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642722008;
        bh=b/aVRf9yFTca7ePjT0UV8R6T98RmKwNXNkZ+/kTTzZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YwMehgm/ETg/DPhgoE2yVTv96wxBve1+vCwjz2iUOxYe8BuIw8ZUtft3BhFm86cVa
         kxQb2Qm5WhuzwdVl0pyldDu075459uRZ3TRJ7yw7Ld1s1UoFlBK4SxL7oXkcJvZe1n
         OIGru3g17idnDEdkZlPk8/zh3SRv+uRkJbPmcWOO6wToMN38XKv2pK0y25qq92Gt1v
         ZoobO45SyyowBxwNfrRdjTsho6r6qG8F+NhyvDpte2M5sVvTsY9pjpNZvRbfzUK1+1
         wVpjbXy9FbMHcvj50CzHt1K9wp5Y/VDyrsfpbOucR2KObLXcmenCwDqa5mIrN8gxkz
         SSI+mqmTttJpA==
Date:   Fri, 21 Jan 2022 10:40:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: h8300 pull request for 5.14-rc?
Message-ID: <20220121104006.7e51367a@canb.auug.org.au>
In-Reply-To: <20220120075233.GA4777@lst.de>
References: <20210913054915.GA3631@lst.de>
        <20220120075233.GA4777@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YiEHKY.YRT4LiF8067pDxzB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YiEHKY.YRT4LiF8067pDxzB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 20 Jan 2022 08:52:33 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Sep 13, 2021 at 07:49:15AM +0200, Christoph Hellwig wrote:
> > Hi Yoshinori-san,
> >=20
> > what happened to the h8300 pull request with the set_fs() removal that
> > is in linux-next? =20
>=20
> Given that we're at the end of yet another merge window:  what is the
> status of the h8300 tree?  As far as I can tell the last pull request
> was in July 2019, and it has commit since just after that.

The h8300-next branch (which is what I merge into linux-next) has some
more commits, but even there the last commit is from Aug 2021.  It also
has a lot of old back merges of Linus' tree, and so probably needs a
good clean.

--=20
Cheers,
Stephen Rothwell

--Sig_/YiEHKY.YRT4LiF8067pDxzB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHp8tYACgkQAVBC80lX
0GxTZQgAhc1ey5iCo+RHXX0YpbLo73K8PIAWKg2aafDKNCpSIMpVCVsx6h3ScHrs
7PnXvCT2JV77VMlZCHwZV97qkjxACFCpI819OyQHFO7HdoC9/Z+V1EpZ6QCTdw19
0ZkJrvaehGL5un/MGUXf4Y7smUlKA/38txWwfvIMGlc1ZOY1cLsym+cNh6PDBH8D
OMVvBzgGTbXtEXoj5coxKM0GPZWuNlMNK/WIpwXl1Ij/eqoQs9qp+0EDLN6BMWb4
T0ph6hWCAwcJAo3EN8TSVqaVkXzcFQImise4fUmg86GWzciNXjCdPXsf6hAppwfV
DBuc5M5y7Wi+Rwt2Jb/SBCkn3Tfs8A==
=HMgu
-----END PGP SIGNATURE-----

--Sig_/YiEHKY.YRT4LiF8067pDxzB--
