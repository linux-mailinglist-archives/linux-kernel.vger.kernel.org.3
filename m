Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2D4B304E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354050AbiBKWVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:21:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354027AbiBKWVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:21:02 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE204D4A;
        Fri, 11 Feb 2022 14:21:00 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BE9693200F9C;
        Fri, 11 Feb 2022 17:20:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 11 Feb 2022 17:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=YvSCKSU842KzUhf1LCRE65E1fnv+NK6PdKlIlr
        Basv4=; b=xeDJtk6zHVtUdiFHLhCC/YBEB2g3ZJsr0pN0e/420tNIotNVFwBt2e
        C45b16uOVdnz7RcPh587jto9J3KyZ4VKLO9/v3b8r7g9Y0aiqvPavimtQQsWtAAe
        IRG0911yqXFINWdI9cm4wGSH4lXFVPz9+w5p1QOdSFOQmrR5yFCVI8HmBa+C7w/8
        C1YqfpsYEPolsFufZheIc5I1Maz4Sd1FOYb4gRxzOjURbAxaziVQDviltIX6XHq4
        c7dXV1chNbs09PeFgqSvVJPLI+AeUX4KvDaqiUE8OO3ynJ6kR/Qr3F3iFc5U+40D
        oQwdaSVOrqNzvKHqcSDNMsa+mmpsGjYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YvSCKSU842KzUhf1L
        CRE65E1fnv+NK6PdKlIlrBasv4=; b=P1WnFAFFnm8D2e+2b0zfbIs5NtfVi/Zqv
        eB4pyQhjvsFLoP5Ko1Li/Gee+xIjtMJ37Rln3khH3WHrfgcfIdJ0jaUy3RXx+2Lg
        Su1+26M3dts9PaCQgCP3Xt1XD0YRwOTzqBy4VW9m3XT0Ehf8/vOBymdYjTOjIY7x
        xq1MkyQg4t7tJp22kqk6+nFthrqUPSTtUM/oAzlIFwS+SaoCEKASG7MiftlQmsgX
        HFQqMz2AxyK/brDuC1tTTuoqu31LS+fR6DWj/5buDmQiOdKu1H+eCyK2sNsZi4An
        d2svM5FvLyyVlhKDWA/s+5EpDqzbQi1UiERMD7M32mKNG/Ougl6Ag==
X-ME-Sender: <xms:SuEGYq9Up2Dm3DQXmA26el_nzm_9_wMSISTSaCYm6Qeii1qeDiJwHA>
    <xme:SuEGYqtknph7FQOnM0NVYyt_pJ694Zea4XQdpfgq84UGYB2aIYK2olonq__6JE2z_
    akKgZj1Ptu5Ahyj4IU>
X-ME-Received: <xmr:SuEGYgDX5liqCcPCTD0-uqdZe9Dlv9-beCysXDFu_Ax6wNbF0VGhisF4kX6phjhoRLiGw4QSYumImG8bFXBxAELO7Aq-Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepvdffgefgfeetiefgtefhieevuedu
    gedvgffgjeefheduteejfeffteektdelhefhnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    rghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:SuEGYif3VrhbjzMAesscHcS03PF8XG0vOzDobEPpKmJkhnj2sTRLAQ>
    <xmx:SuEGYvMJTIUDhBnPt14lzV4jHuDPG2htCjfPSVe5mWSb7bDK_ChmFQ>
    <xmx:SuEGYskqO3nohhsN_3OC6EVGHvHYgmOt2obWuf9QQVTRy-xaHhcOXQ>
    <xmx:S-EGYrBD34OycxYFW1mgRMx81So_55a_OvRH8Li6w5TN_TDPThYGHA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 17:20:58 -0500 (EST)
Date:   Fri, 11 Feb 2022 16:20:56 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] arch: arm: dts: update Facebook Bletchley BMC
Message-ID: <YgbhSCx9qDinSAq/@heinlein>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xmU4fn0mtBe9neDo"
Content-Disposition: inline
In-Reply-To: <20220211014347.24841-1-potin.lai@quantatw.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xmU4fn0mtBe9neDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 09:43:37AM +0800, Potin Lai wrote:
> Update Facebook Bletchley BMC devicetree base on EVT HW design and=20
> rebase sled numbering to 1-based for OpenBMC multi-host
>=20
> This patch series are modified from
> LINK: https://lore.kernel.org/all/20220209100413.23714-1-potin.lai@quanta=
tw.com/
>=20
> Potin Lai (10):
>   arch: arm: dts: bletchley: switch sled numbering to 1-based
>   arch: arm: dts: bletchley: separate leds into multiple groups
>   arch: arm: dts: bletchley: update gpio-line-names
>   arch: arm: dts: bletchley: update fmc configurations
>   arch: arm: dts: bletchley: switch to spi-gpio for spi2
>   arch: arm: dts: bletchley: add interrupt support for sled io expander
>   arch: arm: dts: bletchley: add shunt-resistor for ADM1278
>   arch: arm: dts: bletchley: add INA230 sensor on each sled
>   arch: arm: dts: bletchley: enable mdio3 bus
>   arch: arm: dts: bletchley: cleanup redundant node
>=20
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 303 +++++++++++-------
>  1 file changed, 194 insertions(+), 109 deletions(-)
>=20
> --=20
> 2.17.1
>=20

Left a few minor comments on potential improvements to the commit messages,=
 but
otherwise whole series is:

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>=20

--=20
Patrick Williams

--xmU4fn0mtBe9neDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmIG4UgACgkQqwNHzC0A
wRm1+Q//QGpQSab1LPXpRmbccPbMhY3kwnMBcOQ2Llp2NrnebTJqjVLaJcmWu62Z
bBCXv5Ag6mDXh4Y0rOT/NfPkZpzqa0F65WkXaXNmCzOwOWDc7GTOhXFSKD6bjbH3
84O4ZaVkczBWGbLun2C83gfVyv1nXuRSeWGJ0T0e9sMWUgV1TJPtSIQjwbv8ABFh
lq38vC51sibgumC542MUetQO/UWCr5YYn34CLBwRwQPgaK15rCjr++sgd+r8sh+S
O8SaeaqsdtMZfp+FpwY7lyeImhFE94r6qZ/bT7B+8AnP9QeC1rC2GnNrEHZKxT2i
Y5XOmIwb9VFh5Y7nl/i3zLDqTaqhw6k9F/HbLZWbwFLRSaE+4SCk+Dv/bfAjb9Jp
BAwlLZsa9S+dcJVeW2FxIxuWtMXvhH7xNFUnEBjaObvLQCal4ek5BDWydsvzFFzN
HpMukmUAOmIe3yhxAi6uNqAj7Xn1B0ZElsc3G7skO+oLpqRraU9Ss2e+APgKy6Jq
iDnXtnPsyW9C33nfOq0m5SVQHfRNlsnbG6Ez1nPZFgWcbLdYPo4+RLBYA/EPr66Y
UBDyxT5UPdSQIuaqyf/a31qAqP8cpV3loeikAq5Zf1lTo0tZ9y9gT8tByctg3PTs
Z2dZLZxnVKsRfwrdhppRk6ncUmN/XFMYo0/kJ/M9YZLS1kN+fgY=
=4x0h
-----END PGP SIGNATURE-----

--xmU4fn0mtBe9neDo--
