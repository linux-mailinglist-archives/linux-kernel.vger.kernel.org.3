Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419C9588259
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiHBTN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 15:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiHBTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 15:13:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D7C52DCD;
        Tue,  2 Aug 2022 12:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55B57B8207C;
        Tue,  2 Aug 2022 19:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F9FC433C1;
        Tue,  2 Aug 2022 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659467631;
        bh=T3MBopdOtWixQ3FCkNcXkYUgaM6a+BZ5M1L3tYAPinc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHuxmrVZA/HqE72SdIgz/Y9s94Vyu8TDSWQQQz9mcp07n6m2w4vVfRiAnrES90+9J
         TDd+xn849tl2BR1+rxm+XrxZ/AtElelYlUiiL1sNb+jVvoXzIOIMiKwervMN7lECCY
         rkAHoVHnD+URn9EwSe/uaPiViJ1jmzVprTyBn+ht6dUqxbzxzKuGO/OoxxI+P91Sml
         bK+4L5IK3sfnA+I5eeRm+WfcWdLTkDy9xdsqEnWQYeFuSttclXj1ERSH++pr1aOhAF
         8F8BcPEtMpw96z259gEshriJuDWOB5pYolttpZudqA1e9vrE+3hd5j73wacXIpA673
         j3NA5OOU3RzEw==
Date:   Tue, 2 Aug 2022 20:13:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
Subject: Re: [PATCH 04/11] spi: dw: use TMOD_RO to read in enhanced spi modes
Message-ID: <Yul3aNP8yoBf5QWu@sirena.org.uk>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-5-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7HxAbNud4AYGSDtm"
Content-Disposition: inline
In-Reply-To: <20220802175755.6530-5-sudip.mukherjee@sifive.com>
X-Cookie: Stay on the trail.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7HxAbNud4AYGSDtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 02, 2022 at 06:57:48PM +0100, Sudip Mukherjee wrote:
> When we are using the enhanced spi modes we can not use EEPROM Read.
> The Synopsys datasheet mentions EEPROM Read is not applicable in
> enhanced SPI modes. We will need to use Receive only mode.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  drivers/spi/spi-dw-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> index 8c84a2e991b5..8e624620864f 100644
> --- a/drivers/spi/spi-dw-core.c
> +++ b/drivers/spi/spi-dw-core.c
> @@ -727,7 +727,10 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, c=
onst struct spi_mem_op *op)
>  	cfg.dfs =3D 8;
>  	cfg.freq =3D clamp(mem->spi->max_speed_hz, 0U, dws->max_mem_freq);
>  	if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
> -		cfg.tmode =3D DW_SPI_CTRLR0_TMOD_EPROMREAD;
> +		if (enhanced_spi)
> +			cfg.tmode =3D DW_SPI_CTRLR0_TMOD_RO;
> +		else
> +			cfg.tmode =3D DW_SPI_CTRLR0_TMOD_EPROMREAD;

This is fixing the previous commit...

--7HxAbNud4AYGSDtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLpd2gACgkQJNaLcl1U
h9AdcQf/fp0qGacGXOTmxLhzXNUGajNyCyIQp3hVO43WcLLNP1qX7SwYdQqpJsWL
+Uodapi9ubYTtcuQRK/vTodDYvuYLM4lCY3uEga/7aTesUwFrYL/ExoW8eaqI67B
HC6fmMyp44SZHhKAjp5ayY7HXg0e/eAAY8LwapbRfFC8W93kVApYWirG9hPCYS+W
HGw+HZ80eyBcA0fQNBXzWqfD0Mr0LpIy0itNFZQU/kqcJANcBYuL23i1XkvLFhTJ
I0sOmMtidWMjhig9BvOtfmenSOMvNMVd/PIgGdHI8o21d8f4odJJ9Meni8q4jxkE
s1oep2Sjf6h+xyDDUGGHUoO2irGkBw==
=mC5X
-----END PGP SIGNATURE-----

--7HxAbNud4AYGSDtm--
