Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D935AB1F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbiIBNp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiIBNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:45:18 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D862912EC60;
        Fri,  2 Sep 2022 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662124883; x=1693660883;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=nzPUc9EDrOhRtDNeKPMRzpudxcLrf0JAPFl0JHh3d9o=;
  b=DZ2Sxio5il+oQReWjRJLz0mEL7NTc3FEzLKuoGfHG+NNTHSmzgEOS7DZ
   xcKu9A6lXnc5joQlxm4W3hy8meJCNbRoBzYWkDgjWJkG20XucwkYeOlFS
   S20HOBJfv/Ndg+MqjWPoSrx1u3YchQD5IkWjXdKn9L67gV/9Ww8J2EKaK
   c=;
X-IronPort-AV: E=Sophos;i="5.93,283,1654560000"; 
   d="scan'208";a="255577710"
Subject: Re: [PATCH v3 14/19] dt-bindings: hwmon: (mr75203) add "moortec,
 ts-series" property
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-388992e0.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 13:18:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-388992e0.us-west-2.amazon.com (Postfix) with ESMTPS id C2D51E48AB;
        Fri,  2 Sep 2022 13:18:09 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Fri, 2 Sep 2022 13:18:09 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Fri, 2 Sep 2022 13:18:09 +0000
Received: from [192.168.149.164] (10.85.143.177) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Fri, 2 Sep 2022 13:18:03 +0000
Message-ID: <52e48e0a-1369-2c8f-b3e8-c854365384d4@amazon.com>
Date:   Fri, 2 Sep 2022 16:18:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
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
 <20220830192212.28570-15-farbere@amazon.com>
 <89806ee9a80652d5877ef5c4a86574e82af48da4.camel@pengutronix.de>
 <f49558fa-e987-145c-425e-0e8a7a9fba5f@amazon.com>
 <4ab6f79f54ad975d7c21c86c57fa2defbb8c98c0.camel@pengutronix.de>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <4ab6f79f54ad975d7c21c86c57fa2defbb8c98c0.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2022 12:42 PM, Philipp Zabel wrote:
> On Mi, 2022-08-31 at 12:23 +0300, Farber, Eliav wrote:
>> On 8/31/2022 11:23 AM, Philipp Zabel wrote:
>> > On Di, 2022-08-30 at 19:22 +0000, Eliav Farber wrote:
>> > > Add optional "moortec,ts-series" property to define the temperature
>> > > equation and coefficients that shall be used to convert the digital
>> > > output to value in milli-Celsius.
>> > > Supported series: 5 (default) and 6.
>> >
>> > Is this the difference between mr75xxx and mr76xxx series?
>> > If so, should be a compatible "moortec,mr76006" instead?
>> > If the temperature equation could be derived from the compatible, this
>> > property would not be necessary.
>> The PVT (Process, Voltage, Temperature) monitoring logic can be
>> constructed from many different sub-blocks:
>> *) CONTROLLER (mr75203) - controlling TS, PD and VM.
>> *) TS (mr74137) - for measuring temperature in ring.
>> *) PD (mr74139) - for measuring IO based transistors.
>> *) VM (mr74138) - for measuring voltage rails across the SoC.
>> *) Ring oscillators (mr76007/mr76008)
>> *) Pre-scalers (mr76006)
>>
>> Besides mr75203 which is digital all other IPs are analog.
>> There is a single mr75203 and there can be several or none of the other
>> units.
>
> Thank you for the explanation, I think this information would be nice
> to have in a description in moortec,mr75203.yaml. 

For v4 I added a new patch which adds this description in
moortec,mr75203.yaml:

description: |
   A Moortec PVT (Process, Voltage, Temperature) monitoring logic design can
   include many different units.
   Such a design will usually consists of several Moortec's embedded 
analog IPs,
   and a single Moortec controller to configure and control the IPs.

   Some of the Moortec's analog hard IPs that can be used in a design:
   *) Temperature Sensor (TS) - used to monitor core temperature (e.g. 
mr74137).
   *) Voltage Monitor (VM) - used to monitor voltage levels (e.g. mr74138).
   *) Process Detector (PD) - used to assess silicon speed (e.g. mr74139).
   *) Delay Chain - ring oscillator connected to the PD, used to measure IO
      based transistors (e.g. mr76008 ring oscillator at 1.1V, mr76007 ring
      oscillator at 1.8V).
   *) Pre Scaler - provides divide-by-X scaling of input voltage, which 
can then
      be presented for VM for measurement within its range (e.g. mr76006 -
      divide by 2 pre-scaler).

   TS, VM & PD also include a digital interface, which consists of 
configuration
   inputs and measurement outputs.
   The mr75203 binding describes configuration for the controller unit, 
but also
   for some of the analog IPs.

--
Regards, Eliav
