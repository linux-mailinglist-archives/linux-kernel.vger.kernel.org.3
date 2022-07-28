Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A505844D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiG1RSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiG1RST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:18:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91DD6D9F5;
        Thu, 28 Jul 2022 10:18:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ss3so4229610ejc.11;
        Thu, 28 Jul 2022 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KHxlRISvchYZZeG5QH2xEBKAnceyIE0jpB0uouPZJ3M=;
        b=UiLVK+qCT9gY8jQM2exwGLSaKC8y9LZPiXE8Vdv8FSaRYZM4F5MaUHQomst+47Npfb
         7jmOaJIuvS01O72aiVRpNX+83DCdnchVVFnS1ypvcPfrT887AwbNLoKFCpTWkGqtga8a
         xWgwVrY3sxFXNjoB1TPzDVEQvirMpVcjzApHboWIT1+07V6iTEdA+KPlCXYqm/Zb+XKT
         WjHkUiYSIMR/igapknU2FughwE+GVRTNijsB6itaA+Y3L4wwabSRiZcybxKce0pwxH1Q
         rsJdKsAmTxIwo6IvMBtrIEqBUSUMVfGvqpbCf5r9beXhlehsCKtkD4Qtk5mnXRajC4bi
         YBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KHxlRISvchYZZeG5QH2xEBKAnceyIE0jpB0uouPZJ3M=;
        b=XYlwTOSETUi4dZm12ZKJlNHXVQlRgCejj8ax2+xNj8e+t+iQH190a92Xq9riMkhpDC
         j7xiH/jpOWRtPAeJ9KOQHQjYj3NOk3cDvEZoldW0nQ2EIN3Qgz01Ts5rCVDS54OKbFal
         4m6d5zizTVToaGfDDPmIXH7ep8G9w9YC07/UpyW+2IOdOvVUT9PdVuIqFtt+ihfJJv6F
         S1eFVY3+DTxlLSHm8+WDHOadzDFIsHG/0lm0R5DKvZxtyHL1OC0LXcA1l3JyHfa8JFCb
         +edSglp7QcLM0FGSyTUZ2Ln/pyQnsBdHpo/FARz9BuNNVo2exVJy4iOKeKMDC1Oe+AGX
         E5/Q==
X-Gm-Message-State: AJIora++wqajzV88DPYs8+UY22Yfr38AJ+RNgUReF9IPv/pJWYXHwPfo
        kfJYetm+4NSl6MM1pUDoK+I=
X-Google-Smtp-Source: AGRyM1sRwcH9Rq6esei6oEYWfbW2vNHMithUlyMPEYkVcVTbjbZzOzisljAncisy7T6nA0i4N3XssQ==
X-Received: by 2002:a17:907:9482:b0:72b:8c16:dac0 with SMTP id dm2-20020a170907948200b0072b8c16dac0mr18699523ejc.286.1659028697120;
        Thu, 28 Jul 2022 10:18:17 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v22-20020aa7dbd6000000b0043d06d80d27sm420703edt.86.2022.07.28.10.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:18:15 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:18:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 3/8] MAINTAINERS: Remove myself as PWM maintainer
Message-ID: <YuLE1urkBjTjGDHI@orome>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-4-lee@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mVFp3QKFFA/ktDAF"
Content-Disposition: inline
In-Reply-To: <20220714112533.539910-4-lee@kernel.org>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mVFp3QKFFA/ktDAF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 12:25:28PM +0100, Lee Jones wrote:
> Thierry and Uwe are doing a fine job, leaving me surplus to requirement.
>=20
> Happy to pop back on-board if anything changes in the future.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: linux-pwm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5fbbeec1fae6b..67ae1329123fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16465,7 +16465,6 @@ F:	drivers/media/rc/pwm-ir-tx.c
>  PWM SUBSYSTEM
>  M:	Thierry Reding <thierry.reding@gmail.com>
>  R:	Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> -M:	Lee Jones <lee.jones@linaro.org>
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  Q:	https://patchwork.ozlabs.org/project/linux-pwm/list/

Applied, thanks.

Thierry

--mVFp3QKFFA/ktDAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLixNYACgkQ3SOs138+
s6FkFw/+PcxskQg0NtwRTRJ2/5pnHx9biMU7zh+TESzFS/BnDF9fg2d2R/RC3y+g
Gs9nmk0rvGTHdhXEzdK6jXo6QZKzw2Uk4UyFsVUE0ob15emegvBrutiHaDIMKecd
dueDSsbwPbW2b9hvrCAUoxiCGGzxcaWWkkm6J6jb/pGtS2l59+HHEW1SKY0yE4QL
HRJSrI48p+HSrvmrzdKkyXGgh+7W5KLH2KK9lTyyhzwjPxx+hFTjzmChnOA6R1C6
wImvXLWC9Dl1NZUYLfidxLhuu2v2JCwa7nIrENd+5flXgpuy0oFTNEB98TwA8Jh6
9OuJ+mnUv/+KL7EoS9XbdZHEze5KDT+B8DrWDAJIJAHH1XmjKwlbuP8odUVgEEUp
ihDgphEi/UEZrl+9IELyVQE44RJZtOceBY/FTn9HTvhbTQBdP3nQZKRkBoKRqoot
xCM8TLO0laAfSCpKKHdH4TEf7xBgtvZCdW91C2vcQOyycvUlx3u5Fp2Zohf9xEGg
XPqZ2ncQFQ5oh02Bk7WRRbJ6f3b0trrDUete/0e3VUiBMim6qNlnq5FybTUVK6ou
ekEctHcsoEnc8ku0yZgpMsBLTeoXCS+Sie/+FfcG4qa/igGbqEpkPGp8SgwGY+ed
zSfuao+KVrSxk0mtZnUe+uiLi9jOakQPlFzWQ2cM4AAZASq706U=
=jft8
-----END PGP SIGNATURE-----

--mVFp3QKFFA/ktDAF--
