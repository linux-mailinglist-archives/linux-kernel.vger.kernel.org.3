Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E619F5A9F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiIASlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIASlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:41:04 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9214BD13;
        Thu,  1 Sep 2022 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662057663; x=1693593663;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=/6J77/LlQgbg1hQnSjTTdcGsFBy61d+Z4bCGNjtV06A=;
  b=AMVS6eOrBgEaS4vLTxrVrLN+U3PzNNXhMFLeviITsgfHfH1Im56IX5ss
   OMQQ5iEmytKDsSHuUquS0pnc8ERbcjzWycPLJuD0xv6Hwmqe/zynSzGQY
   t0aY0ZOjvmELwPCHgkmrX5oRIZyTrOvbpeocxJkXr/6msmfB18CeNXCkw
   g=;
X-IronPort-AV: E=Sophos;i="5.93,281,1654560000"; 
   d="scan'208";a="255294431"
Subject: Re: [PATCH v3 19/19] hwmon: (mr75203) fix coding style space errors
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 18:40:48 +0000
Received: from EX13D37EUB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com (Postfix) with ESMTPS id CBD2B450B2;
        Thu,  1 Sep 2022 18:40:47 +0000 (UTC)
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D37EUB002.ant.amazon.com (10.43.166.116) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 18:40:46 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 18:40:42 +0000
Message-ID: <ea7061b8-5779-6bfe-db3a-8670aeebed32@amazon.com>
Date:   Thu, 1 Sep 2022 21:40:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Andy Shevchenko <andriy.shevchenko@intel.com>, <jdelvare@suse.com>,
        <robh+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <rtanwar@maxlinear.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <talel@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <ronenk@amazon.com>, <itamark@amazon.com>,
        <shellykz@amazon.com>, <shorer@amazon.com>, <amitlavi@amazon.com>,
        <almogbs@amazon.com>, <dkl@amazon.com>,
        "Farber, Eliav" <farbere@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-20-farbere@amazon.com>
 <Yw9Q5krebHnb73vC@smile.fi.intel.com>
 <0074475d-04bc-153a-2df8-dd5f7d014c97@amazon.com>
 <20220901144633.GC3477025@roeck-us.net>
 <2d907196-02c5-ea25-4438-04de77282e75@amazon.com>
 <4337076c-9585-9650-5646-ee3f90bd5787@roeck-us.net>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <4337076c-9585-9650-5646-ee3f90bd5787@roeck-us.net>
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

On 9/1/2022 8:09 PM, Guenter Roeck wrote:
> On 9/1/22 08:31, Farber, Eliav wrote:
>> On 9/1/2022 5:46 PM, Guenter Roeck wrote:
>>> On Thu, Sep 01, 2022 at 05:21:43PM +0300, Farber, Eliav wrote:
>>>> On 8/31/2022 3:15 PM, Andy Shevchenko wrote:
>>>> > On Tue, Aug 30, 2022 at 07:22:12PM +0000, Eliav Farber wrote:
>>>> > > Fix: "ERROR: space required before the open parenthesis '('"
>>>> >
>>>> > This patch may have other fixes like adding new blank lines 
>>>> (noted in one
>>>> > of the patches in the series), etc.
>>>> This patch fixed a specific space error which existed before my 
>>>> changes
>>>> and repeated many time.
>>>> I fixed the blank line I added a previous patch (but is it isn’t an 
>>>> error
>>>> reported by checkpatch).
>>>
>>> That should really be fixed where it was introduced, not be introduced
>>> and fixed here.
>>
>>
>> So what do you suggest?
>> I can drop the patch from this series and ignore it or move it to be the
>> first patch in the series, or publish it separately later on.
>> I had it because it was annoying seeing existing checkpatch errors when
>> I came to check my change.
>>
>
> Sorry, you lost me. I referred to "I fixed the blank line I added
> a previous patch". That should not be fixed in this patch but be dropped
> from the patch where you introduced it. Did I misunderstand your 
> comment ?


Indeed I fixed the blank line in the original patch in which it was
introduced.
Patch #19 only addresses previously existing space related checkpatch
errors.

--
Thanks, Eliav

