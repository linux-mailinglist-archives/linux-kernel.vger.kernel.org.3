Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D324F8DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiDHEbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiDHEbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:31:02 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4187D165A3;
        Thu,  7 Apr 2022 21:29:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C86CA8125;
        Fri,  8 Apr 2022 04:26:34 +0000 (UTC)
Date:   Fri, 8 Apr 2022 07:28:57 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/4] dt-bindings: timer: Add am6 compatible for ti-timer
Message-ID: <Yk+6CSx3uTAlye+D@atomide.com>
References: <20220407071006.37031-1-tony@atomide.com>
 <20220407133112.lhs3dm6tvvvbooen@friday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407133112.lhs3dm6tvvvbooen@friday>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [220407 13:28]:
> On 10:10-20220407, Tony Lindgren wrote:
> > Document the dual-mode timers available on am6.
> > 
> > Cc: devicetree@vger.kernel.org
> > Cc: Keerthy <j-keerthy@ti.com>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  Documentation/devicetree/bindings/timer/ti,timer.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/ti,timer.txt b/Documentation/devicetree/bindings/timer/ti,timer.txt
> > --- a/Documentation/devicetree/bindings/timer/ti,timer.txt
> > +++ b/Documentation/devicetree/bindings/timer/ti,timer.txt
> > @@ -14,6 +14,7 @@ Required properties:
> >  			ti,omap5430-timer (applicable to OMAP543x devices)
> >  			ti,am335x-timer	(applicable to AM335x devices)
> >  			ti,am335x-timer-1ms (applicable to AM335x devices)
> > +			ti,am6-timer (applicable to AM6 devices)
> >  
> >  - reg:			Contains timer register address range (base address and
> >  			length).
> > -- 
> > 2.35.1
> 
> 
> We need to convert this into yaml prior to the dts updates patches :(

OK I'll convert to yaml and send the binding patch separately.

Regards,

Tony
