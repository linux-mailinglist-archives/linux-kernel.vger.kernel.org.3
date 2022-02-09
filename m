Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760614AEF67
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiBIKi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiBIKi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:38:26 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B81E148637;
        Wed,  9 Feb 2022 02:25:56 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id B755D2B001F6;
        Wed,  9 Feb 2022 04:20:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 09 Feb 2022 04:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=SBTnBJKQIWPfpUR/56tNnSFnqOAge6wgqkQjX1
        F+GWw=; b=CDpH6QDlK6etkYWwEufaBl86rsCLCUXcMo8QxESkub7gK+AFd4yqkb
        6kBATCa0xGSUTrnFTWB2DgKWUcn2VOOo1B4/rGhPumCOmI815CwDKgYDmQJkn6eE
        JCSD1SyPZwknHxOLs5OpP/1Ky7yjerNewNl0+co96gyMNfKVibE/t45IAmiKT6U3
        jJOwgU49qEiQ2QIAZZ72+TkTZ1W1b+pfNzutZ0nZeGu3iNguwhF2bfS4izy/8oSj
        I3V/B9OkThZYwYbZINt+rO9HeerVjk8Aacd5aLACXvceq5/LEaGe24C/Xfu2iIiq
        Qfd27O+bpPo+bAiwPEsfDEHYAi4cWfUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SBTnBJKQIWPfpUR/5
        6tNnSFnqOAge6wgqkQjX1F+GWw=; b=SuXPnSCidnnCw7+asKU9JhwD7CJo6XAmf
        RlC137mUb7s3vSeq/1VqjwOfxEa6wcMhGsRgKkskL75NP9aLUnE3Y8wzuG4w3pMe
        4ozpoit7AylY8y1k90WXcD8563bbTh0JzGRWXTVqPWYJcDXg9Uoscs/ZH2OIGMlT
        W6JRy7mGxBBXVn7nCQ+JFMlyrZDxw1LPbsUynd27XAB6bWQhF9WLIn0AAumScQay
        xFxRLPiMm9aosDr5c7iqFqitBoP/oLCK/0hwA5DbYR9kWZ0I1p/B3YJ5x+ALo1tI
        DWoZkQL1FTdE25wc8drszHAEtcclHokxgmWl0Yz09tnej/utT/p3g==
X-ME-Sender: <xms:ZYcDYnbEmphW3VJrIoA3r1HmrQD6YNKiP4LGsxBj22ZQThBVA4Pdmw>
    <xme:ZYcDYmbGJb9A4jiJFc-QYbzTkztY9TKYsFy0N_P56Uw048ick-T-7C3irzwcebTvF
    34JSpG9UbrES16sjvE>
X-ME-Received: <xmr:ZYcDYp91vaS2zFZs6_1rZLxXu8eA6F7aY2cwisz6To1-238hYGswL5JU8R4gnnFjg57wgxRwTsoNRT4pMg-inyySD6_KpgmVyR3TrEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ZYcDYtpaz_FpHS6w2OteYl0qFgQXU02dsOId9hLdW6_vwPG8VFgxgw>
    <xmx:ZYcDYipPJUq5rJ23KQCMH8kuAZwdd98ASpCiEmAJNdUsgQg4ufGR3w>
    <xmx:ZYcDYjQNof7nLUqRAGRx9Wdsf-IZRkqFgBUkEnPgktOmRbaaCvmPPA>
    <xmx:Z4cDYnj43Z_R4o22y8Z1KuGyMwA3_z-uKQi0SnfNqBo2HyQHnLDx8A1K950>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 04:20:37 -0500 (EST)
Date:   Wed, 9 Feb 2022 10:20:35 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 19/66] media: sun6i-csi: Grab bus clock instead of
 passing it to regmap
Message-ID: <20220209092035.tz5ctosidpib47fq@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-20-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yjjnfllv4wtw5ufd"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-20-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yjjnfllv4wtw5ufd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 05, 2022 at 07:53:42PM +0100, Paul Kocialkowski wrote:
> Since the bus clock alone is not enough to get access to the registers,
> don't pass it to regmap and manage it instead just like the other
> clocks.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

I'm not really sure about this one.

Sure, there's more resources involved than the clock to get access to
the registers (like reset), but you can't have a functional device
without the reset line deasserted.

You can however have a functional device without the bus clock enabled,
so it just seems much better to let regmap manage it.

Unless there's a drawback to it of course, but it should be in your
commit log if so.

Maxime

--yjjnfllv4wtw5ufd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgOHYwAKCRDj7w1vZxhR
xVdlAP9xWWz+r+5yqqSyDREBt4wUIYsOPLYBVd8MDdUu/WQGfgEAkFTtNt3mcKcT
DWTcs0AATTN6+sept16oF0pNbheHkA0=
=mR//
-----END PGP SIGNATURE-----

--yjjnfllv4wtw5ufd--
