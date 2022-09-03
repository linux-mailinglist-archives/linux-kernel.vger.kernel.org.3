Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDFD5AC126
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiICTfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiICTfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:35:03 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B151EEF7;
        Sat,  3 Sep 2022 12:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662233702; x=1693769702;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=PxhrSNgegw/If3/EaW4kYpuEXX6/cf/dY4xYtRrZeyw=;
  b=I2IQ98jIOc1x9eLs0LnQ/3Rgwt7FuucDBRcW8DimkixfNGuLUeaTNQRU
   qmzM+gzhG25IDrUI0s1ManppDxyhpP493vflmFdEBR8ocWfkFKRtxwjEE
   hDfgxEeUSRfEctQxco4Phrs5rAZSEMUr/R7asG3ttsiwcBDxgFpx65EVf
   4=;
X-IronPort-AV: E=Sophos;i="5.93,287,1654560000"; 
   d="scan'208";a="126424489"
Subject: Re: [PATCH v3 10/19] dt-bindings: hwmon: (mr75203) add "moortec,
 vm-pre-scaler" property
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-6e5a0cd6.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:34:47 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-6e5a0cd6.us-west-2.amazon.com (Postfix) with ESMTPS id 30E02A2647;
        Sat,  3 Sep 2022 19:34:46 +0000 (UTC)
Received: from EX19D013UWA001.ant.amazon.com (10.13.138.253) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sat, 3 Sep 2022 19:34:45 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA001.ant.amazon.com (10.13.138.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Sat, 3 Sep 2022 19:34:45 +0000
Received: from [192.168.97.127] (10.85.143.175) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Sat, 3 Sep 2022 19:34:39 +0000
Message-ID: <02741c2c-7524-5093-19c1-622ac87e7cf9@amazon.com>
Date:   Sat, 3 Sep 2022 22:34:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <jdelvare@suse.com>, <linux@roeck-us.net>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <ronenk@amazon.com>, <itamark@amazon.com>, <shellykz@amazon.com>,
        <shorer@amazon.com>, <amitlavi@amazon.com>, <almogbs@amazon.com>,
        <dkl@amazon.com>, <andriy.shevchenko@intel.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-11-farbere@amazon.com>
 <20220902195737.GA306891-robh@kernel.org>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220902195737.GA306891-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/2022 10:57 PM, Rob Herring wrote:
> On Tue, Aug 30, 2022 at 07:22:03PM +0000, Eliav Farber wrote:
>> Add support for mr76006 pre-scaler which provides divide-by-2 scaling of
>> input voltage, which can then be presented for VM for measurement within
>> its range (the VM input range is limited to -0.1V to 1V).
>>
>> The new "moortec,vm-pre-scaler" property lists the channels that use a
>> pre-scaler.
>>
>> The driver will use this list to multiply the voltage result by 2, to
>> present to the user the actual voltage input source.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>> V3 -> V2:
>> - Add "moortec" prefix to property name.
>> - Change property format to be a single u8 array.
>> - Fix typo: scalar --> scaler.
>>
>>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml    | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml 
>> b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> index 69cc6caceb2c..4c983d8f8fe7 100644
>> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> @@ -54,6 +54,16 @@ properties:
>>      default: 16
>>      $ref: /schemas/types.yaml#definitions/uint8-array
>>
>> +  moortec,vm-pre-scaler:
>> +    description:
>> +      moortec,vm-pre-scaler property is an array of channels that 
>> use a mr76006
>> +      pre-scaler to divides the input source by 2.
>
> to divide the

Fixed in v4.

> You don't need the property name in the description. The entries are the
> pre-scaler values for each channel? The array index is the channel? If
> so, then 'an array of pre-scaler values for each channel ...'.

Removed property name in the description.

The entries are channel numbers that use a pre-scaler.
Assume 2 VMs, with 16 channels each (so 32 channels in total, numbered
from 0 to 31) and assume: moortec,vm-pre-scaler = /bits/ 8 <5 6 20>;
This means that only channels 5 6 and 20 use a pre-scaler, and the driver
will use a factor of 2 only for these channels.

For v4 I renamed the property name to be "moortec,vm-pre-scaler-x2".
And I changed binding to:

moortec,vm-pre-scaler-x2:
description:
   Defines the channels that use a mr76006 pre-scaler to divide the input
   source by 2.
   The pre-scaler is used for input sources that exceed the VM input range.
   The driver uses this information to present to the user with the actual
   value of the voltage source.
   For channels that are not listed, no pre-scaler is assumed.
   Maximum number of items - total number of channels in all VMs.
   Each channel should not appear more than once.
$ref: /schemas/types.yaml#/definitions/uint8-array

>> +      The pre-scaler is used for input sources that exceed the VM 
>> input range.
>> +      The driver uses this information to present to the user the 
>> actual value
>> +      of the voltage source.
>> +    default: 1
>
> It's an array, so a scalar default doesn't make sense.
What I meant was the in-case channel is not defined the default pre-
scaler value is 1.

>> +    $ref: /schemas/types.yaml#definitions/uint8-array
>
> Constraints? I assume there's a finite number of channels to set the
> array size bounds for example. 
Added some constraints in the new description above.

--
Thanks, Eliav
