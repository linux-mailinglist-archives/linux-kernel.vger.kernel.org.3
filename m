Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1E4C1598
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbiBWOle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBWOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:41:33 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEBEB45B7;
        Wed, 23 Feb 2022 06:41:05 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id C8313580332;
        Wed, 23 Feb 2022 09:41:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 23 Feb 2022 09:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=ek/wq6WHXQxS3n5MxPyZYfgoSdNcbmJgZm0COV
        VBMbg=; b=SPHBhJ/xcIvmhRqahY7efrhipsEn2i26/U8fzCnCgXUj4WI/d5L+oK
        kSXYAsh5WICNbJUfVxiFb+HT4ZVSKsLbN5SOSkBRPnjIbdPcN2RBq5hYlOfOaMfh
        YaXoIv+7EsNmeosb1huceMMZpw9QiFpYPtukz++Hr65xHdiyP3qpp+9OsqYd2/Wk
        rMJzXqYv/dF3MVlEAZInEffS5kJvoPZRzNYkMFpmKwmmFMru/UoI/2C6PJz2/0jo
        YfCYi6njnEA1SBmenCI1Pc8kWHXhtSfXIb+0/dgGDXNcNniCXd8rjxJ2i3oAcp5A
        ajQHJObjs0wCwSKHPnbdkzjdzaCyiOkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ek/wq6WHXQxS3n5Mx
        PyZYfgoSdNcbmJgZm0COVVBMbg=; b=BAKtz8N3atHnh8tvAHoU4hRA3HC6SU4Rl
        GLEEHz6Te5wswREjrf0oJyRnv44lgjU5Sgh3g9EhhChpbXn5TfMz32UYmxUX6mRB
        Q4IIiMP42J5Y/xB/dkDp9nsEvaom6NAyINeeQwoaD+7wq4qDg/vFeKlZO2NJc6tX
        CgefZMYIbJjacBNpz3mfj7EsVPiWpcXIrgGepf1I4qM9Bqs+xbqpJnQgD3gmaT+J
        mN79jgX37C4pjPipG3waqy2p0IZdfSoFgPNJ+llA5UhFyePzQCdP1tbVXyxqDcB/
        igLzd/HU7CAF9cp2YDxeYecjCTcFWntmibwghjEnJPPXgXWw8ekWg==
X-ME-Sender: <xms:gEcWYhIXfvcKGGzW9xgsWHRJXQQ34gsV3hCme-RxQ3tV9O46VA-G6g>
    <xme:gEcWYtIa-NHs915GN7deQc5oN4YFO-Kt7on0tvFdFXHqxZ4_xEx-ym2cgFGpB7wiO
    ExVa3Ff7-3qK45yfDw>
X-ME-Received: <xmr:gEcWYptvtBvCP4efx3va16DdremDa14koMl4x_B0xzr_J2METY3cnDm1nhAFNI5M-Rv7LrTd9KhcpCulbEbW5mF3vSrW3kvVSsqFmU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:gEcWYiYz4Hlo1sY0xJFiCchnOVCDTaVJeFHklXeKkgdj-SuSCV5Mgg>
    <xmx:gEcWYoavtamlnABVuNgLk5JnaJVg0Hgy1Ts-Ei8WLX7eGyJIZ-At-g>
    <xmx:gEcWYmC8fAJLyVQGonfujTjcMNFB57P6jxn15G3tMzLah9a07s72sg>
    <xmx:gEcWYoqspllAzZqPBJM7XhHAR6108IAVZ9JKMBZbqXYa8aE2ce3-FA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Feb 2022 09:41:03 -0500 (EST)
Date:   Wed, 23 Feb 2022 15:41:01 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        rjui@broadcom.com, f.fainelli@gmail.com, nsaenz@kernel.org,
        robh+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        stefan.wahren@i2se.com, dave.stevenson@raspberrypi.com,
        naush@raspberrypi.com
Subject: Re: [PATCH v5.1 1/2] ARM: dts: bcm2835-rpi: Move the firmware clocks
Message-ID: <20220223144101.543ntapo7iyux27d@houat>
References: <20220208155027.891055-7-jeanmichel.hautbois@ideasonboard.com>
 <20220223143434.71853-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dihnosor5i3ruv5k"
Content-Disposition: inline
In-Reply-To: <20220223143434.71853-1-jeanmichel.hautbois@ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dihnosor5i3ruv5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 23, 2022 at 03:34:33PM +0100, Jean-Michel Hautbois wrote:
> The bcm2835-rpi.dtsi is used by all Raspberry Pi generations. Move the
> firmware clocks from bcm2711 specific dtsi to the general dtsi.
>=20
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>

You're not saying *why* that patch is needed. Change for the sake of
change is usually frowned upon :)

I know you have some reason to do so, but it needs to be in your commit log.

Maxime

--dihnosor5i3ruv5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYhZHfQAKCRDj7w1vZxhR
xa2MAP0dl1FOxo0s/yra0iukie87AVy72vqOCBs4sqdMR/1Y6gD+Olqh/XusdNIz
l09OIMgbEfv0ewINqWUfLes7jlcfaA0=
=ODyA
-----END PGP SIGNATURE-----

--dihnosor5i3ruv5k--
