Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0713D4F0FFF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377676AbiDDHbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353761AbiDDHa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:30:59 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272A61403D;
        Mon,  4 Apr 2022 00:29:04 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3A2103201F82;
        Mon,  4 Apr 2022 03:29:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Apr 2022 03:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=h/d4R0yINpQf3Q
        7huFHq02rHS+Y8FhIyy0w0l8JY2tg=; b=wJV1LbKgjGW4zSvwVvZwGV0gBKwOUd
        4Hvnl6tYTtE+Is19GtTLAvsUywA/wFR9B1Y+31ol00bWBsXwzbHkjmF8txvKOIiE
        gw7xTEGdigaAIiDVv0sYMubY/ZjgGf8lafmpX1ptAPdL1vRXBLameWiRr9lxuHj6
        gSK1XZnEfv4oUBX9Z5s2bdtvdfzFF3BdtVOyY18sK2FNu6bmJb7cp2tVymOMsixU
        k5CX1ePxn7dGLFR6/kef5SEm9Kwefej5JhANQ197nQeFdxfaQl3ynJWqcFNcrdL7
        wG++dwQ1IrNVUgm2Eix6bAPdugK1cfivrsEHOiiSYC4oHcxHlWM40rSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=h/d4R0yINpQf3Q7huFHq02rHS+Y8FhIyy0w0l8JY2
        tg=; b=oe1jeF16vbKRkBCCOQDVCYEOlBHji4TO2zGmJ7fPjjF2APxdZJ1R58kZN
        2yJ9zTUCtg+1Zpf2k+hIYHPUFT02plhqKo9V19VmP664tH8iq7WpryVc1iWhPXFG
        bkHU9tyuwNKgUi73EvwtJh9v/nH3u2wkMxi2vCkGY+oOYI+of3BqVJxyat20/uPA
        0bBP2VpJ03H5bgZHIG/DEteZMp+8wj1aWkLU78/C7faqdLLs7HvUzt4BrdDKA24D
        5vurEg3nLno+nfFrzzZxE+4NNq52nbQD4xWOcmvgkJ8IP8f0tZZHBwG4Cjo5Iyis
        e4nyIxyrmDydt7WsS1Mt3lcIV26jA==
X-ME-Sender: <xms:Pp5KYrG19Pa3WLROU3UvleaPzJ09j3EJKPppJ942WL2jdZg-vnIThw>
    <xme:Pp5KYoV-kEbfLN0P0zE5u-b633aIEQB2E4Kr1IS-5CM9kSq-hsZm2juNgCc6WbSyw
    7w2w66sn5CGCTnrKLE>
X-ME-Received: <xmr:Pp5KYtK0Lc19uYrx_L8QPZOKirM1YYb1aBpQQ-9Q0Uwt9X2HUnR1IkauJRyoI7IEkAA6xrYsTqKgTl4_kOwRq6zAGy2NS21wg6r663E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepkeeileetveejffegueetjeeigffgfefgkeeuueetfffhheegveefhfek
    heevkedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:Pp5KYpEVZn9bpmrlC44RNMKXF-f0sjQFXQ6Ie-LeBguJHulmbGPBnQ>
    <xmx:Pp5KYhU5x9EKg4Z15QyshDkquQajYk7KkYF2CzuOt4l7rtfS8UnOKQ>
    <xmx:Pp5KYkPIXqWMszVCPKh2C7G-4-Lva-3SAHT5UYEUzH9zHw6ZxYtEXw>
    <xmx:Pp5KYjLpLv13KlGrIZ94r1bl6gA2EuU_ex19hYrOCTJ-5gBm2YBB9Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Apr 2022 03:29:01 -0400 (EDT)
Date:   Mon, 4 Apr 2022 09:29:00 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] Revert "clk: Drop the rate range on clk_put()"
Message-ID: <20220404072900.35jca2o26gopi2qb@houat>
References: <20220403022818.39572-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220403022818.39572-1-sboyd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 07:28:18PM -0700, Stephen Boyd wrote:
> This reverts commit 7dabfa2bc4803eed83d6f22bd6f045495f40636b. There are
> multiple reports that this breaks boot on various systems. The common
> theme is that orphan clks are having rates set on them when that isn't
> expected. Let's revert it out for now so that -rc1 boots.
>=20
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/r/366a0232-bb4a-c357-6aa8-636e398e05eb@sams=
ung.com
> Cc: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

I really like the attention it's getting now that it's broken, we can
fix a lot of things :)

It doesn't seem to be restricted to orphan clocks though :/

But obviously,
Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime
