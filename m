Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4149535D80
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350616AbiE0Ji7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350645AbiE0Ji4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:38:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9BAEC31B
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:38:55 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nuWQb-0000vI-7x; Fri, 27 May 2022 11:38:41 +0200
Received: from pengutronix.de (2a03-f580-87bc-d400-1aea-9b27-7153-c563.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:1aea:9b27:7153:c563])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id BE52E86CB1;
        Fri, 27 May 2022 09:38:39 +0000 (UTC)
Date:   Fri, 27 May 2022 11:38:39 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: mxc-nand: Drop undocumented properties
 from example
Message-ID: <20220527093839.3byc6r6ixuu5givt@pengutronix.de>
References: <20220525205947.2487165-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bh6neac3glogmych"
Content-Disposition: inline
In-Reply-To: <20220525205947.2487165-1-robh@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bh6neac3glogmych
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.05.2022 15:59:46, Rob Herring wrote:
> With unevaluatedProperties issues fixed, 'nand-bus-width' and
> 'nand-ecc-mode' are flagged as undocumented. Removing them from the examp=
le
> is the easiest solution to silence the warnings.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

At least the 'nand-bus-width' property is described in
"nand-controller.yaml" and the "mxc-nand.yaml" refers to it.

| allOf:
|   - $ref: "nand-controller.yaml"

Is this ref broken?

regards,
Marc

> ---
> These properties may be deprecated, but they are still widely used in
> bindings. They either need to be documented (and marked deprecated) or
> removed from current users (i.e. dts files).
> ---
>  Documentation/devicetree/bindings/mtd/mxc-nand.yaml | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml b/Docume=
ntation/devicetree/bindings/mtd/mxc-nand.yaml
> index 73b86f2226c7..66da1b476ab7 100644
> --- a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
> @@ -37,6 +37,4 @@ examples:
>          compatible =3D "fsl,imx27-nand";
>          reg =3D <0xd8000000 0x1000>;
>          interrupts =3D <29>;
> -        nand-bus-width =3D <8>;
> -        nand-ecc-mode =3D "hw";
>      };
> --=20
> 2.34.1
>=20
>=20

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--bh6neac3glogmych
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKQnB0ACgkQrX5LkNig
013rPAf/T95ObL5kt1e5rsNh4vE5CHtYl1qVh4EBnyNLn0zn7UO2KVQvsC+PL8Kh
bHCC2BKCAOj4ArchBlSIHjBef7/TFe/xctP/L7CcmpusD7txFodk6v0RvkE/GqlQ
YbBCd0MU1AKYEeUtpxTijo+Zw1e2R+ZoafWFp/kGAMktAOc4K87zvC8ZJpCbRykF
mqDHSfs0GhXhy0JjQVu94eRLmHBwbBzT7XXfcc5yOG9V7aCVlanctAHkZYbSVBbS
+rJhJnV+UUqG4VK3xXaMKM3hBjQbPp8SxW2oZe+GudL6Rh33aq0oemAn5bzJLEfs
4Q8YCflj3GpSN4/skxLXg6umG1Rebw==
=ikYa
-----END PGP SIGNATURE-----

--bh6neac3glogmych--
