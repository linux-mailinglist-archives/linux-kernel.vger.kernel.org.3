Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9F4810B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbhL2Hf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhL2Hf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:35:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124BC061574;
        Tue, 28 Dec 2021 23:35:56 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id h1so12083856pls.11;
        Tue, 28 Dec 2021 23:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VCTE/twRgiKjq5SmMjjWKYf6C2niB6VMNqEBKuI+5Bc=;
        b=fuAUoxBJCe/z/xdvCwLKVjgi0DteF3P3H6MwvGNoi0z6WdBsd+laDfDRhdiKEN9YTS
         6dgeloGDX/r3wB5/pOtCgPofGSCozHHnnYPIT6W80MJVh6GZFodDtQ6V699amZTb/o3M
         ghtHBnvg522vsZdRF2cVAKhMDil0vYCmpzie0Q6tWun1Zz9K7CTC4sXOSR05SwL/1YH7
         OrENfG7EPElcMBFLKpz0TeZdYZCY7rMoRAMB2N6aSGuzmzQ/n6dj4vkbR/y4Go73x4a8
         etB0cOyuae4nRjSS95HCFtnNppV/5UgOR/iN5oGWh7mjxPbQH6E0c8cXx0kDzXqrzPuJ
         BHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VCTE/twRgiKjq5SmMjjWKYf6C2niB6VMNqEBKuI+5Bc=;
        b=yK2zR8GSgrpxvfRwd4z09z+JCn27dPgZXQ7GEvdvYGFcR+mfGAfEP8AXkZI6mzdJpy
         BeTwdOVGmFjy9igOstCGD6TriiiWqdIne/n2/hiPqgEncGgcWyAug207lqjV1WJ+K+vQ
         Bivi79DdoedgA3DBTFTwPKwILoJiO5CLCnQNm3Gp3CVMEaxnSOc3mn4bsE+AcWgq4NWC
         nSaI/MiDovZraNNC21Rc9qyj2rF9WTf9hWueZMsqFuMsFMOLKErZmCOn/e8ShkuWctob
         YKlxtgbcUqGpt6yFC/JqT+SHKo79BUM4aidORsBmA+iX79PxXWFFA966JM0GHr7HK3TE
         lzcQ==
X-Gm-Message-State: AOAM533r885t1gr0R0nv3S0lGQUSUXjQI9IBMMG6pqjGXLtGSBSwJeNd
        o/EgfRzTk4UoGdJFyG/tBdo=
X-Google-Smtp-Source: ABdhPJwCBggQzJGNpuuWC5V2rLsxVmyoElb47KQyDS0pROYjwf0Fy9wNShRLjDJHiSEcLvp24AR/2Q==
X-Received: by 2002:a17:902:f68e:b0:148:c0d1:605f with SMTP id l14-20020a170902f68e00b00148c0d1605fmr24980306plg.19.1640763356498;
        Tue, 28 Dec 2021 23:35:56 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id k23sm1532332pji.3.2021.12.28.23.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:35:55 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:35:48 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v2 08/23] counter: intel-qep: Convert to counter_priv()
 wrapper
