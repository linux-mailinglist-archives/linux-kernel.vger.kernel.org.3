Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9F4A8029
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347061AbiBCIN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:13:56 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:60343 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237055AbiBCINs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:13:48 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8D7AA32020F4;
        Thu,  3 Feb 2022 03:13:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 03 Feb 2022 03:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=YINLY3zuPhR6koGn0fieHjj7cQe2rTD9umLQbf
        rHwso=; b=jj5BML7DsyOYOzb3bYV9F1nuecl/qSgcQypjbVrfeZ/EMf6GnW0Qfj
        Ql4T4f5gmdeYtsf4IUUgqc3ZTz0Dcx9YCTEKBrp7GlN9df9khqogqO5klABH4gxS
        496lsAs+1PB2RRWp506M7CPPAnHL10kvJGa/AC2sBdBdVvgA6KYxLTfe+C7EHL1D
        J1Z/5nXUBij/+xGJ9ubIJIQ7rmfcYJS7UtCnbPD5UXaKCNU1IR9krvCRq/ZWNEiJ
        S0ElGGciS6aXXBGjbZmr6ii9JD71k1ZtysK2OOiQQMIRrLbI8LUu8fNZjU2vURMo
        YEyu7PsAcCXczeaHzzSmiYzHus1zS6lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YINLY3zuPhR6koGn0
        fieHjj7cQe2rTD9umLQbfrHwso=; b=e/XxvvXKlJwWYBX8bDdLHldzhyMYMRsrJ
        gTuOvF1r2nTcKzOAXfkMewm/v8qOHQyaOYwpofb3UNLcDSn/M7sNYmR3q7l+SC/d
        4e2ssNr05/REUTSFopyVTdioxaCCsNzuG/gehT7v5KFekBrarfT5koocXbs8ig0c
        mbnGj6qtA77F+WCHaxnujhr2AM5rxtPc9aQFnt2U0HOykwL/rCq+Z45mi+lF863w
        AYmI+14cWY0/hAi/LWNqpBEt9YyG1APWEiQYdCkJ8TPCkoNnd9CQQw0JwKURLmPw
        EoCczpbCG2XtULLYr5qp6G9S/zKywqFmPoE1s0oSl8IEXDeT6RaZQ==
X-ME-Sender: <xms:uo77YTA7vFPhYunl215aK6WgXn5ASelqZBrDKUPsaLICJJOo_kKnDA>
    <xme:uo77YZhviDy-hVYAD9I6OaiaMt-i26a5IiCHBDjetSammZnKQozx_LwezDTwmcdFU
    7CZtl4WeWEBXG4euSk>
X-ME-Received: <xmr:uo77Yelr2gGqDUABpFtuNA97nXsThG8GAv-XKo-FANXluz-AZ0MvkN0cPEc9e7xl4_7IYkFnhvJkBOiSubNsGUauJRnC5ZfsVcNNqYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:uo77YVy0otTF7NNRJNy-_sQ9Ii7OR5qdJxad0l74WTLiYY_XBvOcAw>
    <xmx:uo77YYQ3ZQBqgiTwnTDM9_E4az_zBDzDUb59VzFx7Ki31kssOR78pw>
    <xmx:uo77YYbXj0F6YfxtINOHadeGixSW-PU7nkfQEJLHMb83qLG2sPoi8w>
    <xmx:u477YdQPzfKXVtcbngzXJsEifYF1xh2Dv1ejkp89VYo0WcHBmmiL7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Feb 2022 03:13:46 -0500 (EST)
Date:   Thu, 3 Feb 2022 09:13:45 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] nvmem: sunxi_sid: Add support for D1 variant
Message-ID: <20220203081345.kqavvvgq3lnmm2s2@houat>
References: <20220203012502.10661-1-samuel@sholland.org>
 <20220203012502.10661-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cain26m2em4gieqh"
Content-Disposition: inline
In-Reply-To: <20220203012502.10661-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cain26m2em4gieqh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 07:25:01PM -0600, Samuel Holland wrote:
> D1 has a smaller eFuse block than some other recent SoCs, and it no
> longer requires a workaround to read the eFuse data.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--cain26m2em4gieqh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYfuOuAAKCRDj7w1vZxhR
xVj1AP9kafClstYbXgp0QSz8c+SOATHI/7ZDtmy6FjwrAcM4fQEAg6XJcFyIKldS
kPB8WZUmJb1OVsVY6Te7HVEAI6dk7Ao=
=RMcu
-----END PGP SIGNATURE-----

--cain26m2em4gieqh--
