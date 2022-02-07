Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB184AB862
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352181AbiBGKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245529AbiBGJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:58:35 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C52C043181;
        Mon,  7 Feb 2022 01:58:33 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 506A35801B4;
        Mon,  7 Feb 2022 04:58:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 07 Feb 2022 04:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=LaJ0v2ms79kLOJkjg/3kGK9hXazOFFTsZfGFTE
        rsluE=; b=tDAyrh7fO5UWuYXdeQ8lpAnakCa358D+0NBqMt8zV9dw/WZZw9KVgK
        OyXcMpHI/M02B5dP8dTcDiAY+UJdf1YsIszh253r9pZ3YChph+jryADVaZ/gncST
        Kc6T7ejEvXC0lbRjn9XfJcLTfwPH/9RsT7XniJecdYkD7q/uzeYVcloL8JAUPyHl
        F+u3OTeGgmNk6bSmLeCToJg8pKqW5ZSxwPqL0IPO/C+rW+Y2jhnmtpePQ0zaBKg4
        pK218bBspGaXBHza8dHGMu8a60Giparnupw/vwQZA5HhlvFji1ludGbcfJmvZ40F
        ZaEaKEpBvgoykZvhFfyCzew1XXspvVyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LaJ0v2ms79kLOJkjg
        /3kGK9hXazOFFTsZfGFTErsluE=; b=RI3EdBlZEh02qsohqW0pK8fQFNFB3vt5s
        CrYP/JrBbmikFUEfDULCliKhZbnHWAuNqXXz84jkx8pOo1IL34LROcYShY6/3o+l
        ZE2jONyqeMND2SY4SQztG7ANrm2lcP5FXX0PjZwa+LUa5XoPIIKHeag55D0xxLWg
        IUne7wWMVBBlMBZSK4nbrH7ZqgaK5leMiWRBTgrdIKy7r1ma5JObwso1ec65K95T
        qhXhV7i9ZKrFmPFL+KpQKN/Qy+L6CQEEfW2W/zHBYNtKOUC1Y+RzcspOSDws4qRF
        9nUAOZWgFpZmAdiDnea1g0EighrnWwnd9QOeB9YwbFFiNXUm7eniQ==
X-ME-Sender: <xms:SO0AYqSu09xfPBE5UZ65DLtaNJ_e7DULAa93cXP8xp6VuVbA455mRA>
    <xme:SO0AYvzPLrSbrPrbTGuxb-ka5qO3Fs1dGnmzVs5SuLorUS6vt6y1huPZC_639ICFw
    hbbPWAboHIrEsXLQqk>
X-ME-Received: <xmr:SO0AYn1OewLxK-rj4K5kUbmjDwGynPvPWaD1fZ8XRTLvEghzOuDqBsaOtjeHvqbpKWtYIT0nAT_Vgyhox8BpNywBiGjS3MfuyNoyN8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SO0AYmAlJN0QGaxTfRAH7BpgWzAW6uWFnVl-I0lABJcGSAibiW5Uqw>
    <xmx:SO0AYjjuu5KlaBudBxxIpLiCHJKCE1xYTaC-UhOPr5AFF3-8KJF9ug>
    <xmx:SO0AYipakf4e-36UGuC3bY2QKjHLp-P6SRxr-t7gopU91T3LyNiVTQ>
    <xmx:Se0AYsZ6Yr9X0QT_gTp6A7pBGPTtKEaInvNlUZo2XIPRYk_OYwfTRw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:58:31 -0500 (EST)
Date:   Mon, 7 Feb 2022 10:58:30 +0100
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
Subject: Re: [PATCH v2 25/66] media: sun6i-csi: Pass and store csi device
 directly in video code
Message-ID: <20220207095830.k2k2nmkr3kqb5rdt@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-26-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p6vzlvrvhk5bygbl"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-26-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6vzlvrvhk5bygbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:48PM +0100, Paul Kocialkowski wrote:
> The video structure is part of the main csi device structure, so pass
> pointers to that top-level structure directly. This makes it easier to
> navigate and access other elements. No functional change intended.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--p6vzlvrvhk5bygbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgDtRgAKCRDj7w1vZxhR
xQsoAQCTQuGPJjgwQxNDB56tWYcoUfQGHYrEnOAcVpx3F+5OvwEAoyMDIH8m1x/K
QBNwdA2MghhwXgi8r2tujv77nhejlwk=
=nT9H
-----END PGP SIGNATURE-----

--p6vzlvrvhk5bygbl--
