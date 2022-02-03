Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBFE4A802B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346417AbiBCIOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:14:48 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47635 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239825AbiBCIOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:14:45 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4B52B58028B;
        Thu,  3 Feb 2022 03:14:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 03 Feb 2022 03:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=g0pk/IL+SUr/Cc7b8VMIHRiL7WuNfWxDPfDQv3
        PTMxg=; b=Xl/Aag+ASepVDwAcVOkFYKdE/7Oeizbn8eHs3BemhIe/o5J+oGm10B
        H1Y3VG5nTXltADnJqwDb0TkxnfKYgRLibnWqmols6jcdhz1FsCxVh3ftmPKY/tRc
        47RkIRJi42Ytl045DXLw+A3TADkPpgYpioKVLfatR3+NWYxtt++zlbEQx4TvqS8W
        gAeqWgxy1AKGYheZwYZT1R0DxkWiKJwp7yk33R9h5+j3cHg4dUq9xLrk2vzZ/hsO
        6lno9WFo3tpxllRV50wNyUIDcw3KhcXJTjq297jYC+4AIMQuFUUPRR8IrqPvJuzx
        aq1X1XTSbJBea9hN66L/S/xrbL99VWuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=g0pk/IL+SUr/Cc7b8
        VMIHRiL7WuNfWxDPfDQv3PTMxg=; b=MDBhOJ8TXyUc00WDBLUWzG4EVPkL3duyB
        uAVUx1DBCJShgGd9Fgg3kbYW+fSW1jHI+qpPaedyJb1nMx6W8CvinrzMVMPt2ZA5
        iZxzvTRqT+TDWEtZ/64ULBF3uAwar6nnzMi3AJSpdrwJmnxQkcRhkBq3O/QaQjYd
        olciq6DkLmyRClaORjJMkvOD9PTC+Gj6H1jcJVUe2v7aeKTtqSkx1ljCJsXEi7ii
        YtzP56ceVRLmv9VnyUWWdfOhS2NEh9dU8vtPmN+Hu949l7WLPhlekjLIrGnWPqqx
        p/Kj2Pxd2MGFqzHCJsq4V8O3eypHRj4XqrarEcTr+1zhZok2dJvsw==
X-ME-Sender: <xms:9Y77YY2YhrsAX52BEaKdo7vVnTwqfqZxH2_lx1_9IsdN5f-ItqnObA>
    <xme:9Y77YTG-T_WfqzYOfTdJPnPSKlDiBIV0Hpw5m966BmaPUunc6CYVCO06tun2z6h-D
    tq5aGz4vFzSSxdp89o>
X-ME-Received: <xmr:9Y77YQ5ZYOJGY65G9Gno_7rHlNUIUkeBlNV_8VJrN2vx86_ipAbPLoGDEzpROys1Fvp8Fa1EhGj8wYaPZeHWQb5MISKH_BmXsfiENsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:9Y77YR3r03Q3I2Tk4PrIzvkHeQSv89O-SJ7-TdiZ5X0OeWlx4Fy55g>
    <xmx:9Y77YbHtdkTV5LpCViZXqE2XCbVIwRs-iSUs8zc_53xVz6IY438ndQ>
    <xmx:9Y77Ya_WQh7ZXbPaofWMMsa2P_Z81Xo5LWzWAokz7cjyLcIw_eeTJg>
    <xmx:9Y77YT9OqPR_oEKkIADtHhbdef8F89zOaXwaIYOFZvfQHwI1JrXExg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Feb 2022 03:14:44 -0500 (EST)
Date:   Thu, 3 Feb 2022 09:14:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 1/4] dt-bindings: phy: Add compatible for D1 USB PHY
Message-ID: <20220203081443.lgishr4lbz6asbd5@houat>
References: <20220203013558.11490-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d3d4ssd6wxoltkfu"
Content-Disposition: inline
In-Reply-To: <20220203013558.11490-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d3d4ssd6wxoltkfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 07:35:54PM -0600, Samuel Holland wrote:
> D1 features one OTG port and one host port, like the A64 SoC, so its
> USB PHY supports the same set of properties. Add the new compatible to
> the existing binding.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

for the series:

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--d3d4ssd6wxoltkfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYfuO8wAKCRDj7w1vZxhR
xSM4AQCVJr7dBdD67lry2C5gvGUfY6mTWZFR2miM2F5WMXRLkwEAhVsKhxVOvchc
em2yLo1aKpV1AMz0Yzpiafdz8OZewQY=
=7wru
-----END PGP SIGNATURE-----

--d3d4ssd6wxoltkfu--
