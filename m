Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9165454E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbiFIT0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbiFIT0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:26:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459536B43;
        Thu,  9 Jun 2022 12:26:17 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 12FA3660162B;
        Thu,  9 Jun 2022 20:26:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654802776;
        bh=7rw5VKTUlf+bS9la5aXVmdbFfiKba3aev95ZePqUfWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAj84oaJmTpGcYHai09s3FTlK2oReArBbyNR2RigMt0mkuYufjISeGyAGID5Vbc8C
         9iQ60Ddpc11yqYrdCnFT0ytXBDHAvWGekJzieCLh5X7YMzjuNOscohl00J/3y3mqlf
         V7ZGJHfgkjIBAyfNnOTMidGbOExAFYsyxOl2F/3ztAfNrc24BK7s5ufacv91it0aoH
         J8bISK7Wu75CGyLINCX6tN30hY177MXbMYPIXXh60ycvaMOKZw1cx6k+yZho5yCEpw
         vn/UQfS9y7zyGMogGGgGzRF0ST9JA1bb6N3GE9tRdZ2985n56EoypA1Ap13aEv4HlX
         xuLUJYh+JOrbw==
Received: by mercury (Postfix, from userid 1000)
        id 4DE0C10605B9; Thu,  9 Jun 2022 21:26:14 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:26:14 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq24257: Fix syntax errors in comments
Message-ID: <20220609192614.5nlqxgm2f3thgg73@mercury.elektranox.org>
References: <20220604141811.14276-1-wangxiang@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vvhbfz3c2o557vtz"
Content-Disposition: inline
In-Reply-To: <20220604141811.14276-1-wangxiang@cdjrlc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vvhbfz3c2o557vtz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 04, 2022 at 10:18:11PM +0800, Xiang wangx wrote:
> Delete the redundant word 'is'.
>=20
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24257_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/suppl=
y/bq24257_charger.c
> index 96cb3290bcaa..ecba9ab86faf 100644
> --- a/drivers/power/supply/bq24257_charger.c
> +++ b/drivers/power/supply/bq24257_charger.c
> @@ -287,7 +287,7 @@ static int bq24257_set_input_current_limit(struct bq2=
4257_device *bq,
>  {
>  	/*
>  	 * Address the case where the user manually sets an input current limit
> -	 * while the charger auto-detection mechanism is is active. In this
> +	 * while the charger auto-detection mechanism is active. In this
>  	 * case we want to abort and go straight to the user-specified value.
>  	 */
>  	if (bq->iilimit_autoset_enable)
> --=20
> 2.36.1
>=20

--vvhbfz3c2o557vtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiSVUACgkQ2O7X88g7
+poziA//ezQhsHgXgVtZfLmMQrrlPSPM6GLdC3v4PsJvYdytzep5/ic/Pyq96nNN
zYJ0w1VOc/MWv6onJV1SnfRtFShjfx0PuLynOlMRxJd3EwqXoio5x6gQPoUw8ebp
iHgTQKZs/N2/a9h8rbyq9NAq0w/mg6E7l5jEV8DVN0wDjLql54dR3NaEUKJg2xTd
4h5wR3TYgJJeyf4eXeygKOA6Cnnuk0P35i10idM0a3PI64WvDtedH0MdTinU4eHV
WGDA+5gAUZQhOZ9043mnFcM7Fj4xKpF7xqYQTd6g6fiDzz/jflt+CT63H52PLOfh
6UGgCvkJ4FC8+XdHwW5HIWazyr0sUZVfLHDN20NO3exSvdAn6eYhObU6Ibc+byV9
h5CQJnMv/jsBkEc3dYWjyOPv0EPoYN9et6Fpy64OGQc21oHYT9Xx8h0ykT85cwKf
rTrQnzruiM66lkXxHYUh6QXmAUjs0HS8DVySmRZOA/3JnooMbfgaei8NdwmLn9Pg
/PiG1svMPFhstOeKlu6LEOpxy5ej06Srus9OVeX5uOi+bhuhSw/PXc22bG+Sn1qR
DkoLUlqJ8/D3Wg9biKZ9GrZi6zraxBEvE3/xTX9urEAZCTlcNY/TuR/SyxKYi0Br
lPh+ZIGzJeijxvZDQ+0slrmDWxMkhJGTj7A9VA8IWnAk09X2DhM=
=ZZ/0
-----END PGP SIGNATURE-----

--vvhbfz3c2o557vtz--
