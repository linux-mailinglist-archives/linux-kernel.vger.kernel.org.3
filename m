Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7151418B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiD2Eun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiD2Euk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:50:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE952DF8C;
        Thu, 28 Apr 2022 21:47:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KqKj61Hrfz4ySg;
        Fri, 29 Apr 2022 14:47:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651207642;
        bh=1AfKLldYT0hNlL/xJTa21EI2h2yp4L/ZF+EJuxdtr8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T520rKdBuIvWBGis2dIa4UnVvkMcioel+rfpFYaOpnPNFr3WfCp2CX7LaeP7X2lSq
         cCUuxJ1b23qnBLyra49ayigyKiZj6qEyE9qXi81Npr2sDFQdvm615YbrIyJeN+2LtY
         AHoL4cJfKMhP0SzjKWU81ompEmskBis+rTuaFxGKoqyTgWMRDcxUwbVPFBXxwoiSBD
         OB6qEBpF7NGOm7PHYaRXLNd/3aK3Js2mdxqIJ4xv5FeExHr44wOTOgmvKuwzFhi0Qn
         B+8UROXS/k6g9M1E964PuZK4bjtlMLhL1Tu75bfOQcnBUyI/8j3Nonyq1+dmu9XDUg
         9vTKZ8D2U9e4w==
Date:   Fri, 29 Apr 2022 14:47:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Jose Cazarin <joseespiriki@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: linux-next: manual merge of the iio tree with the
 char-misc.current tree
Message-ID: <20220429144721.63ae260f@canb.auug.org.au>
In-Reply-To: <20220429143517.75be9c04@canb.auug.org.au>
References: <20220429143517.75be9c04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o/r1K=4hnAYC/5da6X6W1tw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o/r1K=4hnAYC/5da6X6W1tw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 29 Apr 2022 14:35:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> diff --cc drivers/iio/dac/ti-dac5571.c
> index 0b775f943db3,96b86e2dcc6b..000000000000
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@@ -393,15 -386,16 +394,16 @@@ static int dac5571_remove(struct i2c_cl
>   }
>  =20
>   static const struct of_device_id dac5571_of_id[] =3D {
>  -	{.compatible =3D "ti,dac5571"},
>  -	{.compatible =3D "ti,dac6571"},
>  -	{.compatible =3D "ti,dac7571"},
>  -	{.compatible =3D "ti,dac5574"},
>  -	{.compatible =3D "ti,dac6574"},
>  -	{.compatible =3D "ti,dac7574"},
>  -	{.compatible =3D "ti,dac5573"},
>  -	{.compatible =3D "ti,dac6573"},
>  -	{.compatible =3D "ti,dac7573"},
>  -	{.compatible =3D "ti,dac121c081"},
>  +	{.compatible =3D "ti,dac5571", .data =3D (void *)single_8bit},
>  +	{.compatible =3D "ti,dac6571", .data =3D (void *)single_10bit},
>  +	{.compatible =3D "ti,dac7571", .data =3D (void *)single_12bit},
>  +	{.compatible =3D "ti,dac5574", .data =3D (void *)quad_8bit},
>  +	{.compatible =3D "ti,dac6574", .data =3D (void *)quad_10bit},
>  +	{.compatible =3D "ti,dac7574", .data =3D (void *)quad_12bit},
>  +	{.compatible =3D "ti,dac5573", .data =3D (void *)quad_8bit},
>  +	{.compatible =3D "ti,dac6573", .data =3D (void *)quad_10bit},
>  +	{.compatible =3D "ti,dac7573", .data =3D (void *)quad_12bit},
> ++	{.compatible =3D "ti,dac121c081", data =3D (void *)single_12bit},
                                        ^
I fixed up the missing '.'

--=20
Cheers,
Stephen Rothwell

--Sig_/o/r1K=4hnAYC/5da6X6W1tw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJrbdkACgkQAVBC80lX
0Gzb6wgAgb2XqmbYBM8xNGf1bZ8NCMvk2jJwJx/92+bu9W7EjVednVr8rS+VZ/x0
vJogcElAk1GlNVmvt9w3/7PimoOFZJLTH3loEaGgusm3SZfr9JbFW/kvNUD/dBop
vYaT88Uert2/HNWE1CIcmKgbn62r9WlviNTEjBINrxs6R+gAjWHMtGn0jjfiIibB
UnYGZfMVAnPx6aJAtd3d21xBogBS8YqKug2bB/S7dQ2Z2ubFD86t7FTQnCuQTAUb
9tLZIYD3gdBn8F2F5BHfNqacLJqvXRt62PtziTcfysLEgpOJAj8BKLNfFTdlE6iT
e8zqxaY1G2TrrQx4Q8yiPR1nfydvJA==
=SSlf
-----END PGP SIGNATURE-----

--Sig_/o/r1K=4hnAYC/5da6X6W1tw--
