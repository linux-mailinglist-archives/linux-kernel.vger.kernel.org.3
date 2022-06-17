Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA49754FB53
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383397AbiFQQmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383384AbiFQQmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:42:44 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F11C632D;
        Fri, 17 Jun 2022 09:42:42 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 880EF320094E;
        Fri, 17 Jun 2022 12:42:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 17 Jun 2022 12:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1655484158; x=1655570558; bh=AiSSKnRv3m
        zrSKSMor1JpwujxpGQtnv79xXFLeYhgvM=; b=aWJ1WEAB7fpW3ksRDFuo+wlB7T
        QyH5gRz+OrZHIEnuu1Q0h2c/jNLK6vfxIeok3dOj6duThJ4E2xe4xTeaJp52gPp3
        BXg9EqYuyV6LxTIGh7zGbF48O8ySDN7sGi6sHJL3iQ7AGmof0Q3v+9uWE4lz81xQ
        1mgnObakMLIyipm6DqmQ5qRZu1hwH09VL84Nq8Nqm7TlJ4r0tbK7tyXK9nWBtycJ
        UUfHkijnECeXXTWD1H209NH+McAfaxZPwSdQy+1R8telkDSA3JfXUEWQ/tfq5U6X
        S+fgOwlzMsRhH1IO8dO+nxk8xOsk+duLf3P7ohvHGvDJSGv+dRwrzNOKOd+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655484158; x=1655570558; bh=AiSSKnRv3mzrSKSMor1JpwujxpGQ
        tnv79xXFLeYhgvM=; b=WdbnG9Mxrwj0toMuApALwtgRZd3wp96RyLRMt1T1T178
        xmszSIuCUxiyV6v0J0hTzzZCEf6MS3cG3qYp5FG2jFp1Cj0nKL3CUc17HdO8xTaR
        2Nqx4O3GTSw9Meek3sVu4JbPm6pZpFg6h3t/rj7ZMLKEwSQPx9z+B5yT0tq+2Q+T
        w7GzL6kczaTqJXVT8GVEix0X98I4foDSQi02NkZ1Tj2kYvy4h5C+E3irIy7lp+re
        5fYnlOCqzk7okgLp2FYD7fLaJmf7Z9nEHqO7dLKCibtcd0Iz08iI4CQMrp7tHDwf
        sCFWpd6XQVaq+iGXql1RbCPaQ2GW0cXO7+l+Nuymlg==
X-ME-Sender: <xms:_K6sYhtK7HDaeNX45fyU_hOMZdqLBPxIAEvOpRyYjuR-WPoIZNL6Eg>
    <xme:_K6sYqfrCWJe7BLcgJ69dNEOnXWiylMq0jwSj-dZZVVPAlZfzLLMmhiltn2boAXkx
    3xcEdioSwrQxzC57fM>
X-ME-Received: <xmr:_K6sYky4Ra-qIClGrA4jLZudJc3DLCVD-EAECpC6rJJeNJOpZwrVDJzoq4tVNltkQNK8m4cr3pHe7ffqTRBWFRz7Il0SmvZ4lGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreer
    tddtvdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkh
    esshhtfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepjeejteelheelieejuddtudff
    hfeuueefhfefleehveegvdeigfffheduleehlefhnecuffhomhgrihhnpehgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:_K6sYoMsN1fwFafBxX59k46vv3devjC-WHuIGGzm-SVErQGl5SgzHw>
    <xmx:_K6sYh9qg5OFy7N2L4mWGMNhzujzp1YSr76PMN5PcH9NFmBZVkq4aw>
    <xmx:_K6sYoWlxhduHsqMDjuI23Nh5ieZQqN-GwzLtT7Co8QRCym0PonHPg>
    <xmx:_q6sYvejfzFvkJrNZt9n0skAMhKXbzD8OrVFLsrL0TSWh5chXTdYJg>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jun 2022 12:42:36 -0400 (EDT)
Date:   Fri, 17 Jun 2022 11:42:35 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Logananth Sundararaj <logananth13.hcl@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, garnermic@gmail.com, thangavel.k@hcl.com,
        naveen.mosess@hcl.com
