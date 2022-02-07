Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8774AB75A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbiBGJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243239AbiBGJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:10:18 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90EBC043181;
        Mon,  7 Feb 2022 01:10:17 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3564F580197;
        Mon,  7 Feb 2022 04:10:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 07 Feb 2022 04:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=R7UJ3iF3QHld5VlL8DXB8KHalc3jQUprq6G9Hy
        azmd4=; b=pnZ8k0BqtwOlrpwjVR9F+Ywos6Celc3JwwbWPdnm6EpMOZwuNw7ayN
        oxHfUAk1haNbOFsrs3Pcsj9Z3kgikXa5tl9sahiBMI34BPJxwtSrhI0NcoQ6f1tX
        co1HIxABhBVHZm3PVKHcz/LUQgS8vzLMHtV0Zx052z9fztFg6eXB5Tmr/GvEcMI9
        6TtoyUHbIJDCgR+PD6OurVD3nbcZ7LXMI20KFgnHMnLx/Qym0onRKMv4q7hB1pKI
        J4E3YiUq/AguO4vMKuEbvat7JDC2XdFFplRfBblgEo2IVoz2AD68VJGLuDwF2Ci7
        sIgww9T6PD8iuELP7AQEe2ORxnaemNyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=R7UJ3iF3QHld5VlL8
        DXB8KHalc3jQUprq6G9Hyazmd4=; b=I6KDPlL1blMggMMpM4sfBmsi+xz5ZkoIy
        CGG1kfBDiZ+Cb6stxr9Q4wl2ekuaVwuWsbgiN+6qI0qSQiwy9kn9rmUVVtYCcDg+
        QfOItq+ftrzN7AMoxS/BRrY7xrd7F1HAJ69UH0/ywES29RFZqF0dPsIxQF/DUzoX
        SADmRDVMMqelhoPIpxJgOif5YnFmQjTst/ryXZId60emVmLuRbEsA2fZrbW3yRKT
        iWnrMMTRtk0vMcc7LXVdidjTMdvIbxOlVX+mMDvutOKp7As0J9EqX9HD6Bf5iVqO
        F+Bx2cIkuXM/lAlNaQvX4EE2zDmC4Yl1taf8UF1KaGsizsQKzducw==
X-ME-Sender: <xms:-OEAYi6ZC8ybTYDe51-rgSjE4J6tYtrXvr4fH1xFVQsyUM__fG4fFQ>
    <xme:-OEAYr6o7a5xsoJU-ado0ccOaUNIj96q7Bir_gXZXdKd5iJeK_HYJOqNOGUH5UIYu
    o48IKfCAfb5umVCaZU>
X-ME-Received: <xmr:-OEAYhflU0vIqTcdb4UeLBNpRHEOj-PB-ZOvMufB8UYJ2umvuZJILke-Fv0Nrh97PMjDGBs9zDJHcOccgsl1NE3LLNBwpWuNMK1Y9_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-OEAYvKgotox7wuaen_JPKuVushrlWshKfgnHyw5fFKH3yny111A5Q>
    <xmx:-OEAYmK3M6uHOz0aREF_IB9-a-w0kaD-iIsdKJCjnIDRmb415DsIHQ>
    <xmx:-OEAYgy9BeecMal-mAODbT4HdTHd_y5Rb4e5CKlpeFpXK0Luk3RoUg>
    <xmx:-eEAYrBt6LqJFndomEn_wOo7QhXvozfYzDdBtJn3nKnIbVMkNdTIvA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:10:15 -0500 (EST)
Date:   Mon, 7 Feb 2022 10:10:14 +0100
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
Subject: Re: [PATCH v2 17/66] media: sun6i-csi: Define and use driver name
 and (reworked) description
Message-ID: <20220207091014.6rugcnspzjdubuxb@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-18-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2mtmwumvelpbuht"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-18-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2mtmwumvelpbuht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:40PM +0100, Paul Kocialkowski wrote:
> Add proper defines for driver name and description instead of
> MODULE_NAME and hardcoding (cosmetics).
>=20
> Also rework the description while at it to mention the hardware
> generation that the driver supports and remove the video capture
> mentions since it applies to the whole media device.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--w2mtmwumvelpbuht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgDh9gAKCRDj7w1vZxhR
xUhdAQDxosvE5Z1tfazCfFwKTKvd8wdE1L1J0eAJW2n0zJD0GwD/Y/ZSfxTbktu6
mAwempvC3dPabl4ELRLwkyfcajQdcwg=
=hI7k
-----END PGP SIGNATURE-----

--w2mtmwumvelpbuht--
