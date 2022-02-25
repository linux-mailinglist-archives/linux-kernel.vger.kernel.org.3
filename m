Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94634C457C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbiBYNKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiBYNKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:10:30 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838CC1E7A43;
        Fri, 25 Feb 2022 05:09:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so1662916wmb.1;
        Fri, 25 Feb 2022 05:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2vH+wdo1zZSlCkX6ymcEDv0Mvliw9n+m3623hvmf1xs=;
        b=cScqFsKxDDQbkO4dyvsF3zUzh0LrQ34YStyHEtoe1If6m2XxgehSmIVZsnjn6N0eTQ
         6dQp9wYI7kzmDm3eSngRjcWGq/sVEZrbQMtaFwibvq6TK9orwbE6AxGBcXQ/mdOCvH3y
         7vzS+OBtdHSkR7K6DhZFJHThbPb4xiY7bW32SBD/4pJEd0M6e9GDU3LbVDMc8sDxrTeP
         1eGcnwrNndb7I/jVrkfYxUogCpucGMFE4uwmMyMT8ZItXV8grR5jIyRNy7jUZ0z/jzZR
         csaYo32EVaPgXubZgYcQyAIDGaEzE6fiu7ta52oOPE4+mYOroi/dEiN7C0Qt18ZhAi6N
         MNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2vH+wdo1zZSlCkX6ymcEDv0Mvliw9n+m3623hvmf1xs=;
        b=IcbkcvO/Ia9px8t5IiACNsLyfVTv2Ske/cCXtnGhfLYEVXiT0h2y0TVXDRIvTmyuD/
         DEiPd+wnV2IHnfQ4cO63Mu1JyRaaPff9eKiyLt1KbhJGBloLoKJCuj/bzR+ioze2BtKK
         Re0FSpfS937TSKFKReeMqMoaZYlB1epox3Z5TZOWydZEwQ3DVHs2j6sEdQtW2riLxec5
         Efnm16zkj2ww2/YSO7syj561V30/JRKs3sBfrXqHRFXTMY/jUlTNNom9YKp+6qqm2rGu
         j7KXlMzcVdOfL4SAeQAT3FN0McDB+EZWmttByWMexfPo6/dCo839UFJ9Aa0V4x916R3p
         V3RA==
X-Gm-Message-State: AOAM5306+Rk4+TWStLJODV4dMkxFYYYQqgP6SUgmZMO0+jA60eOk09WG
        OjTNtRlB0DUJHRfalsS9rVg=
X-Google-Smtp-Source: ABdhPJwaW4mB1jJYszYmVuf/mOCBDH8wKGGL9kiPQxaRbyxQLUeYh+XqR4e11x74+/qykGlDVLzJaw==
X-Received: by 2002:a05:600c:2319:b0:380:e369:83ea with SMTP id 25-20020a05600c231900b00380e36983eamr2674993wmo.45.1645794596964;
        Fri, 25 Feb 2022 05:09:56 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id e6-20020a056000120600b001ea9414f2c3sm2236362wrx.12.2022.02.25.05.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:09:56 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:09:54 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     jonathanh@nvidia.com, digetx@gmail.com, ulf.hansson@linaro.org,
        christophe.jaillet@wanadoo.fr, andriy.shevchenko@linux.intel.com,
        jckuo@nvidia.com, caihuoqing@baidu.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: pmc: Add Tegra234 wake events
Message-ID: <YhjVItNqI2QpUQs/@orome>
References: <1643090262-26127-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uE4ihRcxPjwmpkFm"
Content-Disposition: inline
In-Reply-To: <1643090262-26127-1-git-send-email-kkartik@nvidia.com>
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


--uE4ihRcxPjwmpkFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 25, 2022 at 11:27:42AM +0530, Kartik wrote:
> From: kartik <kkartik@nvidia.com>
>=20
> Enable the Tegra RTC alarm and power key wake-ups for Tegra234
>=20
> Signed-off-by: kartik <kkartik@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--uE4ihRcxPjwmpkFm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIY1SEACgkQ3SOs138+
s6ELNg//R/Jd7IYNPAHQ+SZSJyl2uFUbGtSNrT46r/OqGyCETQSF5zzJqltghtIT
ASYZyO94Y1PcoK1AvQksFI7wWIAuGz/qCxjvcwdi/84OaGkO7E3pok5/xJxKHpxH
lcSKqIBVNtOiQpQLpUauoaBktXgvfDCUJ40Zky1KXTQxpDgi2Eq3lx2GTFtAKMPy
8uEmIuAkOLWr0gPJKwuCgPlAoJlmntTUJy/K6RzTcezQhayyqltGkimiysvtYxfr
sVOxcKZSvcZuq4CgF0HfhtSuR2h6LeWN6W27lrE/eKg5wHIE7pfShxPH7FV3AmI1
cizzim1WtZcO8A0+U2gSWmOkL70KVd2fqfJYOlO5S0jVASO8kjDe8GPIqTH7Wo9U
Kgtrph8Atwrqj/zJ7GV6Vc1OTdOjP09GAyCOdPMS5J6Zsfyn573nQxvYfvw4lWXP
QOqhF/UGEdhWkym0r5BpNkKfTWEMtFjfGnOznqcV7Oom66C0LNdGFK9XflxQoZ80
PmJLn5DJzy3cG8ApFcxR6YR2OcMQt0iNY4ggvTX+rBWEh/lLtenV6cRErzhmoBK+
bNnQ5k+pab3K6wBrMlYSTsMnsBYC4U4g9GMKZBy2DakjX2B+dt94AxSzQGCOrlb+
nj3hSNWCvEHTUYj7QSsJCgxn0JtDU7L0pi/fgJwSmfnIQK41cys=
=Xr/P
-----END PGP SIGNATURE-----

--uE4ihRcxPjwmpkFm--
