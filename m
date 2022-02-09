Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79484AEF6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiBIKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBIKi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:38:28 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38DE14863B;
        Wed,  9 Feb 2022 02:25:56 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 115792B0024D;
        Wed,  9 Feb 2022 04:39:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Feb 2022 04:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=zZDTW0FB5xKeIff0Mgbh1Hl+LyU717M3Sxe8pk
        IOuHc=; b=KlmaBgGevb6slB6ovY6OBGrpRLV8tshmia32SHGxOGlrtr6r9ZSNpZ
        Jb9Ov9d6JaZ35Nn7KWKTfA3hAYfX0jjz5bAgcsOe/mkD4+yMLbvPM0bdavTZNZRD
        MfTQFtsvJTp7m+ES+uT49HUNf8PT94qOit8mFniJrAndZEKJEyoDquEtypBtNq6D
        4OOoQyHgRwFY+qigKYrfM64ctNZlTn1nxu3Go/lGlyT1XYvNkW0lpPxslyLXhQTV
        Qy9Hw0pvkVbTnE7HcDmmeX/bjgm4q88G9k74n7t0kI56n0ZxBLhepChTU9JW/t75
        9+lWl8GpcFlNEeafSQsICQrXLatRueLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zZDTW0FB5xKeIff0M
        gbh1Hl+LyU717M3Sxe8pkIOuHc=; b=FURyB28ibG4wKLzvnt1IiJgZcL3W0Y5u+
        XQdEwRtaBvxDjjnpyBGUrfMIBRjgr334IouWW5IeIv5j2modJRRj4QkXC+xy5A9U
        ppRch0eWsuE8XU00D0SEBdF1hW6IsWse9eSCLywMkQFhomRCYDJNvXEnv+yAbrsz
        Awhb+5OyQKDK/7dQBUUHhEdducnVb7EPYUweyzbBfsPC05yKmRvjR4J+CH97Iggo
        UzJdu6pUCkVtjETJqMmN2pW1cNa8KEzGjj58Ab/MoFrKMqRfKVu5UHnuMTVXxKKe
        nflyBCFF5TlmYZyX3kQTulwqf5nOXYrWi/ECbS8SPlm5OGpcUCLhA==
X-ME-Sender: <xms:44sDYjSxlulXbXOJqCM8WdVKQGqZt13IBP2bSh2AF4mf_T2aZDr7DA>
    <xme:44sDYkxHRJSC2rvpTW35Jc5VZnXAAEyya_edLFYC5GF5grGz_-pkYyky_7mWtArdq
    A_TR9_MOpQ1olgXsPw>
X-ME-Received: <xmr:44sDYo37kBJDFUI0HfXtyJ-MMzuKgq_p1SQjGm7_qOZsvqyql4-VV6oSVj2umtI5i7hUsBgzCPA6dDbJvbxXAIKEhQLuTI1Z11jw5mY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeevveefffduveeitdegtefhhfetueffteefffdvheevvdehteethedvleffgfej
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:44sDYjA1m5oRlsmPJVwlSRYEXcPh3mzF2RoLWejLVWrr80SAVR5S2Q>
    <xmx:44sDYsiJYipLR3S9fJRo7q4pokp8cjkfqjwsk4D68iy52hLwQ40XfA>
    <xmx:44sDYnr2BIm6RArU5B456VZSpZCgS9DWObNEBchbLtQyp3KroLcaxA>
    <xmx:5IsDYlZ8pSIB5aLnEULMyXJ-SpVxye41G7b7NbC7R0erH2yzJkQLSRkh33A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 04:39:46 -0500 (EST)
Date:   Wed, 9 Feb 2022 10:39:45 +0100
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
Subject: Re: [PATCH v2 33/66] media: sun6i-csi: Rework register definitions,
 invert misleading fields
Message-ID: <20220209093945.uertj7wut72tximz@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-34-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y5bsrtm5k7kfdw3r"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-34-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y5bsrtm5k7kfdw3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:56PM +0100, Paul Kocialkowski wrote:
> This cleans up the register definitions a bit, adds a prefix, remove mask=
s.
> Registers are now fully defined, some additional fields were added when
> needed. New format definitions are added for future use.
>=20
> Some fields are wrongly defined (inverted) in Allwinner litterature
> (e.g. field vs frame prefixes), which is quite misleading. They are
> now corrected to reflect their actual behavior.

How was it tested?

In particular, see
https://lore.kernel.org/all/20180305093535.11801-7-maxime.ripard@bootlin.co=
m/

Maxime

--y5bsrtm5k7kfdw3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgOL4QAKCRDj7w1vZxhR
xVXMAP4tUZl6Zly0E31lIvZlN0DimuVQB8+cy8faHTKuekbwPQEA4bndLWw2iOVW
ikY5YFrnuK1/de7lSQUW2bhUHCbSPQ4=
=Pxbv
-----END PGP SIGNATURE-----

--y5bsrtm5k7kfdw3r--
