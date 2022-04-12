Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5C04FE365
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354047AbiDLOKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbiDLOKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:10:42 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0C5EDD2;
        Tue, 12 Apr 2022 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649772504;
  x=1681308504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RcwGtxTnBfipy07qeT7JSixj+t14RK2eLBKQPcVo6oI=;
  b=fJ0O7EcD70kYi7wQZwEDr90vEqd6qvq9MMvkerQwVBKhbMNYu8GnU3Gd
   gh96QUk6N2UhTRhXzzw9+6XOp2HjQRiLG8mwsUOB1i/xqrh2+LPQ66e/Z
   VPCIkaHDNSFiAQsZfdIJy9mpHl8sMto7eJ+P02P3f83wj3rVMnqe6NksP
   dcIclV7h5f9CENjggedvU0RGwvCyKklLHmYqrCZLS2rORfb2Mg5y7nkhX
   NED/XhLN8Hq39DBKjSW6l6vzf7wtTKdlMNiD1HI729Pu4GTiB4jtPoOMo
   fxTnl/IoKIDikN7ettsJ7fQxSSCDlLv2CxovRbiafdy85w/6RZo/3gTPJ
   A==;
Message-ID: <66f417b0-c323-1b9f-d5b0-30f1c9bcd90b@axis.com>
Date:   Tue, 12 Apr 2022 16:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Camel Guo <Camel.Guo@axis.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC:     kernel <kernel@axis.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220411100329.1783432-1-camel.guo@axis.com>
 <20220411100329.1783432-2-camel.guo@axis.com>
 <c13a0f34-4938-3d56-43e0-5a9053e0bc25@linaro.org>
From:   Camel Guo <camelg@axis.com>
In-Reply-To: <c13a0f34-4938-3d56-43e0-5a9053e0bc25@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 13:53, Krzysztof Kozlowski wrote:
> On 11/04/2022 12:03, Camel Guo wrote:
>> From: Camel Guo <camelg@axis.com>
>> 
>> Document the TMP401, TMP411 and TMP43x device devicetree bindings
>> 
>> Signed-off-by: Camel Guo <camelg@axis.com>
>> ---
>>  .../devicetree/bindings/hwmon/ti,tmp401.yaml  | 111 ++++++++++++++++++
>>  MAINTAINERS                                   |   1 +
>>  2 files changed, 112 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
>> 

>> +      - ti,tmp401
>> +      - ti,tmp411
>> +      - ti,tmp431
>> +      - ti,tmp432
>> +      - ti,tmp435
> 
> Blank line, please.

Fixed
> 
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +  ti,extended-range-enable:
>> +    description: |
> 
> No need for "|". Here and in most of other cases below.

Fixed

> 
>> +      When set, this sensor measures over extended temperature range.
>> +    type: boolean
>> +
>> +  ti,n-factor:
>> +    description: |
>> +      The value (two's complement) to be programmed in the n-factor correction
>> +      register.
> 
> Do not describe the programming model (registers) but hardware property
> instead.

Make another try. Hope it is clear now.
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    items:
>> +      minimum: 0
>> +      maximum: 255
>> +
>> +  ti,beta-compensation:
>> +    description: |
>> +      The value to be programmed in the beta range register.
> 
> The same, register values should not be stored in DT.
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    items:
>> +      minimum: 0
>> +      maximum: 15
>> +
> 
> 
> Best regards,
> Krzysztof

Fixed in v2. Please review that instead.
