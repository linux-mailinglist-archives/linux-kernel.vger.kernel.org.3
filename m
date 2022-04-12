Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777404FEAD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiDLXc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiDLXb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:31:58 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8672991367;
        Tue, 12 Apr 2022 15:18:04 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23CMHiDr025325;
        Tue, 12 Apr 2022 17:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649801864;
        bh=nyNY/m9ONJlCKzS4q3CdtgYdHO/OxuVygYMFfJGfbVc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=wNWOhax4SJjeNOYOlDh/guaxqjCaoCnetpB9byCEN81YlcKpAgDhE3L3VluOSuYVf
         5wvXqx1oDqR/KaHrL+B1Mo/lENn677nehWEtZATpnawi/WT3skoWn/metfU/7ftVtr
         vxU8vwSn+rFAxwY24SnlVBT5XZcoPCVrKWPNVA/A=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23CMHi3n059118
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 17:17:44 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 17:17:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 17:17:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23CMHhdk128579;
        Tue, 12 Apr 2022 17:17:43 -0500
Date:   Tue, 12 Apr 2022 17:17:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: Add TI K3 RTC devicetree bindings
 documentation
Message-ID: <20220412221743.vbectb4bcghau2b7@confider>
References: <20220412073138.25027-1-nm@ti.com>
 <20220412073138.25027-2-nm@ti.com>
 <dee496ce-5e74-4a53-c783-6420b2391387@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dee496ce-5e74-4a53-c783-6420b2391387@linaro.org>
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

On 14:06-20220412, Krzysztof Kozlowski wrote:
> > +properties:
> > +  compatible:
> > +    items:
> 
> No need for items. Just enum under the compatible.

Will fix in next rev. Thanks for catching.

> 
> > +      - enum:
> > +          - ti,am62-rtc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: VBUS Interface clock
> > +      - description: 32k Clock source (external or internal).
> > +
> > +  clock-names:
> > +    items:
> > +      - const: "vbus"
> > +      - const: "osc32k"
> 
> No quotes.

Uggh.. my bad. yup
> 
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  assigned-clocks:
> > +    description: |
> > +      override default osc32k parent clock reference to the osc32k clock entry
> > +    maxItems: 1
> > +
> > +  assigned-clock-parents:
> > +    description: |
> > +      override default osc32k parent clock phandle of the new parent clock of osc32k
> > +    maxItems: 1
> 
> Usually assigned-clockXXX are not needed in the bindings. Is here
> something different? They are put only to indicate something special.

I wonder if I should rather use unevaluatedproperties instead? If I use
additionalProperties: False, then the second example below fails.

Thoughts?
> 
> > +
> > +  wakeup-source: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    rtc@2b1f0000 {
> > +        compatible = "ti,am62-rtc";
> > +        reg = <0x2b1f0000 0x100>;
> > +        interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> > +        power-domains = <&bar 0>;
> > +        clocks = <&foo 0>, <&foo 1>;
> > +        clock-names = "vbus", "osc32k";
> > +        wakeup-source;
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    rtc@2b1f0000 {
> > +        compatible = "ti,am62-rtc";
> > +        reg = <0x2b1f0000 0x100>;
> > +        interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> > +        power-domains = <&bar 0>;
> > +        clocks = <&foo 0>, <&foo 1>;
> > +        clock-names = "vbus", "osc32k";
> > +        wakeup-source;
> > +        assigned-clocks = <&foo 1>;
> > +        assigned-clock-parents = <&foo 2>;
> > +
> 
> Unneeded blank line.

Ack.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
