Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422194AB70B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiBGI7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351276AbiBGI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:56:01 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88C2C043187;
        Mon,  7 Feb 2022 00:56:00 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6CA2E580161;
        Mon,  7 Feb 2022 03:46:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 07 Feb 2022 03:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=06iDWhIMWF+GL+
        4tV1ry3WHLDvx8sEGX8SCia4bLUlo=; b=SzyNoAzmVIrpysc1eyqHTcsbRZ33lG
        kZioZV9XgeEStB5uEDLvkVS+XJNc18BEIMh3xfV5UCIlw5NUT1gIH6OTM8OT6t63
        efaz9q0t4r3rUsAQFySCwe4JDTukdE39OxTMFAkNYebPDKWZZZuCPukDXOfVWXW3
        voc7zDtotovPQHB6OeTtvT9sNavWKnsZAmeaJc5GHJxgY1CLrLj8u+8twZxo6skE
        ncIOkGAHt5iAOq5SFszdPkWlHTOS54aNrdp0QWMvOfGkugfPHqFbrCKtFDuq03zp
        uwoKSnF22vUn2lMMswRKNIhqzF1D8Vgc/+tg4ra2jv2rIw6+cz/S9S5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=06iDWhIMWF+GL+4tV1ry3WHLDvx8sEGX8SCia4bLU
        lo=; b=Gdy+GNNvCJjjAF8MZ/+bNLQL4iSm/u2ss9Lf0HTkZ1lGBEETWFMTR+KBo
        JbEFEdbPEoKYhU6zhp6hPgA6NkHVRWSGhNbASWKiAAgqRj3JnjtpFGxR6CgerOZ5
        2ppQ6LGU7HXcUDCmY8MJ1EFSl8+tn1hyhZGo6q7giSGUEbGDs4tjtnHDpwVZqPjc
        n3F07jWlqbwXhrY2Cm++fh6dgWhHcbAGxRjPJ4zR8Jably9LaSORMWGcSImuNh7S
        Y3FK/D6psNQu3j8koi5dsDjphpzqGvPFuDgsCO+l2BNzKxs1ei/c0S5SYYe7ya3/
        m5C/1A2IDiFa1BgR13kqpf5XD46yg==
X-ME-Sender: <xms:X9wAYnyoadC6crowfp6rSS1g_dZJJyZj0HJbNH4Fsz_YHqCWaT9u0g>
    <xme:X9wAYvRAosyTp15LWmaagYVihilD-ACCq49PDWHSfE8Hj5ISZKeCtnWns09h_Ep-j
    ca5e0qtAIxgWuubaJ0>
X-ME-Received: <xmr:X9wAYhU4wVdLfn71BD3noSDT2ROADAh_MlBDHFABwQLaQ0RmWAD3_ORgTpeEekafKSObjUHVfrTrCLt60aT7W5cbkSVXpKuNxSocEng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeggdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:X9wAYhgr5yOXQMtplYYtze_ycHouRGRlqOM4hfQ7uT8buKsx3m3DVw>
    <xmx:X9wAYpCtiMCGwFyE1NbyckGN18_nYOxMh0h9jllqSWSAisFh_WD41w>
    <xmx:X9wAYqLixyckvrMMMAQ-PW9eACQAlrL-zrMFV9unpPM-g_XE05EIaA>
    <xmx:YNwAYhxau4hnrYfLueK715S0kZ6KONWoSIyJmS1PYmeypzX5iZv_7A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 03:46:23 -0500 (EST)
Date:   Mon, 7 Feb 2022 09:46:20 +0100
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
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: rtc: sun6i: Clean up repetition
Message-ID: <20220207084620.xajb5wx6bbgg4ugh@houat>
References: <20220203021736.13434-1-samuel@sholland.org>
 <20220203021736.13434-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220203021736.13434-2-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 08:17:31PM -0600, Samuel Holland wrote:
> - Use "enum" for compatibles instead of several "const" alternatives.
> - Merge the H6 clock-output-names minItems/maxItems constraint into the
>   identical block above.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime
