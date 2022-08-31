Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534A75A84B1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiHaRsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiHaRsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:48:11 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBBBBB914;
        Wed, 31 Aug 2022 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661968091; x=1693504091;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=p/GOqKIZDQTxNG42y21N79YylwcTQ9NvOofSnfIbNdc=;
  b=pEoTtJy1TPIdjMvt/fRNLbg709wHOEaURvXJGxgH+RVvsqQXFA7KWdar
   ldqohTAC3A1kAisfNBLMhTlxSe8F89F6ZCUKweC7Z7WtNL4CQgYJbWSjd
   /AWtyqrhLUe6bkiTGqxt+oOCYTYaELidbR2XqkojrjYByBkseQbH1S7jX
   A=;
X-IronPort-AV: E=Sophos;i="5.93,278,1654560000"; 
   d="scan'208";a="125450026"
Subject: Re: [PATCH v3 08/19] dt-bindings: hwmon: (mr75203) add "moortec,
 vm-active-channels" property
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 17:47:54 +0000
Received: from EX13D33EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com (Postfix) with ESMTPS id 488AD80FD4;
        Wed, 31 Aug 2022 17:47:51 +0000 (UTC)
Received: from EX19D019EUA002.ant.amazon.com (10.252.50.84) by
 EX13D33EUA002.ant.amazon.com (10.43.165.38) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 31 Aug 2022 17:47:50 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D019EUA002.ant.amazon.com (10.252.50.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Wed, 31 Aug 2022 17:47:49 +0000
Received: from [192.168.153.206] (10.85.143.179) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 31 Aug 2022 17:47:45 +0000
Message-ID: <2508ecda-cfd2-96ba-a802-47d25f225dd0@amazon.com>
Date:   Wed, 31 Aug 2022 20:47:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To:     Rob Herring <robh@kernel.org>
CC:     <almogbs@amazon.com>, Rahul Tanwar <rtanwar@maxlinear.com>,
        Talel Shenhar <talel@amazon.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        <itamark@amazon.com>, <amitlavi@amazon.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, <shellykz@amazon.com>,
        Jean Delvare <jdelvare@suse.com>, <shorer@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dkl@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-9-farbere@amazon.com>
 <1661945961.480039.3614528.nullmailer@robh.at.kernel.org>
 <a8557b5a-6e27-2e66-161e-814fc0f69c1d@amazon.com>
 <CAL_Jsq+c7DaJFCgeHDsXQT8oqHmPS57S-o_EALz=nHDREhqc7g@mail.gmail.com>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <CAL_Jsq+c7DaJFCgeHDsXQT8oqHmPS57S-o_EALz=nHDREhqc7g@mail.gmail.com>
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

On 8/31/2022 3:17 PM, Rob Herring wrote:
> On Wed, Aug 31, 2022 at 6:53 AM Farber, Eliav <farbere@amazon.com> wrote:
>>
>> On 8/31/2022 2:39 PM, Rob Herring wrote:
>>
>> On Tue, 30 Aug 2022 19:22:01 +0000, Eliav Farber wrote:
>>
>> Add optional "moortec,vm-active-channels" property to define the number
>> of active channels per VM.
>>
>> This shall be useful to avoid exposing sysfs for reading inputs that are
>> not connected to any voltage source.
>>
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>> V3 -> V2:
>> - Add "moortec" prefix to property name.
>> - Add explanation why this change is needed.
>>
>>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml    | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> I used dt_binding_check on my changes (I ported it to my kernel).
>> The error is related to "intel-vm-map" which I did not add.
>
> The error is the vendor prefix is not defined in vendor-prefixes.yaml.

I fixed the vendor prefix error (will be part of v4).

>> I don't mind fixing it if you wish.
>> It requires changing:
>>   intel,vm-map = [03 01 04 ff ff];
>> to:
>>   intel,vm-map = /bits/8 <0x03 0x01 0x04 0xff 0xff>;
>
> That is not the issue. The issue is the type is unknown because your
> schema fails and we can't get the type from it. Once your schema
> passes, this should go away.
Even after fixing the vendor prefix error I still see this:
moortec,mr75203.yaml: ignoring, error in schema: properties: intel,vm-map
moortec,mr75203.example.dtb: pvt@e0680000: intel,vm-map: 
b'\x03\x01\x04\xff\xff' is not of type 'object', 'array', 'boolean', 'null'

--
Regards, Eliav
