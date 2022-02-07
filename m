Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEA4AB76A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350193AbiBGJNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbiBGJMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:12:01 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C12C043181;
        Mon,  7 Feb 2022 01:12:00 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E3FE55800FF;
        Mon,  7 Feb 2022 04:11:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Feb 2022 04:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=AkbvzTgyLEVcCtiaikYwQWMxktMorl1GqklAmd
        isHMc=; b=ZYtQP4oemzGrMZjyzqYYS9N7Fhdl+lS8p19CIH+lB21naHgFNFZdeo
        8NumhaYpjXUzzVhfC5p9vkcGna4l69sCBWSCb0JT5KzG3k15K/X54fm2+pjIYCqM
        Nsj4SY31GoOxQAkk9RwwunBIVxCX4Er5wgVq8LW0qPkTfRL+5PVLrbZzXm+Y5FO1
        mdH/I38750KKGe4E4HIfaAXOAjDbcv2UgzPsH5V6jIyVarRsubn1tx3hcMzaLnKN
        7pkcyaCMPV1bUyuMlw22GjtFd7WzGLJCI0xUvlkJJEqPAM8IoMszOLqxvB/Dr+Ht
        Q1aZR1zX1NPOhAz/TDbFuZosYq9yAjGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AkbvzTgyLEVcCtiai
        kYwQWMxktMorl1GqklAmdisHMc=; b=VM3DGXCpCRL20mz8TJrkx3EUxptakYg6b
        8pdATEcdRfElHDv5rr10zlujya8idjcB1xiYSkA+Upq+rCH1baqpfIcXzu/JRUJu
        OdK7E37rPSA0ZXsASTOKdQlETkT26QtVZLOgi2aD7ZFntOod7W0iBlC8gZRP2px9
        FBnhK1ExbKkAZJFJtB9pzTSWbA1/f11tPsMB8k0fQ76cEo1/Nk34Zr8sHVl6NlEZ
        n1ab3E8akB5Vs1d/3E6KLwmuVJTK0l5vYYdLBNybtXKzY4KEQKq/RICP/NGWKh5h
        9uhwTOHx7tnolu5whbqYroiMKf7cot1IrHM/1niyw1T3ELnN6BnJg==
X-ME-Sender: <xms:X-IAYoEQ2YCfWFywbXQyIA4f13o_qYtQZ8L1gdLh-IwxOIhI13TBug>
    <xme:X-IAYhUJIj6ebXHlIPDI8Cr6xIwtLECh0JKoaSiCO1nEevU532bSFMmG5U6fyJ-qH
    dyO4QR5ivXDL4WQ048>
X-ME-Received: <xmr:X-IAYiIUY5WHilUa2iDRJVTADKxFrXsEFU3g7S3TuL3mJi-8ke4_1ngDKSLZenJc_K6NY1SycUyyIa-6I3BKmHy960Lw6Y3-SNN54EE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeggdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:X-IAYqGKge_BNab5Lue8XWxDzwDoD8YqGutS9Zs8lkyPU0hbw5kAqg>
    <xmx:X-IAYuVwZAM_AADyshif8PSzr3Qax_liBaJRzHJsZ9562Se7MLDfWQ>
    <xmx:X-IAYtNrNNmHIpjLwgQ6OM2QlcMg7fGNQy4M8LU6JKiaAAEFue8hHQ>
    <xmx:X-IAYlMzk0JWZnZIkSt1LtGSGdvZxx-MdM2dAy25y9RP1Ep7jaS-8A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:11:59 -0500 (EST)
Date:   Mon, 7 Feb 2022 10:11:57 +0100
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
Subject: Re: [PATCH v2 18/66] media: sun6i-csi: Refactor main driver data
 structures
Message-ID: <20220207091157.czmye7mgwu2xnvdw@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-19-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvpl6lthepkpplvj"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-19-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvpl6lthepkpplvj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:41PM +0100, Paul Kocialkowski wrote:
> Merge contents of structs sun6i_csi and sun6i_csi_dev into a main
> sun6i_csi_device structure holding a sun6i_csi_v4l2 struct for things
> related to v4l2, as well as the already-existing sun6i_csi_video and
> sun6i_csi_config which are left unchanged.
>=20
> This mostly simplifies accessing stuff by having a single main
> structure accessible to every part of the code instead of a private
> definition.
>=20
> No functional change is intended in this commit, variables are just
> moved around (cosmetics).
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--pvpl6lthepkpplvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgDiXQAKCRDj7w1vZxhR
xSGfAQCEScJB9Pk5OkjRcUoUy0UT+1teyY75s7RbxibNwwsRuQEA7+Xs5alYNZVw
4mxVPttH8uX/GzbBfYot4xEMWPf2dQI=
=cJ27
-----END PGP SIGNATURE-----

--pvpl6lthepkpplvj--
