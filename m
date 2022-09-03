Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D35AC114
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiICTMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiICTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:12:39 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B15A15B;
        Sat,  3 Sep 2022 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662232359; x=1693768359;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=uOyTre85yQlaDYxtAo4E2Bj7GJMoTnZvSMixbf7TAhM=;
  b=sKWsztVU0DymbqizyfALc/6uAVAExuBe06zjMPlLw2ixNwmhcjav/HDL
   pYhMM2DVEBfrbgpeQUaRpWCAmRXeb1x2lS815reFE9Sl7tyM4jYg5Tcqo
   i1kk7KMdnWkC1U18Hv/FhYlH/D9CLzjSmr2G9wfPYjVsPkrNvRr8oseGK
   A=;
X-IronPort-AV: E=Sophos;i="5.93,287,1654560000"; 
   d="scan'208";a="223181348"
Subject: Re: [PATCH v3 14/19] dt-bindings: hwmon: (mr75203) add "moortec,
 ts-series" property
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-7d84505d.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:12:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-7d84505d.us-west-2.amazon.com (Postfix) with ESMTPS id C6998100361;
        Sat,  3 Sep 2022 19:12:20 +0000 (UTC)
Received: from EX19D013UWB003.ant.amazon.com (10.13.138.111) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sat, 3 Sep 2022 19:12:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWB003.ant.amazon.com (10.13.138.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Sat, 3 Sep 2022 19:12:20 +0000
Received: from [192.168.97.127] (10.85.143.175) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Sat, 3 Sep 2022 19:12:14 +0000
Message-ID: <58d05274-b460-638e-d363-930de897283a@amazon.com>
Date:   Sat, 3 Sep 2022 22:12:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
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
 <20220830192212.28570-15-farbere@amazon.com>
 <20220902195935.GA316069-robh@kernel.org>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220902195935.GA316069-robh@kernel.org>
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

On 9/2/2022 10:59 PM, Rob Herring wrote:
> On Tue, Aug 30, 2022 at 07:22:07PM +0000, Eliav Farber wrote:
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
>> V3 -> V2:
>> - New patch to introduce "moortec,ts-series" property.
>>
>>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml     | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml 
>> b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> index 4c983d8f8fe7..ec2dbe7da9c2 100644
>> --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
>> @@ -64,6 +64,16 @@ properties:
>>      default: 1
>>      $ref: /schemas/types.yaml#definitions/uint8-array
>>
>> +  moortec,ts-series:
>> +    description:
>> +      moortec,ts-series defines the temperature equation and 
>> coefficients that
>> +      shall be used to convert the digital output to value in 
>> milli-Celsius.
>> +      Supported series are 5 and 6.
>
> No need to state constraints in free-form text descriptions.

Fixed in v4.


