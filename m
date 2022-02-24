Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C401A4C2D46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiBXNh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiBXNh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:37:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C54606CC;
        Thu, 24 Feb 2022 05:36:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a23so4414497eju.3;
        Thu, 24 Feb 2022 05:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a4atUVhY7Q3Np1v8qRgXZgRpRVagKOvkVRDQTQf2eqc=;
        b=TsrQqzlvg5sPaqVnANLFr4Swio6iAfjcY8OkZGJthP4u5pDiG1SU6KyEpuVn2aqRlE
         C4TKqUgtsX3jAlmafapjeXHEZE+OZNwsiuYBgAwj72wUBF7AgZRstMp6DUjfteyxHncW
         NnyBFlQ/7+ZSHKddSEiazEt9Hs7vyWJdYArrzYvRdecCs95HSyxmJJ8EXkodwv/FElW8
         q0JtnVost+matEBTA3B+WRhgl1x3h/uBXIum5+WWujSetM+2RHLfqx7V/P3WCcT8MMek
         Tfw6LwrATlsEVq0VXuu2XdoDliecPJQkLjXH0WEaExhF/e8M37jKy+4tZ4jmxHn8zVq8
         HnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4atUVhY7Q3Np1v8qRgXZgRpRVagKOvkVRDQTQf2eqc=;
        b=iP5cBrmp86ZYLeBmhMC+n0CKV27jirSvvxkQ96R0CWzsIuvMdtaavuSI6jVC6XGrnz
         06YWQ8Iwk/IwE6dLWHsZGY4fcstsWltIpX8tLZFPN65NWTBNhclDJDuZ1ylql/MUU5DI
         CHV8aFNqaI9qMSYtHIhy1Hp8LwHDRbb4NQa2Np7RVQ87wKHGUjmjxIpEkSgyLfOiAacd
         9GgFjuIt/boDZ9oooIogcK3z875XG0WyTuxetp+IwGSPhZwpttwnZyy/f7ThQdOgL3hr
         EUkZhLFt7gSsg8z63wUerBfV1sySnj5jcGHWaW1SObkflIH7fu/Ex7vnsoS3klugXmYD
         XiYQ==
X-Gm-Message-State: AOAM533TbvbxiCUMp/Lctwxz3dTlrY7MzbtL9P0TV+qcPGTo7YnYCP1L
        NKv2uS2hgpVSu5pPcx+xxa0=
X-Google-Smtp-Source: ABdhPJxUKPQk186q22c91gQ8UHlxUDF2H2Gh59Q7SuO2GmFKXg6SoXXP8SXvznxUOrbuXXHyu0Ad/A==
X-Received: by 2002:a17:906:8681:b0:6ce:d45f:1689 with SMTP id g1-20020a170906868100b006ced45f1689mr2236091ejx.183.1645709813917;
        Thu, 24 Feb 2022 05:36:53 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t24sm1338481ejx.187.2022.02.24.05.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:36:52 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:36:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: vt8500: Rename variable pointing to driver
 private data
Message-ID: <YheJ6OuXOvmQmUGl@orome>
References: <20220211023741.24061-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fvX6B4WTRnbEq9u+"
Content-Disposition: inline
In-Reply-To: <20220211023741.24061-1-zhaoxiao@uniontech.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fvX6B4WTRnbEq9u+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 10:37:41AM +0800, zhaoxiao wrote:
> Status quo is that variables of type struct vt8500_chip * are named
> "vt8500", "chip". Because usually only struct pwm_device * variables
> are named "pwm" and "chip" is usually used for variabled of type
> struct pwm_chip *.
>=20
> So consistently use the same and non-conflicting name "vt8500".
>=20
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  v2: Rename the "chip" to "vt8500" for variable of type struct vt8500_chi=
p *.
>  drivers/pwm/pwm-vt8500.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)

Applied, thanks.

Thierry

--fvX6B4WTRnbEq9u+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXiegACgkQ3SOs138+
s6GdmxAAmSAgLg6QJR+7re7+K9/W72gHisc59W0pddn8TUm9wwMvQbsXDaTRN1WP
HZTxhvG95mq2anQgM1ZdUBnYqDzr7rD01+02ccMaGIPoBVqYsctfuyvIZqzeyrtx
nyeg0cjPXJW6BR0OrCX37lDUuO5NCO0XRuqcExCYg/ubq3R1sN2P0oNh9vnlRLt6
T9YAn94TSmbM1J1dlPdEW39spWLDSRRyIX41Lvpm8tok2oyRz4quP76LxIBMqog9
7iY9YIE7GPxgv2C4W+xZ9T5eRYYsriLLMfbBVNxW6TBQfFr5A1jx2bLU6aqXhypA
jIXoyx5NpU+CDTvK0HxGKhY9uuX6a/8GsjXkn5yleesi8OWTiz0cizD7jnBMnUTk
apMnPAT8mIR8L0j0vrzvmb8cOz/be2fhTuuPxMafz1redG4WLhYRBuqlhdPkrEs/
+JsHVgk04bPblieg5SkPqIuXcnNZ511eZHWGAhJw2BWgBalA0geFwQW4piO1dhBC
Btuq5ijYyyyCRP41tX7GyxcVdf24CqqCTN35O9stoCNV3l2FwRHcePxMyJXwx400
PVMBKJxZX2Ei28fkknEqaTJfnYrp2Z5JZXUb2i/vsD0FePpPZHb56cJeaw6jTzw/
IRkoDnHcEYDBh6ea57cAly2QxynillhvSWRCSLAP8+NGFhnjPzY=
=CxEc
-----END PGP SIGNATURE-----

--fvX6B4WTRnbEq9u+--
