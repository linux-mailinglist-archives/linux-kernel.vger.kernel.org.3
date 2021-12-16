Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE824773BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhLPN40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhLPN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:56:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD73C061574;
        Thu, 16 Dec 2021 05:56:24 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i12so18982175wmq.4;
        Thu, 16 Dec 2021 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iMV003eLLznTLp6M2oBwJEaOYxC5vjXtghvIfAS3DNQ=;
        b=Sli9mUlXv3PM4/ikHFbKNIKTK8n/El4roMYCXwcZR6TA0taVYgveeSZ/E6mkGY2d9B
         2Q/GRx2Ra05xaCgyJCRROknh81z/QVO3snt9kGuajSRoO2CxsMxrToBDZqMGXi6pbJQ8
         i+OEZLBiCU5exBlYlKGHb+pr6wLCg81UuJC1yr/KJi0nFIwEig18l11joASXkKfddigC
         4JEYJ0YNTzFltL51s5+gVem2Q5s9DkBaFbSfzPvK5ZUujMWSl04a3ePok7sXaIDhSm28
         f5n2iHSdkLgoHYv/Z2AoMehKLk0cUCKE0rngVNJSV7bDjEJHre1wdjbcmDCWhD+MEr2g
         tAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iMV003eLLznTLp6M2oBwJEaOYxC5vjXtghvIfAS3DNQ=;
        b=b9SvVa1S+tgvIV46OomLc+wMy/zXruPDkl8Dl76Sig8N4wHYODRVXw1pJ8ek8vEcCU
         DwQeVPhIYl2FwtON1fcASYlc9Qdb51sm6ucgmzG6tTvtj60tCtPdYrx0fXPsfjycqwPz
         bK6B5bV8OIyOjk4F2PdQUdgkpRNGp5cBrTaH1lmkuTgSrdkCC0n1+W0Cd/s7FnDu15a+
         FmOyqMLXHHwr2dYkNdFjQnheaA/hAnG0rcNeM8WL7ImvGKVQcz+CV84UsxJQ10HMwtZg
         6N287JZhWT8EVrZ6Inmymnj+lku7JjS22kVaY7joLCz63FuOaaZE247lIkVZtyNxHUEP
         KGGg==
X-Gm-Message-State: AOAM5323K/4fH0DoJqXwZoiWTMh3VaZ5WRdReFXs2Bxb1+ezDXcxnEMH
        sVUSFk+R97itPveURIkT5qQ=
X-Google-Smtp-Source: ABdhPJwyzOoZu9zxfL+1OjtEMOMUMtdhsprxGBD+PcGf+w/+6ISQTTgbCC2+hySDGxg9pU8JhSYXEQ==
X-Received: by 2002:a1c:cc0f:: with SMTP id h15mr5102355wmb.38.1639662983607;
        Thu, 16 Dec 2021 05:56:23 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id p12sm5945219wrr.10.2021.12.16.05.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:56:22 -0800 (PST)
Date:   Thu, 16 Dec 2021 14:56:19 +0100
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
Subject: Re: [PATCH v4 01/22] ASoC: dt-bindings: Add binding for Tegra20
 S/PDIF
Message-ID: <YbtFg7t4cM9dV5Gw@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DYeD+wTM6cNwfNkf"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-2-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DYeD+wTM6cNwfNkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 05:37:04PM +0300, Dmitry Osipenko wrote:
> Add device-tree binding for Tegra20 S/PDIF controller.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/sound/nvidia,tegra20-spdif.yaml  | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra2=
0-spdif.yaml

Acked-by: Thierry Reding <treding@nvidia.com>

--DYeD+wTM6cNwfNkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7RYMACgkQ3SOs138+
s6G3YBAAgNf/4lgE/tO88tQPV1jLl4JoqxFX/HSw2KtQ6EGrW6HXSk8heutahviv
QMpfJVkw2+bSfPz+MdO2jBSg3XQWNOVYMrdN0Z5VcuAgbankuYJPCCkwoJ8U1SIO
O3NuhaPHvLSsKTHb74u9xcZ7LBxcpWtPHJ7JiF7W+wicXg65vYmcamQJoQCO0CLS
yrS7z8183zb2RDMPVu7cPQ9xZA/ofS2A8SiuZCFdpEE/ONX8l301v6EH9p8KsoNV
cRKjLEPyaaSMMS70NiCD1pw5Gk3NtDnwUePvpDzotGqAr8HU8aLCf5F6PY+tEEZv
qF5u18vQGEc6S77qvYmpIGVcvzHFdmzZ3y05EpP+bSCBasGCqKkRJJQvUMc0AE4m
HKRTWOL0fln9k7D7GAfHKdGoGx40vsQwaaq0OyRWhAXYBr/SfRMUWcd/gEaUajd5
x/GJ7IuzjYmHTcYaVCo6NZsrQiWTRfescCB7PmEqQlJXaAO12Qx++2fmh2Aqsgk4
M65Ez3z/7TVwwvYP5IQCGw6LHFebrxMLMNZlEIf042houTzAEUCozC8hXlqRRSH8
/xAnSkcAqUd/SOye4O2yhSaLYBWlTrfe0gqvbVsCLvjXKNAoNwWBAuwRQ7UPNsi4
iPi8TgisuC6KHPPUuNoyDA+aQ+lh9RJF6/q99KaBDq8FaEh0wVY=
=zYcg
-----END PGP SIGNATURE-----

--DYeD+wTM6cNwfNkf--
