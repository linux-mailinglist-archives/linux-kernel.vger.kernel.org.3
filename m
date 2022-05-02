Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193E3516ECA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiEBLYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiEBLYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:24:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827FF12AD6;
        Mon,  2 May 2022 04:21:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E69735C009E;
        Mon,  2 May 2022 07:21:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 02 May 2022 07:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651490474; x=1651576874; bh=/HFvyCgF45
        DiVip9szDLN9IPhqJ4EuOs8Zamh5E+TEw=; b=UMq6g5QFW/N2Xm7MpjJOhNsH9S
        Z2udjefqHLtg0yV4fNRHD24cVPL5tY5uKcURG9ar+S36Mmx8Mf1sJGF+n6Dk1fvu
        txdSwExSetlsp7kxPElyT8WoPCS/K6zLyGL/LeF+FJYbkgDF2WffblkrrtX+dlu0
        Y4PSQZfT3NmCiqgWbuZOvAJaLbAXLpoV9RItF2gZBO6ZB4nc1R8F7eihk+LrXqTY
        J/Vg8gtdSnD8afZm1OXftv/4kJWu7eDKMbv1sUWTS0af4j6m2bl1+xkFdKVS6H9j
        aULgyf1HSawcVz7gRnQ+P0NLmMtFZHaQSzU/JT4A7RgHuXl3hgoMwHAKoaWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651490474; x=
        1651576874; bh=/HFvyCgF45DiVip9szDLN9IPhqJ4EuOs8Zamh5E+TEw=; b=t
        HHbNwQkNggwVCtXe3/M8PkMetlJJa15JOh1f6tKm6UvrQ8dUHg1JGt/EP6LvH5JB
        8i3v7nlNYezBi40oIjw85yFyCjH6QqcqEA+lMvrjCon90H3Z8tLthnBQq4XLGJsp
        kFSw+WA3a3gjyPJXg/iZwrGnXGNgxripvvyFJHUvscVWH6h92TWFRztG0/5D4LiW
        YrZVKPo37tSOTpt78KaaBTXKW6JhVzEym7+/bzvgaNgTCPqTj4aN7fGbZWkXGl8L
        59TjDf2icZLyZS6u48tD/2peTL+jnlug6wL5CrLJZiyB/8wnP511uRb5PsZRwz8n
        ZjmZ2ClAt7i+86HE0iWmg==
X-ME-Sender: <xms:qr5vYumONgG9-R_uQnc5VH0rlrkdVNRzfe4ASrB4N28YkWXPwuCYNQ>
    <xme:qr5vYl1LYp3YYbSVUP62rjq19_2l6VLAsvgygaJ5sWBHqXqUZikyRNfxFb4j4guvo
    NyRswT1UQGX8f8Glxo>
X-ME-Received: <xmr:qr5vYsr8q2nQup_EdnTEabCfjxToRVdzTNsyZXC7jsKbfgsqz1lia3Mym84C-U7A4LgZnLZAvOdcyjSEpK3KfrwJC3ckTGtsxF86ntg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfduhedttdegudffuefgvefhveejtdevgeegteejudeuueefvdfgkedvuddv
    hfffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:qr5vYimKc_7jj77jC-dHyKzNkwbgbZkKuGs5KC5dM23SR35JvU2NEQ>
    <xmx:qr5vYs1tYk0ZYBowxe_KuZgwu21tOAypYDE9TR8xBJseIsp34YhKyQ>
    <xmx:qr5vYpuKceG4J1g6hBtf0D0yv8HEAB1ub7G5lQYWiTh0Cq0o3FAKZQ>
    <xmx:qr5vYiyHE5rS7y57UX5KbDGjX7lXrg8Qxu9LEhi88aqXYEQB3L6Z0w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 May 2022 07:21:13 -0400 (EDT)
Date:   Mon, 2 May 2022 13:21:12 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Ruslan Zalata <rz@fabmicro.ru>, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
Message-ID: <20220502112112.3ne7zy4b6gggxzoo@houat>
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <20220502110010.q7vvdkdpaiz5acjl@houat>
 <7433B295-D896-4BF8-87DF-87EB89D7A550@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mg35qjdbc5ra2hwr"
