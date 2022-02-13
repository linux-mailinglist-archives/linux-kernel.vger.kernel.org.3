Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE034B3CA0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237515AbiBMRt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 12:49:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiBMRt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 12:49:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DD15A098;
        Sun, 13 Feb 2022 09:49:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C89D761217;
        Sun, 13 Feb 2022 17:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023AEC004E1;
        Sun, 13 Feb 2022 17:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644774560;
        bh=OewMStTlzJ/2x6huYiTR8duZ0S7XUhG3RQPHtIvN+xM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M6st7DfIaFodwCgloRBE0fkPjlwRbIP20pJGpErXhw5hDReDYuq28Re/KLir7yiYP
         UYLzBy3T/GQ4skIhMQbxHhg0WurJgLKBWcRstsel9tUirPdxexJ1zVFpyqmzipSqAk
         WVVlX2au5jFDNClybg560ecmnH629WaYi5K1yM3RG28vFwonYR/H0/ViSZ6QhgK4Qa
         rJhz/K9uRnKsdJhbn0DtoUiFDSbdPQuBx9yCgo+/09ev7NRdaNaWVOYJTZDnTOJ54O
         0NJ1ARnIwaMQ/3i5QeGTv3vXL4GbpRTOd38PvllbX+tRZgtAgB9XU2ES5CK7Kq0sva
         0rhGjRUqyvCSg==
Date:   Sun, 13 Feb 2022 17:55:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
Message-ID: <20220213175559.46e8dee2@jic23-huawei>
In-Reply-To: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
References: <20220210135522.26562-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 15:55:20 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In a couple of messages the constants, which have their definitions,
> are hard coded into the message text. Unhardcode them.
>=20
> While at it, add a trailing \n where it's currently missing.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Mostly so I can remember what is going on with this patch,
Nuno is OoO and planning to test this series when he returns.

Given that I'll wait on Nuno's testing.

Thanks,

Jonathan

> ---
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

