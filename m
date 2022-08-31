Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3C5A7A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiHaJYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiHaJYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:24:05 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB76B941B;
        Wed, 31 Aug 2022 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1661937845; x=1693473845;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=OxRHe00tIu+wEnbpDdPcwB/UKvS8htw1fOMgAij8ARk=;
  b=tpwZEk2Bds5NbQUrZ/uiIoTnMesbKPuXqGBzA6y8xzyOW8wbkjxMRV+e
   AWlapD/nWUIxcmbgghCDRA+zy7YLQRKJGw8g/qb3c6nzFpjQUo+1c4REX
   K046vEpnuayCgqh62t9vrFBPmmT9kKVyY4d1rbkgfXdUN0b8K1FPvTNQR
   w=;
Subject: Re: [PATCH v3 14/19] dt-bindings: hwmon: (mr75203) add "moortec,
 ts-series" property
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-d803d33a.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 09:23:52 +0000
Received: from EX13D37EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-d803d33a.us-west-2.amazon.com (Postfix) with ESMTPS id B8C9B8550C;
        Wed, 31 Aug 2022 09:23:51 +0000 (UTC)
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D37EUA001.ant.amazon.com (10.43.165.212) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 31 Aug 2022 09:23:50 +0000
Received: from [192.168.153.206] (10.85.143.179) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 31 Aug 2022 09:23:45 +0000
Message-ID: <f49558fa-e987-145c-425e-0e8a7a9fba5f@amazon.com>
Date:   Wed, 31 Aug 2022 12:23:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
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
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <89806ee9a80652d5877ef5c4a86574e82af48da4.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2022 11:23 AM, Philipp Zabel wrote:
> On Di, 2022-08-30 at 19:22 +0000, Eliav Farber wrote:
>> Add optional "moortec,ts-series" property to define the temperature
>> equation and coefficients that shall be used to convert the digital
>> output to value in milli-Celsius.
>> Supported series: 5 (default) and 6.
>
> Is this the difference between mr75xxx and mr76xxx series?
> If so, should be a compatible "moortec,mr76006" instead?
> If the temperature equation could be derived from the compatible, this
> property would not be necessary.
The PVT (Process, Voltage, Temperature) monitoring logic can be
constructed from many different sub-blocks:
*) CONTROLLER (mr75203) - controlling TS, PD and VM.
*) TS (mr74137) - for measuring temperature in ring.
*) PD (mr74139) - for measuring IO based transistors.
*) VM (mr74138) - for measuring voltage rails across the SoC.
*) Ring oscillators (mr76007/mr76008)
*) Pre-scalers (mr76006)

Besides mr75203 which is digital all other IPs are analog.
There is a single mr75203 and there can be several or none of the other
units.

The kernel driver is only for the controller (mr75203).
The series 5 or 6 is relevant for the TS (mr74137) and not for the
controller (mr75203).
Each of the analog units can have a different series number (for example
we use series 3 of the VM).

That is why I didn't change the compatible of mr75203, and instead added
a TS-series parameter.

--
Regards, Eliav
