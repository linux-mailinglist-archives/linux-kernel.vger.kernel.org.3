Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB44F8FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiDHHgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDHHgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:36:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5564517DC8C;
        Fri,  8 Apr 2022 00:34:33 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2387YLf3112553;
        Fri, 8 Apr 2022 02:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649403261;
        bh=utB+5AJ0MG+aUScpIOnzQKbcaFxDRZbL4sQdqSpNBT0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XyMHiYNPIR0MA1iQ7sXFITOkjxzyj1z8YkGf7pMZBMmeHlBldxDA81+L40N3W/pjv
         2iPicZJv3YjpFjK/7TXBod7ZYF1yHGj3o99nfJkqdRbEF30VNi3dtWQLP+ImyMHQW6
         Y0OOCNiZBffl7F7Xs/PiEvjNhZT3BpdLSeL4H2Cs=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2387YLxQ030868
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Apr 2022 02:34:21 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Apr 2022 02:34:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Apr 2022 02:34:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2387YIpj073598;
        Fri, 8 Apr 2022 02:34:18 -0500
Date:   Fri, 8 Apr 2022 02:34:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Keerthy <j-keerthy@ti.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/4] dt-bindings: timer: Add am6 compatible for ti-timer
Message-ID: <20220408073418.4yjs3ykt34fhqjco@boondocks>
References: <20220407071006.37031-1-tony@atomide.com>
 <20220407133344.v2x2b6rkmskatips@handled>
 <Yk+8P5EdsdZR5h1Z@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yk+8P5EdsdZR5h1Z@atomide.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07:38-20220408, Tony Lindgren wrote:
> Hi,
> 
> * Nishanth Menon <nm@ti.com> [220407 13:31]:
> > On 10:10-20220407, Tony Lindgren wrote:
> > > diff --git a/Documentation/devicetree/bindings/timer/ti,timer.txt b/Documentation/devicetree/bindings/timer/ti,timer.txt
> > > --- a/Documentation/devicetree/bindings/timer/ti,timer.txt
> > > +++ b/Documentation/devicetree/bindings/timer/ti,timer.txt
> > > @@ -14,6 +14,7 @@ Required properties:
> > >  			ti,omap5430-timer (applicable to OMAP543x devices)
> > >  			ti,am335x-timer	(applicable to AM335x devices)
> > >  			ti,am335x-timer-1ms (applicable to AM335x devices)
> > > +			ti,am6-timer (applicable to AM6 devices)
> > 
> > Suggestion:
> > 
> > Could we call this ti,am65-timer instead? AM6 is a bit nuanced and spans
> > a couple of sub SoC architectures.
> 
> I think the timer hardware is the same across am64, am65 and j7. So we
> should pick something to represent the am6 timers as it would allow using
> shared dtsi files for the 16 - 30 timers there are.
> 
> Using shared timer dtsi files should work as long as the clocks are
> defined in include/dt-bindings/clock for each SoC, and assuming we can use
> the same compatible property for the timers.

Compatible should work fine, Though I doubt clock and other indices
(base address etc will scale appropriately), but we could give it a
shot, but we can discuss that in the context of the dts patches.

> 
> Of course if the timers are really different across am64, am65 and j72
> then multiple compatible properties are neeeded.
> 
> If the timer hardware is the same, then I guess we should just pick the
> earliest version, so how about using ti,am64-timer?

yep - the oldest version will be ti,am654-timer ( AM65 was the first
K3 device. Unfortunately, the numbering does'nt follow a chronological
order)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
