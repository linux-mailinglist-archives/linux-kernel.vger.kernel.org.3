Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62445A7A73
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiHaJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiHaJns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:43:48 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21479CEB3C;
        Wed, 31 Aug 2022 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661939025; x=1693475025;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=dhx4/HWDxIlBVqlYs4wS13lU72P1ArGL4LVJwKr7dkU=;
  b=TTMP7HZ9z6Y6IqgOHUtTUqu/0crjIpthYwXk8qaQeJ+j880DewWmBiiB
   MfQXH2McS5urK5E7EdDTC9DUDGdGMpwlkj/9uuq9jy3g9fykPf8pepCR8
   dUTPDRhkvdKi7SJSC1QxcUmFnWLyun47EAMsX1RI4SHwJAh9t8yM0u11T
   0=;
Subject: Re: [PATCH v3 04/19] dt-bindings: hwmon: (mr75203) change "reset" property
 to be optional
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-f20e0c8b.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 09:43:33 +0000
Received: from EX13D41EUB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-f20e0c8b.us-east-1.amazon.com (Postfix) with ESMTPS id 0E82680268;
        Wed, 31 Aug 2022 09:43:30 +0000 (UTC)
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D41EUB002.ant.amazon.com (10.43.166.132) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 31 Aug 2022 09:43:29 +0000
Received: from [192.168.153.206] (10.85.143.179) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 31 Aug 2022 09:43:24 +0000
Message-ID: <671a0ee8-9b0d-b417-19ff-013681cc73d8@amazon.com>
Date:   Wed, 31 Aug 2022 12:43:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Philipp Zabel <p.zabel@pengutronix.de>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <rtanwar@maxlinear.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <ronenk@amazon.com>, <itamark@amazon.com>,
        <shellykz@amazon.com>, <shorer@amazon.com>, <amitlavi@amazon.com>,
        <almogbs@amazon.com>, <dkl@amazon.com>,
        <andriy.shevchenko@intel.com>, "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-5-farbere@amazon.com>
 <3bd5f46dff622e375c4f60140f479bf6ee483aec.camel@pengutronix.de>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <3bd5f46dff622e375c4f60140f479bf6ee483aec.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2022 11:21 AM, Philipp Zabel wrote:
> On Di, 2022-08-30 at 19:21 +0000, Eliav Farber wrote:
>> Change "reset" property to be optional instead of required, for SOCs 
>> that
>> don't support a reset controller.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>> V3 -> v2:
>> - Change "reset" property to be optional instead of adding new
>>   "reset-control-skip" property.
>>
>>  Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml 
>> b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> index 6abde48b746e..2ec4b9da4b92 100644
>> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> @@ -49,7 +49,6 @@ required:
>>    - reg
>>    - reg-names
>>    - clocks
>> -  - resets
>
> Is this just for mr76006? Or does mr75203 work without reset as well?
>
> If it is the former, maybe a new compatible should be added and resets
> should be kept required

mr75203 also works without a reset.
As I replied in PATCH v3 14/19, series 5/6 is relevant only for the
temperature sensor.
The “reset” property is relevant to the controller.

--
Regards, Eliav



