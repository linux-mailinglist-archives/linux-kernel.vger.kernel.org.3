Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10EE57700B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 18:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGPQJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 12:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGPQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 12:09:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2065F9;
        Sat, 16 Jul 2022 09:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E462611A0;
        Sat, 16 Jul 2022 16:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234B0C34114;
        Sat, 16 Jul 2022 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657987760;
        bh=nuK8GK3uKLya8oToFj66vEMC13us5ufvacB/Y1/YHR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sPJSozviix4Hz3h/Ln2GbrVWzORwGVK9GBOFiW/u2egcTXJqlDjjHnvWHyJlfl9jM
         5szkTR/EjgPJ6Pyoq0Xl7TPREBwaFx11KtsMQO8WmwwrUehku6DkVn2VLP7sCPTnj2
         bOt9FicTOU7ygEthnMiM4u/IhLXZt3nXzsEKFz3bIpqDpSfsUF4qqjf7Jdr9sVOtxT
         vZUuFYyPHsOE+HSzZrC6uq4I66Wj4avbNFY1PyeI2e4iHxI2gIX85vC3I2+gqJc6xO
         GW9gxYe3HjKVMPuu7ZtG47Ygv1hEW4vMWi8X76jg2GnmtLiK7NTZe5jBIPXW+0Ok7h
         GbijlDI3fO5Tw==
Received: by pali.im (Postfix)
        id DC602A52; Sat, 16 Jul 2022 18:09:16 +0200 (CEST)
Date:   Sat, 16 Jul 2022 18:09:16 +0200
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
Message-ID: <20220716160916.jp37siznitgzw6qf@pali>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-3-pali@kernel.org>
 <20220716144028.rzwcn4wl5uyxepjd@pengutronix.de>
 <20220716145019.nps3oh4a22fsuzup@pali>
 <20220716150751.6yaknmo3qwusyy5h@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220716150751.6yaknmo3qwusyy5h@pengutronix.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 July 2022 17:07:51 Uwe Kleine-König wrote:
> On Sat, Jul 16, 2022 at 04:50:19PM +0200, Pali Rohár wrote:
> > On Saturday 16 July 2022 16:40:28 Uwe Kleine-König wrote:
> > > On Thu, Jul 14, 2022 at 08:33:27PM +0200, Pali Rohár wrote:
> > > > Armada 38x supports per CPU interrupts for gpios, like Armada XP. Pre-XP
> > > > variants like Armada 370 do not support per CPU interrupts for gpios.
> > > > 
> > > > So change compatible string for Armada 38x from "marvell,armada-370-gpio"
> > > > which indicates pre-XP variant to "marvell,armadaxp-gpio" which indicates
> > > > XP variant or new.
> > > > 
> > > > Driver gpio-mvebu.c which handles both pre-XP and XP variants already
> > > > provides support for per CPU interrupts on XP and newer variants.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > Fixes: 7cb2acb3fbae ("ARM: dts: mvebu: Add PWM properties for armada-38x")
> > > > ---
> > > >  arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> > > > index df3c8d1d8f64..9343de6947b3 100644
> > > > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > > > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > > > @@ -292,7 +292,7 @@
> > > >  			};
> > > >  
> > > >  			gpio0: gpio@18100 {
> > > > -				compatible = "marvell,armada-370-gpio",
> > > > +				compatible = "marvell,armadaxp-gpio",
> > > >  					     "marvell,orion-gpio";
> > > 
> > > If you can treat the XP variant as 370 and everything that is supposed
> > > to work on 370 works then, then maybe the right incarnation is:
> > > 
> > > 	compatible = "marvell,armadaxp-gpio", "marvell,armada-370-gpio", "marvell,orion-gpio";
> > > 
> > > ?
> > 
> > For pre-XP variants is "marvell,orion-gpio" enough and for XP + post-XP
> > is needed "marvell,armadaxp-gpio" (with possible "marvell,orion-gpio"
> > for backward compatibility).
> > 
> > So I do not see reason why to add "marvell,armada-370-gpio" nor what
> > value it brings.
> 
> If you boot an older kernel (i.e. one that doesn't support
> marvell,armadaxp-gpio, but does support marvell,armada-370-gpio), it

Is there such kernel version?

> will work better as there are relevant differences between
> marvell,orion-gpio and marvell,armada-370-gpio.

And if yes, do we really need this in DTS files for new kernel
versions? I can imagine that such change can be relevant for old LTS
kernel version, but not for new versions.

> For example some
> registers seem to have a different offset ...

armada-370-gpio is mapped to MVEBU_GPIO_SOC_VARIANT_ORION, so it will
get same offsets as orion-gpio. So no change.
