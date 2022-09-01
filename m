Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E771B5A9BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbiIAPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbiIAPh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:37:57 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AEB7B1F2;
        Thu,  1 Sep 2022 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662046678; x=1693582678;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=PyurQaqCq9eoCeTsYctAKTgwQl7ucsbfOPj1kVaxsIU=;
  b=oGo4iiHggPSXorbnmKDj0OlnkboBHQRPfvJr662V1DtB/L2Bvof8OQQk
   5rw/amNyC6B2n8ItnFc/aCxKybye1XooFkGaqPgaXi56UcZDc4uEN/91j
   5ZkX+GL8LYYX4w9rMVgQlLFOEA71RAxecdpLbdZz3UQSuROCFoFrC1HFo
   A=;
X-IronPort-AV: E=Sophos;i="5.93,281,1654560000"; 
   d="scan'208";a="125723485"
Subject: Re: [PATCH v3 19/19] hwmon: (mr75203) fix coding style space errors
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 15:31:48 +0000
Received: from EX13D28EUC003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com (Postfix) with ESMTPS id 397B4803F9;
        Thu,  1 Sep 2022 15:31:44 +0000 (UTC)
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D28EUC003.ant.amazon.com (10.43.164.43) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 1 Sep 2022 15:31:43 +0000
Received: from [192.168.93.228] (10.85.143.172) by mail-relay.amazon.com
 (10.43.60.234) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Thu, 1 Sep 2022 15:31:39 +0000
Message-ID: <2d907196-02c5-ea25-4438-04de77282e75@amazon.com>
Date:   Thu, 1 Sep 2022 18:31:38 +0300
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
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220901144633.GC3477025@roeck-us.net>
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

On 9/1/2022 5:46 PM, Guenter Roeck wrote:
> On Thu, Sep 01, 2022 at 05:21:43PM +0300, Farber, Eliav wrote:
>> On 8/31/2022 3:15 PM, Andy Shevchenko wrote:
>> > On Tue, Aug 30, 2022 at 07:22:12PM +0000, Eliav Farber wrote:
>> > > Fix: "ERROR: space required before the open parenthesis '('"
>> >
>> > This patch may have other fixes like adding new blank lines (noted 
>> in one
>> > of the patches in the series), etc.
>> This patch fixed a specific space error which existed before my changes
>> and repeated many time.
>> I fixed the blank line I added a previous patch (but is it isn’t an 
>> error
>> reported by checkpatch).
>
> That should really be fixed where it was introduced, not be introduced
> and fixed here.


So what do you suggest?
I can drop the patch from this series and ignore it or move it to be the
first patch in the series, or publish it separately later on.
I had it because it was annoying seeing existing checkpatch errors when
I came to check my change.

--
Thanks, Eliav

