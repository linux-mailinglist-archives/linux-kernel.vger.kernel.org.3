Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D0577D89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiGRIaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiGRIaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:30:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940721900E;
        Mon, 18 Jul 2022 01:30:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmZs31zTwz4xXD;
        Mon, 18 Jul 2022 18:29:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658133002;
        bh=54kmAmnoYCcxmNMinGjy12Hzym0v8NfrO5fwMD3Ehzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WoOiYyczHtsedefj+PjZBGY/94UkOX3jKM+OT92vjzDcIPHN7bsSIo5e0eCwLAU2O
         SIK63mJ7knOy+Ac9o963m1jqcIzfH5VwgrMhuwyF1YHtGRzaoihBSH4Avlopyv/Ast
         fapsoC2bKJcce+GopXnw+y+PmxdrR57otjtcqQSHI3dLIzl7Mj/ldgfnwZ1BJvPYCX
         hYgGQFcxVmyjI74xCj9R/yADGplvS6Ie1JhnGlTErLkLnkMPd8QIU7uUh9ziVZ/H6E
         +ekLgvvv9ueegbzq1xMZX47lFsSQfCM4DU1W3N7Q8GQjFQABHKP/3WOc0/YXP6TEIj
         vjlvrKPP64PrA==
Date:   Mon, 18 Jul 2022 18:29:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: linux-next: manual merge of the soundwire tree with the
 sound-asoc tree
Message-ID: <20220718182955.050c9678@canb.auug.org.au>
In-Reply-To: <20220707152831.57f1e92d@canb.auug.org.au>
References: <20220707152831.57f1e92d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ghlKLIEbt8+jgZxf19MZ0ir";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ghlKLIEbt8+jgZxf19MZ0ir
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 7 Jul 2022 15:28:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the soundwire tree got a conflict in:
>=20
>   drivers/soundwire/intel.c
>=20
> between commit:
>=20
>   ca68202098a4 ("soundwire: intel: Migrate to new style legacy DAI naming=
 flag")
>=20
> from the sound-asoc tree and commit:
>=20
>   3e9c9f90573f ("soundwire: intel: use pm_runtime_resume() on component p=
robe")
>=20
> from the soundwire tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc drivers/soundwire/intel.c
> index 0268fa527c0c,95ce292994cc..000000000000
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@@ -1097,9 -1114,9 +1114,10 @@@ static const struct snd_soc_dai_ops int
>   };
>  =20
>   static const struct snd_soc_component_driver dai_component =3D {
>  -	.name           =3D "soundwire",
>  -	.probe		=3D intel_component_probe,
>  -	.suspend	=3D intel_component_dais_suspend
>  +	.name			=3D "soundwire",
> ++	.probe			=3D intel_component_probe,
>  +	.suspend		=3D intel_component_dais_suspend,
>  +	.legacy_dai_naming	=3D 1,
>   };
>  =20
>   static int intel_create_dai(struct sdw_cdns *cdns,

This is now a conflict between the char-misc tree and the sound tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ghlKLIEbt8+jgZxf19MZ0ir
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLVGgMACgkQAVBC80lX
0GwvMAf+IAR1mGrjma/53li8iAr9U1sacxSzVcLPktLrGE9lwCCtsXSQcuMjCCay
6s3f4gzVUOSbl6sh7xWfXn5AP31tF1+8b4MWvBRn3umnvpi2O18d7FoiFPwmQGs2
XN8rra0dMwFDaA4oKx5/c0PAj++4Ruet/2OfJHd0rWlQkHRiSjEHTYMj+uFhJY4E
zWpiAGLn7pk3Jrn5gYydbCJ+bXOMadThbyzfOqoxKOBmLEyT7pyk+Vy45XngOmwI
UboLcpKBcCpIxAjX7EIUnIxhnehRK/u0xYxFcgLXW6mCBo9YRdoeznWxFdTMnttl
Eprupbh7xi66eb3HLC0pipcjsex4iQ==
=hdGA
-----END PGP SIGNATURE-----

--Sig_/ghlKLIEbt8+jgZxf19MZ0ir--
