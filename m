Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA45473184
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbhLMQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbhLMQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:21:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880A5C061574;
        Mon, 13 Dec 2021 08:21:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k9so10191352wrd.2;
        Mon, 13 Dec 2021 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K5OV2i857SBsczI55KRvi+KO9pPWwFOs0SKSXk5xdv8=;
        b=Cb0GvraGkmh/W0cP1vlmrKJdh39P5Q1x7gFyrQQSuSjTlpceuPPxlbYowBF51aEdUe
         lYyBJD/fGugbyMB3UBeegtcmVgjLlSrisUu2AzPhLxN3Bhnh2JjGmWVU/KkHcD+LvIkx
         2plX526plk4mZYUMJJcG5BV19EcZoT7nECFSOyHca8plKyj6X1DKZ9hcUZgI+VfR4cH+
         Jd3Ix2T8BV4j0jtAy/Eape2bqQKaknnKQftFYA8S15sTMJL2TCcBWSgYox73S0N42liV
         qUiAUBzzMFBkgluSQGRBg1HmR+nFk4Xo+JVUHkfKo31vfTKDY919D6uIB43U7QoHY2Us
         zZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K5OV2i857SBsczI55KRvi+KO9pPWwFOs0SKSXk5xdv8=;
        b=FchiWIPArwZKevHbueguz/s+htA96nZI2sXDQNjfKPypWQBZ/lmkp42osYsfYL/dty
         UU3+C1lnrlcJWNc+5d/IGBvF0g7gIk8P78HfYI+bAwH3T9eQ6s8qJfkMjHkNp50X++6D
         oZNxnVULzn/WT3SnbNRhiou5pqbPQn5ptfguG+CrtB0y5uU8PJRxTHBfCTl5ztJHTRMI
         DkzoRxBxiBGjas+9j/XkWjfaoF1FIeDWAALzUWa+JGYULX9aHnCVr0j81ttGDdFxJVgY
         MrpYH6ECxOqRi0Gewm4YbkBnhMyeQHZTRAGlpFDLg05fTdZ6z6KkRdB66Yu57fMe/5kU
         wB0Q==
X-Gm-Message-State: AOAM533HdrH11iEww8U3uVH8V3irM5aB1kH9yH80dBBJleG1pqHczh42
        74uXT1D462Sftfaf/8QEPqY=
X-Google-Smtp-Source: ABdhPJw6j6Pl1kicYyATDZNEICdbDmVh76LTeFdwsw4M3n1KhVTplhApqkGUZXJ+En7ALoEa2LudXw==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr32274227wrt.419.1639412510050;
        Mon, 13 Dec 2021 08:21:50 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id e11sm5651830wrq.28.2021.12.13.08.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:21:49 -0800 (PST)
Date:   Mon, 13 Dec 2021 17:21:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: memory: tegra: Add Tegra234 support
Message-ID: <YbdzGppDm6H1UNLQ@orome>
References: <20211210164741.881161-1-thierry.reding@gmail.com>
 <20211210164741.881161-3-thierry.reding@gmail.com>
 <ffb00485-ad21-a11a-03ea-3856e2212563@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wCmQDuIn5rDzYLz4"
