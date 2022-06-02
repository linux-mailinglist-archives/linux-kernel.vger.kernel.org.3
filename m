Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104353B689
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiFBKD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiFBKDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:03:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625BFD347;
        Thu,  2 Jun 2022 03:03:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 252A3ftt075162;
        Thu, 2 Jun 2022 05:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654164221;
        bh=Mhu4wLDnsE/ZNGCAq11U03NXmXeOClrY6ZpD/8qzWTk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Q1ahS700ccV8cGuhGp+kTVm5CpPKz53cWiyRJygEmTG8F6hMsp+4VmJ47I3lB/N3p
         VDSK0zTTk7r3AFdvZKAYGLWJZjRpV+swQOxBUZmN9CJsElaOpTASj31tvbQ4+x4vio
         5pE5RMo5iH4A9I3LFLMR+qk3elmFooh1SjgHlVjI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 252A3f3X033139
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jun 2022 05:03:41 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Jun 2022 05:03:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Jun 2022 05:03:41 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 252A3bLW061739;
        Thu, 2 Jun 2022 05:03:38 -0500
Message-ID: <68381314-136b-776d-070a-e825506f2132@ti.com>
Date:   Thu, 2 Jun 2022 15:33:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: Update bindings for K3
 AM62x SoCs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220427072703.4898-1-kishon@ti.com>
 <20220427072703.4898-2-kishon@ti.com>
 <53212a3b-d02c-ab5e-6b5c-e19d359c7c2b@linaro.org>
 <dcce6737-5881-a703-67f0-59c5f55f1cd1@ti.com>
 <81d94ea8-9d0f-785b-07aa-fe9c9093ad73@linaro.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
In-Reply-To: <81d94ea8-9d0f-785b-07aa-fe9c9093ad73@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 16/05/22 20:48, Krzysztof Kozlowski wrote:
> On 16/05/2022 14:33, Kishon Vijay Abraham I wrote:
>> Hi Krzysztof,
>>
>> On 28/04/22 11:48, Krzysztof Kozlowski wrote:
>>> On 27/04/2022 09:27, Kishon Vijay Abraham I wrote:
>>>> Update the PRUSS bindings for the PRUSSM instance present in
>>>> AM625 SoC.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>> index 64461d432004..cf13e5179657 100644
>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>> @@ -69,6 +69,7 @@ properties:
>>>>        - ti,am654-icssg   # for K3 AM65x SoC family
>>>>        - ti,j721e-icssg   # for K3 J721E SoC family
>>>>        - ti,am642-icssg   # for K3 AM64x SoC family
>>>> +      - ti,am625-pruss   # for K3 AM62x SoC family
>>>>  
>>>
>>> Looks like out of order (although for some reason before it was also
>>> misordered...).
>>
>> These are really in the chronological order of the introduction of SoCs.
>> Isn't that okay to have?
> 
> You mean order of release on the market of order of adding files here?
> The first is ok, the latter would mean there is no order at all.

I meant order of release to market. Anyways, I'll send a patch to change
the order to alphabetic order.

Thanks,
Kishon