Content-Disposition: inline
In-Reply-To: <7433B295-D896-4BF8-87DF-87EB89D7A550@aosc.io>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mg35qjdbc5ra2hwr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 07:15:01PM +0800, Icenowy Zheng wrote:
>=20
>=20
> =E4=BA=8E 2022=E5=B9=B45=E6=9C=882=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=887=
:00:10, Maxime Ripard <maxime@cerno.tech> =E5=86=99=E5=88=B0:
> >Hi,
> >
> >On Thu, Apr 28, 2022 at 09:09:03PM +0000, Ruslan Zalata wrote:
> >> Some Allwinner SoCs like A13, A20 or T2 are equipped with two-channel
> >> low rate (6 bit) ADC that is often used for extra keys. There's a driv=
er
> >> for that already implementing standard input device, but it has these
> >> limitations: 1) it cannot be used for general ADC data equisition, and
> >> 2) it uses only one LRADC channel of two available.
> >>=20
> >> This driver provides basic hwmon interface to both channels of LRADC on
> >> such Allwinner SoCs.
> >>=20
> >> Signed-off-by: Ruslan Zalata <rz@fabmicro.ru>
> >> ---
> >>  MAINTAINERS                       |   6 +
> >>  drivers/hwmon/Kconfig             |  13 ++
> >>  drivers/hwmon/Makefile            |   1 +
> >>  drivers/hwmon/sun4i-lradc-hwmon.c | 280 ++++++++++++++++++++++++++++++
> >>  4 files changed, 300 insertions(+)
> >>  create mode 100644 drivers/hwmon/sun4i-lradc-hwmon.c
> >>=20
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 5e8c2f61176..d9c71e94133 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -18861,6 +18861,12 @@ S:	Maintained
> >>  F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-=
keys.yaml
> >>  F:	drivers/input/keyboard/sun4i-lradc-keys.c
> >> =20
> >> +SUN4I LOW RES ADC HWMON DRIVER
> >> +M:	Ruslan Zalata <rz@fabmicro.ru>
> >> +L:	linux-hwmon@vger.kernel.org
> >> +S:	Maintained
> >> +F:	drivers/hwmon/sun4i-lradc-hwmon.c
> >> +
> >>  SUNDANCE NETWORK DRIVER
> >>  M:	Denis Kirjanov <kda@linux-powerpc.org>
> >>  L:	netdev@vger.kernel.org
> >> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> >> index 68a8a27ab3b..86776488a81 100644
> >> --- a/drivers/hwmon/Kconfig
> >> +++ b/drivers/hwmon/Kconfig
> >> @@ -1691,6 +1691,19 @@ config SENSORS_SIS5595
> >>  	  This driver can also be built as a module. If so, the module
> >>  	  will be called sis5595.
> >> =20
> >> +config SENSORS_SUN4I_LRADC
> >> +	tristate "Allwinner A13/A20 LRADC hwmon"
> >> +	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
> >> +	help
> >> +	  Say y here to support the LRADC found in Allwinner A13/A20 SoCs.
> >> +	  Both channels are supported.
> >> +
> >> +	  This driver can also be built as module. If so, the module
> >> +	  will be called sun4i-lradc-hwmon.
> >> +
> >> +	  This option is not compatible with KEYBOARD_SUN4I_LRADC, one
> >> +	  of these must be used at a time.
> >
> >How do you plan on enforcing that?
> >
> >I guess a better path forward would be to either register an hwmon
> >device in the original driver, or convert that driver to iio and use
> >iio-hwmon.
>=20
> I think this driver should be use IIO, and then try to probe an IIO input
> if possible.

It's been a while, but if I remember well we couldn't use IIO for that
driver because it's not generating interrupts all the time but only when
it goes over a given threshold:

https://lore.kernel.org/all/52C5E9F1.9010700@redhat.com/

I'm not sure if it's still relevant, so we might just need to add an
hwmon driver to the existing driver

Maxime

--mg35qjdbc5ra2hwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYm++qAAKCRDj7w1vZxhR
xZfzAP45baOfMHgE07gDuTms0R435nh6idYPLh86SZXpVD1x0wEA0e2PYbOvaM4Q
hel2Z4Gtv0wdzACyM6T9aRjdarTmdww=
=z935
-----END PGP SIGNATURE-----

--mg35qjdbc5ra2hwr--
