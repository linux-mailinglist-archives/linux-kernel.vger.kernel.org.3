Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6C14E5B28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345196AbiCWWSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345274AbiCWWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:17:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F098FE52;
        Wed, 23 Mar 2022 15:16:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KP2kd2hXqz4xNq;
        Thu, 24 Mar 2022 09:16:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648073785;
        bh=cHHotlnSxtgBzbJhFRu1jaTET3CXFmR3lj1E4cN5Lew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YbXV7QIQRo+opkTdkbVSIFBUqOnjaXHVX1Wc+XtMhIFCROra8qmgjEec+hnGTVcEt
         DAL5/Co4zDVIE/m/zIzeCzSE++/rs8BYZ9d6tP3zsZipKFk0ge/E9G6vcMHrhxDQTq
         cwhDWJIn0vPVEAU334rQgTItI+hjp1I+P3G+E3jF+Zq/P95ytZxttwka4jm30KTvGU
         LfYpBIq2Mh5/XQvl6oJifplUsfKxqji6x9qRX7+lnRqkX+/hHMyvyhvFiX09s6HXNl
         2ssvHTSVxaS60yz0JIwxUSRTqa/wXY9VfO3ke0s4IkrsBGqbzwp4Vg030aien3UoXq
         1JP/kAmAPdAKA==
Date:   Thu, 24 Mar 2022 09:16:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Kao <alankao@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 asm-generic tree
Message-ID: <20220324091624.58b5bbb0@canb.auug.org.au>
In-Reply-To: <20220303191741.3055ac34@canb.auug.org.au>
References: <20220303191741.3055ac34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2oYwpDSvSmJnDN./NK4/UbC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2oYwpDSvSmJnDN./NK4/UbC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 3 Mar 2022 19:17:41 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the akpm-current tree got a conflict in:
>=20
>   arch/nds32/mm/init.c
>=20
> between commit:
>=20
>   9f15ac318b83 ("nds32: Remove the architecture")
>=20
> from the asm-generic tree and commit:
>=20
>   311ca692496e ("mm: remove mmu_gathers storage from remaining architectu=
res")
>=20
> from the akpm-current tree.
>=20
> I fixed it up (I removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the asm-generic tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/2oYwpDSvSmJnDN./NK4/UbC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI7nDgACgkQAVBC80lX
0GzXIAf/dR2W+A39sSfaQ+VKo7N7XYpQ/KXINwfnjb63nH5/YMBw/7a+I0Vxajem
96jQ/r79WT1CO8SX2U/aEO6KgyuZd0Kx1K/rOYtMXV6uWzCCBT7EgDPKVrJbCL1U
8Cxeg6VlmoA2n4yckdRQo2aR1BTzY0z6741v7DVcIQlak/tSPh0wQInqe2Bvu0A7
16QpFMKm3Ow23OcYXbEYDIsHPB236BJbBKN5dynos6ZZa0Fv6KDI7oG61o6vL4tC
ZfgJeRdt+uLRqGO7qOn+HYN6pAO3O4Wiw8UH9FaatDWtHieEXYxNqfPOsesLpWzg
JlFNqyqWppPXyaZGX9sNQf5ifKn43A==
=lHuP
-----END PGP SIGNATURE-----

--Sig_/2oYwpDSvSmJnDN./NK4/UbC--