Message-ID: <YcwP1JeLETPd6dqK@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-9-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gft/vq9VWUrba0rI"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-9-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gft/vq9VWUrba0rI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:11AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/intel-qep.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index 0924d16de6e2..8f84a48508ac 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -109,7 +109,7 @@ static void intel_qep_init(struct intel_qep *qep)
>  static int intel_qep_count_read(struct counter_device *counter,
>  				struct counter_count *count, u64 *val)
>  {
> -	struct intel_qep *const qep =3D counter->priv;
> +	struct intel_qep *const qep =3D counter_priv(counter);
> =20
>  	pm_runtime_get_sync(qep->dev);
>  	*val =3D intel_qep_readl(qep, INTEL_QEPCOUNT);
> @@ -176,7 +176,7 @@ static struct counter_synapse intel_qep_count_synapse=
s[] =3D {
>  static int intel_qep_ceiling_read(struct counter_device *counter,
>  				  struct counter_count *count, u64 *ceiling)
>  {
> -	struct intel_qep *qep =3D counter->priv;
> +	struct intel_qep *qep =3D counter_priv(counter);
> =20
>  	pm_runtime_get_sync(qep->dev);
>  	*ceiling =3D intel_qep_readl(qep, INTEL_QEPMAX);
> @@ -188,7 +188,7 @@ static int intel_qep_ceiling_read(struct counter_devi=
ce *counter,
>  static int intel_qep_ceiling_write(struct counter_device *counter,
>  				   struct counter_count *count, u64 max)
>  {
> -	struct intel_qep *qep =3D counter->priv;
> +	struct intel_qep *qep =3D counter_priv(counter);
>  	int ret =3D 0;
> =20
>  	/* Intel QEP ceiling configuration only supports 32-bit values */
> @@ -213,7 +213,7 @@ static int intel_qep_ceiling_write(struct counter_dev=
ice *counter,
>  static int intel_qep_enable_read(struct counter_device *counter,
>  				 struct counter_count *count, u8 *enable)
>  {
> -	struct intel_qep *qep =3D counter->priv;
> +	struct intel_qep *qep =3D counter_priv(counter);
> =20
>  	*enable =3D qep->enabled;
> =20
> @@ -223,7 +223,7 @@ static int intel_qep_enable_read(struct counter_devic=
e *counter,
>  static int intel_qep_enable_write(struct counter_device *counter,
>  				  struct counter_count *count, u8 val)
>  {
> -	struct intel_qep *qep =3D counter->priv;
> +	struct intel_qep *qep =3D counter_priv(counter);
>  	u32 reg;
>  	bool changed;
> =20
> @@ -256,7 +256,7 @@ static int intel_qep_spike_filter_ns_read(struct coun=
ter_device *counter,
>  					  struct counter_count *count,
>  					  u64 *length)
>  {
> -	struct intel_qep *qep =3D counter->priv;
> +	struct intel_qep *qep =3D counter_priv(counter);
>  	u32 reg;
> =20
>  	pm_runtime_get_sync(qep->dev);
> @@ -277,7 +277,7 @@ static int intel_qep_spike_filter_ns_write(struct cou=
nter_device *counter,
>  					   struct counter_count *count,
>  					   u64 length)
>  {
> -	struct intel_qep *qep =3D counter->priv;
> +	struct intel_qep *qep =3D counter_priv(counter);
>  	u32 reg;
>  	bool enable;
>  	int ret =3D 0;
> @@ -326,7 +326,7 @@ static int intel_qep_preset_enable_read(struct counte=
r_device *counter,
>  					struct counter_count *count,
>  					u8 *preset_enable)
>  {
> -	struct intel_qep *qep =3D counter->priv;
> +	struct intel_qep *qep =3D counter_priv(counter);
>  	u32 reg;
> =20
>  	pm_runtime_get_sync(qep->dev);
> @@ -341,7 +341,7 @@ static int intel_qep_preset_enable_read(struct counte=
r_device *counter,
>  static int intel_qep_preset_enable_write(struct counter_device *counter,
>  					 struct counter_count *count, u8 val)
>  {
> -	struct intel_qep *qep =3D counter->priv;
> +	struct intel_qep *qep =3D counter_priv(counter);
>  	u32 reg;
>  	int ret =3D 0;
> =20
> --=20
> 2.33.0
>=20

--gft/vq9VWUrba0rI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMD9QACgkQhvpINdm7
VJKxdw/8CkDVm7FJNc8iSD/i47jH47pn08S3bebCMuaOeWZuP0N4V4S4Mloa93W7
giI4XxflDBiGJmV2HBAAlqomPAj38YrEfVJESSl3A1ishT/8aSzBSUBRTkBtZyQY
wudbrj7DmbCU2KJz3CPtQKy3tk6J8AUkeGVBPv0cj22goViW8e1KDaZgEbWJlA0v
4kcEBbEGKEXH96E76raxaw3mIyAOKa/wuoIGkROhQQQ8WP/vY6P0JO2BFzffLGMu
aIBphBsUq0mPWGoiwXfCWGYgYmlAbj9Jk1hN1q2odM9zYpQFAEhdrYmz6Rcpq+Fe
DeXP8j8HKQVIMgrF4kp9qqmG6cMuwFhZcrSxegOHudpMsgK061hvyipc0t7nNzHM
bQusKyAH5jEq8TjbGvr073LJQa4gYgIRVUCSl5/ksSjIkCnqQqonOXaTs3IympGY
qbHKDVqrLdc4vW0uuBrn+pSFWjJ4k27ByPW9u2dilUBqWu7jFA2RqcV7hbjdUFq4
Ya4CYfZd9M5QnV21UqBgDdf9Mxf/o12sN/3EYBCzxhWz4oJ11VMA1cZibK7q3aVh
4GajrZWRa9SiyzIqT0IGmpQatispXCdyo4KvCwgw1brQTTLs/IGxYO/VACO7V5C9
GOFz+amL0dJCf5XYDGeQ69uVfcgLeNhKMs1S8dEImGErf6J+gPk=
=UdbV
-----END PGP SIGNATURE-----

--gft/vq9VWUrba0rI--
