Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D223D4F80A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbiDGNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiDGNgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:36:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9E724D9B7;
        Thu,  7 Apr 2022 06:34:07 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 237DXjBH047530;
        Thu, 7 Apr 2022 08:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649338425;
        bh=tuDtmrZ/JCOGuQoIOjbg452duIx7WDeBGy1pAwK9JO4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xuwxeKZjRS70tzQmIO4sWBXDVcwegIgA9cZt96TW5xjEJgvM1xN77ZmAsi14RrftV
         gvVpqXCbp1w75wqX0/Z6GiZO3Pq8pvPmlW5OqvOCXCesoIJ9x0l6l6onj0n1ayQ0gE
         fIfySuCxD69CQQvmmHMQDyToDIsaz1JqgaXycu3I=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 237DXjTP072645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Apr 2022 08:33:45 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Apr 2022 08:33:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Apr 2022 08:33:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 237DXiKQ031379;
        Thu, 7 Apr 2022 08:33:44 -0500
Date:   Thu, 7 Apr 2022 08:33:44 -0500
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
Message-ID: <20220407133344.v2x2b6rkmskatips@handled>
References: <20220407071006.37031-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220407071006.37031-1-tony@atomide.com>
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

On 10:10-20220407, Tony Lindgren wrote:
> Document the dual-mode timers available on am6.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/timer/ti,timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/ti,timer.txt b/Documentation/devicetree/bindings/timer/ti,timer.txt
> --- a/Documentation/devicetree/bindings/timer/ti,timer.txt
> +++ b/Documentation/devicetree/bindings/timer/ti,timer.txt
> @@ -14,6 +14,7 @@ Required properties:
>  			ti,omap5430-timer (applicable to OMAP543x devices)
>  			ti,am335x-timer	(applicable to AM335x devices)
>  			ti,am335x-timer-1ms (applicable to AM335x devices)
> +			ti,am6-timer (applicable to AM6 devices)

Suggestion:

Could we call this ti,am65-timer instead? AM6 is a bit nuanced and spans
a couple of sub SoC architectures.

>  
>  - reg:			Contains timer register address range (base address and
>  			length).
> -- 
> 2.35.1

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
