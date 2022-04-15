Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45278502E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 19:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbiDORmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 13:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbiDORmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 13:42:36 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D2C5C369;
        Fri, 15 Apr 2022 10:40:05 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FHe20X130102;
        Fri, 15 Apr 2022 12:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650044402;
        bh=kaZ6Nxqiacg38fVMqIk7hdcjqcvJLSzaBMBHEm/y8Vc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=itdH7JQUJ+w8UIxkM+bDMYJF9a3CWCIV1odpgLrX+a0x8l2+vdpGlVgu7Np8lqNL1
         HNeBfhIehcN18VM1M0RGejhvbug2SkawhSNoBhaCVYNm0BPEHaIbNmG13jfDpr/kUZ
         9/1lIbJvdh8cyUTsh/qZcqaE0Ogrs3CEYnblqoIA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FHe11W098273
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 12:40:01 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 12:40:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 12:40:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FHe0vM069602;
        Fri, 15 Apr 2022 12:40:00 -0500
Date:   Fri, 15 Apr 2022 12:40:00 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Georgi Vlaev <g-vlaev@ti.com>
CC:     <ssantosh@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 2/2] dt-bindings: clock: ehrpwm: Add AM62 specific
 compatible
Message-ID: <20220415174000.cnnmolsaktl7ghye@jurist>
References: <20220415134142.12141-1-g-vlaev@ti.com>
 <20220415134142.12141-3-g-vlaev@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220415134142.12141-3-g-vlaev@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:41-20220415, Georgi Vlaev wrote:
> Introduce AM62 specific compatible for EPWM time-base
> sub-module clock. The time-base clock setup is identical
> to AM64. The only difference is AM62 provides 3 time-base
> clocks instead of the 9 found in AM64.
> 
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> Tested-by: Vignesh Raghavendra <vigneshr@ti.com>

Reviewed-by: Nishanth Menon <nm@ti.com>


That said, please re-org the patches. Bindings come before the driver
changes :)

> ---
>  .../devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> index 9b537bc876b5..66765116aff5 100644
> --- a/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> +++ b/Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> @@ -15,6 +15,7 @@ properties:
>        - enum:
>            - ti,am654-ehrpwm-tbclk
>            - ti,am64-epwm-tbclk
> +          - ti,am62-epwm-tbclk
>        - const: syscon
>  
>    "#clock-cells":
> -- 
> 2.30.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
