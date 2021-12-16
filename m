Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8184775C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbhLPPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhLPPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:22:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB16BC061574;
        Thu, 16 Dec 2021 07:22:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i22so15044794wrb.13;
        Thu, 16 Dec 2021 07:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N9lKomucSEtgpalX3CqQQafa6o2fb76nBfcohaSv2i0=;
        b=RiN3+7h2+dS25INC7Gf8BPfoVCcvRFVUUth9najkqFWtZJ2s8mxTX2aUm8atU5pMez
         AbW7FHEhmPgLXQk9znLFEESxZDcVJ6XC6FDF6ra5By+L3VlxNN5HWrzvj/7oINATJVH5
         T4PF2Kiot4lISiQvsUdMBPAFGp5adygEESAiVXmYM7unQqdBh3ueVghRDHqLHcii0VCs
         g82F3adcpyxbequgS/D+baMYsQLAEbFQNUgtDLxFLem+DkU+Qm7TFR2mg/Z0yCrrrRMN
         FK7l0JsP8J9Hurf3AnTxjix62NgHc0tKl5/97nXE0yTxhvy+LGCJrG8EUUtusW5b3LhD
         OwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9lKomucSEtgpalX3CqQQafa6o2fb76nBfcohaSv2i0=;
        b=7Znl8MeokIlk5TGXaN/yvXhdGjEwh/ogk9KLqASVCh3KYydv9pUx6XiznhY/diFTvQ
         GGprux9lTJSkQxvLbtgOavVy9scJ1pAodnYgHrnjzcGU0w/tO5C2gcKjhh8czxHiaa/O
         SKUEt0cq0m8KNjnJMIQM2hwFYP0AhEFgZU1pNH2ueQ2nyOvUMD+BP8mtfwD14vIdzs2j
         E49L7ll/TkaW6OWh2for1sD3YZb0GxxKKjXVkJy3bbnhcj+6XBQCP+2sy5GdUKuyy5UA
         1hNHmbhhwZW57cB0IuGOUuyp+Q5xkGtZtJeynycwOrHcY/1RLOFlZJjvMjhkapBGB+h+
         woIg==
X-Gm-Message-State: AOAM5334ODHxyxTaOVroizNuyn3mZpzPh2VJD/ABHoyp5bRIkQG72prr
        AsZa+EJHzQ/WSLqjdkj6i1E=
X-Google-Smtp-Source: ABdhPJxx/CpIEkfJ7mExMh2hQOZZomkvt7McXghXR6da0L3qO+ST232+y0rAS8ozWZflFbx29kYq1Q==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr8352497wrn.93.1639668145306;
        Thu, 16 Dec 2021 07:22:25 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id w15sm4921670wrk.77.2021.12.16.07.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:22:24 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:22:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 10/22] ASoC: tegra20: spdif: Reset hardware
Message-ID: <YbtZrOtns+Fk5tEF@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kmzUbGK/nRGQn6lv"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-11-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kmzUbGK/nRGQn6lv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 05:37:13PM +0300, Dmitry Osipenko wrote:
> Reset S/PDIF controller on runtime PM suspend/resume to ensure that we
> always have a consistent hardware state.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  sound/soc/tegra/tegra20_spdif.c | 32 ++++++++++++++++++++++++++++++++
>  sound/soc/tegra/tegra20_spdif.h |  1 +
>  2 files changed, 33 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--kmzUbGK/nRGQn6lv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7WawACgkQ3SOs138+
s6Ef7hAAvN95siU/ogWUCn3U5jvV2xqxZXBwjimV0crLNHF0/o0HMkgZpuSC5RtK
G6Xk2Od6WsmYkIi6fr+YcyQ8dywvI29z7eRg/nbyEduda5lFZKVXCMSTUt1wZmac
8AKSgtpmXhNRECD2+rmES3sc//gh5mY4PrV/DNY67jFvo7IzDuSUeWoq9SU6bjOS
VMFyC/LD6ClzTWHxntB9LctBRk8E9L/tGF/j7vyHTa2CS2Fh/o0dD7Y8W6pnNgmN
0af4NDx5gox9CTwmCd7x61kU3Fw22v2AujNAGbQ53pjasgtlaH9Eur0zE17Bnp7r
f0l3Zp0CtVvMb+WPygM+IR1+ZmxGqL2ohc3SoZqswnNQDNljlfqoiMSzx2yEGrKe
1ZLDxDZLSzTHKCnaJEFhDUzlscGqMBMVOibheflHwWfxJk82nkzEs+ac4FA5Xmh8
a1VEfTQ0kyfJgCiDxAt3H90mGAgofnuyfcXgP9s2bm1NdYjXBE4gyZ4NzCT878kJ
ogE9/DrcbPI+K3sq/OjLEZrZAjwLOAf1OHcmF4QsFjJac7CNuJKLoTgDsN/yB1jG
OLzAqPpIVFzh4uf+k4liyoFAlDSrLpR3iAF9p6uWuCdvD+hQEgzuty128FS2AwA9
wnjLdUHoMcsbMAYI156l91YpYswWloVZHZQYbvRbhoKfsojNzs4=
=NQYq
-----END PGP SIGNATURE-----

--kmzUbGK/nRGQn6lv--
