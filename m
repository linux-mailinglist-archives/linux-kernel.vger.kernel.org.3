Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833155AFBA9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIGFVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIGFVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:21:51 -0400
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664127AC3A;
        Tue,  6 Sep 2022 22:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662528111; x=1694064111;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=bPqlJ+GjeaPi4Ygdk7T8Mj9Y8iSsKAp13cLkUSv1BbA=;
  b=PAnboWnz2Jlw8xn5/3tacAhPnHOfqduZ3/QD9f7F59No/fTHkrD/vYOm
   nHyjAIAtFfSqdT9a7QPdJJkjb5BHmKXBjlld3tKKlkIb20RQUvch3dItS
   rN9gqON4B65ue2KlQheykxXGm8lV165arFdCyQ7H84IYiWVDHUUF56GCt
   E=;
X-IronPort-AV: E=Sophos;i="5.93,295,1654560000"; 
   d="scan'208";a="238396350"
Subject: Re: [PATCH v4 12/21] dt-bindings: hwmon: (mr75203) add "moortec,
 vm-active-channels" property
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 05:21:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-c92fe759.us-east-1.amazon.com (Postfix) with ESMTPS id 50798C08A7;
        Wed,  7 Sep 2022 05:21:37 +0000 (UTC)
Received: from EX19D013UWA003.ant.amazon.com (10.13.138.202) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 7 Sep 2022 05:21:34 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX19D013UWA003.ant.amazon.com (10.13.138.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 7 Sep 2022 05:21:34 +0000
Received: from [192.168.96.145] (10.85.143.173) by mail-relay.amazon.com
 (10.43.62.224) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 7 Sep 2022 05:21:30 +0000
Message-ID: <1d12aae1-63d9-0b51-a97f-6af9557084ad@amazon.com>
Date:   Wed, 7 Sep 2022 08:21:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <andriy.shevchenko@intel.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-13-farbere@amazon.com>
 <20220906170851.GA900242@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220906170851.GA900242@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2022 8:08 PM, Guenter Roeck wrote:
> On Tue, Sep 06, 2022 at 08:33:47AM +0000, Eliav Farber wrote:
>> Add optional "moortec,vm-active-channels" property to define the number
>> of active channels per VM.
>>
>> This shall be useful to avoid exposing sysfs for reading inputs that are
>> not connected to any voltage source.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>> V4 -> V3:
>> - Fix DT checker errors.
>>
>> V3 -> V2:
>> - Add "moortec" prefix to property name.
>> - Add explanation why this change is needed.
>>
>>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml     | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml 
>> b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> index 9454576ebb73..2aa4c3618596 100644
>> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> @@ -70,6 +70,15 @@ properties:
>>    "#thermal-sensor-cells":
>>      const: 1
>>
>> +  moortec,vm-active-channels:
>> +    description:
>> +      Defines the number of channels per VM that are actually used 
>> and are
>> +      connected to some input source.
>> +      Maximum number of items - number of VMs.
>> +      Maximum value of each item - number of channels.
>> +      Minimum value of each item - 0 (which means entire VM sensor 
>> is nou used).
>
> s/nou/not/


Typo fixed in v5.

--
Thanks, Eliav

