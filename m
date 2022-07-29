Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E811584903
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiG2AUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiG2AUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:20:48 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Jul 2022 17:20:47 PDT
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3841903F;
        Thu, 28 Jul 2022 17:20:46 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 77CB758099B;
        Thu, 28 Jul 2022 20:14:48 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 28 Jul 2022 20:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659053688; x=1659060888; bh=1CqIgEzBLY
        47OHaV4sSf/xZhANJWym0dF7Lbe51Gho8=; b=Prja2fJywNoccXxpjpow3zGOJ2
        xOO4vfXVawIaKmJc0bhYtRFydLKuH0fHCgcVLRM1lUuLNu9BBN//3X9ouCnjhWE/
        h6CzOrA/fHh2fcolx+w5V5tq6TCq2bQIPsf3ZACWLAKEpf25e8ZY9XU3KFQic2se
        Jtce8nCqDD9jE+OjT6DxHmtBE41TY8DYxcrHiNxcyS8kN3p2GQxDzYsllntF8mJS
        FS2T7PKKNAKPR8aJRiKi728rbnqI8yzpnLur/gXgoHLFMmia3zmPWCK9KTleynRy
        jOxuw5ngIWElnzlSjMqsH07YSliZTA7wCA1cjU76B4SvQw24/jF2rPXTu1qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659053688; x=1659060888; bh=1CqIgEzBLY47OHaV4sSf/xZhANJW
        ym0dF7Lbe51Gho8=; b=rk1BZHZ1UaKHog5lKRuUrUckMq4BFSl4BtoMl4GVeEqA
        uP8Q/U4l30FCDS6Lcw3xoSku/ZK/qU0Ppk3IwCHStdpczFzStmnmO+vC8fgdqtMF
        L/9J11RH73L9sx+hzEM7Eu5L2OQZDiRt+J4fkyFq50/7oqrhR+fyh3f2zJfKWvbX
        G5oB1PIDRUU4HJ25E1M0KtG9dyqUyrQTA3jbvGkorG2/yaqJAjlBAAjd5Q2fWxl8
        Itq4r/XIBs9hQu2qdc6/UCMqpnavTMvAaMxWwoxGtCPMptiR3o/ZgbZKMSuVjAu9
        GxafBtrfUIcHJLVFoN5Y5kI4k3zq1mPqBv0rN8j4eQ==
X-ME-Sender: <xms:dibjYq61WULSSvHAb-Fw6g_a4fXhuLh8dvOAfkntuhZvcfdlvl7Pww>
    <xme:dibjYj7LyoGVphHU_BmO-2rYwgaulvBbRFulbawl0I52oSGsa9-e4LnjM3ZcB2utm
    iqBTBR4VqJXRHgcMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduhedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhgurhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecugg
    ftrfgrthhtvghrnhepkedvkeejkefgjeduffetteegjeekteetudevtdfftdeluddthfeh
    veefteekieetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:dibjYpeVeo5Y5h9hpZreusiUaYr9cd-GNjqdKKjoELpg2MwQwS2j_g>
    <xmx:dibjYnLHruoskZDhofIBZdqd2L6PUeOuHZh_12EOvd8nk4fKXELcKA>
    <xmx:dibjYuIb9-it4epXA9PpIvUcVGm0Og35TN2M0qLz4e-5zACCQcRfjQ>
    <xmx:eCbjYsQMVZNaGfoD93vj0O0QSde7ARYF5pisHwVHhhgcCI35mR2OAg>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 183BA1700083; Thu, 28 Jul 2022 20:14:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-757-gc3ad9c75d3-fm-20220722.001-gc3ad9c75
Mime-Version: 1.0
Message-Id: <833e10d7-ceb1-4859-8028-e724d41421f1@www.fastmail.com>
In-Reply-To: <20220721141325.2413920-2-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org>
 <20220721141325.2413920-2-arnd@kernel.org>
Date:   Fri, 29 Jul 2022 09:44:25 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Arnd Bergmann" <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Andrew Lunn" <andrew@lunn.ch>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        linux-aspeed@lists.ozlabs.org,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        "Liviu Dudau" <liviu.dudau@arm.com>,
        "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Alexander Shiyan" <shc_work@mail.ru>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Will Deacon" <will@kernel.org>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        linux-sh@vger.kernel.org,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com,
        "NXP Linux Team" <linux-imx@nxp.com>, linux-sunxi@lists.linux.dev,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>, "Ray Jui" <rjui@broadcom.com>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Takao Orito" <orito.takao@socionext.com>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        "Scott Branden" <sbranden@broadcom.com>,
        "Taichi Sugaya" <sugaya.taichi@socionext.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Sudeep Holla" <sudeep.holla@arm.com>, linux-oxnas@groups.io,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 1/6] ARM: refresh defconfig files
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Jul 2022, at 23:43, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> A lot of Kconfig options have changed over the years, and we tend
> to not do a blind 'make defconfig' to refresh the files, to ensure
> we catch options that should not have gone away.
>
> I used some a bit of scripting to only rework the bits where an
> option moved around in any of the defconfig files, without also
> dropping any of the other lines, to make it clearer which options
> we no longer have.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/am200epdkit_defconfig    |  26 ++---
>  arch/arm/configs/aspeed_g4_defconfig      |  16 +--
>  arch/arm/configs/aspeed_g5_defconfig      |  16 +--

For the Aspeed bits:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
