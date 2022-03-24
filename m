Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557BB4E5F61
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbiCXH3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348553AbiCXH3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:29:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CC498F5E;
        Thu, 24 Mar 2022 00:27:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KPGyQ3PpXz4xLS;
        Thu, 24 Mar 2022 18:27:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648106846;
        bh=Ykwf/vshyeQSeWYIdanCW8F3MhFuHqdkiAKQ5UwEhDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NNKdd5IYi7t54wWj+d4M6OcRrcyN0WEsn4wEehl7HjxBKF91DRM9zxLx+u3N+wdq7
         60qTuU9KOPAXae4tzHSgfo7z6Fq8eXAFYjI5D2rPcoflD4sAYvYL9OjYp+iTZzDF2y
         rmyv/92M9kuaVVdHusaejOjrwUxtsBBfJdWnPYR76eYERYXVfoYLGo9rcLmgjCdBhG
         Hc69MCajX1OsLByABq+C4qAotT8kh4XtF2KiuijFWBnk5bT/CVocbxNFQHRI69+tV7
         Yjceaby5FoxTuFMdNbV0aPHvBU8cZNaJ6OVYwfoPnA+Teh2oh49fHor1eu5sYsN3GK
         X10ZSkeXcTxiQ==
Date:   Thu, 24 Mar 2022 18:27:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the akpm-current tree
Message-ID: <20220324182725.63a454e3@canb.auug.org.au>
In-Reply-To: <20220209170245.08968c92@canb.auug.org.au>
References: <20220209170245.08968c92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BYSkcCTydD1p6B7yTgN1zW8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BYSkcCTydD1p6B7yTgN1zW8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 9 Feb 2022 17:02:45 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> After merging the akpm-current tree, today's linux-next build (htmldocs)
> produced these warnings:
>=20
> include/linux/mm_types.h:272: warning: Function parameter or member '__fi=
ller' not described in 'folio'
> include/linux/mm_types.h:272: warning: Function parameter or member 'mloc=
k_count' not described in 'folio'
>=20
> Introduced by commit
>=20
>   60a5c5ab0ba7 ("mm/munlock: maintain page->mlock_count while unevictable=
")

I am still getting these warnings.  That commit is now

  07ca76067308 ("mm/munlock: maintain page->mlock_count while unevictable")

in Linus' tree :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/BYSkcCTydD1p6B7yTgN1zW8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI8HV0ACgkQAVBC80lX
0Gw5Jwf/QxuaHq/Vhx4bTya1Tj/nimJNOlpk10Ievklf3ZX0R+ytC5y7tvvQXs6N
zBHvuP+KQNOCUbckR79VxqFITlyA2Met2SWM5+Ook6Pwa67vV24RVu12l0Y/NPzz
FtqxVfbkHkqiPRpXDIlLqQUxmX6v1y85d//gKxIIzumdLdfB9DJcTs+kbppqDRM+
gHbX9SwE7w96pHEb4jJdkE1k/d9VxPgV6WEvw7xX3tNGFRjw65SbxmM9uT4zRS73
V5Fy8KwkGWUos0je9aOqLYKaHeZXY8NW0C4SCoKaJIroAawwrY6dr333v6StPCwr
JTmxbuAhz/sWf7sVXV0GyEsChbgxew==
=mFkm
-----END PGP SIGNATURE-----

--Sig_/BYSkcCTydD1p6B7yTgN1zW8--
