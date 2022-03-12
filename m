Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C54D7089
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 20:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiCLTZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 14:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiCLTZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 14:25:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79A1E0147;
        Sat, 12 Mar 2022 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647113042;
        bh=BiQBm2UCZmXDRmTqod0u4Z76MdsDly3+2N9yHM33E/4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=E/xboekxgiea0zyl4r8K50w4kZqKzc6jVxT7XTW0NAn8v5gGmZ6MBYq9Hga5Uq/Pl
         s+8MbNq0egdEeMC83ofkg45H7SvXwKjCshpSWp2syv6FoaHZlq+ustlX+4FgpCYDGy
         9/aA9Gnwf49b3sS2tjNHZIgmty3BQiFHbClft/pU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1nN1Tf3Ini-00FzMx; Sat, 12
 Mar 2022 20:24:01 +0100
Date:   Sat, 12 Mar 2022 20:23:48 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alistair@alistair23.me,
        samuel@sholland.org, josua.mayer@jm0.eu,
        letux-kernel@openphoenux.org
Subject: Re: [RFC PATCH 1/6] dt-bindings: display: imx: Add EPDC
Message-ID: <YizzRKSDvHon83ks@latitude>
References: <20220206080016.796556-1-andreas@kemnade.info>
 <20220206080016.796556-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4dGDc1ulGkdHTd51"
Content-Disposition: inline
In-Reply-To: <20220206080016.796556-2-andreas@kemnade.info>
X-Provags-ID: V03:K1:O/HCc+HDKnwFzBvV8D7YKaDp+2sxe1jqC9CVwWViznBPNN7xWNG
 5G2h8HSNsT9FWHB+AtmX6EfpTuqRFDPXTehKmY4uCiu0hV334h2VcLXBUyFiqk41ROadDV7
 g1IvldVtoNvTTXbFhPfWSaPZYRsCyvZXHZBI66eAAWDmw8395cI7zelEuULsQ5AYBiJWGO/
 WiTVWTluht/pjXQ4RgGTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D1NYddq4Moo=:L2YrP5XMIwYlGi/tUVBvWV
 Vzcc1fHFEUoUyRFL3cUwpDqeVsmNRmBWJMf4FsE66lRCwKXZ+yweO3SjysUodGEhicGdZHk/e
 Lk+ad3niPLIRdyf9osntRqucEdpcuPAOJjGMG5xSq4Qk8aGM2UkAILtqV0LHnT03r0k39IJqD
 0GzEC4M711WrUPkQ5Mpq5+jYBpN0SvIgedMpWRqS1yyTeiEgmTEAlfKRNneky32aVdKoP3BRz
 XBS8CoKof83v0gDT8rTsWaBJrDWqp5A8tkKfAwT+WbFetlkvTd7nuTqA3xYuUWrzjIFMwjJ5t
 WI1ErMCkTLBEzlJXC4ySLa3ry+uhNQKaLAVgwdUMQ9Ri/3Z8e/YlNxvTAX61w+w+oO76ZK6hh
 q8sh9wN0AFS3yo9+zIXyD0o6ezTrdF1n0VwNwoseGkNKWJmFGxWv5SsjWk+4XqKeWR2qdiTCP
 ZU6zG3uqxRcNIlJvyPCgDyK75J1N8SVh4ganXvmuIeuPIRkJcC/rJHnxJLBBStJKQgvqJPmL1
 3eu5sH8tuDjx10fqqduhXj1OTq+f2ZOXwMtRewdfrX+hARV/EqCSKhOnGpSqVVfU2+J+UJQWG
 cyDryMlx+SMd79qL1854VbAc3zv0IysDaRqMzskf4Rcw8RqcCrDmLz+wWY1e9vYZ2bm2oFzCZ
 YQRmJFhVQXe8z3GsVZH9jEfBDOf2c+BboFKXLvCGPsBBtT3WlkqV4cXyjuQ23XAQwNQJxpDxx
 M6PL0U+ebZVmMo5R1q93HgB5Olk7mD2zszI7EEBlzv+rBUB3m4+2LfnMN1V/G030oIOAwz2Mr
 ZY56/xB+UFir9Q8OnhskGG1c9hIDUVzSpU6WJfrsAlAvhIRZHcbbWEqsz+1paGbHoac7BYDr0
 2Uf06hYzgCiSbwh3m+vf5bLZUUgVL9tohv6sV28Es9E3P0N7DZZsT0NiLKG4GYV3RMggdqySW
 4zZ7DRghUFC1qFUmvZ7KDhdBcXF043jyxvEivvqjLIntv+SwSASRS1NnEYk0jHe+Rac1h4VyE
 PzErTrVkqMeASGYeZITEQLBtdDoM6WnzDQqf3tVfzG7aeA35Z8mxUkrf5oBsdKuulJcqMt8Pk
 1ilaZXm0KiqJNQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4dGDc1ulGkdHTd51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andreas,

