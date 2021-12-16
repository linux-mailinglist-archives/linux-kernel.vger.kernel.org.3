Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888CA47758B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhLPPPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbhLPPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:15:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C54C061574;
        Thu, 16 Dec 2021 07:15:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v11so44763382wrw.10;
        Thu, 16 Dec 2021 07:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7wfg2/f35dLEMNUi0braWFcvM9LG6JIBQ4wa0N2N+9Q=;
        b=K02jPVe6FfJPLsLfOx6aLSp6p2GvtVyyz7N6wDtzqIwXsRCI4cTDLOe3AKp/5WWZ9g
         sa+qFEoZ3X2OCvjCH4yFnmUGwx5VQOjbev+QAKRnZUMDQcVfYWE2/yLAzske3Jr4Id5A
         SKidD2w+NPbkRjjo7K2D+Bx8A9tJl/jFxUABwzf/HbgUSInjC40geoKXb4UmyeJrkJMT
         97XSUhRI2rjVTebRnT6+dh5GvtcMvepH3YeRMrGljKYUG9YXfTRfIX0NHDA6F/4XJvEi
         hblnDIJzfcFP9Gssy37L4EB/WzIcSXrDZWLJ3iTgUAUDsEgCKhJfnOh8wHEsuIn3WDkX
         /kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7wfg2/f35dLEMNUi0braWFcvM9LG6JIBQ4wa0N2N+9Q=;
        b=f3mAlLo3y9X+aW70gpySejWO+2H6fyDi8Xi8KKD00Fi+FlXnm1PVStc8pUNZf+mJog
         VaZagohinv6m9cm4NSjwGJGFXHgZy2uu5wipnvIl06TLN8y/l2NEIYd3v2Q8fyVOhsj5
         gErEKT2q6iRufVm9TtdAM6bBPrXAJXwJ7mRG5yyhFVcW3oxOPzPYs0mrXxcIBghVwsaP
         2gX0mblk+dJX0nyYlamaRxNTiMINWNuIbvqrX2nX54aF8aFvS9QMpeAKbDjfBNpdYhLx
         UWh0NWYWy3Fqr4RE3CCQwOaEhfbLPLLIs6u6GbFMLFqh+Kfk63jbzuA4eIjq+v9sozK8
         7epQ==
X-Gm-Message-State: AOAM53224QXYaV1rnJZYxF7xv4DS231oqkomFlPGfNwkz7EQ/rkziXqr
        b8f2fR/N2s/NaximHI7HGbE=
X-Google-Smtp-Source: ABdhPJxIjZcHYAgIzHJzFSWBtF2xpwNn98/7KzUbICH6lYJeYtkqC0HoC7Z9nFPbaR5XJD+omsmD6Q==
X-Received: by 2002:a05:6000:18a8:: with SMTP id b8mr9330098wri.166.1639667736757;
        Thu, 16 Dec 2021 07:15:36 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id n8sm3760461wri.47.2021.12.16.07.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:15:34 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:15:30 +0100
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
Subject: Re: [PATCH v4 05/22] ASoC: tegra20: spdif: Set FIFO trigger level
Message-ID: <YbtYEml9OwaiO5IC@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2AOAozvC3BJfdqc4"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-6-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2AOAozvC3BJfdqc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 05:37:08PM +0300, Dmitry Osipenko wrote:
> FIFO trigger level must be not less than the size of DMA burst, otherwise

"must be bigger than or equal to"?

> audio will be played x4 faster that it should be because part of the DMA

"faster than"

> data will be dropped on FIFO input buffer overflow.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  sound/soc/tegra/tegra20_spdif.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Makes sense:

Acked-by: Thierry Reding <treding@nvidia.com>

--2AOAozvC3BJfdqc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7WBAACgkQ3SOs138+
s6ESDA/8DbIeZESt+My1mOIlSYpY4fVQpZkFchjl7VTpEtVebjXYgEHv4vGjmjY/
OGd6DleF7MQc8GDZXXpTUgHXu6N3wR07FAPLv+2hwOy+ikYbSkvEcPRouU9bqXPP
q0YaU7Uk4Rap6tXZt5Hftj4s1bCaDY7IpLx+24RMJT2s8OJtgSnlqe1YOAiXyEBk
UZxAJztbek7OXcellOsfMj0ZctB68jS7cOt2/hQ/0W+q6hkwksORs2XbD69wDDsR
ffq4z7CoZhxtZe9dxxphzXb8UaRr+40QmIRmtGFXS986geXAybN37lh7WZvC+Q4E
FmQFh1xIdUqbGYdJfOCCsUnxdG1Fcp0+vuiJbRfWWgrKPQYvbSz1pyMyOFTgFxXH
GcBz20DGnj2X86pvObeTVeLJqz3s9joZwbzhTTgL6osmUp3urxyl7A4jhKVK6vYZ
lvUTBjpp9N7kKQ4HvKy3lc/mj3dt84Gn+Zxna1nw6MLlvwPp/81aUBq82sqISfiv
iX87GcjYWzna2P61nKCX0GvLDs3NIbvPPQeBJ+TCYYhnVuNphbgFNa7Br1eJH3PD
I7xZBuSgcMLy4LPatILEZHWk2fYrrX3Oa6kK4XbBiM+Cuux5orZ4VtDtWUtTxEX/
dT2QwTi4s7PLXBGNYeA55d1mVvcKhIMicExH/ZQam5cdA+zHQYw=
=Wn5s
-----END PGP SIGNATURE-----

--2AOAozvC3BJfdqc4--
