Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39AA49D7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiA0B7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiA0B7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:59:06 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A20C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:59:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j16so1215099plx.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 17:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3GFLFPcC+bi0kn9hGKkkl3a/+Bvg4fCt0af+T2OF+Ng=;
        b=GSfqPeOdRikTAsFSmLGUoF8iwk9otUGYBcN1yQ/IgSjUK9iMzeKY0uKgW3TGU+NPUE
         yQ3s5TGJcR2VziVPFPDvRQ5uKz+WcJGA2paZM9RsLY/jHO0srojX6K58NiS9oQH8xIHV
         h0i+ceDnK1kDRyjmz7V/j9SAz9HQ1XIH+sVCqWCZ7mxe2yLK71ZG/pCYOUB3L7rVibP/
         5KZO4ut22yOJjrrSjDfQurSt7MsvPkbYULYTUq9FWb5m09TCwGiYYlMA0qAe21Tc0qxJ
         R4E70qsPC7Y3tpgV6KI5NqcXR83hIjjN0rKmfG7EA9j3WcrdlYH9NJ0EPzwiEqzrsoNz
         UV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3GFLFPcC+bi0kn9hGKkkl3a/+Bvg4fCt0af+T2OF+Ng=;
        b=K3bSKVegJMTmUaTspIPla6MjPlyqR1u3wCSHumdi9jxv+pjmdQjwtdLg2zKMY/CJfx
         +LMLr0ePVfO2vawrmFGUS6tnNmpZeF+cq7yILDPC9d0ki0he2QxvAI5R6ExHlIyXh1Bv
         3UX9+CLIb3H2tFJNjBGU1v15bxZxxYeXQL/MGKvncb2SP5Mspu8fSKXaDC6uQzG4qGQY
         71H503d5awjmQ1VBd33JRU7YRJU4xIQyBNJ20p/Lj7KKtEC8SqR2VQ3DHTR+T7fARYT7
         GYAlN+TOnx8/JnyuN9FBYQV7qqMIOx8gdLv0BSSt7hdqx0dStgGwdXcdZdb/iaksZnfc
         Wnvg==
X-Gm-Message-State: AOAM531sR6JSRigQrEzS6mdngEQWgSXG/ttyFcipQVnKC+LEdDpXVsfb
        UNaSkMdyD+GxFWKQ+ysGFsj35Q==
X-Google-Smtp-Source: ABdhPJzn+kR0m6Mwsx2Lqd1H0Lj6nsc2zGlOFUsvqF6qo0DEjA8pX/GyG2wJU+z4wFBwv+57VNIzcA==
X-Received: by 2002:a17:903:11c9:: with SMTP id q9mr1545989plh.36.1643248745144;
        Wed, 26 Jan 2022 17:59:05 -0800 (PST)
Received: from google.com ([2620:15c:202:201:7499:b258:18ee:819f])
        by smtp.gmail.com with ESMTPSA id l23sm17954421pgj.20.2022.01.26.17.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:59:03 -0800 (PST)
Date:   Wed, 26 Jan 2022 17:58:57 -0800
From:   Benson Leung <bleung@google.com>
To:     Benson Leung <bleung@chromium.org>, cychiang@chromium.org,
        groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        pmalani@chromium.org, tzungbi@google.com
Subject: Re: [PATCH] MAINTAINERS: platform-chrome: Add new
 chrome-platform@lists.linux.dev list
Message-ID: <YfH8YSuX+GICPPyJ@google.com>
References: <20220126222233.2852280-1-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QYJETpWnJahCqHhM"
Content-Disposition: inline
In-Reply-To: <20220126222233.2852280-1-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QYJETpWnJahCqHhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 26, 2022 at 02:22:33PM -0800, Benson Leung wrote:
> Signed-off-by: Benson Leung <bleung@chromium.org>

Attention to cychiang@ and groeck@ who are both listed as M and R below.

Be advised there is a new chrome-platform mailing list spun up.
https://lore.kernel.org/chrome-platform/

Thanks,
Benson

> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..cad7b0fff9f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4537,6 +4537,7 @@ F:	drivers/input/touchscreen/chipone_icn8505.c
> =20
>  CHROME HARDWARE PLATFORM SUPPORT
>  M:	Benson Leung <bleung@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/lin=
ux.git
>  F:	drivers/platform/chrome/
> @@ -4544,6 +4545,7 @@ F:	drivers/platform/chrome/
>  CHROMEOS EC CODEC DRIVER
>  M:	Cheng-Yi Chiang <cychiang@chromium.org>
>  R:	Guenter Roeck <groeck@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
>  F:	sound/soc/codecs/cros_ec_codec.*
> @@ -4551,6 +4553,7 @@ F:	sound/soc/codecs/cros_ec_codec.*
>  CHROMEOS EC SUBDRIVERS
>  M:	Benson Leung <bleung@chromium.org>
>  R:	Guenter Roeck <groeck@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  F:	drivers/power/supply/cros_usbpd-charger.c
>  N:	cros_ec
> @@ -4558,11 +4561,13 @@ N:	cros-ec
> =20
>  CHROMEOS EC USB TYPE-C DRIVER
>  M:	Prashant Malani <pmalani@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  F:	drivers/platform/chrome/cros_ec_typec.c
> =20
>  CHROMEOS EC USB PD NOTIFY DRIVER
>  M:	Prashant Malani <pmalani@chromium.org>
> +L:	chrome-platform@lists.linux.dev
>  S:	Maintained
>  F:	drivers/platform/chrome/cros_usbpd_notify.c
>  F:	include/linux/platform_data/cros_usbpd_notify.h
> --=20
> 2.35.0.rc0.227.g00780c9af4-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--QYJETpWnJahCqHhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYfH8YQAKCRBzbaomhzOw
wivMAQCLpmCgTDVvn9/ELenRMd82kPM9A5Fuo1cmUim1kDr/qgEAgtoXh/T4Oy9b
WaZcSuqOtPOfmxC6qT8jMkZGmyoSwwE=
=oPCa
-----END PGP SIGNATURE-----

--QYJETpWnJahCqHhM--