Subject: Re: [PATCH v2] ARM: dts: aspeed: Adding Facebook Yosemite V3.5 BMC
Message-ID: <Yqyu+y9ms/DmFCbJ@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220616120707.GA22590@logan-ThinkPad-T14-Gen-1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5N0BVpXlyV7XdVV7"
Content-Disposition: inline
In-Reply-To: <20220616120707.GA22590@logan-ThinkPad-T14-Gen-1>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5N0BVpXlyV7XdVV7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2022 at 05:37:07PM +0530, Logananth Sundararaj wrote:
> The Yosemite V3.5 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V3.5 platform based on AST2600 SoC.
>=20
> This patch adds linux device tree entry related to
> Yosemite V3.5 specific devices connected to BMC SoC.
>=20
> Signed-off-by: Logananth Sundararaj <logananth_s@hcl.com>
>=20
> ---
> --- v2 - Enabled i2c drivers.
> --- v1 - Initial draft.
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-facebook-fby35.dts    | 277 ++++++++++++++++++
>  2 files changed, 278 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-fby35.dts

A few comments below.

=2E..
> +&uart5 {
> +	status =3D "okay";
> +	/* Workaround for AST2600 A0 */
> +	compatible =3D "snps,dw-apb-uart";
> +};

Is this comment accurate?  Are we using A0 hardware on this system?

> +&fmc {
> +	status =3D "okay";
> +	reg =3D <0x1e620000 0xc4>, <0x20000000 0x8000000>;
> +	flash@0 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "spi0.1";
> +		spi-max-frequency =3D <50000000>;
> +		spi-tx-bus-width =3D <2>;
> +		spi-rx-bus-width =3D <2>;
> +		#include "openbmc-flash-layout-64.dtsi"
> +	};
> +};

Aren't there two SPI flashes?  It seems like it based on:
https://github.com/facebook/openbmc-linux/blob/dev-5.10/arch/arm/boot/dts/a=
speed-bmc-facebook-fby35.dts#L162

> +
> +&spi1 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_spi1_default>;
> +
> +	flash@0 {
> +		status =3D "okay";
> +		m25p,fast-read;
> +		label =3D "pnor";
> +		spi-rx-bus-width =3D <4>;
> +		spi-max-frequency =3D <100000000>;
> +	};
> +};

What is SPI1 used for?  I don't see it in the facebook/openbmc-linux
DTS.

> --=20
> 2.17.1
>=20

Are we missing the pwm/tach support?  Or is that still not upstream from
Aspeed?

--=20
Patrick Williams

--5N0BVpXlyV7XdVV7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmKsrvsACgkQqwNHzC0A
wRnIcQ//VcCo6ddGOZm0/gcObmyDc7rvp8grACdL5h0TbcdIsfsewa4a+/bp6ZmV
flPUo9HCS4mqkHhip2YZbIfiv4ksneGst6p3LupEwLkba87dtBqgrbMhEGTcrjiz
fJ3DfwnbPrmexUY3UiNZYifiej2L4PwKk/exlj2hx5VKyErHns+T3vuFov/LkLQX
B5o1KWNis2E6Luj8olDfdnHQm7LR5Xsi7j9G1ZAYyb8Uro5Osja/GpAkqOxMKWoM
ZpaavyncNeSBiJH6gMYDN2qEwhuWgMVd1nh0OEbNEk0ZfdySMjLHmHqTBX2fXQ/f
OchWoLQVoC9Je9k8DAkmJ/cw5n9vOx63CyFezeuI5sFPU8S7DLXH1YFZGkES9cF7
mw+Waxpho39r3wTNMfA6gM1dQ7L+TJxXrjH6W3FfwD6100611QdKX6tfIjiVMAal
7Urzckk+EN2G5AbMnuede7Xfm2iRrZjSwDkG32/xSo7XtN0ZN/X9E4YWVWktxJ8E
+pi0fLHaRl2jcgKWYKQGhQc+BTZxS6b1cjJQSNuJSTDaeyQLFAEyyWr2vXGv0OUv
lYqB2y2bVrVX1VFHOsO+7eUyT84nekhmEbKJ6Yu95Wr1PgXaQRsQ4loA/aqHPqhY
sb2g9WrcUvuycVQbXM4pKwwBfayoj4j8APpfFLqIJ9yiHk9R/tA=
=aJmc
-----END PGP SIGNATURE-----

--5N0BVpXlyV7XdVV7--
