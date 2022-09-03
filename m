Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9785AC11C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiICTR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiICTRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:17:25 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D926108;
        Sat,  3 Sep 2022 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662232645; x=1693768645;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=6eY6ILL7xr6dXL7iV98qCDgSKJZoAKj5jlHTdI8wblU=;
  b=Tzz9s1t2kIdN0VMarDvrKrTXVN8HE8nJMniUGNwQwTfpGbd+JvQI1NWo
   gyFLNFdJd339w7PhBKBtnR6lJKbCRuQTf86Af6hi3gWO0sEwWmdS9VN7S
   F2DGCX9i1jHvsMnhWAFMoiJ9JYz2x+Z706sK6xBlckXF6l59zICg7AsaL
   o=;
X-IronPort-AV: E=Sophos;i="5.93,287,1654560000"; 
   d="scan'208";a="255898948"
Subject: Re: [PATCH v3 04/19] dt-bindings: hwmon: (mr75203) change "reset" property
 to be optional
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:17:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-9a235a16.us-east-1.amazon.com (Postfix) with ESMTPS id 5BD738013E;
        Sat,  3 Sep 2022 19:17:08 +0000 (UTC)
Received: from EX19D013UWA004.ant.amazon.com (10.13.138.207) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sat, 3 Sep 2022 19:16:58 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D013UWA004.ant.amazon.com (10.13.138.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Sat, 3 Sep 2022 19:16:58 +0000
Received: from [192.168.97.127] (10.85.143.175) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1497.38 via Frontend
 Transport; Sat, 3 Sep 2022 19:16:53 +0000
Message-ID: <cd5e5aae-119e-2ae3-4f86-5e008c890328@amazon.com>
Date:   Sat, 3 Sep 2022 22:16:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-US
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
 <20220830192212.28570-5-farbere@amazon.com>
 <20220902195114.GA305400-robh@kernel.org>
From:   "Farber, Eliav" <farbere@amazon.com>
In-Reply-To: <20220902195114.GA305400-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/2/2022 10:51 PM, Rob Herring wrote:
> On Tue, Aug 30, 2022 at 07:21:57PM +0000, Eliav Farber wrote:
>> Change "reset" property to be optional instead of required, for SOCs 
>> that
>
> 'resets'
>
> And subject too.
Fixed in v4.