Sorry for the delay, I finally got around to having a look at the
patchset.

Some comments from skimming the patches below, and in my other replies.


On Sun, Feb 06, 2022 at 09:00:11AM +0100, Andreas Kemnade wrote:
> Add a binding for the Electrophoretic Display Controller found at least
> in the i.MX6.
> The timing subnode is directly here to avoid having display parameters
> spread all over the plate.
>=20
> Supplies are organized the same way as in the fbdev driver in the
> NXP/Freescale kernel forks. The regulators used for that purpose,
> like the TPS65185, the SY7636A and MAX17135 have typically a single bit to
> start a bunch of regulators of higher or negative voltage with a
> well-defined timing. VCOM can be handled separately, but can also be
> incorporated into that single bit.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../bindings/display/imx/fsl,mxc-epdc.yaml    | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mxc=
-epdc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.y=
aml b/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> new file mode 100644
> index 000000000000..7e0795cc3f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
[...]
> +  - vscan-holdoff
> +  - sdoed-width
> +  - sdoed-delay
> +  - sdoez-width
> +  - sdoez-delay
> +  - gdclk-hp-offs
> +  - gdsp-offs
> +  - gdoe-offs
> +  - gdclk-offs
> +  - num-ce

These parameters should perhaps have sane defaults in the driver, and be
optional in the DT.


> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx6sl-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    epdc: epdc@20f4000 {
[...]
> +
> +        timing {
> +                clock-frequency =3D <80000000>;
> +                hactive =3D <1448>;
> +                hback-porch =3D <16>;
> +                hfront-porch =3D <102>;
> +                hsync-len =3D <28>;
> +                vactive =3D <1072>;
> +                vback-porch =3D <4>;
> +                vfront-porch =3D <4>;
> +                vsync-len =3D <2>;
> +        };
> +    };

The way you did it here, the timing parameters are directly under the
EPDC node in the DT, but I wonder if it would be better to have a
separate node for the display panel, which can then provide the timing
parameters either in the DT or in the panel driver (selected by compatible
string of the panel).


Jonathan

--4dGDc1ulGkdHTd51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIs8yAACgkQCDBEmo7z
X9tJ5hAAxertxtsQerEUdypFRk6tF6GZ7tpwhND2/arfmp7+/DAZ8Uq52gl8tHNN
gBfg99ukZ4HftCbcoPMLaqNi5K1nB6+igACg6tIuXj9GoTyniynnZjrcDT/0Hzhu
zEQQxUDcDIZc1JuqVmaE5nMyE+Tgpz4bHxZNqfSnYcvcqxaE1UHczrPZxblz80X0
ZDFBPYmgFKXKHbmQYaaODTpgDVMQ74EEuTSuWcPLqUEL68kQsYkrOnULAr5A5AhZ
ppFSj2C5AfAGRN3Qe08P7FEEi7SyhGC+iARK/wnLHkSNamYXgz8SVpKsgMnoZeal
QUnOft+ZkAyPIKBo3aDVpRfodPJ48s0gj1NhCarYr8cEuNsyZXfysoeRCGOiRlzp
8+B5zLoyh1FDrJVBL5ptNDlYWyqew6MnXgVnmt6rcgMKKVrJvZ8hTbMBEkV3ZsY1
vs/Se9Jyhhasow734cG2+2zt0IPhrO4m7/Zoeci2zNPmvj4ZtPYc8aTdXQx7RUl8
CLfX59/st5hWgVV2O/CY8tQUrjdLCXp0jHYYWIxoKprFh7ekNYdw/D8BqwNI5c+S
RUO5yw8Tu6Y/wVAsrHtn+E8m6mTI6B9yAxM7ltwY2/9svVsLcPO0UCLUSnDtFvlg
X5MGbxTMdPI4Kbz2rixXEIp3en0OobFSJctn9SLZWqXhXTzyQjs=
=lMbE
-----END PGP SIGNATURE-----

--4dGDc1ulGkdHTd51--
