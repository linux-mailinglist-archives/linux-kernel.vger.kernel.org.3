Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E39257868E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 17:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiGRPmi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Jul 2022 11:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGRPmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:42:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B3A18B1D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:42:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oDSsu-0003FH-Dg; Mon, 18 Jul 2022 17:42:12 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oDSsr-001k2n-PI; Mon, 18 Jul 2022 17:42:09 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oDSsq-000Byu-P3; Mon, 18 Jul 2022 17:42:08 +0200
Message-ID: <b7540ac17d28cee09f6f9cce65b696248e545ae1.camel@pengutronix.de>
Subject: Re: [PATCH v2 03/12] reset: add polarfire soc reset support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Conor.Dooley@microchip.com
Cc:     paul.walmsley@sifive.com, Daire.McNamara@microchip.com,
        sboyd@kernel.org, aou@eecs.berkeley.edu, robh+dt@kernel.org,
        palmer@dabbelt.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org
Date:   Mon, 18 Jul 2022 17:42:08 +0200
In-Reply-To: <22d3a11b-a603-8406-77ec-51ec038560fc@microchip.com>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
         <20220704121558.2088698-4-conor.dooley@microchip.com>
         <22d3a11b-a603-8406-77ec-51ec038560fc@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Mo, 2022-07-18 at 11:34 +0000, Conor.Dooley@microchip.com wrote:
[...]
> > +config RESET_POLARFIRE_SOC
> > +	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
> > +	depends on AUXILIARY_BUS && MCHP_CLK_MPFS
> > +	default MCHP_CLK_MPFS
> > +	help
> > +	  This driver supports peripheral reset for the Microchip PolarFire SoC
> > +

Please sort alphabetically by config option.

> >   config RESET_MESON
> >   	tristate "Meson Reset Driver"
> >   	depends on ARCH_MESON || COMPILE_TEST
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index a80a9c4008a7..5fac3a753858 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -17,6 +17,7 @@ obj-$(CONFIG_RESET_K210) += reset-k210.o
> >   obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> >   obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
> >   obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
> > +obj-$(CONFIG_RESET_POLARFIRE_SOC) += reset-mpfs.o

Same here. Otherwise,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

and

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to merge this together with the other patches.

regards
Philipp
