Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A094AB6F9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348677AbiBGI7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348893AbiBGI4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:56:37 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28F5C0401C5;
        Mon,  7 Feb 2022 00:56:36 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1A5DB580150;
        Mon,  7 Feb 2022 03:56:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Feb 2022 03:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=BEewoVma9HXhmdhrD/v/m7pVTmB9jXt2yFyzuP
        Re66c=; b=FSi8BimzmGAYlUPJ43h3bUAe+OjPK4WRDVu5DpVPMCXDnojl+YQD4j
        eC6rWJszOwSqDYxPPADu+NHiWRNJsSqvPXIi+VR9mGHCbzfgOdOAIbhZ7RqYpt5u
        EKumqhX47+7dADXKTb2SZuJd8JX7g2eR7Gsdt9H9GYrNqph7iRR7AZt6f/M9oSFd
        iWTHmsdsjkMKfP6arYiI0riaFAGlPP+k5RuvCswaPiAJUBEbobG60yX1aihy7hJC
        C5l/KY9jgibo1DH6lRm5OLli8nHJNdcPluqMyd+wv8C3Oko1mTdWT8zCNzGnbofW
        iUxav4kM7S8SXUepJmmB2xis78jDo1WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BEewoVma9HXhmdhrD
        /v/m7pVTmB9jXt2yFyzuPRe66c=; b=RMgAJFvB+k0+HLJBsC4gYb7eF+d4+6Kpg
        MXjZkvrHdRYC9sGSPn3vauHUtiqPb8QnloHpztapfOOQQDlIDTYm3punCJymoYdp
        mphiZhLU3ciYvQshxpGwnupaGld5A0KtiC1b+vWOoIvpZft8cF934IIAm2QHrZqM
        N1ofH8MGPpjtkgAuyM6ELzdFeDNsTkZovelUP4qJts4xTi3rLxpXz9m33PVoWMIC
        hBigMXWGRbYgIpb8wf0szg9ob+a4KGeVBJjFhCJXSFjy69IrJmduTf3Ztzwc6GCh
        8r/isNF2jGyTgdLeiYsQqmC09WNtqsRiTNgwXkP2cP6UA2wPkTTsQ==
X-ME-Sender: <xms:w94AYm_1fgUgcVnmmjjXFz1gQdoB32r4hLCo8394u5gEMNFPYV_Ugw>
    <xme:w94AYmtW2jPp_jN2_9TQRDj76JbYG5v1y9Twh342pnGtR8L9UUN-T9PJpvEWgDuVi
    2rjPbE1CuFqiFPtakw>
X-ME-Received: <xmr:w94AYsBFn6l1U-xjzm6WVolKkwOmtP9NwYXK1vWuAqoMP5RyQsvEDYevbtCP8isYT2DU8b66pNoMrcfAWbw28or1YSkeJOLJ4mkR1TY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeggdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:w94AYueeXmMqPMV62AN0i_OQl7Ryxnt0B8I6ubSMxP6HcR_rjdSzLQ>
    <xmx:w94AYrP2RF0sG_lzLC05Q-9rDMk6xHOKd8JB7VK26iUj2rqzXWxlvw>
    <xmx:w94AYol47NNFaOrQpaQFsh-ESNhFJ7vRdtykfZ41PihetdYR4cqEJA>
    <xmx:xN4AYvkmvo30Fxi2J8vew-MTWjnx5jNa98swIh5TU0jTmLA249Q2Hw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 03:56:34 -0500 (EST)
Date:   Mon, 7 Feb 2022 09:56:33 +0100
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
Subject: Re: [PATCH v3 3/6] rtc: sun6i: Enable the bus clock when provided
Message-ID: <20220207085633.q5ubv4v4iv4rg6rv@houat>
References: <20220203021736.13434-1-samuel@sholland.org>
 <20220203021736.13434-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6ts3zafdzecbmnf"
Content-Disposition: inline
In-Reply-To: <20220203021736.13434-4-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e6ts3zafdzecbmnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 08:17:33PM -0600, Samuel Holland wrote:
> H6 and newer variants of the RTC hardware have a bus clock gate in the
> PRCM CCU. This was not known at the time H6 support was added, so it was
> not included in the H6 RTC binding, nor in the H6 PRCM CCU driver. Now
> that this clock gate is documented, it is included in the A100 and D1
> PRCM CCU drivers. Therefore, the RTC driver needs to have a consumer for
> the clock gate to prevent Linux from disabling it.
>=20
> Patch-changes: 3
>  - New patch for compatibility with new CCU drivers

Did that creep in? Shouldn't it be in your changelog?

With that fixed,
Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--e6ts3zafdzecbmnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgDewQAKCRDj7w1vZxhR
xbs1AP9OCXqNcbxnEr+NVY47L454dgyjujqAGtd5ZEb99XtJ6AD/QgF3NL4AwVd4
Dq+JeHsetvY+k2GM6U4CtGoO3FXkLAc=
=/6TF
-----END PGP SIGNATURE-----

--e6ts3zafdzecbmnf--
