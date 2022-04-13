Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AAC4FFA91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiDMPr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiDMPru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:47:50 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FD5EBF7;
        Wed, 13 Apr 2022 08:45:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23DFjArV099164;
        Wed, 13 Apr 2022 10:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649864710;
        bh=LKiOhQpH11PRHnUk7E83nty6XMEWWedQyINcMzjxJ8k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SVEb3BmVQOgTig6W3fudXL+ubrtWwy2pakyL8YTIVC5bPMqE85CXrPIEtfwcPAxlw
         zo/X/4lE0+yAM9MoHbDCDkcuWQIRm12LbF8quvim9Q+WxywWZ+zgb0JDd2UfbyTfvk
         inJtvkeAV8u8eeK6tXf3T56YpKAs7bkmm7bmK1XQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23DFjACd014238
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Apr 2022 10:45:10 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 13
 Apr 2022 10:45:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 13 Apr 2022 10:45:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23DFj9VX015581;
        Wed, 13 Apr 2022 10:45:09 -0500
Date:   Wed, 13 Apr 2022 10:45:09 -0500
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
Message-ID: <20220413154509.2bllkjdnp7r2f7fd@remindful>
References: <20220412073138.25027-1-nm@ti.com>
 <20220412073138.25027-2-nm@ti.com>
 <dee496ce-5e74-4a53-c783-6420b2391387@linaro.org>
 <20220412221743.vbectb4bcghau2b7@confider>
 <2609cb4e-df0e-f4b5-b89f-37287bbc569d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2609cb4e-df0e-f4b5-b89f-37287bbc569d@linaro.org>
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

On 08:42-20220413, Krzysztof Kozlowski wrote:
> On 13/04/2022 00:17, Nishanth Menon wrote:
> >>> +  assigned-clocks:
> >>> +    description: |
> >>> +      override default osc32k parent clock reference to the osc32k clock entry
> >>> +    maxItems: 1
> >>> +
> >>> +  assigned-clock-parents:
> >>> +    description: |
> >>> +      override default osc32k parent clock phandle of the new parent clock of osc32k
> >>> +    maxItems: 1
> >>
> >> Usually assigned-clockXXX are not needed in the bindings. Is here
> >> something different? They are put only to indicate something special.
> > 
> > I wonder if I should rather use unevaluatedproperties instead? If I use
> > additionalProperties: False, then the second example below fails.
> > 
> 
> Are you sure it fails? I just checked and it worked in my case. This
> AFAIR was working since some time (or fixed some time ago), so maybe
> update your dtschema?

Arrgh, Thanks and you are right.
Apologies, I should have cross checked again since developing late
last year (understood the min schema currently is 2022.3).

Will fix this up in the repost v2 in a short while.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
