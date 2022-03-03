Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57194CB722
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiCCGnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiCCGnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:43:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C11C1688CE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 22:42:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPf9i-0000cS-G5; Thu, 03 Mar 2022 07:41:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPf9a-002MQZ-Jb; Thu, 03 Mar 2022 07:41:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPf9Z-006eej-4Z; Thu, 03 Mar 2022 07:41:33 +0100
Date:   Thu, 3 Mar 2022 07:41:30 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Fabio Estevam <festevam@gmail.com>,
        linux-riscv@lists.infradead.org, Vignesh R <vigneshr@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Jeff LaBundy <jeff@labundy.com>, linux-sunxi@lists.linux.dev,
        linux-pwm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 00/15] pwm: dt-bindings: Include generic pwm schema
Message-ID: <20220303064130.lzvptbq3hpny74ke@pengutronix.de>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
 <211b3d35-1d8d-b71c-996a-b185324815f7@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="szkcsdi5ha36tvvv"
Content-Disposition: inline
In-Reply-To: <211b3d35-1d8d-b71c-996a-b185324815f7@canonical.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--szkcsdi5ha36tvvv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

(dropped Anson Huang and Yash Shah from Cc, their addresses bounced last
time I used them.)

On Wed, Mar 02, 2022 at 08:04:45PM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2022 22:21, Krzysztof Kozlowski wrote:
> > Hi,
> >=20
> > Changes since v1:
> > 1. Add tags.
> > 2. Adjust subject (Uwe).
> >=20
>=20
> Hi Thierry, Uwe and Lee,
>=20
> Any comments here? Rob acked all these, so these are clear to go via PWM
> tree.

They are fine from my side:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

It's Thierry who is reponsible to pick these up and it seems he marked
the series as accepted:
	https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D286150&state=
=3D*

So I would expect that it turns up in next after Thierry is done with
his testing.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--szkcsdi5ha36tvvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIgYxYACgkQwfwUeK3K
7AlLnwf/RtAHP6ySxnXSdGI6h/ICx3Q7FjK5zy2WDgciveSQhO92SP1TrQR8Ll0H
CN5ftiC6uc/PqFXfnzno/ZKrQ+yhwuL3GNWl/tK070bXLkZS9rtZoo62p2DxK6/U
V9GQpUSATRqU19pMkuje+qfbL5o5gTzehAAtQq/aQLEUqn0R46gk4DnYVuFK9ezV
KLe6HD8NoNbclEkJwJ6NKZKgwxIck0g3HFqTwHD7PEHb1i1R1teL4M3lacIflRMB
dNw2LCVgIFw/Su/sZWL/sj2vilOrKUQD+R+O4vOzxqEO7TrSOZgHitAHOWs2uBI6
NeJ60SyXxmDSYCmuEiZVL1Fax6Dldg==
=/r9+
-----END PGP SIGNATURE-----

--szkcsdi5ha36tvvv--
