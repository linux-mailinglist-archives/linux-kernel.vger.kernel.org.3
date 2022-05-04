Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEF351AC5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376675AbiEDSKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377150AbiEDSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:09:18 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6674854;
        Wed,  4 May 2022 10:25:09 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 511FE1C0BCC; Wed,  4 May 2022 19:25:08 +0200 (CEST)
Date:   Wed, 4 May 2022 19:25:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Aparna M <a-m1@ti.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, praneeth@ti.com,
        grygorii.strashko@ti.com, nikhil.nd@ti.com,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH RESEND] arm64: dts: ti: k3-am642-sk: Add DT entry for
 onboard LEDs
Message-ID: <20220504172507.GH1623@bug>
References: <20220420072952.3509-1-a-m1@ti.com>
 <YmYuV3lhncn6RWGQ@ada-deb-carambola.ifak-system.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmYuV3lhncn6RWGQ@ada-deb-carambola.ifak-system.com>
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

> > +		led-7 {
> > +			color = <LED_COLOR_ID_AMBER>;
> > +			function = LED_FUNCTION_INDICATOR;
> > +			function-enumerator = <8>;
> > +			linux,default-trigger = "heartbeat";
> > +			gpios = <&exp2 7 GPIO_ACTIVE_HIGH>;
> > +		};
> 
> This might also be LED_FUNCTION_HEARTBEAT, but it's probably up to
> author's personal preferences?

You are right that having 8 leds marked as indicator is not too useful.

> I added the linux-leds list to Cc.

Thank you!
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
