Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A9B4B2665
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350317AbiBKMu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:50:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350299AbiBKMuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:50:54 -0500
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 04:50:51 PST
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC2B49;
        Fri, 11 Feb 2022 04:50:50 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 7B1422B0015B;
        Fri, 11 Feb 2022 07:43:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 11 Feb 2022 07:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=BDYhciq+AIHw6hjqPa/dRDkYC8xAIm4+0THkok
        Yzbis=; b=Dq81JwwHX+baPcHzGY+cAveyLXmakpAEpZOt7zAUDj/YbPw3BNVCcQ
        K+9AIoqsPTHPptBs94tdPRvoXx0eACD4R07TJZzhyISh2lf+haEjeoYFQ3I4fNJb
        zCt5S0p6PjQffktregoTzcBxPiIxC6CCpr5Wdw+AZEYOiLUmrdd5PxAJmAvCSaEy
        /xD4wg+c7JX4e+KaAxMm8NPHUzJESCm7m2DcG6OXikCXRnpnxOJmFri7jGTs/2xQ
        DN90+joi6IFi3gmhfWnKQCFhPGqpHGxQVs2KZdRQDXa4v4NkHfEnwOLAoFM/L4+S
        ez5n3cdGlg6dn2xP0D2N35+nMdBAPL1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BDYhciq+AIHw6hjqP
        a/dRDkYC8xAIm4+0THkokYzbis=; b=bg8msYbqy1rWiMbg9LQzm63QMC/nShZkg
        nhvL+zJNAWfEKxQJLK+iF/4P+za5XKDceBPVBiZEe88QOavxSZzdC0OaVQfgUUZB
        489MlI22eKDjZPKL1U8yJsSSRFUe96tbTuZu7aHiGZN5T/AE5YBtPDIhMaLQQlul
        BEPHjFMu1Mg2meJhPU6m6+u5tGZ9xwHIAl0T8sz1iTA4opg2q6so0aS19pozTGY2
        bostmhHai8uwlk71sVjHyULCuVyFk3TDuZz5b6xOrLWZurCYfL/Z3wKR7JbqjUzu
        Y5MDvgKHwtKu3M9+sJo+HOIQXWOAHZrzfJP52jvuitPHJn1VTRmFg==
X-ME-Sender: <xms:41kGYmLc0CdM_etbKl-Vp6vregNpr3wLZEv5HCyuj7a1UH_wWB4tzw>
    <xme:41kGYuL9OwiaIKWevvj7UdbEGt0CDU94r-W-8_ZpZ6e76-VfPYGKMvKPQXtH6Mq8I
    YuuMr2kQ431_RzRp8Y>
X-ME-Received: <xmr:41kGYmt9XGeCQAc2b96iKo9v9ytLNlEy6lPQ6HVJJ_2Ok-qlQipc5LxMsrQHrq5knh21mcRCAYF-t5V5ej1JISWNhPvLh-0nO90oIEs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:41kGYrb0lsihBAsCkOmN4V_hVnMKMm81zjzXClgxvmtLq02ohS51fA>
    <xmx:41kGYtZ5LbDzg320thXD-IjgyJWFv5_Q7_wF_w-a-CjRnhXX6tswAQ>
    <xmx:41kGYnDAAUX1CP0Z14cgFJyUumFL5l1-byhNs-uoGHjJyKVTHFAC1A>
    <xmx:5VkGYhTbL4T6LyunZs3qneRlGpTUBFN_bhbEtRqqN_4PJAPZg7Gh_voH428>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 07:43:15 -0500 (EST)
Date:   Fri, 11 Feb 2022 13:43:12 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: (subset) [PATCH v3 5/6] clk: sunxi-ng: Add support for the sun6i
 RTC clocks
Message-ID: <20220211124312.kiw6t25nojvkp2rw@houat>
References: <20220203021736.13434-1-samuel@sholland.org>
 <20220203021736.13434-6-samuel@sholland.org>
 <164422443570.21572.13511859513410998733.b4-ty@cerno.tech>
 <bb05bc64-2a9e-fe21-5a69-0ea31134e978@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lqz5abdijtduikp5"
Content-Disposition: inline
In-Reply-To: <bb05bc64-2a9e-fe21-5a69-0ea31134e978@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lqz5abdijtduikp5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Mon, Feb 07, 2022 at 05:54:02PM -0600, Samuel Holland wrote:
> On 2/7/22 3:00 AM, Maxime Ripard wrote:
> > On Wed, 2 Feb 2022 20:17:35 -0600, Samuel Holland wrote:
> >> The RTC power domain in sun6i and newer SoCs manages the 16 MHz RC
> >> oscillator (called "IOSC" or "osc16M") and the optional 32 kHz crystal
> >> oscillator (called "LOSC" or "osc32k"). Starting with the H6, this pow=
er
> >> domain also handles the 24 MHz DCXO (called variously "HOSC", "dcxo24M=
",
> >> or "osc24M") as well. The H6 also adds a calibration circuit for IOSC.
> >>
> >> Later SoCs introduce further variations on the design:
> >>  - H616 adds an additional mux for the 32 kHz fanout source.
> >>  - R329 adds an additional mux for the RTC timekeeping clock, a clock
> >>    for the SPI bus between power domains inside the RTC, and removes t=
he
> >>    IOSC calibration functionality.
> >>
> >> [...]
> >=20
> > Applied to local tree (sunxi/clk-for-5.18).
>=20
> Part of the build failures were because this patch depends on patch 3. Is=
 that
> okay, or should I update this patch to be independent?

We don't have anything queued up yet, so I think the easiest would be to
merge this through the RTC tree. So nothing to do on your side yet, we
just need Alex to answer :)

Maxime

--lqz5abdijtduikp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgZZ4AAKCRDj7w1vZxhR
xXfFAQD+s0se1c3RmUjRKL5SSsXRiVv9CkvUKcfRH7ptG2jgtAEA775H2YEgm5Ju
UWHXjcknT+aQXdvvra4xK+YbD/hGBQg=
=vIOd
-----END PGP SIGNATURE-----

--lqz5abdijtduikp5--
