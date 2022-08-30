Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86555A6B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiH3RsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiH3Rri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:47:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA8723BED;
        Tue, 30 Aug 2022 10:44:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27UHcCrg080481;
        Tue, 30 Aug 2022 12:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661881092;
        bh=76Q7cq/AR/+iJyWKEKNDDgUJpWOaO+SHwO2XSEGZ4h0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IzfFP6MrvdxpXcmxYeE1V8Q4JS38TTWejMIJQrRMKWDJ3ZH5sKreY02nrFIAn+gKi
         TG05ngCr7GmcwriybH/I2NFCYllesuVY8+1rACGQB+RwDMeoPx4vwJg3P20zjLcObd
         Xq364P74xmBlfdJRLqdZCSyBkM5z3RdwJqqrgsoE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27UHcCld029103
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Aug 2022 12:38:12 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 30
 Aug 2022 12:38:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 30 Aug 2022 12:38:12 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27UHcC3h015049;
        Tue, 30 Aug 2022 12:38:12 -0500
Date:   Tue, 30 Aug 2022 12:38:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: k3: Sort the am654 board enums
Message-ID: <20220830173812.knnavya6uud56wsa@unrefined>
References: <20220830160507.7726-1-nm@ti.com>
 <20220830160507.7726-2-nm@ti.com>
 <6d558914-2667-9e48-b662-980b9c7ca094@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d558914-2667-9e48-b662-980b9c7ca094@linaro.org>
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

On 19:50-20220830, Krzysztof Kozlowski wrote:
> On 30/08/2022 19:05, Nishanth Menon wrote:
> > Use alphabetical sort to organize the am654 board names.
> > 
> > Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> It's not a bug, so it should be rather "Suggested-by".
> 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

Thanks - Vignesh: let me know if you'd like a v2 with
s/Reported-by/Suggested-by update.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
