Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960CC46698B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376515AbhLBSDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:03:48 -0500
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:49977 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231154AbhLBSDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:03:41 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C2E1B2B0059C;
        Thu,  2 Dec 2021 13:00:14 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 13:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=WqXxaA56k/cauFGBfgNPZ3hCAT2Z
        ZqG8MOqqw2pzOQo=; b=Q7SgWEGzLoSyIq6xy710syOyNYRzSY70ii+4tWyaz/6X
        hOMAwaxeyQ2+bPY0DqPlFI0lPIKMXqRF1xnIU1vfUfvGN/tyXPMLCjyVxLDmqRoF
        CfCSBW5PZO/l9p6h/tZP7vFeQ4MzaSGGKXxPELhobN0Yp1ZCNah5rqfSGJ/q+TH+
        j8fXt0l5/IsvL0J5lv8uVftN6LwBqPmmzo1644ihuvqcB85TXXY/S6cqyEbJk0hB
        lFdlwkJEPNTZxx9jJOhrDZaMXZNsUUT4m3riAIJlfFqzjNcE6ot6W+bmtOCwDXtz
        4sCazQ/XqqZpunqm6udU8wF08Cpj7aLXroF1fZnfCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WqXxaA
        56k/cauFGBfgNPZ3hCAT2ZZqG8MOqqw2pzOQo=; b=UYYZt731oJ+nbG7EH3+d9z
        PzahR1GOPDOYXgJwUFC/aWYhrvid9ZRx1y3edS+4B0vm8HDDLWDL8ErggL/0GIUR
        reHaxnx/PURLqBHGgOnvFle7uS70vH6qai6ENM7By/vlbTxTxFrgnL8Zh3ax8SOP
        UPYeyCk72YCubUt3ii+XuXud1EuyTuW7ne4Dx6i2i1I3iJ7L+a4Ymu72Zp3MtJ9B
        3oekRDnmdEj8dNhPwe0qgXMjSf/CLA2f0q5xVGBb+Drchr84pnH4Cuc+zFCkJqrV
        EPSi11YbY9h8BWgIg5zsAB3Ie+rHmWqyeyJO6CiLefL/dOsowIpn+ooxupAmyFCA
        ==
X-ME-Sender: <xms:rAmpYVDNsZ4OMuM83jX22uCU1x1Bl02DtvgN-fzwzhTWNXA2YAqMNw>
    <xme:rAmpYThn4D1Z82MLiQney_E6S-esg3jL2rurkUfFibIyqtsIk-FKSSmAcw5fhY_HG
    AfuHVZq3gXJX2J-Lr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:rAmpYQmbSKSf5hhg5tkr0ORujfI76t9xU3Iox92ENediIqyyvSn3mA>
    <xmx:rAmpYfyEYy1vx0Ve0donjTChqT08Ntz1ZrWqgcltWTq8pnjLN7hi9g>
    <xmx:rAmpYaTLbRkJzRLKa0-d50N-kFNRRkbYt6LCK3KhONfRUuSAJ58Otw>
    <xmx:rgmpYfg187so2lmfmXDBqxodtwj-8q5aCp5Q2I4WCMvXE3iaTOk8XND9ZMM>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CAC5F27407D4; Thu,  2 Dec 2021 13:00:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4458-g51a91c06b2-fm-20211130.004-g51a91c06
Mime-Version: 1.0
Message-Id: <1954b7b6-abb8-4a73-9d90-6b2342f73bb8@www.fastmail.com>
In-Reply-To: <20211124073419.181799-10-marcan@marcan.st>
References: <20211124073419.181799-1-marcan@marcan.st>
 <20211124073419.181799-10-marcan@marcan.st>
Date:   Thu, 02 Dec 2021 18:59:51 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org
Cc:     "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Johan Hovold" <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 09/11] arm64: dts: apple: t8103: Add PMGR nodes
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Nov 24, 2021, at 08:34, Hector Martin wrote:
> This adds the two PMGR nodes and all known power state subnodes. Since
> there are a large number of them, let's put them in a separate file to
> include.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  arch/arm64/boot/dts/apple/t8103-pmgr.dtsi | 1136 +++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi      |   24 +
>  2 files changed, 1160 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
>
> diff --git a/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi 
> b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
> new file mode 100644
> index 000000000000..1310be74df1d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
> @@ -0,0 +1,1136 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * PMGR Power domains for the Apple T8103 "M1" SoC
> + *
> + * Copyright The Asahi Linux Contributors
> + */
> +
> +

[...]

> +	ps_atc0_usb_aon: power-controller@88 {
> +		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +		reg = <0x88 4>;
> +		#power-domain-cells = <0>;
> +		#reset-cells = <0>;
> +		label = "atc0_usb_aon";
> +	};
> +
> +	ps_atc1_usb_aon: power-controller@90 {
> +		compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
> +		reg = <0x90 4>;
> +		#power-domain-cells = <0>;
> +		#reset-cells = <0>;
> +		label = "atc1_usb_aon";
> +	};

These two nodes have AON in their name but can be powered off.
Is this intentional and Apple just labels things a bit weird in the ADT
again?


With that confirmed:

Reviewed-by: Sven Peter <sven@svenpeter.dev>




Best,

Sven
