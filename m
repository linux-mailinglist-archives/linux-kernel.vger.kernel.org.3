Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7204AEF19
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbiBIKQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiBIKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:16:49 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D0E04AC97;
        Wed,  9 Feb 2022 02:13:08 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 776AF2B00246;
        Wed,  9 Feb 2022 04:26:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 09 Feb 2022 04:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=Yst7o+x5EtjXnl33aAZq4gosVv6gXJnBpoVn39
        4TOHM=; b=ZpBgYdgJXi4cgTd2jIrh7o0vMx/f5jSOVxlKfvr2bC/EVLUhib//y0
        +9la+HhPPoaLIVv7YsYEPSFEdw/FAJg2YaNc99THHsSU97m6w6wjCXbFXmt3n3t5
        vPE2WKMv5XYIfnxodrSruxN70ye9IZYtyhoKN+ajkooexyppjjfk1zw+yQju7ETN
        5F5wr+Ev5qDDaM5J2/0Wx8QQIo7bPAV70m2R66gQS4F4ynVhSRLTBExxw+QyJWlU
        +7TQqwGJafgyuZiTgehN9wLXxPb8pfr7nxmMXeYjS8n+SdF6EmbghkDB0enUlX17
        vr4IQ4vQlCepHCrixpv8/QPGbMQUEJvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Yst7o+x5EtjXnl33a
        AZq4gosVv6gXJnBpoVn394TOHM=; b=VO8XXfMVkaKkzAcPxAOsWlpy9P2Mr7HoG
        yDa+wCRtVfanK3hE58CxKm5hcLrf0HK5wAxIGZpU7reFl9WfR8K+uFY3SihJmyiX
        E3eNUaHXhghVHkDK2xlXny4mDVbxPumcqjOh56DXJDTCbu+1hjd2GprCfjZwVGF+
        frj8Po4MDFdlqYUbtFhi4N4OEkZfAGBVPKa5FSPVqHYE8M7BbWoG4O2hfDp1ZMbz
        n7sUkkcdVuWMtFn/52mdV3Ror9VYTCMr6YMpVocRKffhPzWlzLq4cTEK3pwvJeuF
        NegHi8sK4kWOgJOJ/+Is0WGnFn22Bxp393MhUM0MaXxsNsvhYySXA==
X-ME-Sender: <xms:1IgDYlpg8b5Y9Y1oY42SMjSIkvdgXSlkdBypxcVIji9uGNkKoUmeJQ>
    <xme:1IgDYnr-RFC1aprnWlg66CCuKOdNjSnY_mdYhGLehoqFzZWorRpPWmzyWCYXaxHEr
    FtIRQ8BH5jWV6IoJIg>
X-ME-Received: <xmr:1IgDYiNO2oX1EQXQ9eGbgFALH9i5cdo0M_mZlObzoGobEncfh14D5ML4ODtCUkrtTVyIVMe8AIYpblUns8B4JnLCOjMs-f2nbL_T3Hk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:1IgDYg4jTsdQohGOtMnY_Lc8zeoijPD_7f_6iaTYCqE2MHR4apqggQ>
    <xmx:1IgDYk5F78AtfFpKLVYDb2N7uP-p5iQKFtwqJUpSwJwH7V8Sb30Idg>
    <xmx:1IgDYogy8ya_HjfxBgzv49dLXbHJ9OmTphMvcOniqYrE7W4L6nSTPw>
    <xmx:1YgDYhwAvhIjkYEblBF7w5e6SrUg1tYL5CcwYRSJ4kAvqvcExhGQj58yfF4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 04:26:43 -0500 (EST)
Date:   Wed, 9 Feb 2022 10:26:42 +0100
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
Subject: Re: [PATCH v2 32/66] media: sun6i-csi: Add capture state using vsync
 for page flip
Message-ID: <20220209092642.hhppmrrekj7zrorj@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-33-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jklumgcplfx32qie"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-33-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jklumgcplfx32qie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:55PM +0100, Paul Kocialkowski wrote:
> This introduces a new state structure and associated helpers for
> capture, which handles the buffer queue and state for each submitted
> buffer.
>=20
> Besides from the code refactoring, this changes the page flip point
> to vsync instead of frame done, which allows working with only
> two buffers without losing frames. This is apparently a more
> appropriate thing to do with this controller.

Why? What issues were you seeing before, how does using a separate
interrupt addresses it, and what makes you think it's more appropriate?

Maxime

--jklumgcplfx32qie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgOI0gAKCRDj7w1vZxhR
xYZPAQDrDko84tq9LXCvMRtIUy/RSXOSvfU/BhWGM/EPZPpjHAEArGovoU+NnCqt
aFGVF658ZsgVaRo6Oorm0BIvOnUZLgg=
=J6MU
-----END PGP SIGNATURE-----

--jklumgcplfx32qie--
