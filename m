Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8475A8039
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiHaOa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiHaOaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:30:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95887548C;
        Wed, 31 Aug 2022 07:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81BF561BBB;
        Wed, 31 Aug 2022 14:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F252C433C1;
        Wed, 31 Aug 2022 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661956253;
        bh=RZ1NKKaymq+6ZylhYUzYOUmsnd+VirvgHXMwybf81Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KzCHCyUlihhvc1ponolL2CKrfgyltgxE0XMCQYgm7hVLIC7RJj3YjsGI2U56jcAbk
         NT37ydGKbDzkJQztXhN+PzEPGTLB0JJbsYn0FzTq/K513FT2WdLuuTZZJeWYJEv/iU
         cnNzCXSGD2AMCaGq49nQUx2amtpdXdlsjWbA82nKTx+JJMo1ppxeRrrfJyyQfWVZ2S
         7MU1RYKH6bCbUOSiGEF/VQkZvvHcRtEoGM0fHDpcP7G21yrgSSBcl5gTCp46qFEQ3g
         jG1KXFgwy9hmNA2TaOUgOqCa8fbzCTvSXXs3/LNnsMFETBCHs/XJgs3b3Y11FkbbD9
         OZ/sGQdHQFPxA==
Received: by pali.im (Postfix)
        id 80DA1855; Wed, 31 Aug 2022 16:30:49 +0200 (CEST)
Date:   Wed, 31 Aug 2022 16:30:49 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] ARM: dts: armada-38x: Fix compatible string for
 gpios
Message-ID: <20220831143049.gdh6dyrn5su2enox@pali>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-3-pali@kernel.org>
 <20220716144028.rzwcn4wl5uyxepjd@pengutronix.de>
 <20220716145019.nps3oh4a22fsuzup@pali>
 <20220716150751.6yaknmo3qwusyy5h@pengutronix.de>
 <20220716160916.jp37siznitgzw6qf@pali>
 <20220725200417.nwthxzvdv2bzd5ej@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725200417.nwthxzvdv2bzd5ej@pengutronix.de>
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

On Monday 25 July 2022 22:04:17 Uwe Kleine-König wrote:
> Hello Pali,
> 
> On Sat, Jul 16, 2022 at 06:09:16PM +0200, Pali Rohár wrote:
> > On Saturday 16 July 2022 17:07:51 Uwe Kleine-König wrote:
> > > On Sat, Jul 16, 2022 at 04:50:19PM +0200, Pali Rohár wrote:
> > > > On Saturday 16 July 2022 16:40:28 Uwe Kleine-König wrote:
> > > > > On Thu, Jul 14, 2022 at 08:33:27PM +0200, Pali Rohár wrote:
> > > > > > Armada 38x supports per CPU interrupts for gpios, like Armada XP. Pre-XP
> > > > > > variants like Armada 370 do not support per CPU interrupts for gpios.
> > > > > > 
> > > > > > So change compatible string for Armada 38x from "marvell,armada-370-gpio"
> > > > > > which indicates pre-XP variant to "marvell,armadaxp-gpio" which indicates
> > > > > > XP variant or new.
> > > > > > 
> > > > > > Driver gpio-mvebu.c which handles both pre-XP and XP variants already
> > > > > > provides support for per CPU interrupts on XP and newer variants.
> > > > > > 
> > > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > > Fixes: 7cb2acb3fbae ("ARM: dts: mvebu: Add PWM properties for armada-38x")
> > > > > > ---
> > > > > >  arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> > > > > > index df3c8d1d8f64..9343de6947b3 100644
> > > > > > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > > > > > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > > > > > @@ -292,7 +292,7 @@
> > > > > >  			};
> > > > > >  
> > > > > >  			gpio0: gpio@18100 {
> > > > > > -				compatible = "marvell,armada-370-gpio",
> > > > > > +				compatible = "marvell,armadaxp-gpio",
> > > > > >  					     "marvell,orion-gpio";
> > > > > 
> > > > > If you can treat the XP variant as 370 and everything that is supposed
> > > > > to work on 370 works then, then maybe the right incarnation is:
> > > > > 
> > > > > 	compatible = "marvell,armadaxp-gpio", "marvell,armada-370-gpio", "marvell,orion-gpio";
> > > > > 
> > > > > ?
> > > > 
> > > > For pre-XP variants is "marvell,orion-gpio" enough and for XP + post-XP
> > > > is needed "marvell,armadaxp-gpio" (with possible "marvell,orion-gpio"
> > > > for backward compatibility).
> > > > 
> > > > So I do not see reason why to add "marvell,armada-370-gpio" nor what
> > > > value it brings.
> > > 
> > > If you boot an older kernel (i.e. one that doesn't support
> > > marvell,armadaxp-gpio, but does support marvell,armada-370-gpio), it
> > 
> > Is there such kernel version?
> 
> Ah, I thought you added "marvell,armadaxp-gpio" with this patch series.
> 
> > > will work better as there are relevant differences between
> > > marvell,orion-gpio and marvell,armada-370-gpio.
> > 
> > And if yes, do we really need this in DTS files for new kernel
> > versions? I can imagine that such change can be relevant for old LTS
> > kernel version, but not for new versions.
> > 
> > > For example some
> > > registers seem to have a different offset ...
> > 
> > armada-370-gpio is mapped to MVEBU_GPIO_SOC_VARIANT_ORION, so it will
> > get same offsets as orion-gpio. So no change.
> 
> OK, you're right, my assumptions were wrong. I'm convinced your change
> is fine now:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Best regards
> Uwe

Ok, are there any other objections with this patch series?
