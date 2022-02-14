Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA44B5385
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355252AbiBNOkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:40:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbiBNOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:40:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54A7488B3;
        Mon, 14 Feb 2022 06:40:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 64498CE1178;
        Mon, 14 Feb 2022 14:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9163C340E9;
        Mon, 14 Feb 2022 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644849608;
        bh=IrOrOpgPPmFbfM3il0ebgLaeD+CuFh0YSmEC9klEfq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gSPQiEo/UWzPaYPOQGio0C7NdgEgbsvDpQCjtFt/nDc0TIgtoFqpRw9IFaviz8yoI
         mJPxxd1dcMhXVtiTPBagq06i8xn2CeWnrdwC9QoI0PN0WnHyLnj4BC+4mYak1j822w
         JDxx/SSElOD+UVTJOlChnr/71UdX3/HZy1FxC5XsCXM2FDeu2RxP1TUOU+YjhMUQ+3
         27p4ZdRxP+6lSSUY8QcF98p0DVe4RBPkw5WemPIpNc72rU9XFPHRmZw+a5/TlOZs9e
         DQwMVljO4uid/hUfrK8Sjdx3DTOcv5PHtTrHWZCtcs2aHHtE442M3UwOU31mbnhMqj
         ZZpbyNOpS4TpQ==
Date:   Mon, 14 Feb 2022 14:40:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 1/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <YgppwvQwfJ1xycvT@sirena.org.uk>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
 <YgFgQsV2bJS6mjQs@sirena.org.uk>
 <YgpkZzMWuuWpK8Tk@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xdCazYqh+GtAHX7"
Content-Disposition: inline
In-Reply-To: <YgpkZzMWuuWpK8Tk@google.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5xdCazYqh+GtAHX7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 02:17:11PM +0000, Lee Jones wrote:
> On Mon, 07 Feb 2022, Mark Brown wrote:
>=20
> > On Mon, Jan 24, 2022 at 09:23:44AM +0100, Krzysztof Kozlowski wrote:
> > > Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> > > controller bindings to DT schema format.
> >=20
> > Reviewed-by: Mark Brown <broonie@kernel.org>
>=20
> Do you need a PR?

It'd be good to have one in case it's needed.

--5xdCazYqh+GtAHX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKacIACgkQJNaLcl1U
h9BnUQf+NeuzP2MTMuB1toCQAVLkcgSQNHJePb6KtO22NsKtZK8Bss9IXTRr3EyQ
RlyZq/M28HJx3d2d8mOh3iEseAgTyJRjk15K4waf3NcJd+FswIXbyyN12e2FsMsm
EgYNAXkEWmL6yOq4eWBGfcNHigtCe1D64j50AsjbMTL+gv0JSyHi1c49CW+FC/I7
oPD3lsB/0VQ/rLz2bpRVx8rVg3czhe0wl2AVT3uSDudIkWOW8td/zbKqxWjrw0oN
2KdNXsfo/QoOPvZsb3S+Dk0lHRwlxND6XzgqYdxQbLvTHk4PHOiJRij7MDHDmGAn
YXGCqPQPsmf6mWJm04ZvgyvXzgGsVA==
=gtbi
-----END PGP SIGNATURE-----

--5xdCazYqh+GtAHX7--
