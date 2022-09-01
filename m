Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EAC5A8D5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiIAFbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiIAFbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:31:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E355E4B4A1;
        Wed, 31 Aug 2022 22:30:34 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2815UQii026785;
        Thu, 1 Sep 2022 00:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662010226;
        bh=NqwbWXA2C23+c+6x6OFGJWJve438k2+PUlczUT3em5E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pdwP0a/X+u0NsWPBZiuSC8jJludGAIYVH3b1Ae2pz+V/hTh5tbAk3g2eHMUnSSRTc
         63qFiZmgK4PSNpRqb3bZw1epAKM8pVxYEEUsvRdwrFuZWifNmbjUFjOvyFs6n3n9O5
         8TcUI7igX/fA10dod0LHGuz79Fy5Yyr/M3DQCtc0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2815UQlk013688
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 00:30:26 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 00:30:25 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 00:30:25 -0500
Received: from [172.24.145.182] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2815ULEL018341;
        Thu, 1 Sep 2022 00:30:22 -0500
Message-ID: <8c5f6921-62c9-29d2-5c13-ce1932e1715c@ti.com>
Date:   Thu, 1 Sep 2022 11:00:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/4] dt-bindings: arm: ti: Add bindings for AM62A7 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
References: <20220829082200.241653-1-vigneshr@ti.com>
 <20220829082200.241653-2-vigneshr@ti.com>
 <d7303503-70ef-7307-8cc0-1bc334c9e6af@linaro.org>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <d7303503-70ef-7307-8cc0-1bc334c9e6af@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/22 15:22, Krzysztof Kozlowski wrote:
> On 29/08/2022 11:21, Vignesh Raghavendra wrote:
>> This adds bindings for TI's AM62A7 family of devices.
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> index 61c6ab4f52e2..28f6ea4c007e 100644
>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> @@ -65,6 +65,12 @@ properties:
>>                - ti,j721s2-evm
>>            - const: ti,j721s2
>>  
>> +      - description: K3 AM62A7 SoC
>> +        items:
>> +          - enum:
>> +              - ti,am62a7-sk
>> +          - const: ti,am62a7
> 
> Is it possible to have some order in the file?

Nishanth has posted [1] for the same. Will rebase on top of that series.

[1] https://lore.kernel.org/all/20220830160507.7726-3-nm@ti.com/

-- 
Regards
Vignesh
