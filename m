Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9488504C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 07:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiDRFWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 01:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiDRFWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:22:20 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0B4101FF;
        Sun, 17 Apr 2022 22:19:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23I5JFaH028353;
        Mon, 18 Apr 2022 00:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650259155;
        bh=oMWykkOjn8YbIp9yDJTk+cdjfn72U31dolM6E1w49f0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qnL/fy+pfPzITq0xHATdSQdu/TXEJvlUemKTTBDdGpFB63mAHtJeJCyVodYucRFuM
         6L6e696W49GJ+kJGbRAOqiKEa+WW7YrdQPE7ZiLsXdnWz0rVpDddCT3g32m2iY4qhn
         AhjszOZkY37Kf6c7LHl2GYt3spFnwmbO7vpl6Hc0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23I5JFms006926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Apr 2022 00:19:15 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 18
 Apr 2022 00:19:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 18 Apr 2022 00:19:14 -0500
Received: from [10.24.69.236] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23I5J96x066544;
        Mon, 18 Apr 2022 00:19:10 -0500
Message-ID: <56c72151-af5f-366b-b17f-24b9fb6264da@ti.com>
Date:   Mon, 18 Apr 2022 10:49:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: usb: tps6598x: Make the interrupts
 property optional
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Martin Kepplinger <martink@posteo.de>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220414083120.22535-1-a-govindraju@ti.com>
 <20220414083120.22535-2-a-govindraju@ti.com>
 <be8ab691-98f1-5fb9-fec8-7213a2288d07@kernel.org>
From:   Aswath Govindraju <a-govindraju@ti.com>
In-Reply-To: <be8ab691-98f1-5fb9-fec8-7213a2288d07@kernel.org>
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

Hi Roger,

On 14/04/22 23:40, Roger Quadros wrote:
> Hi,
> 
> On 14/04/2022 11:31, Aswath Govindraju wrote:
>> Support for polling has been added in the driver, which will be used by
>> default if interrupts property is not populated. Therefore, remove
>> interrupts and interrupt-names from the required properties and add a note
>> under interrupts property describing the above support in driver.
>>
>> Suggested-by: Roger Quadros <rogerq@kernel.org>
> 
> I did not suggest to make interrupts optional by default.
> 
> What I suggested was that if a DT property exists to explicitly
> indicate polling mode then interrupts are not required.
> 

ohh okay, got it. However, may I know if adding a dt property to
indicate polling for aiding the driver, is the correct approach to model it?

In terms of modelling hardware, as interrupts are not connected we are
not populating the interrupts property. Shouldn't that be all. If we are
adding a property explicitly to indicate polling that can be used by
driver, wouldn't that be a software aid being added in the device tree?

Thanks,
Aswath

>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>> index a4c53b1f1af3..1c4b8c6233e5 100644
>> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
>> @@ -25,6 +25,8 @@ properties:
>>  
>>    interrupts:
>>      maxItems: 1
>> +    description:
>> +      If interrupts are not populated then by default polling will be used.
>>  
>>    interrupt-names:
>>      items:
>> @@ -33,8 +35,6 @@ properties:
>>  required:
>>    - compatible
>>    - reg
>> -  - interrupts
>> -  - interrupt-names
>>  
>>  additionalProperties: true
>>  
> 
> cheers,
> -roger
