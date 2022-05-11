Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AB9523D44
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346725AbiEKTQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242629AbiEKTQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:16:09 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF02E2497F;
        Wed, 11 May 2022 12:16:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E434F32008FA;
        Wed, 11 May 2022 15:15:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 11 May 2022 15:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1652296559; x=1652382959; bh=uR1UqOSmk8
        pEMKPCLyKsAhbJdVyUpDr+WJgxE/2DLik=; b=K2KdYiDqASFoaViNgGxA21rYyO
        oQ3PBAAsNzLo4rhEcmnqsEvTqunBjKJn0soV6vJ8p64rBwGbljOGzrBqg6mWapOy
        dobg2WaPcuUGOiIotJKb3Ga34S0JQdVu9QzR/5GBFphrMtFoBqqs4V/qnaFAzjYo
        cKTvv7BY9CZ8XsaW5bzDa/5gvXbi+OZwWLUZTGFL7Pa05gRbnp2j94cDyBjpaS1J
        pBZvufJl4JHnyscSeT2E6uvqaWa5zj2RHlmxwRG/HBZI8yl16Wll0yoh0v5Pn8o/
        YFoK6gNM7XYkXWTCA6F1O1ihqyCTqM3awncfKeqivgJp7zBP5DWBXkO99uJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652296559; x=
        1652382959; bh=uR1UqOSmk8pEMKPCLyKsAhbJdVyUpDr+WJgxE/2DLik=; b=u
        6yYvWA2Iou103Gdtfgum2YuMD+Ic99qGCRkXeTqw0ma4slv/+V5Ds2MmoObjBUww
        kymv4/GA28FIEGtTuThp70cLJKog21mlPFOU6pn2WhWZIr6gWrrshnMP32Nxqz2T
        BG6LdiZJW7hSvkhhGI8R/7hHoFe8Rm5i4R905UM+AaUHOniQgsGBByWpmBYburto
        6rkNIoVGLf8pb3A5aOdfrcUknWhfYrfKeEexhRLKaYjcvkPcCyq1tkbAcESa4CST
        N8Ft1HrZQLbSSG+CxnnYVjcfG3iaUOJ5q385le9J6CIHG/5AM2cywjuBd2212B1k
        qSLaR7CBOKoWx1Z0GMong==
X-ME-Sender: <xms:bgt8YsWM_VJtAE4nZYsHBBstAuFjykkfgCewtGyTnoQVoBhIsjhwEg>
    <xme:bgt8YgkKAAbANkR-JXdytbXTToau8IRN-JJST1Xw7GamMkKMno9UyTbLQt9kW1K99
    LhPnhUIMXhRJEKj2PA>
X-ME-Received: <xmr:bgt8Yga0tJz-groxhW0sf670pA2OeCAObsi5Cp-x0BD6GZgpqaBvqI5BFkRZATZGO_ctZVZ_t16X2TZSnyaale3wnRykqqgEt8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeehgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludejmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:bgt8YrV2GYH1XD2qnzzR7pCNnjN3r0maDoqBi1bQA-nAB4qLaBjn2A>
    <xmx:bgt8YmntnXkH6NCuyl9-8XFhCDCLPUIvRtpFrpJoNwg1Qsi6-Wu3iA>
    <xmx:bgt8YgcIPReim2vby8WDDhNs_72a1wYyHNnUFSZeBEz8H2YnSEK0XQ>
    <xmx:bwt8YkatK2K9uVgK-OZ2i9N8kemoCHSBVNe9WAkphGl-vd4wWDk18w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 May 2022 15:15:58 -0400 (EDT)
Date:   Wed, 11 May 2022 14:15:56 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Potin Lai <potin.lai.pt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/6] ARM: dts: aspeed: bletchley: update dts file base on
 DVT schematic
Message-ID: <YnwLbOOq3MnfKaX0@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
 <CACPK8XfXbay7u5kMDgMoyDTO_Le2i4okNUG8sb8_NDepbPRjxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="13cpD+Gj1qD2RKVb"
Content-Disposition: inline
In-Reply-To: <CACPK8XfXbay7u5kMDgMoyDTO_Le2i4okNUG8sb8_NDepbPRjxA@mail.gmail.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--13cpD+Gj1qD2RKVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2022 at 06:09:33AM +0000, Joel Stanley wrote:
> On Mon, 9 May 2022 at 15:14, Potin Lai <potin.lai.pt@gmail.com> wrote:
> >
> > This patch series update Facebook Bletchley BMC devicetree base on DVT
> > schematic.
> >
> > - EHCI: enable ehci0 for detecting and accessing usb device on sled
> > - MDIO Bus: enable mdio0 for accessing switch registers
> > - SPI2 Flash: switch spi driver back to aspeed-smc to improve performan=
ce
> > - EEPROM: add eeprom node on each sled
> > - GPIO:
> >   - add PCA9536 IOEPX node on each sled
> >   - update gpio line names
>=20
> These look fine to me.
>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>=20
> Patrick, did you want to review them before I merge?

Yes, also...

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--13cpD+Gj1qD2RKVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmJ8C2oACgkQqwNHzC0A
wRklZRAAiA6+18+skbpmSRL9kIJ0YGdTR0eF9/lZlFT8e7QprxDuKZabiKsJN7GV
Vby90wG4AGa7YT6TxkdRtLErxNMaKOVnWwQIMw+7Zdt7mwHYIfrS4Pv6763UfheA
GEx8atnbs1F1dYRPv+fbfTqvX9cImLHUzMZ5ekXa10L5mhTGYggaQtfcsPgvMq8v
NyeNzbwyBezF1v1LOiWdiHhmyv8DTSgueJ3vEbRYUWlkPcMzIgNTnnaIkZS2Yras
6s+fDO6jn11mV10Fe5pGMFu5tYMYDUTnQZ27yu1c0XGZcAHp29NldSmp0OGLdsQo
8tQ5rQSDekUTld9fJ6nLyAhimIRyNHyUj97l1g3jbtb4mDnCHObRu7rTK2b8v4hE
THdyNtL59+IVE0hw6raXK7vXyyICrCoXNUu1ZON4Wu1FjrcDaReyuBKj6QcjHwzI
dLuVRM9A10BYsSCx/g2W+7ZhbK6IyzLycyVVNMvmO4meOvuonBB9Q0D//BVQA6Ug
1vZ9M6Oom158xAditHOjTzL8kR9TXYbMaCC/JBeLZ50TWYDpbDM0dhhL1EgUIPd1
9oRuZJbImndgdA4leVyBbgUD4Xdg4rEyIvERnOfcJbXsGUwArrzVXp5UNdnG4txf
5d+LVZBrFYuafH+sn961jtuX9D5TiJH40Ev7HZI29Z0xVj5+j3M=
=3yWb
-----END PGP SIGNATURE-----

--13cpD+Gj1qD2RKVb--
