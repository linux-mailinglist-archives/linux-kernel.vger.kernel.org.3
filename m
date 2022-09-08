Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0329E5B2794
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIHUTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIHUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:19:18 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51765103043;
        Thu,  8 Sep 2022 13:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662668358; x=1694204358;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=ew1JSf+VMU1imqdWntc+SKpqCQ2xpoV/wfYgN33Kk6A=;
  b=MTyl7WyuASAGGi0ULNXHo+x7u053W9lQBnrAVSOqXKLm7EtifZFDtq2V
   tWPWa/8p1tgnMqXPUr1fA/SzB1jUhkFywfxf/aI+WyQGewoYoNoD5e/ym
   awOJ2IXEH/BjkHpwFAN7VcQruNFHxV4p6A8fDl+KkFotUeEjXY0Z/gR6w
   g=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="257610989"
Subject: Re: [PATCH v5 16/21] dt-bindings: hwmon: (mr75203) add "moortec,
 ts-series" property
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 20:19:02 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com (Postfix) with ESMTPS id ABEC6C0A08;
        Thu,  8 Sep 2022 20:18:58 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 20:18:47 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 20:18:47 +0000
Received: from [192.168.150.48] (10.85.143.179) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 8 Sep 2022 20:18:43 +0000
Message-ID: <40e210d8-2fad-b340-fdcb-6b2e4637bba1@amazon.com>
Date:   Thu, 8 Sep 2022 23:18:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-17-farbere@amazon.com>
 <20220908190216.GA3423559@roeck-us.net>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220908190216.GA3423559@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/2022 10:02 PM, Guenter Roeck wrote:
> On Thu, Sep 08, 2022 at 03:24:44PM +0000, Eliav Farber wrote:
>> Add optional "moortec,ts-series" property to define the temperature
>> equation and coefficients that shall be used to convert the digital
>> output to value in milli-Celsius.
>> Supported series: 5 (default) and 6.
>>
>> Series 5:
>>   T = G + H * (n / cal5 - 0.5) + J * F
>> Where: G = 60, H = 200, cal5 = 4094, J = -0.1, F = frequency clock in 
>> MHz
>>
>> Series 6:
>>    T = G + H * (n / cal5 - 0.5)
>> Where: G = 57.4, H = 249.4, cal5 = 4096
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>> V4 -> V3:
>> - Remove constraints in free-form text descriptions.
>>
>> V3 -> V2:
>> - New patch to introduce "moortec,ts-series" property.
>>
>>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml       | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml 
>> b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> index d6b03a6d7043..df849517464e 100644
>> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> @@ -91,6 +91,15 @@ properties:
>>        Each channel should not appear more than once.
>>      $ref: /schemas/types.yaml#/definitions/uint8-array
>>
>> +  moortec,ts-series:
>> +    description:
>> +      Definition of the temperature equation and coefficients that 
>> shall be
>> +      used to convert the digital output to value in milli-Celsius.
>> +    minimum: 5
>> +    maximum: 6
>> +    default: 5
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>
> I am not a dt expert, but I wonder if this should be handled
> with different "compatible" properties. Sorry if this was already
> addressed and I missed it.

It was already addressed in [PATCH v3 14/19] by Philipp.
It is indeed confusing which is why I added a detailed description
to moortec,mr75203.yaml in [PATCH v5 07/21].
Shortly, the driver is for the controller unit (mr75203), while the
"series" is a parameter of the temperature unit (mr74137).
Therefore I added a new TS property and not a different compatible.

--
Regards, Eliav
