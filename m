Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8424B79C5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244327AbiBOVOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:14:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiBOVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:14:52 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946ED7EB09;
        Tue, 15 Feb 2022 13:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Ewfe4TG75hNdQYiqI5YcRGb9gBCJCzU8HIieAhtXL9Q=; b=rUAnTaT6QlkDIZSbdWSdyVfoP0
        /IhvV+6wHA7VESbxmaQ0RieXS20ndEBV8tIvsXyH/k5IlVK9Mx8b9B6gxBFLWyXPtF/wQc/tMi1/F
        59BFtiff3amxKR2ZXyQGcWyREYWaMSuavp6yZ7tYIVti1E6erzFBouUTvaoCpEfwCHZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nK59U-0067eJ-EW; Tue, 15 Feb 2022 22:14:24 +0100
Date:   Tue, 15 Feb 2022 22:14:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: kirkwood: Add Ctera C-200 V1 board
Message-ID: <YgwXsIRR/B9UmBOD@lunn.ch>
References: <20220215163926.894-1-paweldembicki@gmail.com>
 <Ygvv/CWUYumhKoCh@lunn.ch>
 <CAJN1Kkz3_z8M1j_mtOJzriUWj1m6iAEdZSZFg-zB2Gw2BYY4wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJN1Kkz3_z8M1j_mtOJzriUWj1m6iAEdZSZFg-zB2Gw2BYY4wA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thanks for adding a comment. So you need something like a PWM driving
> > it? Have you tried playing with drivers/input/misc/pwm-beeper.c ?
> 
> It use a PWM device. Driver gpio-pwm isn't accepted in mainline so far.
> 
> > Some of the mvebu family have a simple PWM functionality as part of
> > the GPIO controller. I don't remember if kirkwood has this.
> 
> Kirkwood have very simple blink mode only: GPIO pin make visible blinks.

[Goes and looks at the datasheet]

Yes, Kirkwood has fixed rate blinking. It is the later generation of
devices which have true PWM capabilities.

	Andrew
