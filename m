Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF55170BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385352AbiEBNnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385346AbiEBNnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:43:01 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB90DED2;
        Mon,  2 May 2022 06:39:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B0B65C00E1;
        Mon,  2 May 2022 09:39:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 02 May 2022 09:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651498771; x=1651585171; bh=b/HxRexqfg
        Eb8+SHUnuabjiYGZLnMMek+P3/ue2RuKo=; b=kqHt5l9GKf/t74JrB2a/N3kLZv
        0amV60x+HegodkRcYRpR0bwgE6HqVice9AkD5bn/AO+XAPVv6VsD18gECO6MIzBe
        Ch4NxwghtZ19LHZLm4tN/NsIbTmLX0P3vTpPaoCNAoTK1BnuyMVaNx2XvO2QwnbW
        JrOXSnGAmyBvpYEdmAQiFbaggGaRK5KQGjHmB4z3bGDNuqOX0jxzVVV2AiciYhUM
        3YVzS6sHJiP/m7+JZSlVPl3XIyytLx+vEjmQc+wslUxVUly0vBDROBVz1kgduxXl
        G59xKcwCZ1jZGuWl5V3NHgT4FEawobSfO4BHuEqlE2geGytd0QRp0vESAqEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651498771; x=
        1651585171; bh=b/HxRexqfgEb8+SHUnuabjiYGZLnMMek+P3/ue2RuKo=; b=N
        IRUbTsQaEhLeVEydXxCOFA8ChDyAivepcydJpPl6CArJV58na9ilEqft3/lWjUR1
        M6vAsuLbRJ/oRGLrq3HZaRKmyfO3mDnqHNNidYkCJa/rAr6ElTkSfxpsaa4GQzPT
        zuthGkbJgb+A2OuFB4vp7K4Voyq2061I0eCbz3jLYkPYNC35+Y12+emNo/xq+cNj
        yDr2sgpcQvlNQERSZ/s7EWk74o9zUb+5Uo//QtXMmFAopwJJ4cpfuZiZXXv1Y7cv
        QG3/nfDSqzPASWLls37MCkGmB0ivX4YFmybGZIfJ/Mv9Y/uf7w7B8dt3J8VpIV/R
        dGOzKmA/Ox578Q3seSNPg==
X-ME-Sender: <xms:Et9vYlrjslC-ETH5AGbvpaQhjJghfwDbDa7OHLx1eVTNemm0Xh6iSg>
    <xme:Et9vYnrFW_9ezUl8rETO4ojr7EUTqkWuwFJvXi0pJcsXGUpFAsZg_mKBuFZ1kxM45
    DZIoobe7BSSRCFXQ5o>
X-ME-Received: <xmr:Et9vYiMJV_06NYgYMOeWBtuO5cijNKXbghu3bTnH1oo6PPm1jMEOzoJ9AVDjcI02QGoqPdlvjxSInHqbYTwM6FLwhCC1T9FwC_kIZpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Et9vYg7CaxtWDU2eqb9e9kqqPZm9bxaJW_tGKYuHvoRcKfGifUUFQw>
    <xmx:Et9vYk74ZcL7Qer8JM-aditq1vPt4bMcpIRn2hxCTiRt_nm1U5KJtg>
    <xmx:Et9vYohpT28Gl5j9b3dNLYqAHqkjv4n4bggMTLkm71KFFC1rmn3hEg>
    <xmx:E99vYmuAtnzedLswK4NAkLoRolYaZGRj7heks-VeQkHZf3OutTBzog>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 May 2022 09:39:29 -0400 (EDT)
Date:   Mon, 2 May 2022 15:39:27 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ruslan Zalata <rz@fabmicro.ru>, Jean Delvare <jdelvare@suse.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
Message-ID: <20220502133927.4wqhru4es32gws2b@houat>
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <20220502110010.q7vvdkdpaiz5acjl@houat>
 <21a89ae0-7152-49eb-7500-7d46dfb259f6@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tamuqpt5k5qosgyi"
Content-Disposition: inline
In-Reply-To: <21a89ae0-7152-49eb-7500-7d46dfb259f6@roeck-us.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tamuqpt5k5qosgyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 06:31:56AM -0700, Guenter Roeck wrote:
> On 5/2/22 04:00, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Thu, Apr 28, 2022 at 09:09:03PM +0000, Ruslan Zalata wrote:
> > > Some Allwinner SoCs like A13, A20 or T2 are equipped with two-channel
> > > low rate (6 bit) ADC that is often used for extra keys. There's a dri=
ver
> > > for that already implementing standard input device, but it has these
> > > limitations: 1) it cannot be used for general ADC data equisition, and
> > > 2) it uses only one LRADC channel of two available.
> > >=20
> > > This driver provides basic hwmon interface to both channels of LRADC =
on
> > > such Allwinner SoCs.
> > >=20
> > > Signed-off-by: Ruslan Zalata <rz@fabmicro.ru>
> > > ---
> > >   MAINTAINERS                       |   6 +
> > >   drivers/hwmon/Kconfig             |  13 ++
> > >   drivers/hwmon/Makefile            |   1 +
> > >   drivers/hwmon/sun4i-lradc-hwmon.c | 280 +++++++++++++++++++++++++++=
+++
> > >   4 files changed, 300 insertions(+)
> > >   create mode 100644 drivers/hwmon/sun4i-lradc-hwmon.c
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 5e8c2f61176..d9c71e94133 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -18861,6 +18861,12 @@ S:	Maintained
> > >   F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lrad=
c-keys.yaml
> > >   F:	drivers/input/keyboard/sun4i-lradc-keys.c
> > > +SUN4I LOW RES ADC HWMON DRIVER
> > > +M:	Ruslan Zalata <rz@fabmicro.ru>
> > > +L:	linux-hwmon@vger.kernel.org
> > > +S:	Maintained
> > > +F:	drivers/hwmon/sun4i-lradc-hwmon.c
> > > +
> > >   SUNDANCE NETWORK DRIVER
> > >   M:	Denis Kirjanov <kda@linux-powerpc.org>
> > >   L:	netdev@vger.kernel.org
> > > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > > index 68a8a27ab3b..86776488a81 100644
> > > --- a/drivers/hwmon/Kconfig
> > > +++ b/drivers/hwmon/Kconfig
> > > @@ -1691,6 +1691,19 @@ config SENSORS_SIS5595
> > >   	  This driver can also be built as a module. If so, the module
> > >   	  will be called sis5595.
> > > +config SENSORS_SUN4I_LRADC
> > > +	tristate "Allwinner A13/A20 LRADC hwmon"
> > > +	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
> > > +	help
> > > +	  Say y here to support the LRADC found in Allwinner A13/A20 SoCs.
> > > +	  Both channels are supported.
> > > +
> > > +	  This driver can also be built as module. If so, the module
> > > +	  will be called sun4i-lradc-hwmon.
> > > +
> > > +	  This option is not compatible with KEYBOARD_SUN4I_LRADC, one
> > > +	  of these must be used at a time.
> >=20
> > How do you plan on enforcing that?
> >=20
> 	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC

Right, but that just doesn't fly for any generic distro / build-system.

Maxime

--tamuqpt5k5qosgyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYm/fDwAKCRDj7w1vZxhR
xSVHAQD142Lap5ZsMcemWljKEK+KsiCz85L2Rgh7n1gU1OLGQwD/UT/E/ugwkLyK
p/8dvzoTP4avZO6kO1wOsHMzgQVfrwM=
=ZSfL
-----END PGP SIGNATURE-----

--tamuqpt5k5qosgyi--
