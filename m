Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4557E6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiGVSiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiGVSiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:38:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA83A0B85;
        Fri, 22 Jul 2022 11:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9655060DFE;
        Fri, 22 Jul 2022 18:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CDDC341C6;
        Fri, 22 Jul 2022 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658515097;
        bh=yxyq7a2jEomP2Y5qR7Uos8qn+okY3YhRz9MvehQfMm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CyVXVug3Nt+MsbZ5O8hBnwnxJct6PxB1vaAqG5BncvrWRZQMPrwlx2VIgZcOxuaKG
         PePaAF34ef570pSN/VMZnMvjubUenVsFmzaQGze3jZxDAmBpdJMg0ui4q2lflJAZGq
         OiIk4kUkcNiJnXAtNKCe+99LK5qQkwnECayBVNRMIK7SCYQtHzr66wR9koJ0PQJ0kj
         //0NH17AqRSVDSx/se9np9lyjYAGiSXIh2ws0b0NDZXbQp1mbTqUPfb4Kz6YGYV1rU
         g2h0PkcPQ8C+UcRT4s2C/TwOd1qjUBJdpri4V1z5EuZ7Zprg3b5y+i6yFrfXwLSU6/
         IqjMUFA1hO9yg==
Date:   Fri, 22 Jul 2022 19:38:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
Message-ID: <YtrukeLk9fInqQIL@sirena.org.uk>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u7Z7lZkjhnzZyt/z"
Content-Disposition: inline
In-Reply-To: <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
X-Cookie: Yow!  I want my nose in lights!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u7Z7lZkjhnzZyt/z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 23, 2022 at 12:48:30AM +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou=
 Yanjie) wrote:

This looks mostly good, a few small issues though:

> +++ b/drivers/spi/spi-ingenic-sfc.c
> @@ -0,0 +1,662 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Ingenic SoCs SPI Flash Controller Driver

Please make the entire comment a C++ one so things look more
intentional.

> +static irqreturn_t ingenic_sfc_irq_handler(int irq, void *data)
> +{
> +	struct ingenic_sfc *sfc =3D data;
> +
> +	writel(0x1f, sfc->base + SFC_REG_INTC);
> +
> +	complete(&sfc->completion);
> +
> +	return IRQ_HANDLED;
> +}

This doesn't pay any attention to any status registers in the chip so
won't work if the interrupt is shared and won't notice any error reports
=66rom the device...

> +static int ingenic_sfc_setup(struct spi_device *spi)
> +{
> +	struct ingenic_sfc *sfc =3D spi_controller_get_devdata(spi->master);
> +	unsigned long rate;
> +	int ret, val;
> +
> +	if (!spi->max_speed_hz)
> +		return -EINVAL;
> +
> +	ret =3D clk_set_rate(sfc->clk, spi->max_speed_hz * 2);
> +	if (ret)
> +		return -EINVAL;

The setup() operation should be safe for use on one device while another
device is active.  It's not going to be a problem until there's a
version of the IP with more than one chip select, but that could happen
some time (and someone might decide to make a board using GPIO chip
selects...) but this should really go into the data path.

> +	ret =3D clk_prepare_enable(sfc->clk);
> +	if (ret)
> +		goto err_put_master;

Nothing ever disables this clock.  It might also be nice to enable the
clock only when the controller is in use, that bit is not super
important though.

> +	ret =3D devm_request_irq(&pdev->dev, sfc->irq, ingenic_sfc_irq_handler,=
 0,
> +			dev_name(&pdev->dev), sfc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq%d, ret =3D %d\n", sfc->irq,=
 ret);
> +		goto err_put_master;
> +	}

It's not safe to use devm here...

> +	ret =3D devm_spi_register_controller(&pdev->dev, ctlr);
> +	if (ret)
> +		goto err_put_master;

=2E..unregistering the controller may free the driver data structure and
the interrupt handler uses it so we could attempt to use freed data in
the window between the controller being unregistered and the interrupt
being freed.

--u7Z7lZkjhnzZyt/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLa7pAACgkQJNaLcl1U
h9BufAf+ML3z6pqB+9VRx2uVE2vDguPss14L7VVj8Szqp0T4Dmx4QF9s0u6QKqxP
9UUQHAEdO1N6Vh2SSdBGvOPPrChYaAWW3eA/t7ODFbynEkJ1+bq/UPQrVfOln8hs
8hEnsS1N3XHn4CRSfVBGsw4+FxsIG3t+sSXSHEqI8uk9aBJ2GUgWZepEJheNFK4a
NF6bAJnK896B73olJr0deNlCfhsvSiUqaAE5fxsLuWY7Ur1LNBG8JV5WvHGNEJkR
dknDfQL0Y4nWWlffbKz6VReB6dFvFGETgGfIDepjsxvznoXqAMdNYtwixpu5dVuO
hh/q4B5v95rS4/BjakpMCs+Jmw3Psw==
=c0js
-----END PGP SIGNATURE-----

--u7Z7lZkjhnzZyt/z--
