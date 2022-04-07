Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4271B4F8095
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiDGNdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiDGNdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:33:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABCB2316D;
        Thu,  7 Apr 2022 06:31:42 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 237DVHwX121831;
        Thu, 7 Apr 2022 08:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649338277;
        bh=FkL+nLnsDIczf1J4USqtIGn2t+WprQVeZK6cfAqE0No=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aomvn3LCtUkkFY3iWkSRwOxd7WkuVpc69cyKSPZCDOLgx0OEUY4WVqpHe+eX9wlQD
         BPoPsYzJ95Y0ezzF7LsOBjfflFsgz4fRVwxpM5NpuJ60UJ1PerrubKDwygTp1y3p51
         Y6gJVNW0E4QBotRil97aveDGV42zfdKCB4rDXuew=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 237DVHwU034787
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Apr 2022 08:31:17 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Apr 2022 08:31:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Apr 2022 08:31:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 237DVCSH029520;
        Thu, 7 Apr 2022 08:31:12 -0500
Date:   Thu, 7 Apr 2022 08:31:12 -0500
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
Message-ID: <20220407133112.lhs3dm6tvvvbooen@friday>
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
>  
>  - reg:			Contains timer register address range (base address and
>  			length).
> -- 
> 2.35.1


We need to convert this into yaml prior to the dts updates patches :(


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
