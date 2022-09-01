Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEFA5AA349
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiIAWqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiIAWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:46:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C136E2E3;
        Thu,  1 Sep 2022 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=x+DgUFgLazTEoxlPi4eum/VL9xjskp/JstZFrST/B9g=; b=gK
        9s9hu0hoHMStg5UiyZLEtEPOId0/wrYSDd6UCfZSQ7fTllz/ewwbA/ENucjHAtpvBxTWGbXlHUky2
        8TwJ7vmEuBRvOLI+iLMDySES1qYFU4osEo6ngGn1LLpzl6NCGtZ+5I2u+3O43bmhW7t52ysyLInTg
        A70CEKK6iu25zN4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oTswg-00FLOQ-Uj; Fri, 02 Sep 2022 00:45:58 +0200
Date:   Fri, 2 Sep 2022 00:45:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Behun <marek.behun@nic.cz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Message-ID: <YxE2JqJutZ0ilghH@lunn.ch>
References: <20220819131152.6513-1-pali@kernel.org>
 <20220831142809.lcmnv3l4rnulo522@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220831142809.lcmnv3l4rnulo522@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 04:28:09PM +0200, Pali Rohár wrote:
> PING?
> 
> On Friday 19 August 2022 15:11:52 Pali Rohár wrote:
> > At i2c address 0x2a is MCU command interface which provides access to GPIOs
> > connected to Turris Omnia MCU. So define mcu node in Turris Omnia DTS file.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > 
> > ---
> > Same change was already sent to U-Boot project together with driver. As
> > Turris Omnia DTS file is shared between Linux kernel U-Boot, I'm sending
> > this change also in Linux. There is a plan to write also Linux driver for
> > Turris Omnia MCU, like there is already in U-Boot.
> > 
> > https://source.denx.de/u-boot/u-boot/-/commit/832738974806e6264a3d0ac2aaa92d0f662fd128
> > https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/turris_omnia_mcu.c
> > ---
> >  arch/arm/boot/dts/armada-385-turris-omnia.dts | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > index f4878df39753..f655e9229d68 100644
> > --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > @@ -184,7 +184,13 @@
> >  			#size-cells = <0>;
> >  			reg = <0>;
> >  
> > -			/* STM32F0 command interface at address 0x2a */
> > +			/* MCU command i2c API */
> > +			mcu: mcu@2a {
> > +				compatible = "cznic,turris-omnia-mcu";
> > +				reg = <0x2a>;
> > +				gpio-controller;
> > +				#gpio-cells = <3>;
> > +			};

Please document the binding, preferably in yaml.

I'm also not sure what the DT people will say about the node name mcu.
I don't see any examples of that in the binding documentation. They
might request you rename it to gpio-controller, unless it does more
than GPIO? And if it does do more than GPIO we are then into mfd
territory, and the binding then becomes much more interesting. Then we
start the questions, are you defining a ABI now, before there is even
a driver for it?

       Andrew
