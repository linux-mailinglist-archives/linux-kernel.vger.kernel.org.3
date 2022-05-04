Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06E251AC53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376554AbiEDSJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376718AbiEDSIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:08:49 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6354072E17;
        Wed,  4 May 2022 10:24:20 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D5E261C0BBB; Wed,  4 May 2022 19:24:18 +0200 (CEST)
Date:   Wed, 4 May 2022 19:24:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] leds: ktd2692: Make aux-gpios optional
Message-ID: <20220504172417.GE1623@bug>
References: <20220408184104.13665-1-markuss.broks@gmail.com>
 <20220408184104.13665-3-markuss.broks@gmail.com>
 <CAHp75VfgSphDN9TVgeiPGdcDVqutcGnTURqu6r143sjJDsPXUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfgSphDN9TVgeiPGdcDVqutcGnTURqu6r143sjJDsPXUA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Make the AUX pin optional, since it isn't a core part of functionality,
> > and the device is designed to be operational with only one CTRL pin.
> >
> > Also pick up maintenance for the LED driver and the yaml bindings.
> 
> It's polite to Cc reviewers of your previous versions of the series.
> 
> While this patch is fine to me, Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com> 
> one comment below.

Thanks for review.

Markuss, can you collect review tags and post v7?. Please drop MAINTAINERS part for now.

And sorry for delays.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
