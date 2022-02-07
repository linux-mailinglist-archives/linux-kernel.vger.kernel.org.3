Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2338E4AB84E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiBGKJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbiBGJ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:56:40 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2DEC043188;
        Mon,  7 Feb 2022 01:56:39 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 19A9B5801B1;
        Mon,  7 Feb 2022 04:56:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 07 Feb 2022 04:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=kGIMVYhKNCUOPYuVWpsXpzFka3m2RK9MnBQ1Zh
        CUJw0=; b=W/NE6I+eNlpjh6UO5VSgb7pJjCD4kgvHSRxmCyUQY2alPdd9ud2Csy
        Rg/0mLwlxFzml9FA630Z6UN9/dJZ91di1AxwMoBIGnWAuRClF1r2OeTPCpgbTCL/
        sGntx8DNrjEvHA0fg8E/vayRNBgHIjg2LTgo1wLh/HiXAjF/wjQUoX3BrNcb3aJw
        yHlo387UzHeAE0cQ6Fyk8x3spQ2JRjjJ1QNn6qn5Zyu0wm+w8nVL2ukxHkEFBTGR
        mN5xk4oocy3yGeordrzMszSH/AfSeR5y3T42Pxhk99OngnAXUcXHazqBDAQ8zdUw
        /HS7UNGbuq6jfRgEmIXK4CnJN4qoiDpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kGIMVYhKNCUOPYuVW
        psXpzFka3m2RK9MnBQ1ZhCUJw0=; b=T4pixUTz9EGQeZ5nMxygyybJID341dNQu
        9gvL3iVHPDruyI9/kNiLP/nmgNaVSmfpYKO7vQlbscnu1dF0K+wDaRNy/E0C0Ean
        MM5eONfdQdFs6MD19CZhVH2Vfa1Puj8WfM+iOpLHz394w0+L6m1Rt46mr4Xd2KJ2
        VRsGxh8Us0ve+cd7IVv9YJk4CTBNTBIEH/YiLyB5bkoEewG4sExvMqLHU/pl1MAL
        rli8hB1Ksd4n4wW5JV0G9ratwqf8kRY3oWx3bt5VqssspLJ1Ww0Ut/PBF2mgHDNY
        l2HH7aZHSjOP1HiFqbVsgymDWbi1eO7GhS2+Mu5BxGyq9w9+uJO5w==
X-ME-Sender: <xms:1uwAYmCd4dWfTFwbmZMzaIzU4qwW7XvrdOok8Iz7_VDd1yJjluPsHA>
    <xme:1uwAYghe6mBViOZMM9FzfrDrQkNvnPc9jwihc497M-lCkvJ-I1EwB4NKwqe8oT5TU
    dfyE6ZtJVeVGA4WT9A>
X-ME-Received: <xmr:1uwAYpmRBWuemiFFlQvB3RgOILvxo-1O0Pbw0BISlKnp1tUxUhtxfJQ-cuAaQcptH1tkAWFLs3I9DXSk4ugb2qd_augvSuTL_eA0smA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:1uwAYkzgHb5EfN9-i9d458PWYAM8GUHuZ-rFIOsa3oIRsMtjYKWN8g>
    <xmx:1uwAYrSMkLR0RcApVpl6j1G6eqwy2SN0Rl010dxnffzbn7LlSQE94Q>
    <xmx:1uwAYvY8zA4DTe3_dQjXZ5bjFVEn7ZdbAalQtAvCB0jkjdHGwWwF9g>
    <xmx:1-wAYsJjFnQwWw7aXHbVGFPdqU3iO8pJbDfGoUbBz4VlDSG1Kj_1Lw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 04:56:38 -0500 (EST)
Date:   Mon, 7 Feb 2022 10:56:36 +0100
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
Subject: Re: [PATCH v2 24/66] media: sun6i-csi: Tidy up video code
Message-ID: <20220207095636.qoqagsavskhlrng7@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-25-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pyrsjzli2thxv5dg"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-25-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pyrsjzli2thxv5dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:47PM +0100, Paul Kocialkowski wrote:
> Some code cleanups, renames, variable lowerings and moving things around =
for
> better organization. No functional change intended.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--pyrsjzli2thxv5dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgDs1AAKCRDj7w1vZxhR
xQKnAQCMUjpfUgamt9vxCE20zE0gPD6E4cQ4Qn5ABCapBEwBMAEAvy8vHSWgmZqd
l7MgNjmOqkikWP952Y5ku+UaAbTVFA0=
=XZPY
-----END PGP SIGNATURE-----

--pyrsjzli2thxv5dg--
