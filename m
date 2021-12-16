Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81224775BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhLPPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238434AbhLPPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:21:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3DCC061574;
        Thu, 16 Dec 2021 07:21:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so18356053wme.4;
        Thu, 16 Dec 2021 07:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EDnhGOt5yt/Q5eHlMXrXDwNEP6fA2fIbiM7ZWpn1ct8=;
        b=VHbrRdbkAMmFFx50VrmdFx9wt32X9gRxBKtODT+TJlanscSWIdaAF192rfa9sWV/cy
         tVzlZmLMyzQay1zy8gagBymEOoZBs5xF6SmJD6a08yxZyWVOW4a2dBCDz3J+Zn2wEIja
         ylRxqj7soRPq0jFA6bIkTqWwz8NLSEsHwfuWjyqbeQwL+O0+nEU0fS2Kkls5J59wF+fr
         3pytUFm7qVuXCqBXBNvvu+ArGZNwhtqoA2+uk1vMiWV8wxFZGhxQvMjWWPGe+Fs2tvdU
         oUMDoANzX03Sg+eHQlL6DeWjKQULxnf6HgQVrWgfqmHQG3dL4qMfC3PWUxWR0vdIRX+i
         kh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EDnhGOt5yt/Q5eHlMXrXDwNEP6fA2fIbiM7ZWpn1ct8=;
        b=GDUJrAEVs5F8RbVhapUCPXfVudipNLtuON4E3uGxxNyl2BIGIN5oC1mc5745n073ab
         WnO3OblHHl79+cBku6FDUj0L3/WKrHqKLAG5813dBBqITv31MEOL51JAWozyG34Ua23c
         7esdw8pEI5C583fA8tTTGB4ZMzK/sU3iIQ1F37dG2vExBAuTtxRbJYkCc1K8HwAuD8BQ
         PL29ktzGrL6r4dAksMH45Bl9FQuJFo7BnlBNBaWV6LfwuL1n+HMK2Qr1Sufgy3+TocZo
         scRemcytZk2IjhaX355YNK7b5j/izWRL1khZL3P2xQTM+567ZpqJFm18wF7wBk/cqOzT
         lgBQ==
X-Gm-Message-State: AOAM532/QpFha2gS2ANjeMMbSt1Zah8DMNZRXULYV5HX4jCjhMDiDPoj
        /DPoS+yaj5wmDT/1YGk+ijvkIhlnWetGZg==
X-Google-Smtp-Source: ABdhPJwilYtfCADToZ6QkaMbt5zJnumtsxOZMAuNZ4D/GKs7xcdpDggrZGVjGtSduqPc33LbKVcHpQ==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr1586709wmc.140.1639668090773;
        Thu, 16 Dec 2021 07:21:30 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id j11sm4945091wrt.3.2021.12.16.07.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:21:30 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:21:26 +0100
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
Subject: Re: [PATCH v4 09/22] ASoC: tegra20: spdif: Use more resource-managed
 helpers
Message-ID: <YbtZdqCz6qHS2JZL@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8bk+QQaNEhaPh30H"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-10-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8bk+QQaNEhaPh30H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 05:37:12PM +0300, Dmitry Osipenko wrote:
> Use resource-managed helpers to make code cleaner. Driver's remove callba=
ck
> isn't needed anymore since driver is completely resource-managed now.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  sound/soc/tegra/tegra20_spdif.c | 33 +++++++++------------------------
>  sound/soc/tegra/tegra_pcm.c     |  6 ++++++
>  sound/soc/tegra/tegra_pcm.h     |  1 +
>  3 files changed, 16 insertions(+), 24 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--8bk+QQaNEhaPh30H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7WXYACgkQ3SOs138+
s6HnzhAAhjmsSsHNiLAo22R/O+NXEzqlLxBG/882IqtVa8bWgdNLWvx5VilbasbL
lJUVTEs+mVr5JYQlrHEXsMKXfb9Cc+hq/dcWSU/aQaFIp5Vy/xhFZ4iKsbwJkr5J
JoWpkvNdSqSHUFOSib3Ck5mQqeByyQbm8RVDBUtsZpD1JskZRJyqgvHF14KOsEjF
PvKp73zUoSEAU/rhbn2NhgIqnmdwXBwdUSbr3JBOtIUKe5E5uxtVu0fsFvNnoSFg
3U7FLsVMR01x2zcJ1aebebVS/Ii/oQHXABzPra2sGcDPnfAM75db7fGdvyCPxrdC
Wy3WxVcAgz5jqSYF7m4CBX9JO0uLpFJGkeP6ok2HplasPrjvbrzyVXkaUdX0/NFW
aDdZXRMgt38QkLUxd5O5FsjlQSIPhI2/nXdB6cocmKzyOC+aBlEWc/K2zsJKkPcx
sL1y0YUGWJkYZZS/DKlplMR5FIwhuX3v8tJBIwfx/1Mrk2Spp4ggbh5xml8Wi+9m
uI1mXNZP5MyiO1V4CuRIAfi+vVT72uxrb8HT8WYRkrt7IYPhqujU2TCmw93Yzk5F
MHNkJOwsFmmY9TvA1dWb5GXi7gXPPiwEWv4uOvtc8T1hX9gGAyajEbQzIvwNO/DK
eOoAS1lWs84wnYx2OpOJKK+5MkxlvgklCor9YrSdKEDW44AraMI=
=XTa0
-----END PGP SIGNATURE-----

--8bk+QQaNEhaPh30H--
