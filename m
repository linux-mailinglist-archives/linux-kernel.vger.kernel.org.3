Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7774F6210
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiDFOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiDFOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:47:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6A75DDA85
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649243838; x=1680779838;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7uy3jIH2Iom8PJPh5zdl4Y9ZT/NPr6yZs+900q/1f2w=;
  b=PXGRk5ZWxSRtsYLEn3BMOFA4rFhI74YB4CQ76A76EFnpwe2cXxTw2tFf
   pQejwFwo0+rNpHsKrdU3/Oa8n3v/KTck5HlFyVh3LYCyWY8L5q1K8Nb5L
   IGzFSMu2pD9CqDl4nUowppgdQ9Ye0mhJ7XglIUnMnCgg0An03i2bK19e7
   5BauiCGKBYJf3+/lAEp1c+rQfZ+r4CSB1bXi1q2aM6TGRy8gV1HexE/25
   OZE5EjQUqSLcfAl5nAO8LrjDc/VJXZXM/Hb2H/8wuKLwebz61H+yK6Km3
   azcDI47wT2sTA+pvROW7PPIjskBNfuSVjnNtn/oyI0Yknvl8MRmlI9SB6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260717456"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="260717456"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 04:17:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="570470476"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.173.64]) ([10.249.173.64])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 04:17:14 -0700
Subject: Re: [kbuild-all] Re: drivers/cxl/pci.c:439:7: warning: Local variable
 'rc' shadows outer variable [shadowVariable]
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <202204021950.bTbpM2Gy-lkp@intel.com>
 <e4d381f0-bafc-771b-7298-cfc6685776f0@infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <810c4865-45c1-ec93-4f72-2086461756c3@intel.com>
Date:   Wed, 6 Apr 2022 19:17:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <e4d381f0-bafc-771b-7298-cfc6685776f0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2022 3:29 AM, Randy Dunlap wrote:
> Hi lkp/ktr,
> 
> On 4/2/22 04:26, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   88e6c0207623874922712e162e25d9dafd39661e
>> commit: 523e594d9cc03db962c741ce02c8a58aab58a123 cxl/pci: Implement wait for media active
>> date:   7 weeks ago
>> compiler: alpha-linux-gcc (GCC) 11.2.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> cppcheck warnings: (new ones prefixed by >>)
>>>> drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows outer variable [shadowVariable]
>>       int rc;
>>           ^
>>     drivers/cxl/pci.c:431:6: note: Shadowed declaration
>>      int rc, i;
>>          ^
>>     drivers/cxl/pci.c:439:7: note: Shadow variable
>>       int rc;
>>           ^
>>
>> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
>>
>>>> drivers/cxl/port.c:63:1: warning: There is an unknown macro here somewhere. Configuration is required. If __stringify is a macro then please configure it. [unknownMacro]
>>     MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
>>     ^
>> --
> 
> Can you provide a cppcheck config file and command line
> for this, please?

Hi Randy,

The below command can show the warning:
$ cppcheck --quiet --enable=style,performance,portability --template=gcc 
drivers/cxl/port.c
drivers/cxl/port.c:63:1: warning: There is an unknown macro here 
somewhere. Configuration is required. If __stringify is a macro then 
please configure it. [unknownMacro]
MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
^

Best Regards,
Rong Chen

> 
> My naive testing does not see any of these warnings --
> although I can easily spot the problems in the source file.
> 
> thanks.
> 
