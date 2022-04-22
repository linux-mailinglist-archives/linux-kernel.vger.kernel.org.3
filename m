Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107CB50B127
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444681AbiDVHNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444645AbiDVHNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:13:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FF250E34
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:10:39 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nhnR0-0005L2-KB; Fri, 22 Apr 2022 09:10:30 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nhnQv-0001fI-LA; Fri, 22 Apr 2022 09:10:25 +0200
Date:   Fri, 22 Apr 2022 09:10:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [Linux-stm32] [PATCH v1 2/2] ARM: dts: stm32: add support for
 Protonic PRTT1x boards
Message-ID: <20220422071025.GC5244@pengutronix.de>
References: <20220421091949.2789488-1-o.rempel@pengutronix.de>
 <20220421091949.2789488-2-o.rempel@pengutronix.de>
 <37ba2977-848a-19a6-8505-279f2b19c962@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37ba2977-848a-19a6-8505-279f2b19c962@foss.st.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:09:30 up 22 days, 19:39, 71 users,  load average: 0.04, 0.21,
 0.20
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:11:41PM +0200, Yann Gautier wrote:
> > +&sdmmc2 {
> > +	pinctrl-names = "default", "opendrain", "sleep";
> > +	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
> > +	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
> > +	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
> 
> Hi Oleksij,
> 
> > +	disable-wp;
> This is not used for eMMC (or SDIO), it can be removed.
> 
> > +	disable-cd;
> This property does not exist.
> 
> > +	none-removable;
> The right name is non-removable.
 
OK, thank you for review. I'll send v2

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
