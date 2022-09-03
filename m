Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E725ABF87
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 17:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiICP1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 11:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiICP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 11:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2B258DE8;
        Sat,  3 Sep 2022 08:27:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 857AD615FA;
        Sat,  3 Sep 2022 15:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A672EC433D6;
        Sat,  3 Sep 2022 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662218858;
        bh=ZU057wj4ngSYkbS4a5Uqoeq3JjOvsVmcxmt4ZdKWXPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOFrLFN/X7DXahu1USfGB8JUpVNwM++gLJ5EuuDNzAdsmop/WVD48Z/2r3XgzuMCO
         GGcTEUozvtkKkLyEuInn4OLlYtCXzg+TPc44iIPVojqPOjQCXZLScZmNXy1zb59SJ9
         +zLvBIdnfC+caQ4ijO9XIkZCH/AEiaW5WhkD5f/5V1nv/+dIyw9L4um0aLQOsWsxQG
         zRr28efuhu7Fon13XXRq6AGIfDhRLWwm3xh+FBO2sm+jkauH9IcZgZdKOqGcWoRHSI
         +qztzjG2XqrdzoKzFFGu/LYqXbgrH4Dd64gfqYlMIgeLUh4DgwpJvl5rzjpHNVG/qR
         YbW2e1mtM8gfQ==
Received: by pali.im (Postfix)
        id C465B850; Sat,  3 Sep 2022 17:27:35 +0200 (CEST)
Date:   Sat, 3 Sep 2022 17:27:35 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Behun <marek.behun@nic.cz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Message-ID: <20220903152735.2ga3iwrivh6zhibf@pali>
References: <20220819131152.6513-1-pali@kernel.org>
 <20220831142809.lcmnv3l4rnulo522@pali>
 <YxE2JqJutZ0ilghH@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxE2JqJutZ0ilghH@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2022 00:45:58 Andrew Lunn wrote:
> On Wed, Aug 31, 2022 at 04:28:09PM +0200, Pali Rohár wrote:
> > PING?
> > 
> > On Friday 19 August 2022 15:11:52 Pali Rohár wrote:
> > > At i2c address 0x2a is MCU command interface which provides access to GPIOs
> > > connected to Turris Omnia MCU. So define mcu node in Turris Omnia DTS file.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > 
> > > ---
> > > Same change was already sent to U-Boot project together with driver. As
> > > Turris Omnia DTS file is shared between Linux kernel U-Boot, I'm sending
> > > this change also in Linux. There is a plan to write also Linux driver for
> > > Turris Omnia MCU, like there is already in U-Boot.
> > > 
> > > https://source.denx.de/u-boot/u-boot/-/commit/832738974806e6264a3d0ac2aaa92d0f662fd128
> > > https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/turris_omnia_mcu.c
> > > ---
> > >  arch/arm/boot/dts/armada-385-turris-omnia.dts | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > > index f4878df39753..f655e9229d68 100644
> > > --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > > +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > > @@ -184,7 +184,13 @@
> > >  			#size-cells = <0>;
> > >  			reg = <0>;
> > >  
> > > -			/* STM32F0 command interface at address 0x2a */
> > > +			/* MCU command i2c API */
> > > +			mcu: mcu@2a {
> > > +				compatible = "cznic,turris-omnia-mcu";
> > > +				reg = <0x2a>;
> > > +				gpio-controller;
> > > +				#gpio-cells = <3>;
> > > +			};
> 
> Please document the binding, preferably in yaml.

I'm not going to send any new yaml dt binding document as I see that
dt bindings is clearly deprecated project. Either patches for dt
bindings are waiting without any answer for months (maybe year?) or
patches are ignored/not accepted by beyond reasons or there are request
for changes which cannot work on the real hardware or that new yaml
cannot be parsed/validated due to ton of bugs in other schemas.

Sorry, this is just a waste of time and energy to write new those yamls
as it does not bring any value.

> I'm also not sure what the DT people will say about the node name mcu.
> I don't see any examples of that in the binding documentation. They
> might request you rename it to gpio-controller, unless it does more
> than GPIO? And if it does do more than GPIO we are then into mfd
> territory, and the binding then becomes much more interesting. Then we
> start the questions, are you defining a ABI now, before there is even
> a driver for it?
> 
>        Andrew

Yes, there is already driver. See my previous email, I mentioned it and
also I wrote link for this driver. Moreover now driver is merged in
upstream u-boot.

Driver has currently implemented only GPIO support, but other functions
supported by MCU would be implemented later.
