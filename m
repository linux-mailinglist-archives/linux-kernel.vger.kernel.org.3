Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702CA46B5A8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhLGI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhLGI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:27:13 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDD3C061746;
        Tue,  7 Dec 2021 00:23:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t18so3856109wrg.11;
        Tue, 07 Dec 2021 00:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wf1F0OooNs3PnyoBoMApcLPrH4rs/RIVNVT4Xw7LDtE=;
        b=HIts2RhQ0ar1CQAfyAbxBJIxVVViuSUnMONa73z8lIFQ2OW2Jt+fVxDl/WkuoqWyR0
         xVthDmQdYWZUe1sHsJ6hgo9rdta/9gJE4eS4DQ5Nc65C6Y97D6heVXdZCIJKgpaYSdLz
         iVJ16SJwuCa4Szp35HXfObQ7Hf55E0BYjHgWe0h6UYQNdPgu/NDrs/ffE0Qi8kVe/Lyi
         NnUIHMTr4jaKxEXgJ7uftPbBSVkeNJHlnCNXD+7H+eLsoD29XHVYoWzjEprbuJ6KpfEt
         a5efUDL47bxb2pXLBEuhGcJSBNAOCc6DtR8fCK8Iap4MP+/DzPo7FQTHwbrW/V+XZM9E
         yrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wf1F0OooNs3PnyoBoMApcLPrH4rs/RIVNVT4Xw7LDtE=;
        b=29J0iGCQFKScfmnlwo+Uv059105+PajNfHCbgePivlFdMGU9qC1MaW9iFoFGBoxt8V
         sEVFqZF2CsRh9nXSOmrHv2iUCI063X/fO8Zad6wypLRfL8WFHR7LrUEygpPo3gmyfWTi
         oHO8eE7jnpPJorPW5PltziFdK3If5IjfPoCwZaHUxwM/y04ax7duXVD8Yz5gF6zmBTZu
         aNvYgqXZvEP3AcEAGyHslA4+Bxe8IDnNTsnH5pv9NTdWyFT0Ae+l+kR83IGgi4qsDGmr
         txvDxYFoSQET36iPTJyZNqZrhYrwGKkCZBIquGuIJoaUnwsYTYt8SXA1IVd+xo1UV6LN
         DE0w==
X-Gm-Message-State: AOAM530zyf+Xt87yuyXHEEPXF5Pb+uP5mENCsagK+cWUjz8nrn9AzWN3
        P0WceUCIxk89PI44dire7M0=
X-Google-Smtp-Source: ABdhPJyBwwYvAFcM04yFYn7xrv6roHYJgYOItRrOUapqWJ0XVoV1AFabRCZQAPDFVHDGj+zqkkZ4lg==
X-Received: by 2002:a05:6000:1885:: with SMTP id a5mr50860055wri.258.1638865421875;
        Tue, 07 Dec 2021 00:23:41 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id e3sm14200097wrp.8.2021.12.07.00.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:23:40 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:23:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: atmel: Add missing 'interrupts'
 property
Message-ID: <Ya8aCdLpnB6GZ4Ye@orome.fritz.box>
References: <20211206174045.2294873-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U7s/QMunYu2yFdOv"
Content-Disposition: inline
In-Reply-To: <20211206174045.2294873-1-robh@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U7s/QMunYu2yFdOv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 11:40:45AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the atmel,sama5d4-wdt
> example has the following warning:
>=20
> /home/rob/proj/git/linux-dt/.build-arm64/Documentation/devicetree/binding=
s/watchdog/atmel,sama5d4-wdt.example.dt.yaml: watchdog@fc068640: Unevaluate=
d properties are not allowed ('interrupts' was unexpected)
>=20
> Document the missing 'interrupts' property.
>=20
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml        | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--U7s/QMunYu2yFdOv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvGgkACgkQ3SOs138+
s6GYbg/9FxK0XbOB7kB488bREQmQAwC/I4peSRhhfjRAxSz32wJGzWqgIYvO8Tsy
ouMAPQVcPAkU56ki40QP+yZXTUli4MX55ji5T4p+lI/O4yiLNRKLLJLy+svwOtju
sBSY4YeoQgiTs5Y7PfQbgvoJRMktjhyVfIFZIibd0DMRB+VqYaxvd8GWIMfSkZtW
Aai10aZ0/vdfpRCmnK97eExshzbaHVYho7cVkmcsxNLJW1WXKJHeiPdbS+/qVdsr
Zh8CaEHabIg6ICRoQlRCFsU+dF4eeJHC7cGGRkh8kDatfMKHC7c8YLvM4wT1rTf/
qESciDYJcIrTDrOGTMa0Yd+zPZI4YEKXQBMG+3FO2B1F6OFm0pEJ28qdH9MvbGYY
NjIv3r1/GqXmBjtNYmInWrzbWGFePrQV2mARvTKUBgTlP7Am4Hteb5bvzLRCJqSB
jAcUk1o9kDXTcPkBgKvgH2/J3UmKMUzlr1jgLFxiZff8UJeW6yAEzILXv32wLLw0
KW5uQ6YkqqwqQVeGd/kI/EJAq2FsqYUMxxKMShVJ1mmImWNKrnQhR9cRJ+V4SOxT
+COJwwL01fISqTphMEoeY102HqKw3Gqzh1IdM6mFrJqi7qdZYs+XsAnmoZPDnWX6
AOK3hlaCXo6PtIWnpUTIqNeFkk0VHkY+A/wXxK+HF43iN41UNtA=
=CDsV
-----END PGP SIGNATURE-----

--U7s/QMunYu2yFdOv--
