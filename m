Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0504AB76B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350731AbiBGJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245314AbiBGJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:13:08 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9236C043185;
        Mon,  7 Feb 2022 01:13:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2A2875800FE;
        Mon,  7 Feb 2022 04:13:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 07 Feb 2022 04:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=qLSCGH0RRyPL+HW9Z2e/mHoD755JpEut5CNQEN
        vEneQ=; b=ClmO9I5a6y5kK0j81cwsKebakL3jiaA65SCTuOColr6pDdjC1+c5fK
        8qrZQQae1IMcbt9WOHtBEesXU8f11tPGbWTHsSzojOfiLJUart2mP6Tz65l2xX8Q
        3FVVq8Q7Arj15m2p9AoRzembtXnsz6dD7od4NOwK5r9YEswWyBpmEi/nBtGo3tPP
        rXwu66Q3oNPa/bKiKJwqKomBb6xwTyis5BUOh/5f0+bKo8rBJH+yxrk17xD80M3t
        4qSx+DdaBgLBcpQKJdONfLvWO7AoidXjQqdHq6sao1VWGT1Hf0/qc1N3gfhskhkB
        4CqC5FH/ild8aojhp/JX3qfON7U2aNbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qLSCGH0RRyPL+HW9Z
        2e/mHoD755JpEut5CNQENvEneQ=; b=IhsZ0TP0BqhdKfiHlHCj/6jcP6Q7W/vOk
        YKA5qUjYTlQi2HVS+aSdWKciGc6uE/8vcgFo8XZ/GDcv/5eSvZ5p6q6ZOcnr+HwN
        zMfYDXiH/RyJCLxFiJ7ovsiKxgM22HTEVIJzYoV/cChhvVu+8X4aKUpRB9iJyuoT
        8JM1SY05SYwDitf+hpze3g5oPIbnt3LurYcmQNsKP39sqsalBLpabm73W/tuWpvU
        2zNPQrv9UlcQg1q+dPwZQ/nLtPlOrNvCSZGsR0X0Xn8iZvc7n3fR63qLL8hRZtla
        UuvN+sBTjeTmbs6XfnSJAAfBueeXa7dDo7K65G+eIaB0qMdxtAZTQ==
X-ME-Sender: <xms:ouIAYvS72L2ywHs712zopqFdkfBchJXhHc67d0i-pAKH3urb1XzImQ>
    <xme:ouIAYgxbC7MkgQr37cU0nkzCEw4chCP5wTxslyNQf4xEKRZVzDzZ7b_ToY_JWVHGA
    X-pDKiWbK7tNqKgPz0>
X-ME-Received: <xmr:ouIAYk3kEr6iPGf6M2HWA973maxTKkH8UavJhg-1GVz80CMZ__glG5Zh7yx4cw1J23WZ5867wjFQCokyyAlxAFuaC2rwzQ3Rg4jDQ4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnh
    epleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieehgedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ouIAYvDOB2l77RitIJC-9Qq7UBEyTtA1EwJaGNxSKogopg819ko24Q>
    <xmx:ouIAYoiAwt0iqH0plXpyW_JTvYNQiSopbJ_3BhKFyxkGrB_7M3amrQ>
    <xmx:ouIAYjqGkRmXM7OAGazuh10uvTopi2O15JZ4rfaDww1omDTtu182vQ>
    <xmx:o-IAYha7Jg3BY7BcreyYo_NCDnITADZRmu3BBr5tuLksZOeFq9qMkA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:13:06 -0500 (EST)
Date:   Mon, 7 Feb 2022 10:13:05 +0100
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
Subject: Re: [PATCH v2 20/66] media: sun6i-csi: Tidy up platform code
Message-ID: <20220207091305.wzfhgyhqdvmbwv26@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-21-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zn33dzpi5f5xuniy"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-21-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zn33dzpi5f5xuniy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:43PM +0100, Paul Kocialkowski wrote:
> Various renames, variables lowering and other cosmetic changes in the
> platform-support code. No functional change intended.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--zn33dzpi5f5xuniy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgDioQAKCRDj7w1vZxhR
xfZSAQD9zXv8azZLXEezoQC3ws4048ji/X/17zUo4FiyDc+csgD8DQDo7XmeUDwY
ZqXOeUrxj6ly/YWrY7r3NDGlsxfIVww=
=Sg3F
-----END PGP SIGNATURE-----

--zn33dzpi5f5xuniy--
