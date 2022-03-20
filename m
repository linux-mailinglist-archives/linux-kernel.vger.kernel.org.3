Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC74E1C59
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245403AbiCTPtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiCTPte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:49:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF71240902;
        Sun, 20 Mar 2022 08:48:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63D6EB80B95;
        Sun, 20 Mar 2022 15:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFBAC340E9;
        Sun, 20 Mar 2022 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647791288;
        bh=gF1b2RX+zCM5oK/wIC5CVU46M+hHdRSc8f+Jo5E+QXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jOTc3Ka7YW3qC4S9fMrs+dNMGWeuTnjTNOuVqCMwIcZkwGwQ8jHm09WY/P2cTMstr
         MjDl9MffxLSmYPvV9dso9orb79Z0FrxPm/SSM7Pc//j+UNFW5lRPU/Xc8+WVyUt/XJ
         no2dn2HTT/0AIl1DdFP3B8FK56lS543ulIUSRltKYDhregPxT/lHFzk65FLmOEg9fa
         GAQZJc4q8u8F8BkVhuez6OQbJgAm4n9ExJJ9zjpxVxQm0mZZu7MaJOy0n4XR+aJMNH
         0vwL1dcz7cf4wFurwK1psZgpc6tsOSPyEA2UJ/bRiyposKsnqo0cayEn3qPZYqj7eR
         u30aGmkuh2+Cg==
Date:   Sun, 20 Mar 2022 15:55:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
Message-ID: <20220320155531.19e13a5c@jic23-huawei>
In-Reply-To: <20220307203606.87258-1-andriy.shevchenko@linux.intel.com>
References: <20220307203606.87258-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Mar 2022 22:36:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In a couple of messages the constants, which have their definitions,
> are hard coded into the message text. Unhardcode them.
>=20
> While at it, add a trailing \n where it's currently missing.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Series applied to the togreg branch of iio.git, but that will be rebased
so for now this will only be visible in the testing branch intended to
let 0-day poke at it.

Thanks,

Jonathan

> ---
> v5: no changes
> v4: no changes
> v3: added \n, used %u (Joe)
>  drivers/iio/temperature/ltc2983.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/=
ltc2983.c
> index 301c3f13fb26..94d6dd4db47a 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -409,8 +409,8 @@ static struct ltc2983_custom_sensor *__ltc2983_custom=
_sensor_new(
>  	new_custom->size =3D n_entries * n_size;
>  	/* check Steinhart size */
>  	if (is_steinhart && new_custom->size !=3D LTC2983_CUSTOM_STEINHART_SIZE=
) {
> -		dev_err(dev, "Steinhart sensors size(%zu) must be 24",
> -							new_custom->size);
> +		dev_err(dev, "Steinhart sensors size(%zu) must be %u\n", new_custom->s=
ize,
> +			LTC2983_CUSTOM_STEINHART_SIZE);
>  		return ERR_PTR(-EINVAL);
>  	}
>  	/* Check space on the table. */
> @@ -1299,8 +1299,8 @@ static int ltc2983_parse_dt(struct ltc2983_data *st)
>  		if (sensor.chan < LTC2983_MIN_CHANNELS_NR ||
>  		    sensor.chan > LTC2983_MAX_CHANNELS_NR) {
>  			ret =3D -EINVAL;
> -			dev_err(dev,
> -				"chan:%d must be from 1 to 20\n", sensor.chan);
> +			dev_err(dev, "chan:%d must be from %u to %u\n", sensor.chan,
> +				LTC2983_MIN_CHANNELS_NR, LTC2983_MAX_CHANNELS_NR);
>  			goto put_child;
>  		} else if (channel_avail_mask & BIT(sensor.chan)) {
>  			ret =3D -EINVAL;

