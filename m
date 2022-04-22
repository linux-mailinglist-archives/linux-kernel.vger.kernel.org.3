Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3450C84B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiDWIrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiDWIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:47:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05741B9FB5;
        Sat, 23 Apr 2022 01:44:15 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23MJAqRd055009;
        Fri, 22 Apr 2022 14:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650654652;
        bh=aWLd/2RyGAql92fiaxn8ur5cJ8eJ5/TK8S5NNMNK8v8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=vF3iH3vWvOMk66fGAYxvIsaufssvDnx7ldzzamWegfnAGc2WQlyMnc41NyF1Mjldl
         0zFys75wGMqX6U3Ov/tYVhFX/Fsgc0JzoVF2P/YoWo13hUe5Z6IShgf3mLkzJ1zpnv
         dTCkbyOtbroMwufITSOfWO1scJ1M33LdWm+LcEuY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23MJAqQV012376
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 14:10:52 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 14:10:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 14:10:52 -0500
Received: from [128.247.81.242] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23MJAqWX104615;
        Fri, 22 Apr 2022 14:10:52 -0500
Message-ID: <2528be71-ca3f-566b-4769-36063c98ee0e@ti.com>
Date:   Fri, 22 Apr 2022 14:10:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/6] dt-bindings: ti,sci: Add ti,ctx-memory-region
 property
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220421203659.27853-1-d-gerlach@ti.com>
 <20220421203659.27853-2-d-gerlach@ti.com>
 <ad47db06-7f5c-399f-0ad0-81f720e6f035@ti.com>
From:   Dave Gerlach <d-gerlach@ti.com>
In-Reply-To: <ad47db06-7f5c-399f-0ad0-81f720e6f035@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/22/22 14:02, Andrew Davis wrote:
> On 4/21/22 3:36 PM, Dave Gerlach wrote:
>> Add documentation for the ti,ctx-memory-region property which is a
>> phandle to a reserved-memory carveout to be used by the ti_sci driver
>> storage of low power mode memory context. This is optional for normal
>> system operation but required to enabled suspend-to-mem usage of Deep
>> Sleep state.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>   .../devicetree/bindings/arm/keystone/ti,sci.yaml         | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>> index 34f5f877d444..ec88aa88a2a0 100644
>> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>> @@ -61,6 +61,15 @@ properties:
>>     mboxes:
>>       minItems: 2
>>   
>> +  ti,ctx-memory-region:
>> +    description:
>> +      Phandle to the reserved memory node to be associated with the
>> +      ti-sci device, to be used for saving low power context. The
>> +      reserved memory node should be a carveout node, and should
>> +      be defined as per the bindings in
>> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +
> 
> 
> Why does this have to be yet another reserved carveout region,
> should be dynamically allocated.
> 

This must be a fixed address in order to support other low power modes
which have not yet been introduced.

Regards,
Dave

> Andrew
> 
> 
>>     ti,system-reboot-controller:
>>       description: Determines If system reboot can be triggered by SoC reboot
>>       type: boolean
