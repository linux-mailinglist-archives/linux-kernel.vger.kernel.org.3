Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F0146B5A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhLGI0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhLGI0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:26:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D614EC061746;
        Tue,  7 Dec 2021 00:23:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so1603787wme.4;
        Tue, 07 Dec 2021 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q7CdkXM5ySsAfZfCm0NSIMCVpyUhKcfZPcd8ceqOy70=;
        b=hJa1avq7XULBYyh0e3gCW424NuCPlrQ44yC4htKI59AZnRgVjW/1LZZzN65U8joura
         3Iuz+FJjjk4rL64040Aa4B7TKCu6S2x2eRILCBOWgedcNXmcby5PxN2xmihJ91xJteZ7
         ZUCVGjaJUZzOvRHajeIPsRdDYdZpfAA+4qs/PKzCePbmVYNXiB10vYKkxz0tE78M4vFv
         06aL8+zg3heC4UqF6+YrxHIeizGPqLcQUN/dgND1j6pKLhe8PTs5TQjYtyTT4tS8gVMx
         ywz+bLy0rsCpNGHDC7WPio4FC2C4tK1dnpGmpJOrSBL/RYvFjttVWDgFIECKuATyTOb/
         9hPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q7CdkXM5ySsAfZfCm0NSIMCVpyUhKcfZPcd8ceqOy70=;
        b=K3h46kGwCYDpelYmJ9Z3omyRuBSQ0Eb0rw8nykLmhz4QZwgEIt8eqJWiK6T/I0q0/A
         ZdRwijRKvXV4+t0ATB82kNxBmeZM/JX8mvl7QOuMcF6/z6RLlInW4Bhc7cGv4VaYw9/3
         9j3jK9Z2v0Mwc/2ofnR/xy9uZEPyR9KUHDQLT1qyTkFuN8DJG1wUtKNuYhiIJIdiWoNX
         X1LQn7Vln8TYZBochBKgiElAR7trXC7+o2ERvVjsNk1ewTjxnt7gfqXFrvKoWjcwmGOs
         ggB1A89N2MAScx5zSsDZPTekQndl0xXPKyjSY0txXNHENOhjP3zChR2uLJLGVQIDU493
         chXA==
X-Gm-Message-State: AOAM532/mkKcnXPC+VusgPzx1vFxB8u8YtgAwPPEnz/KPZEdW5Q/wFSw
        p1s+Rvaa2XjI9ycZ01RPKzI=
X-Google-Smtp-Source: ABdhPJwWwKOV0/Ek/XuvkDLpi1WCs0EGXw2vL+5HWfDlDGWFdNe7ZH71V4oDoYUPaxD1kzkhqjZkuQ==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr4992466wmq.54.1638865394495;
        Tue, 07 Dec 2021 00:23:14 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id l4sm13346813wrv.94.2021.12.07.00.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:23:13 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:23:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: ti,rti-wdt: Fix
 assigned-clock-parents
Message-ID: <Ya8Z7gReKtZA+BGw@orome.fritz.box>
References: <20211206174028.2294330-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f2LNv0Yes4TwKbbz"
Content-Disposition: inline
In-Reply-To: <20211206174028.2294330-1-robh@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f2LNv0Yes4TwKbbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 11:40:28AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the ti,rti-wdt example
> has the following warning:
>=20
> /home/rob/proj/git/linux-dt/.build-arm64/Documentation/devicetree/binding=
s/watchdog/ti,rti-wdt.example.dt.yaml: watchdog@2200000: Unevaluated proper=
ties are not allowed ('assigned-clock-parents' was unexpected)
>=20
> The problem is the schema has a typo in 'assigned-clocks-parents'. As
> it is not required to list assigned clocks in bindings, just drop the
> property definitions to fix this.
>=20
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: linux-watchdog@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/watchdog/ti,rti-wdt.yaml | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--f2LNv0Yes4TwKbbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvGe4ACgkQ3SOs138+
s6HfaxAAm9ukYVc7Yiq88IJNZmyMn/KYhRVrwVJUeup3t8MMB775s5wVxrtc2emF
vS49IaPwwaHzK36kn0PRr6btkSPB66Ejnj+DOz2HSxZHYw86KbifyAmDRCq/LGjP
KkyW5SbUi0crMWoqTAxLdgLNWeR5DUdHdmuz7HXA0FlQdjvyuRZZeqTqFgz3+c14
QGjS5nLqrF7xgymXQUGrR+WJYfrh7SDodMGys2Oag2GoXxbdJA6/JNXYmN/iaDmZ
rXYmWBGGgndPEXjtLgA4gwK+e59k/F5fpbHY9Jr8jz14WlbDVhx5jyZTGiHHhlXW
X8TbQEWEw6s5EUWAYgHstBOAZRbPAvDl+VbLAWz00rMg1LZub9fz3gyH7wVqwEjn
UIJRvjz48VHmKsdGRk1patxuQGe2Z8GhNUflhn2wM5mYQ6MoT2kiOEYLm8UMUBlJ
izY8I5eM10EnkDd8ckhR2YTMTiNUhbNLbVqJL6MRxGTooVH04ZszdXWoNGrlwoIx
jTpU5b7VlCrcu4mByqROQzrjGjifWorL+vJ05gQzYzTejv2n8G1VpXKi9z+/GV0m
O/XbvVMw+2kV7pxfjFtOdYctIDB2gikuHJQf6if8zte+aXkpoiZOIF3K9gle1Oxo
Hc0xCzxndPjejNeF1v/qJju1vkgE83XUXF1jNEFv5fyT0SLGahk=
=g1+2
-----END PGP SIGNATURE-----

--f2LNv0Yes4TwKbbz--
