Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE05F5AFCDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIGGuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIGGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:50:41 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC835A00DE;
        Tue,  6 Sep 2022 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662533425; x=1694069425;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=wnvnIuOeYP0xa1qg9Sm5/dopt+6QQVhvQYrBlszMVFo=;
  b=aSkiOizjQJsjQ1BA0SpsTG9koBn0+C+VeAHNg8t0GTwI7HbuxPhlH87f
   UE/KO2ncwafe4o9+5iz8hIDocXq9iyVt3oZ4RFByimCZMTtLF2VOA25nu
   YsU4Ng9DrY+myUPZ1vdw6QN/D8aaCdwRpX94bWU4z1Lba6SFCba83uGvM
   I=;
X-IronPort-AV: E=Sophos;i="5.93,296,1654560000"; 
   d="scan'208";a="127521217"
Subject: Re: [PATCH v4 01/21] hwmon: (mr75203) fix coding style space errors
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 06:50:09 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com (Postfix) with ESMTPS id ADC4BC0965;
        Wed,  7 Sep 2022 06:50:05 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Wed, 7 Sep 2022 06:50:04 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Wed, 7 Sep 2022 06:50:04 +0000
Received: from [192.168.97.69] (10.85.143.172) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Wed, 7 Sep 2022 06:50:01 +0000
Message-ID: <9323b609-cb9d-8b3d-2894-65296487cdb1@amazon.com>
Date:   Wed, 7 Sep 2022 09:50:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <jdelvare@suse.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>, <andriy.shevchenko@intel.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220906083356.21067-1-farbere@amazon.com>
 <20220906083356.21067-2-farbere@amazon.com>
 <20220906165229.GA594012@roeck-us.net>
Content-Language: en-US
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220906165229.GA594012@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2022 7:52 PM, Guenter Roeck wrote:
> On Tue, Sep 06, 2022 at 08:33:36AM +0000, Eliav Farber wrote:
>> Fix: "ERROR: space required before the open parenthesis '('"
>>
>> Fixes: 9d823351a337 ("hwmon: Add hardware monitoring driver for 
>> Moortec MR75203 PVT controller")
>
> Coding style "fixes" do not fix the code. I consider using the Fixes: tag
> for those to close to an abuse of that tag (and it would be great if that
> was spelled out somewhere). As it is, I can not with good conscience 
> apply
> this patch to the mainline kernel (especially not for -rc5), meaning the
> entire series will have to wait for the next release window unless there
> are no conflicts. 
Because as you mentioned  it is not a functional fix in the code I’ll
remove the Fixes tag in v5.
I checked older kernel versions and patch applies without conflicts.
That’s also why I moved it to be first in the series, so it will be
before any of my other changes that night cause merge problems for
other branches.

--
Thanks, Eliav
