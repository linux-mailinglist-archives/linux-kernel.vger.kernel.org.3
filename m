Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D81346873E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 20:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350398AbhLDTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 14:52:02 -0500
Received: from mout.gmx.net ([212.227.15.15]:43059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349441AbhLDTwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 14:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638647298;
        bh=PrgmBUyfxqtpVy1lwWQb2aVCmUol9Hr5FDzh3x1bgZo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gL2YIDlIE6qQ3da8brSoJUDmy4jGsmbwJSXzZmtCheuUfzU/VVd4rHq4PzrLkNyOv
         Kn+XCmJlaT5ymYQtUF5X+DZnwlxB1U2wGklfwMCr96yqfQFhKQOJGYuH0bV3oJcpbs
         Fh3zqwBlYNVikW6/lfmK4o6J+8j+DO2eXZLeRJNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzBj-1nAqv50woz-00Htgr; Sat, 04
 Dec 2021 20:48:18 +0100
Date:   Sat, 4 Dec 2021 20:48:16 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: Sort entries using parse-maintainers.pl
Message-ID: <YavGALvWdsW+BO9w@latitude>
References: <20211204175255.1361385-1-j.neuschaefer@gmx.net>
 <429227f33cf14aee6f0668a3d98aa220b54383d6.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ROvq4wnVg2ILd55W"
Content-Disposition: inline
In-Reply-To: <429227f33cf14aee6f0668a3d98aa220b54383d6.camel@perches.com>
X-Provags-ID: V03:K1:Mfj+DDgT2I4N38q2aei8davRHgCE1wdFIJ1g8ujVKryRuGnw1/6
 R3Q1MR/FfJJYbiNJJjCSvuFjAhMz16vQWesCPTP5qnvjRXVSTlqpZf//kOboyarVCfJ7YoL
 RvOwyh/7qTvtQHEc7OhPyEsPKUlb3N3S0MzYPaBmXIXjL85tN/rdL0B1bTleNuDf0KEW4Lr
 j/gZc4WBkWHxXkuRW93Lg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hSSBK00JIFY=:Onp6Mv0JrmzhzTgrvwFgri
 ohWVhm0yixQ+wnmPwzweulJ2DTav9xKEej9IKthN3yC3umPene19QmdkyMoOOx9bk7WojKPqg
 5S+Kq9LW1TOWlf5BpL4finTgF4MqTuF3oXVLfUg/5Fuql1RSFZvfztmvOJH2qN0/4EVBSP+Pe
 8XHdJph5hkXUlbGAyB0QvHJh+xFj7lPsC2Q6jbOuFBWOkgWY5Tno27J3ipAEdhvJdivck0NqD
 2JkNOBauKa+Sg/7gTe/fh60/Y2zbP+3v/ZJ4YMuMFc4tDjrIcAPa6Zw7SYZmJsUyZnhP/qZRP
 nBlais9bZ2rhii82oSxy603GAq9K0GDjEiSvheyXTjlwtrUhrE6pmOFLpZvysnQtDepR5Ydke
 xP6ENq3Yq+GIabRgLtyahNldGoLlJgBlsX8hCfcC15oWAnz8DqPWH1AhGKjw9JtiSC67V1nj2
 DZQlLGZURRGsc1lRQ69evq22PNOiOY6v88d6EcNDm9dhheAS9BYlkIUi03FYQeClyQIG17K2A
 j/suDLiekMC1Kol5VL7AE3BYcaDK/Y5xMs3SwBz3moeQXAPkHS/6voAuLBDM5dwYDaOgMJF7f
 eAlQSif/RU/0++dR52m727m9xOf2Feh+2JTqjG3if/DI1ImQdTFP7jVpPEnOcJKU04QvCszMt
 6HYoqXeqvZNEFG5edNG6G04orVbZlLBFMzmh4N4iJtRBvbrlOlU4w2LrvpHHwNHdbTFCrY0qo
 SIeGhKwl+Vd77jW8Ct4hdgs2AFe/YnOzDQWJA8QV4OxWFnBpbuSed+MO/tPYwEvpd364mSqLk
 P3jiwz760GFWw+jgpRi3Z6qkdPoSq9C6BsaP5qB66OiCl5QTmSuJs2beDCdRloPXoSBPzuqoj
 YHnbPNea4zPOd6jcaVcMm9zONaTh1UZwBqpTXdVkg8pa+3dygXIZHy24WSOJ6ySDjB0IabRsj
 ctskX7idyGMhP0Rhvli/cu1OEBbChHMAkpF+kLnxSWpN5vXzdubeX34avFxr64WUPk3tumddy
 ZwRZ6m6FjomXdzcduxLvXvWMGGSvbvXhSItt+i0Q2gFVgwzLY9CN5Fc8pCEJqsKU3oizEbEs8
 kTV7TMz8WUPkm8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ROvq4wnVg2ILd55W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 10:20:24AM -0800, Joe Perches wrote:
> On Sat, 2021-12-04 at 18:52 +0100, Jonathan Neusch=C3=A4fer wrote:
> > The MAINTAINERS file got slightly out of order again, making it
> > difficult to put new entries at the right (alphabetical) position.
> >=20
> > Run parse-maintainers.pl to restore the alphabetical order.
> []
> > Checkpatch warns about a few unordered "F:" lines within sections, but I
> > left those alone because I wanted this patch to be as automated as poss=
ible.
>=20
> The --order option does that.
>=20
> $ ./scripts/parse-maintainers.pl --order --output MAINTAINERS

Ah, good point.

Unfortunately, the result of parse-maintainers.pl --order currently
produces a (small) merge conflict when merged/cherry-picked on top of
-next, so it might be better to start without --order. (Not sure.)


Jonathan

--ROvq4wnVg2ILd55W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmGrxcIACgkQCDBEmo7z
X9tVJA//aISsE+7K0fQ3JOcW81DBxVamtjIVwDlgWZY4/GydoC2/Ixgyab2/SNX+
+sKYYtB1zlrkYtDQFG7UQ7b2dATpwntvZuLMM9j+MtZ9ZxXDmDZz52omGGlZlMIp
XIVpoglmN9YTWOc0p2iCi2P9wMwdZSghfpjSBdzyp4iZ2OCYpI+Rzuo0Mh+sKpV2
l5DTv8+kV9gjRgoQGNktF/grwyJZVF5tJqXex5rQg+cftse+cOi5/awVepvG6czD
w7OrbVzbyt+/M47hI81XtnNsP3nTEXQW8fJsbEIeBpdP+OUwWtP+FI0et1Q4jnaG
6I0+4xFZcg87jbD/2FpIuEyCvWiw1YBJ52nkfcOFTSjLkuBTdqGc+DmJbZrZEe52
ZdSmN2l36IKA1Rw+quMe8eCNAI4eiSqtR8M+tar9ydhUxKBiCcVExpraEhXW5E4I
jBJnzwxb3FFHopI97VhXvTTqdSxVov2cU7vDLoLdGz1LDQr8/ni6pMj8tCkLmYoj
s3eQ5mdnb86hpObpkbRViFymzJPtxYq/pUzgz0JDubJhUjOVtvqixO+JkP2Uy1qP
locYLqWcgHoJVXH5k9d6Sbo16FB3ZAPhDGO0mkQhVOHjr2zX/gbqIqeuXO86vSQ2
IYDaxBZQBPLhgs5v0Na3yyFa51K9/706r+eJYCtvGPboGUwFUx4=
=7ALR
-----END PGP SIGNATURE-----

--ROvq4wnVg2ILd55W--
