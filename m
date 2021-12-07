Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC346B58B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhLGIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhLGIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:21:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155DC061746;
        Tue,  7 Dec 2021 00:18:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so27702553wrw.10;
        Tue, 07 Dec 2021 00:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kRxFMkke8kPsT6dq9wGTXaXiuVZPZaBpHvXxKIHkW/E=;
        b=DJ/MU62Lho87CUKKXZOHyB/XjVG+kqXFCbwpqjKPOgLADuaLk3ZHR/jAQIT1xdea0t
         Hm6JijaouJ7A715fyom/jDb1RVq4bsOpjRfcYK106KlfN2XA33C70AVr1g6vT+2tIe1m
         6K8juYvMAAo/TX3imczXbhuRNNGN/c8j4QF9ZvDKMylQocMacpkCJzx08XyxSvtNovrP
         dd3J/X3CzhHbFsIqdQRzKEa4XHQud07VWVodbuOzwQmQRTj4DUQ8FnzuepBA2raVq+Gj
         EKfyJkoLDYN5B1ZpGuMtcjeWf3JYvBQ5iZcvXbF03JWqBAa3zb+mlPbf70CJS1rTBbqS
         LqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kRxFMkke8kPsT6dq9wGTXaXiuVZPZaBpHvXxKIHkW/E=;
        b=hYdPdooETBimxEPhY5tNq3H32AD84vBP0cHoHneaMcBEF0YaMO/u4EJT+g5WxZNp51
         MYQNB3P3QV+/FYdTJEgaDMOzDRkjrvA/gInIFEwapP1Z5YrmRVSBRdUSEiUBh9HgN5Uj
         NisMDVksru68YLLXAww/qVQ8jGrrCvvWXdv00t3ml+IBs+uWF5wKdwmILf2Z9K5uqx4Z
         pxcH+Af/66YZdondFe0qg9eFSxqTsjNTIhnoxX3CbQPLjfATWb0km/wSgaU8wg2ZAFnM
         Tm4X0DbX7zwNNkqPlcNjw+GiZOwqRAQPBb0bTOtGx1qI6RD4RqlGTjJVlBkr4L2xI+pR
         gsEg==
X-Gm-Message-State: AOAM531Cm8l8f1XsYDGWbkIabZkzJ5Py3S3cf1cV9H05lFAoTSjClKo9
        YXdn6XZo4mf+vqnOAwcfL0E=
X-Google-Smtp-Source: ABdhPJy59QXG+VmaUQsLuNuwkqRjLh3Sjkyua7qwDgZMn0fBXE18S12L376YblPkWtxW0V4lyH7qlw==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr51218114wrw.367.1638865105805;
        Tue, 07 Dec 2021 00:18:25 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id r7sm13631282wrq.29.2021.12.07.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:18:24 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:18:21 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, perex@perex.cz, jonathanh@nvidia.com,
        digetx@gmail.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: sound: tegra: Update HDA resets
Message-ID: <Ya8YzUdUg+bFcx/2@orome.fritz.box>
References: <1638858770-22594-1-git-send-email-spujar@nvidia.com>
 <1638858770-22594-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IpL2ISpQCYw3FiPf"
Content-Disposition: inline
In-Reply-To: <1638858770-22594-3-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IpL2ISpQCYw3FiPf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 12:02:49PM +0530, Sameer Pujar wrote:
> Tegra194 HDA has only two resets unlike the previous generations of
> Tegra SoCs. Hence update the reset list accordingly.
>=20
> Fixes: 2d8f8955fe02 ("dt-bindings: tegra: Convert HDA doc to json-schema")
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml       | 13 +++++++=
++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.y=
aml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> index b55775e..70dbdff5 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> @@ -50,13 +50,18 @@ properties:
>        - const: hda2codec_2x
> =20
>    resets:
> +    minItems: 2
>      maxItems: 3
> =20
>    reset-names:
> -    items:
> -      - const: hda
> -      - const: hda2hdmi
> -      - const: hda2codec_2x
> +    oneOf:
> +      - items:
> +          - const: hda
> +          - const: hda2hdmi
> +          - const: hda2codec_2x
> +      - items:
> +          - const: hda
> +          - const: hda2hdmi

We could make this more specific using an if: conditional and match on
nvidia,tegra194-hda, but this would work as well, especially since I
presume that Tegra194's successors will also not have the hda2codec_2x
reset.

Acked-by: Thierry Reding <treding@nvidia.com>

--IpL2ISpQCYw3FiPf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvGM0ACgkQ3SOs138+
s6HtrA//SQTJKoBonjblOXCfZCGpl4NiEuG+ksgtRENQH8uNYgFqFryy5n2X7VAL
QVBUOOJfRyW4RHy6+dfw7QIG8d6c7JhTZuB9f5I6P+l27UQ4QG8p4kc5wQ8oi47R
uTRhlfl8qnjJmmtsgqMXcSWkAFlOqWxzSWiyY6CSmrbx27tcbEyaRudtfY1oe05N
aKN56OGVYimjF3yTU6iv7scGgBJ9o+FGNIM9dUZsPWfkuxdpIESRUJ4pQ2QVoQDh
Kv/ykUPHnLhS62pDvctKOYjFyDsPkEww8mZra+rnIYg93vHzW9xaVF2UcAmpW3Ie
H+JGFZ33eixMpCzyqG7NjtOXxOp6ardsYbf56VTUgig2JMDwszKDHtWkfDcJpcC2
3UylGgNUo/wQuUnqVL3BHQdi9i5I9w81ZC8XlJEmGyBhR46oLGDSUjwxZuiKuaiT
hOQm62icc8QSiBb0AF4q0NRiO6kxGSFDITCSR3ZPTBnems4kn7+hgMpNYDFVQq3h
Tui2E/Hx5X0Yuv3Pn2VHzEPTOSB/Vo9i4hFAHWcYjJgZfnAsC3XRAoAVPPXlqUPu
PLQphJUdXvsKris2OJDhbUJIz8kThuzbTiNgiH1QKCHukn+pbWuyyE5qS30L0dKZ
3I5YoTjE79X+fDDtIeEbJcwZbKelyx6QgduhREVvNMs9Jk8s7QU=
=m28v
-----END PGP SIGNATURE-----

--IpL2ISpQCYw3FiPf--
