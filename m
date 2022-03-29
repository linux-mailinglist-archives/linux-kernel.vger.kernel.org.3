Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9864F4EA528
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiC2C37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiC2C34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:29:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736453A5;
        Mon, 28 Mar 2022 19:28:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 011495C01FC;
        Mon, 28 Mar 2022 22:28:11 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute5.internal (MEProxy); Mon, 28 Mar 2022 22:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=Tg9t/nSNCv1cymBb9h1DbMyvjS3EsvJEQGzQp2
        TOyM8=; b=XFkdhraQUwYLP4o4yQoWxpA4KPNvgAs2MZq5+h6OpbYKgarMR4XyAq
        eG954aYjmlj8D2qo8GV/K665oRn6qcrLy1ZbDcfjin8++CdViVHiXBeFEGy16Age
        YdaQXEW/CF8BBxVa16ceFrWcYrlpsGnPhjyhMTzW5VrJU8K5nc6QXadF9VbKXR5x
        LXE1RgCvGYE4TgQb3RwT/b76aKSXiGYC6OJz/p+Yd0fdVi25dpT95casX3VTTGAl
        mFWYEESn1vqThBiSwqFQkYHV2J5lb//emdr4G4JpxYwDs8eEv1Mguex0xjZD+Z1c
        o6NDTk+UVfKg6m+fhtwlY2YvN9ALrkbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Tg9t/nSNCv1cymBb9
        h1DbMyvjS3EsvJEQGzQp2TOyM8=; b=ll4aACnB0xXdqAGPRtbi6xARgqY3/Dv6v
        +P6I5Nha/DNjDpYCXI/weghAkDyzJS9w4tn8KIom47b7WZlcPLwtC/414LGdtKfZ
        D96ceFgosXG/PtyVWM7kLWsvRWao0fZGFk9S4CuikDiFy4LjdU1o6fdh8RMxUJXb
        LwVOWEFkq4S18j1cSy/jn9iHtzFh7kJXf9ZyWCEyXNbP1x/6zjdESpu/1G+m0lLQ
        jMgAmdqHBtCcJGN4Zf1SV7gifBLgKz9ONov5rkJvQubwrHdCgWk1P71EUReQTgei
        Dyn+ZQ9RLZzOM1zEv1+1/VHVuXT8p1BsrOtugf492fJ5Hy/lZDeDw==
X-ME-Sender: <xms:um5CYtqHueWV6efmC-OBJvze6gUG7EBH6CFW0E-50WHHCaM0CSNK7w>
    <xme:um5CYvrP-hBHlkLJr6TkTf2Ch8ro_QFAxnWLaYKu0buKpSccTfVJJRZW9ApRsKgu7
    lQJnW6VNZSjwCpigQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehkedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:um5CYqOBfQ-x1__xLH4NlEf1l47wv63yRB3L3qlfl8RwL2n6DimrZg>
    <xmx:um5CYo4QEHytI7S8Voa_ow5KlGjquqc3T-Lq1zZm8IBKwi5HL8QfNA>
    <xmx:um5CYs5k4uSD81iBMtu1LLNVYGGgE0m9xUdm_eYTT7pJebiFScFaYQ>
    <xmx:um5CYmT8LXX0P0z4fz6woyc_MUlXI5iaqfkOjVYMlrKY095hRoDefA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 76362F6043F; Mon, 28 Mar 2022 22:28:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4911-g925b585eab-fm-20220323.003-g925b585e
Mime-Version: 1.0
Message-Id: <8de31099-3695-4d9c-a656-525ff1945112@www.fastmail.com>
In-Reply-To: <SG2PR06MB2315BF301B03A52EE0D8BB56E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
References: <SG2PR06MB2315BF301B03A52EE0D8BB56E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
Date:   Tue, 29 Mar 2022 12:57:39 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Howard Chiu" <howard_chiu@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "Troy Lee" <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v3 1/2] ARM: dts: aspeed: Add video engine
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Howard,

On Tue, 29 Mar 2022, at 12:08, Howard Chiu wrote:
> The ast2600 SoC has an embedded video engine
> This node was removed by commit 645afe7

The summary line of the commit should follow the commit ID (which 
should also be 12 characters not 7) here, so:

645afe73f951 ("ARM: dts: aspeed: ast2600: Update XDMA engine node")

>

And then you also need a fixes tag:

Fixes: 645afe73f951 ("ARM: dts: aspeed: ast2600: Update XDMA engine node")


> Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> index c32e87fad4dc..aac55b3aeded 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -389,6 +389,16 @@ sbc: secure-boot-controller@1e6f2000 {
>  				reg = <0x1e6f2000 0x1000>;
>  			};
> 
> +			video: video@1e700000 {
> +				compatible = "aspeed,ast2600-video-engine";
> +				reg = <0x1e700000 0x1000>;
> +				clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
> +					 <&syscon ASPEED_CLK_GATE_ECLK>;
> +				clock-names = "vclk", "eclk";
> +				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
>  			gpio0: gpio@1e780000 {
>  				#gpio-cells = <2>;
>  				gpio-controller;
> -- 
> 2.25.1

Cheers,

Andrew