Content-Disposition: inline
In-Reply-To: <ffb00485-ad21-a11a-03ea-3856e2212563@canonical.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wCmQDuIn5rDzYLz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 12, 2021 at 07:46:06PM +0100, Krzysztof Kozlowski wrote:
> On 10/12/2021 17:47, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Document the variant of the memory controller and external memory
> > controllers found on Tegra234 and add some memory client and SMMU
> > stream ID definitions for use in device tree files.
> >=20
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v2:
> > - conditionally set minItems for reg properties
> >=20
> >  .../nvidia,tegra186-mc.yaml                   | 20 ++++++++++++
> >  include/dt-bindings/clock/tegra234-clock.h    |  9 ++++++
> >  include/dt-bindings/memory/tegra234-mc.h      | 32 +++++++++++++++++++
> >  3 files changed, 61 insertions(+)
> >  create mode 100644 include/dt-bindings/memory/tegra234-mc.h
> >=20
>=20
> (...)
>=20
> >  /** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_S=
DMMC4 */
> > diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bind=
ings/memory/tegra234-mc.h
> > new file mode 100644
> > index 000000000000..2662f70c15c6
> > --- /dev/null
> > +++ b/include/dt-bindings/memory/tegra234-mc.h
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +
> > +#ifndef DT_BINDINGS_MEMORY_TEGRA234_MC_H
> > +#define DT_BINDINGS_MEMORY_TEGRA234_MC_H
> > +
> > +/* special clients */
> > +#define TEGRA234_SID_INVALID		0x00
> > +#define TEGRA234_SID_PASSTHROUGH	0x7f
> > +
> > +
> > +/* NISO1 stream IDs */
> > +#define TEGRA234_SID_SDMMC4	0x02
> > +#define TEGRA234_SID_BPMP	0x10
> > +
> > +/*
> > + * memory client IDs
> > + */
> > +
> > +/* sdmmcd memory read client */
> > +#define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
> > +/* sdmmcd memory write client */
> > +#define TEGRA234_MEMORY_CLIENT_SDMMCWAB 0x67
> > +/* BPMP read client */
> > +#define TEGRA234_MEMORY_CLIENT_BPMPR 0x93
> > +/* BPMP write client */
> > +#define TEGRA234_MEMORY_CLIENT_BPMPW 0x94
> > +/* BPMPDMA read client */
> > +#define TEGRA234_MEMORY_CLIENT_BPMPDMAR 0x95
> > +/* BPMPDMA write client */
> > +#define TEGRA234_MEMORY_CLIENT_BPMPDMAW 0x96
> > +
>=20
> This header is needed by the driver and DTS patches. One of us can apply
> it and provide to the other via stable-tag. I think Arnd and Olof prefer
> if headers are coming with DTS and are provided to other trees, so maybe
> you will take the bindings and provide a tag for me for the driver?

Yeah, once you're happy with the series (I've just sent out an updated
v3) I can apply this to the Tegra tree and send you a stable tag to pull
into your tree.

Thierry

--wCmQDuIn5rDzYLz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG3cxoACgkQ3SOs138+
s6FznRAAgVzB/8CCwzOnLIyGxbbXkJm3xtoqDo0mskneOdW6HpnDHLDQStK07Em4
7TEluacnK6gVIuWGjz0bh3nvlZKqZLPa+bF0xUjmS6SAnSgdeEo5q1Rt5+OXKVi0
MwqtP84gvWm136zRAsOuli6tgomncci2WyKt+pzjrP7w45eOCtD997kt8YwnyZ9r
Bc2vLUydEp2ppA+U7GlljOq6gOsR2iNiPJR9xVFMYT/MOw+T0FR54ViGnS0sMJ1V
XBS1dPUrntKIWe8/5wHp466XhNOp4JbZxhSAlhHufXY5972XPQy5W4p3yPPJrPOY
iQmvpl/aA9YHFExcw513xxeUFfGwIvz47o0Jtj8i2YTwK4n1tYHv8fO7cgsVi1gt
VjME8y9/cB1Ds3l+fOfpPfhZBMVjB8fnLJYGWIOdV8sV1ez0W5feXSt/bggm8DYy
6yoUUaIlzFO5iZEdirRC6hWZ13zao2fv/ZQn9wSsoMOCRjy33OSl7eEgve4CMkX+
YbaZ/w4ZJB9M/j89n7Puj28IJmRvFzxqBC9Gy1O9NkfVNKZjHH6dlVaM3XG2tB40
X6m206mohr96o6aSzYlQNulPuNUobMwTSGGJWZ41gwDRH739PuLTIGq2JUXa5gu4
Xlh2UABoIYAFxgSYjDWurAhIQ/SXgRVFnirL4JEf9BltNutMRZQ=
=rxKQ
-----END PGP SIGNATURE-----

--wCmQDuIn5rDzYLz4--
