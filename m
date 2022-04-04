Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611CC4F0D43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 02:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376819AbiDDA2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 20:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242059AbiDDA2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 20:28:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8BC38D93;
        Sun,  3 Apr 2022 17:26:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KWs5Q39kjz4xNl;
        Mon,  4 Apr 2022 10:26:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649031979;
        bh=vkEydrZ8KYUUbt4hWGk3zyh3sYWeOUuzb4/bDpe8168=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yv4PhXPfPXqBER8LKEOsoBHo6jtU79PVXkONfInMbtSWutYj1rkkSbLRnZ/eZm+l6
         fOqfxATcNUvdrMmmixY3KrwKTAGjEv1szgJgkUp/WxxpGB/4/0wvbdF120oPyC62GX
         zWGhWYNUw4B3tmWZkhnHxlXQi421va3VSHZd9TaxiT3EwvcdKOakHtpC0bFvHBLrLr
         G/FuiCA7tvDZRg/lYc9MzFpSUI1D6PHB4rr7gfG8NTUerBufV/NoEr8MrIknADY6Rd
         qSSUBuhVXyMeo5BTge+8tSwxNtuDevfh2IuuFmrvByhRDzSg8GTUU8RNgrsB/eAcjh
         XTv5vNQkYy9gg==
Date:   Mon, 4 Apr 2022 10:26:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Wei Xiao <xiaowei66@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sysctl tree
Message-ID: <20220404102617.572de1d8@canb.auug.org.au>
In-Reply-To: <20220330115617.4d694d11@canb.auug.org.au>
References: <20220330115617.4d694d11@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.826Wd/eyfK8gDkf=r_gnft";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.826Wd/eyfK8gDkf=r_gnft
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 30 Mar 2022 11:56:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> After merging the sysctl tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> kernel/sysctl.c:1776:36: error: 'C_A_D' undeclared here (not in a functio=
n)
>  1776 |                 .data           =3D &C_A_D,
>       |                                    ^~~~~
>=20
> Caused by commit
>=20
>   84053cc7ef2f ("ftrace: move sysctl_ftrace_enabled to ftrace.c")
>=20
> I can't imagine how that happened (though I do note that the whole branch
> has been rebased and not tested :-( ).
>=20
> I have used the sysctl tree from next-20220329 for today.

I am still getting this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/.826Wd/eyfK8gDkf=r_gnft
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJKOykACgkQAVBC80lX
0GxMvggAn8cFamOuwoy3+EiT5ilkrMlCAkidsDCOPv5hN5MGKjmw7aPx/LMf1ZUq
P3+i2skyY8hapx180oYRdrBAEjv4EWSrSSFNDQVtT4C7WdErsVx1SzpH2JMnVyG6
cEB9HqbaEu57YyuUk0UxBp+8VDxVXpvGyJU2Vkm3XrDZCYx5h0KJfx7kHIdLFDc8
kn0Gym0j2nq8/BGP00IsrfuI9zICkAu3jVsSzhtqTA7obCKRzfGE43SMvjmyNGZO
jM37zULLIuMB3IaYPL9iZfFVJ+XPfCZFss/oZ+DEZ+iAImJ3F2JcebnZG6PAFQpx
3CExtXMmJc3zAGHlu9NHO/NxK769Aw==
=bLaf
-----END PGP SIGNATURE-----

--Sig_/.826Wd/eyfK8gDkf=r_gnft--
