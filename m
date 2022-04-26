Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEB50F122
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiDZGio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiDZGik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:38:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7011153
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:35:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1njEnC-0005De-IN; Tue, 26 Apr 2022 08:35:22 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1njEn7-0007vL-TY; Tue, 26 Apr 2022 08:35:17 +0200
Date:   Tue, 26 Apr 2022 08:35:17 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: stm32: Add compatible strings
 for Protonic T1L boards
Message-ID: <20220426063517.GB3419@pengutronix.de>
References: <20220425132844.866743-1-o.rempel@pengutronix.de>
 <20220425132844.866743-2-o.rempel@pengutronix.de>
 <35648611-cfa9-1df4-7130-7cd1bcf1a69e@linaro.org>
 <5c6ce97d-e31a-6cf9-6da6-8d27f19a53cc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c6ce97d-e31a-6cf9-6da6-8d27f19a53cc@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:33:08 up 26 days, 19:02, 55 users,  load average: 0.22, 0.13,
 0.14
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

On Mon, Apr 25, 2022 at 04:06:45PM +0200, Krzysztof Kozlowski wrote:
> On 25/04/2022 15:53, Krzysztof Kozlowski wrote:
> > On 25/04/2022 15:28, Oleksij Rempel wrote:
> >> This boards are based on STM32MP151AAD3 and use 10BaseT1L for
> >> communication.
> >>
> >> - PRTT1C - 10BaseT1L switch
> >> - PRTT1S - 10BaseT1L CO2 sensor board
> >> - PRTT1A - 10BaseT1L multi functional controller
> >>
> >> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> >> ---
> > 
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Although the order is still messed up. I through you will move the entry
> just slightly up, not to the beginning, so maybe just rebase on top of:
> https://lore.kernel.org/all/20220425140436.332467-1-krzysztof.kozlowski@linaro.org/

I put it according to the SoC version. st,stm32mp151 would be the first
entry before stm32mp153. What order do you prefer, where should I put my
boards?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
