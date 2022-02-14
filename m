Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E74B54FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355902AbiBNPjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:39:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiBNPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:39:15 -0500
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Feb 2022 07:39:06 PST
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCDA40A35;
        Mon, 14 Feb 2022 07:39:05 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6E231240008;
        Mon, 14 Feb 2022 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644853144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yd4h8qG0bOZ43U9tdtwFQ5VmXb5hOehL8q+jzFS2vS4=;
        b=MWGYl1SVktk3dJzE/XVK7PfBGHJwxRS99HyvdnnxQLCw2UbxKVvkYxQ2eQWTlEW9C0mwTM
        3iT2psJxpLV1oGfFwciU2Id/dgdoxp6h8OAc35Bs83LqtjTEC8QaGq8FPcHzz7fHnCHNsQ
        SCd4Gau2Kh/7jNfDyAM1s+C2ct6kFkfKzRBZRHnuqZ470WA4mE3UxN/58xJ6KvHMUy0s4c
        3/kOPO2TkbSigRBPJ4cjg9k79B1PmJ4+09jVfK8ARSrnTMCBIHQvQKOLrGl74RKXPMftE1
        vyu+rZ/IvazvsscTVenPpRktLNUIzYTWAIKcPTRpx6704Wu55iLJ6o5sYvsd/g==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
        robh+dt@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: armada-xp: add interrupts for watchdog
In-Reply-To: <20220211003257.2037332-2-chris.packham@alliedtelesis.co.nz>
References: <20220211003257.2037332-1-chris.packham@alliedtelesis.co.nz>
 <20220211003257.2037332-2-chris.packham@alliedtelesis.co.nz>
Date:   Mon, 14 Feb 2022 16:39:02 +0100
Message-ID: <87o839jw4p.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

> The first interrupt is for the regular watchdog timeout. Normally the
> RSTOUT line will trigger a reset before this interrupt fires but on
> systems with a non-standard reset it may still trigger.
>
> The second interrupt is for a timer1 which is used as a pre-timeout for
> the watchdog.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

To keep bisectability this patch should be merged after the driver
patch.

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 1 +
>  arch/arm/boot/dts/armada-xp.dtsi          | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> index 38a052a0312d..0e561dfc0ca9 100644
> --- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> @@ -286,6 +286,7 @@ &watchdog {
>  	compatible = "marvell,armada-xp-wdt";
>  	clocks = <&coreclk 2>, <&refclk>;
>  	clock-names = "nbclk", "fixed";
> +	interrupts = <93>, <38>;
>  };
>  
>  &cpurst {
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 6c19984d668e..4297482da62f 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -260,6 +260,7 @@ &watchdog {
>  	compatible = "marvell,armada-xp-wdt";
>  	clocks = <&coreclk 2>, <&refclk>;
>  	clock-names = "nbclk", "fixed";
> +	interrupts = <93>, <38>;
>  };
>  
>  &cpurst {
> -- 
> 2.35.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
