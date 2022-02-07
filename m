Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616934AB85A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352070AbiBGKJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351034AbiBGJzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:55:42 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1C6C043181;
        Mon,  7 Feb 2022 01:55:40 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3A1B65801B4;
        Mon,  7 Feb 2022 04:55:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 07 Feb 2022 04:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=LzpW5U29/mV3TnArXep7XidAoi+6P2KaOjL2Uu
        SGyY8=; b=MwrJLKGMyPYfjGSbDCS1Bf2SMrC4nOsXhJrjqKdZd8qTYTpfxFpND3
        /gsSGltSjOBoQkC5J+m/YTzVMLI1mmXh+5+Q7mtXzUvgmm7t9V52tqKFcEbkw4O7
        Q3N7WqUigvXrK/4VjQgdBAvxpcNzTRvBxF2csTyNz68ZthjZ/XEQTPwSXPvXJIQJ
        vP3qaDy5m0exlpNtsVHI/m6tSUU6yHnYrggo5LX7AAc+Q+FmmNCKwuEWt2KBhEUs
        9IZiCOxQp1WUR4fMwgFjBTLDbiUmezRa5+S/J/pC1Vh9PKGrplN9PmtuZtUOHz3u
        LkzM/UkUdr40WIWgRTwBGIDlyoNBmcrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LzpW5U29/mV3TnArX
        ep7XidAoi+6P2KaOjL2UuSGyY8=; b=Y1H9v6AU1pfVmn3nNPk08l9+B0J+9pnKa
        ZdiHbNsx/uiyxDrhDBw7CzGOtP9+Kb5rwIZviATjfFSqLYnFsw4M1p0KNG0kF3cA
        nIr35V2XkfxDylGVAmNHwoMXfREpbtbhsj5jJwdTOVj0nUj1p/vQ1RhvkJ8vtsRk
        glIk5rqme0zB7Zo05AGElNuMItJyD3AWIXQ+IEDb9YqXayoD3ofbrY36N8q3Uxt0
        afK9Mmb3Pies1SrH2FzMX9hmZ6hguz1aNUpRkh0hlO6ap0HcoRSIdT3Z6K1EODwm
        74lLGaCBl3U1Os+F1fic0CaLmu0zQ+g9wQW3W0dDGQ4Gq8XxG2TOA==
X-ME-Sender: <xms:muwAYnnfH21w3ZcYr9vUpgzcYUGx-F97VwZGwYnhXbtwy5sjkbjmlQ>
    <xme:muwAYq342lI5EVIWLeSOgymB5EkMPpM83WSbTo2S1Ddf1QJ8YI4_vTvy-qqLcqMe5
    25lNsFX3peeqlY8BSc>
X-ME-Received: <xmr:muwAYtqngz_qQbtbcklfBTqPSDbjELfpHcmEOdPhIp7zo5lxGBSTdL6SPfFktGE0VAJqm1TRsBCVotVZouaprw9NlmTI9CDbtEgJupw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:muwAYvm_t2Eh25_r1lKUHHTlvfu7vKe8Hy4YNn4zFvateXTN_9PEgg>
    <xmx:muwAYl03htUu29oGMPledVUjxdmcSi0sIAWKVMU18XH9LVClhf96fw>
    <xmx:muwAYuu8hbBa_2DGNEEwR7-AmlflacezEtyRO2ZJtIF__L1_t4yamQ>
    <xmx:nOwAYsue7NANvZAY5nXD7ySAL8rq_35RGFbNNtBo5k9smbwHLxm1mg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:55:38 -0500 (EST)
Date:   Mon, 7 Feb 2022 10:55:35 +0100
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
Subject: Re: [PATCH v2 23/66] media: sun6i-csi: Tidy up v4l2 code
Message-ID: <20220207095535.bvkenjwnrawbh66j@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-24-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z2k626xkldr63pmc"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-24-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z2k626xkldr63pmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:46PM +0100, Paul Kocialkowski wrote:
> Various cosmetic improvements to the v4l2 registration code, with
> renames, lowerings, etc. The cleanup function is moved down after
> setup. No functional change intended.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--z2k626xkldr63pmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgDslwAKCRDj7w1vZxhR
xYUzAP0ej+2jY/iJRXJJW8CJHTu9z9F4r55daJfJr9TYHTjmzAD/T7cUtfZlL39G
0syT9Uej1bcktNVjzCz1cIxmQn9AFAo=
=3IsS
-----END PGP SIGNATURE-----

--z2k626xkldr63pmc--
