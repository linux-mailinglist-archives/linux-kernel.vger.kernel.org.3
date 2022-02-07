Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939D24AB706
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348107AbiBGI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349283AbiBGIzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:55:31 -0500
X-Greylist: delayed 542 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:55:28 PST
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F2C043181;
        Mon,  7 Feb 2022 00:55:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CA33458018B;
        Mon,  7 Feb 2022 03:55:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 07 Feb 2022 03:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=iY/XWrOv5z+3ui6SOcBcF8zRTUJJdfQQ/DmZSz
        cWgDQ=; b=tmAloTuurUn7U+BsgBpI54lAsHq8irV/mMs5UuUc1nJip6ZWkiDp+L
        T/u3M2117jpcSQEcvfjjkne0dhg6ac8klXXP5IL6+mgMJLux6K5ToB1ZhYwvmifO
        hv5Q72yvoWzZ8+Lri4VNoMRqgOleVY5ScyBt1fg2r6FeTBbaowm4GcMgoApItIhe
        PuhAy82LJ/l2utVvk8M9i4Iu51RFwP/GOCr/Z4M16GXadaUDg4KiG+1Vqr9CmXlm
        ZXlLGuYf13q2Lay0MnuFfarJQd2k2DJNn66VrRJqf+XQJNjtDPWI5CzAAmMBQc5o
        APuJVuw0ULJP6Dp+Nm8I2tOIv85i+qlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=iY/XWrOv5z+3ui6SO
        cBcF8zRTUJJdfQQ/DmZSzcWgDQ=; b=mcAE9m3LQgQ/Mnz8l2c8I+uhsaUdOFV9A
        F2I6r+8TLk7Xbc/rgLk5T4myhRqrQuQPHIi29ycXFZpJ2c17gU/+3FHlz64wqvsW
        +8dNlATUQDWN/jspHrgAYImJtgREJ//9Oj//tpTW/i1OUOQgQXQYKCsRngU3MWFF
        SJ5vTqN8JY+vfN35mRV05zsQ6zX6riTzKdf5EpDiYDzhSLBADqhji4LJspl0n6xU
        jlWrbZ7fHT0zLCqx5YZiPnMDjqbb+PYbFbbigJWs/zEGBamJPCstId3Ue9u8HdXj
        sDRvZKNwqvH4R3O7XrVfleBiu82m3vclvCcG89kR/CsTjY7qTwMlA==
X-ME-Sender: <xms:f94AYqEMI9Cp1F63PJcg-q8TS4n8umV8WxW7o-tSXHHGudBRj42uEA>
    <xme:f94AYrUip6bl_HB9jHcptnOM8gqXJZuNX64xccRa-xYzfA63_BFuBM7humSS3j7Nw
    IA77nFXWAjpC4gSkvg>
X-ME-Received: <xmr:f94AYkK9lAr_BiL4xNLJri_D3Uv-e2DSFCyqnXFtOUvUOMuBy17pSOEBs7UnDWXJWkd6U2zxT0fGIkh6NMKXq3qJGxLr8DwqCKfX1_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeggdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:f94AYkFNGR2CITYSmmXT_WfAa3LYpLu1pNC9XvuBLo8cX9Uta0xGGQ>
    <xmx:f94AYgUPXvEMcdh6qIH9lRyraTuIW3WcZkoGOPlSsFvFUwXz_AEX8Q>
    <xmx:f94AYnN_DfYQzRMjD5tto5wZ5f_vzAtX8gN_NtnP8fahgpyzQ7z9Hg>
    <xmx:f94AYhsBC3c2yhahIurEvvnv87_-GJrnwUqsDdNXOk06ZlDC-Wg_hA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 03:55:27 -0500 (EST)
Date:   Mon, 7 Feb 2022 09:55:24 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: rtc: sun6i: Add H616, R329, and D1
 support
Message-ID: <20220207085524.rmt6fwku5mdvgvx6@houat>
References: <20220203021736.13434-1-samuel@sholland.org>
 <20220203021736.13434-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qkbg3fjun5hhqpuu"
Content-Disposition: inline
In-Reply-To: <20220203021736.13434-3-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qkbg3fjun5hhqpuu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 08:17:32PM -0600, Samuel Holland wrote:
> These new RTC variants all have a single alarm, like the R40 variant.
>=20
> For the new SoCs, start requiring a complete list of input clocks. The
> H616 has three required clocks. The R329 also has three required clocks
> (but one is different), plus an optional crystal oscillator input. The
> D1 RTC is identical to the one in the R329.
>=20
> And since these new SoCs will have a well-defined output clock order as
> well, they do not need the clock-output-names property.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--qkbg3fjun5hhqpuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgDefAAKCRDj7w1vZxhR
xanbAQCV3IfYrd8wt+3Bv8a73mndzneaP7kXmLPtVzeaBn9tSgEA0xja/ekjRcsL
rmx3XMyAvoiTBrDJEYr2r1elL9YxQQk=
=vfa3
-----END PGP SIGNATURE-----

--qkbg3fjun5hhqpuu--
