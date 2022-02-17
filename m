Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1284A4B9A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiBQH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:58:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiBQH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:57:50 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C940B9A4E8;
        Wed, 16 Feb 2022 23:57:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JznH53slgz4xcY;
        Thu, 17 Feb 2022 18:57:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645084641;
        bh=fRCJEuT2NNqbc+8BttfsxPBdr1n25ZCNmIXyN/Q2BvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kDcsGSnYL+Mwe2moZ85DIr9l+ob7ZkreaMMtirHog8y3AhnGRBR3hpkqT61/qW0D5
         xtLIaoX6Tpwuvq+x+dTcXdTs5L39X5fOAYXPxe1XlSKGkl1ls0e8J2ukNQnmTvrFPZ
         9R7zScYJYk88SWz63r2Cd/i87m7EGVVaHkDAIsxeMFMIxXdNkXz9Eq7nGntdV86j8t
         Sz5MgLAaWr89WCyoOj8yem2OQuhkhISwC5++pm9A1kdXdHfh34ZPmVU2pyqRc2HcKW
         /H9pxW3iPxdm/1+y/ZxpCVgsp2KOYxuu7nfI+946AUbnvc80aR1doJ3e7pAPtcsXi6
         GGTGX3mhFE1cQ==
Date:   Thu, 17 Feb 2022 18:57:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the maple tree
Message-ID: <20220217185720.4b2f5923@canb.auug.org.au>
In-Reply-To: <20220217185602.78adebeb@canb.auug.org.au>
References: <20220217185602.78adebeb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zgsd5i/zVPG=Ec44pLba63m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zgsd5i/zVPG=Ec44pLba63m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Thu, 17 Feb 2022 18:56:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> After merging the maple tree, today's linux-next build (i386 defconfig)
> produced this warning:
>=20
> lib/maple_tree.c: In function 'mas_wr_spanning_store.isra':
> lib/maple_tree.c:3941:1: warning: the frame size of 1040 bytes is larger =
than 1024 bytes [-Wframe-larger-than=3D]
>  3941 | }
>       | ^
>=20
> Introduced by commit
>=20
>   4af8015a7707 ("Maple Tree: Add new data structure")

Also

lib/maple_tree.c: In function 'mas_wr_modify':
lib/maple_tree.c:4249:1: warning: the frame size of 1040 bytes is larger th=
an 1024 bytes [-Wframe-larger-than=3D]
 4249 | }
      | ^

--=20
Cheers,
Stephen Rothwell

--Sig_/zgsd5i/zVPG=Ec44pLba63m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN/+AACgkQAVBC80lX
0GzecAf+InS5pge23TqjtT6wGTy0YUEvQyo8YofCCqtC9lka34/h0+ZEvbqQkZyA
A21oLhhUMoDBR/5Cml9LCgxscD98brBVAvuUbVpIU3LjuaJrBTCXk/yxNWxBFQrO
FCdTf7A94a0moaeidNEzytpL2W4JoXMXhaOAvjJrK/M2OkWJYdOutZw334S1vOio
kGL+9iiJldk/VYjgqtYBonPUqGYinBolfczxvsrhQKMHOj/Mz+oZB9iRyte96b8P
tBh0Jz2B5AEwntdfvAuMe1h9PMvshiqItdZx5Z7Tb0QihV+/PrWpF7azPNbnYpJI
j7C6plZ0OBxwUW+qMlBH1EgTDV0mXw==
=oDUc
-----END PGP SIGNATURE-----

--Sig_/zgsd5i/zVPG=Ec44pLba63m--
