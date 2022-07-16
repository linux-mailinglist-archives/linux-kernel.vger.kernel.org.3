Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE34257721A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiGPXEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiGPXEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:04:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F01C13D3C;
        Sat, 16 Jul 2022 16:04:34 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3694466015B0;
        Sun, 17 Jul 2022 00:04:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658012673;
        bh=E5qEU7CbOfY7rZMsExFLr3maD3YA8JZcjIGFGM+rmjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbtLMZ1Sv0AM7ZXXTDaSUyTasBS26hC9GPPIg/NFWXpyVIpvVzPlf1t82YDouSAAN
         Gscsz/omPRJpKfrqNfv6L5JkBYrqWheHqECOV3SM/n+rYKO/42Hah+ZA4dUXiKV9WT
         fa/OoYoF0VM7JdOdw69jKYow99Fv86FarWxzNveP88QkLpy1nUK7pHlS2ba0F4cFed
         k6fZhu7eu+Q1OPu+rsKEVjkIZVeWqoeJ/rIIKrEBw0lwoucBbUJ+EwRXGLuxB50xmd
         I9L+WYC8+hgYhA9VAnZHJMleARnbO1E5Eezzx1FXwLlggvdQYrQwye3o9XR9tLLbIb
         8GFnJtGeZ+QHQ==
Received: by mercury (Postfix, from userid 1000)
        id C73271060428; Sun, 17 Jul 2022 01:04:30 +0200 (CEST)
Date:   Sun, 17 Jul 2022 01:04:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500_fg: drop unexpected word 'is' in
 the comments
Message-ID: <20220716230430.qkv524wrlw5ct2nh@mercury.elektranox.org>
References: <20220622171410.5467-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="36qeumywz7deknmz"
Content-Disposition: inline
In-Reply-To: <20220622171410.5467-1-jiangjian@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--36qeumywz7deknmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 23, 2022 at 01:14:10AM +0800, Jiang Jian wrote:
> there is an unexpected word 'is' in the comments that need to be dropped
>=20
> file - drivers/power/supply/ab8500_fg.c
> line - 415
>=20
> * The capacity filter is is reset to zero.
>=20
> changed to:
>=20
> * The capacity filter is reset to zero.
>=20
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---

Thanks, queued with shortened commit message. No need to describe
what exactly has changed, that's obvious from the patch diff...
Instead commit messages should say _why_ something changed, so in
this case something along the lines 'fix word duplication' is
enough.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 4339fa9ff009..12eafeca83e1 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -412,7 +412,7 @@ static int ab8500_fg_add_cap_sample(struct ab8500_fg =
*di, int sample)
>   * ab8500_fg_clear_cap_samples() - Clear average filter
>   * @di:		pointer to the ab8500_fg structure
>   *
> - * The capacity filter is is reset to zero.
> + * The capacity filter is reset to zero.
>   */
>  static void ab8500_fg_clear_cap_samples(struct ab8500_fg *di)
>  {
> --=20
> 2.17.1
>=20

--36qeumywz7deknmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTQ/4ACgkQ2O7X88g7
+prKfA/+M7F7yHmV3yAcgrUDT3uYtFYOgQhzFSsm81UuEe9hl77uN/WVvvvYlipy
q1k4JT03zhzikZile6RI4UwkW6Dl2o0jikyWVktJHiC+ZhGSuaT0e4Scw3VKd+RG
wZESHtso+5DxPLzrsraXcxjASGgPrHNb5dzLB2BSEqNYs3iz2QFC5GCnzePgGc8J
1d8yof5B4WH7SrNDSaGABg3KP6pIHSmGfx2Ki0gTQ+wJUdKU2iXblkdw+/8bw/iy
lVlR6DA05QEO+i2F7M9ZcAcvuEw/cHYBzg8R7m3Xx2sEuSlloXZKM/o86QCohU33
fquWBamyKieRCwXhKbVP9sjRsNNNG/Nl7J7yPYU5hAB+JPb89cJZiLBU9fHvVsUS
mHZJzgHOlMWVCNN0c6m+2+eCGZRCeGMaK/wKw+ZqlNsQgtPPrz9GGJ6SMRZ7qOXd
zYfjGjl3QNFg3Xa3Qqqy3IXS4MyVPH4/1hxkqBbCWXTMOneZduu1UV1AfgSubeNG
u8UcW+8Drf5BbcqDBZaO4GegbEvPVHDVKprw1qZztc7DRfqZde2NvCh4vqZdX1TM
IE7VHvW+KfxfAALB8G45UdQxc4VmMaW6J59tFoJTJle8pf6gdQV3rskM1m/ML5pv
TaVQKymlaybvhDP0sIRBqczm+rQOT+XyjLmcbYqRwPpCDXH0Ssk=
=Mbza
-----END PGP SIGNATURE-----

--36qeumywz7deknmz--
