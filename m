Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D15AFC5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIGG2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIGG2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:28:43 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1195A8E4E0;
        Tue,  6 Sep 2022 23:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662532124; x=1694068124;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=4cDYIE/7ld7yTLHdxOZK80QRgY+Riw5EdEOFHWUOWjw=;
  b=WAuIWTzRbbuehMVMHbBDPmnqcbGOErJKagx5NP8ZoNXKMyq4MDLA70ci
   g6hT9o0UgJv+ly56v1QI7mVnpnMWcWg5DhZKyo4j2rOuQ0AqOxQ3uTCAo
   kmicjsQA2Dy5GYoVUu/LH/dSUx9cbJ7kmFNANyzKtxXx/CSJXirIeGX1u
   E=;
X-IronPort-AV: E=Sophos;i="5.93,295,1654560000"; 
   d="scan'208";a="256931908"
Subject: Re: [PATCH v4 02/21] dt-bindings: hwmon: (mr75203) fix "intel,
 vm-map" property to be optional
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-5bed4ba5.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 06:28:28 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-5bed4ba5.us-west-2.amazon.com (Postfix) with ESMTPS id D87F181896;
        Wed,  7 Sep 2022 06:28:25 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 7 Sep 2022 06:28:24 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 7 Sep 2022 06:28:24 +0000
Received: from [192.168.97.69] (10.85.143.172) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 7 Sep 2022 06:28:21 +0000
Message-ID: <f638f9bc-b757-c352-7be0-4f9ab6607378@amazon.com>
Date:   Wed, 7 Sep 2022 09:28:20 +0300
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
 <20220906083356.21067-3-farbere@amazon.com>
 <20220906165359.GA817639@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220906165359.GA817639@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2022 7:53 PM, Guenter Roeck wrote:
> On Tue, Sep 06, 2022 at 08:33:37AM +0000, Eliav Farber wrote:
>> Change "intel,vm-map" property to be optional instead of required.
>>
>> The driver implementation indicates it is not mandatory to have
>> "intel,vm-map" in the device tree:
>>  - probe doesn't fail in case it is absent.
>>  - explicit comment in code - "Incase intel,vm-map property is not
>>    defined, we assume incremental channel numbers".
>>
>> Fixes: 748022ef093f ("hwmon: Add DT bindings schema for PVT controller")
>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>> ---
>> V3 -> V2:
>> - Change this patch to be first in the series.
>> - Add explanation why "intel,vm-map" is not required.
>>
>
> I don't see how this change warrants dropping Rob's Acked-by tag.
> Am I missing something ? 

My apology. I wasn’t aware I had to keep the Acked-by tag.
I'll add it in v5.

--
Regards, Eliav


