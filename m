Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2345D477458
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhLPOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhLPOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:20:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82826C061574;
        Thu, 16 Dec 2021 06:20:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q16so3695939wrg.7;
        Thu, 16 Dec 2021 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2aMnjU7hIQzPIODNPQxr8yp+39K6YzUUOxZgZZF/gHk=;
        b=jEXIJan1huk1UQpmmCmNfmwqrd4qKANO5zNtO8Iijqax4fsDmJvFxqBEI9x5qrcgfq
         Ye8tnshx4JVdfL4kZBqhxOzJ2xMFLrThaclAwSTQmw/2fs0XZaIGl4xlTA6Vf/ebNqwF
         sO2rK2ZGdWMbB6Fbo08LnCIjOBiU6gTb1Lk1WGlvdpWNfnRStY1ulhBlmov2PZzKUzJK
         ZDdHZUNzPxPjFmX6KnFQysxSD0QIfXb2jSCBjNOFPbIxqLjcmJeNfzGyRNWrqkMJo6xv
         G1joetmCmqGyaqWacTWR5NhiGJ4DfQ3vKCg/5K55qhCws8gH9Vja2Ua4hpztSGsIqdSu
         Nbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2aMnjU7hIQzPIODNPQxr8yp+39K6YzUUOxZgZZF/gHk=;
        b=DrdyloSPtPM5G+0NZDPOog8IYfv+ctQ+6MO3yiX+nZaMv9tiqo5E3YW+sqJTeK3ofA
         ZtnSSChR7jiaibcuI17hnZox9IVR6gNNDuDDGePNklZ40KOrcAMkWt0T7SS5vt6n6q8A
         JiIK+oe88sFOLSyJa69WAY0ttnaOluYx/Daea8rJYV4B7K0v9TWWYkKH8arDaLbth9fL
         Q1Yo7u80xUnj8IY4dnXsX+QRXp7kCYk0beGjSJ9irUDQ3c0STpp4w5iWJKt2KMgLP7UN
         YNukgA4eaWcE0KF6UBulvcwzm9t/PzkVRmH7nxajAy7ppCJq7QA9u9WqbAisO0gW2uMM
         AAyw==
X-Gm-Message-State: AOAM533V6mii1gg0by4tBmOMYEeCiC2Icvf3n+ZyT7FGt93duFebroaS
        G8c9gr+UUwyWvyJ41ShAhFI=
X-Google-Smtp-Source: ABdhPJzyhdKgbIYkyLmJVEDx2jsU2zymKPqxvGpbsD2mBizBJldfL7d0I25gv5R9KPE9gf994HYdeg==
X-Received: by 2002:adf:f68a:: with SMTP id v10mr8139833wrp.212.1639664426137;
        Thu, 16 Dec 2021 06:20:26 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id q13sm1460504wrr.64.2021.12.16.06.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 06:20:25 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:20:21 +0100
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
Subject: Re: [PATCH v4 04/22] dt-bindings: host1x: Document optional HDMI
 sound-dai-cells
Message-ID: <YbtLJeIxXlVyQhd3@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <20211204143725.31646-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s6xvmThKn00W/gOE"
Content-Disposition: inline
In-Reply-To: <20211204143725.31646-5-digetx@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s6xvmThKn00W/gOE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 04, 2021 at 05:37:07PM +0300, Dmitry Osipenko wrote:
> Document new optional sound-dai-cells property of HDMI node. This node wi=
ll
> be used as endpoint of HDMI sound DAI graph.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt  | 1 +
>  1 file changed, 1 insertion(+)

It's probably best for this to go through ASoC along with the other
audio-related bindings.

Alternatively, I've just sent out a patch that converts the host1x
bindings to json-schema, so I could work this into that as well.

Thierry

--s6xvmThKn00W/gOE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7SyUACgkQ3SOs138+
s6HU9Q/+LJiPotWXIHgjqddwtzU6/HD7NNzSDIDIQzl+FQCjYyWmJCFfhyIgmI1O
3t27pQ7abUhhsvr1oZr/+vnUpw/ZGekjOTA7cuqXWstDJfVpKtALJXwqqNvn059V
NDBYXE9IvoNnPWZlKZpF+RvPxBekzBOOG7zQ8Ig/2JwhG/caYnzRYNsH1GF5NOhN
8zbP5CrTY+jRpaKWF5J2oXrvS+EmV0tYuleNpJsZttYhPwWwbyE6Nk12WNqacnEW
vGBSNv/DeO2yPvcfxvn15SXPFRo93hc1JdoiuGKUrS38BoKCjQj4yA5DTFgp9MVz
tLzMZ38YlZS7hwxrlhzGjNPyZmZ6e7o09cj2CgfYzL++fJC0PzTXK9bPkwBpnmB8
TT9TCAVZE+KUpExyiOroT6TmpJRl8ETH+x/cUOltkPwtpl1eKIS19l1qFuTqp3x0
Uh5w4Wg96EeqRlf8BDw6l7748TmED1Z4BqiyMZ0SrDAxF8fzalxsoIgfZ9xrn2u7
xJIoigBHB2gHjVfaDFxOx3eHTioW9xQCdjMC0y6vBbJYPjw1lXz5Sc1n84k3Wyij
Gd80HQ68NLb2hcERYf6Rbl+jVnibKYrS5HEuA9bGU0gU/HEoTqEJTAicFKHu5PwH
OjRKjFar0sFhYQtFVQh77Yb7CQzlV4dg9ywdLK718KnY9IlzipA=
=InZN
-----END PGP SIGNATURE-----

--s6xvmThKn00W/gOE--
